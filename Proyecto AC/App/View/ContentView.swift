//
//  ContentView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/5/24.
//

import SwiftUI

struct ViewMangas : View{
    //   @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @State var list:[Manga] = []
    @State var conten : String = ""
    @State var num : Int?
    @State private var pages = 1
    @State var changePage = true
    @State var txt = ""
    var body :some View{
        ScrollViewReader{ proxy in
            VStack{
                ScrollView{
                    LazyVStack (alignment: .center) {
                        if let errorMensage = vm.errorMensage{
                            Text(errorMensage)
                                .foregroundStyle(.red)
                                .background(.white)
                                .padding()
                        } else{
                            if !list.isEmpty{
                                ForEach(list, id: \.id) { item in
                                    NavigationLink(destination:MangaDetailVeiw(manga: item)){
                                        MangaComponetDetalle(manga: item)
                                    }
                                    
                                    .id("TOP")
                                }
                            } else {
                                HStack{
                                    Text("Manga not faund  ")
                                        .bold()
                                    ProgressView()
                                }
                                
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.customColor)
                .onAppear {
                    Task{
                        await cambiar()
                    }
                }
                if changePage{
                    if let metadata = vm.metadata{
                        Spacer()
                        HStack(alignment:.bottom){
                            Button{
                                if metadata.page <= 1 {
                                    pages = 1
                                } else {
                                    pages -= 1
                                }
                                Task{
                                    await cambiar()
                                    withAnimation(.easeIn(duration: 0.5)) {
                                        proxy.scrollTo("TOP", anchor: .top)
                                    }
                                }
                                
                            }label: {
                                Image(systemName: "arrowshape.left.fill")
                            }
                            VStack(alignment:.center){
                                Spacer()
                                Text("Page: \(metadata.page)")
                                Text("Total: \(metadata.total)")
                            }
                            Button{
                                let pagesTOtal = vm.comprobation(page: pages, totalItem: metadata.total)
                                if pagesTOtal != pages {
                                    pages += 1
                                }
                                Task{
                                    await cambiar()
                                    withAnimation (.easeIn(duration: 0.5)){
                                        proxy.scrollTo("TOP", anchor: .top)
                                    }
                                }
                            }label: {
                                Image(systemName: "arrowshape.right.fill")
                            }
                        }
                        .frame(height: 37,alignment: .bottom)
                    }
                }
            }
            .background(Color.grDark)
        }
    }
    func cambiar() async {
        switch num{
            case 1:  await vm.listTopMangas(page: pages, 20)
                list = vm.topMangas
                changePage = true
            case 2:  await vm.listMangas(page: pages, 20)
                list = vm.allMangas
                changePage = true
            case 3:  await vm.listMangaGen(page: pages, gen: conten)
                list = vm.mangaListGen
                changePage = true
            case 4:  await vm.listMangaThemes(page: pages, themes: conten)
                list = vm.mangaListThemes
                changePage = true
            case 5 : await vm.listMangaDemo(page: pages, demos: conten, 20)
                list = vm.mangaListDemos
                changePage = true
            case 6 : await vm.beginsMangalIst(conten: conten)
                list = vm.contenBg
                changePage = false
            case 7 : await vm.contaisMangaList(conten: conten, page: pages)
                list = vm.contenSh
                changePage = true
            case 8 : await vm.getAutorManga(pages: pages, idAuthor: conten)
                list = vm.authorManga
                changePage = true
            default : num = 0
        }
    }
}


//vista de  resultado de busqueda por ID
struct MangarIdResulr : View {
    @Environment(MangasViewModel.self) private var vm
    @State var buscar :String
    @State var idManga : Manga?
    var body: some View {
        ZStack{
            Color.customColor.ignoresSafeArea()
            VStack{
                if let manga = idManga {  // Verifica si idManga no es nil a
                    MangaDetailVeiw(manga: manga)
                } else {
                    Text("Manga not faund")  // O un indicador de carga, si idManga es nil
                    ProgressView()
                }
            }
        }
        .onAppear{
            Task{
                await vm.getIdManga(id: buscar)
                idManga = vm.mangasId
            }
        }
        
    }
}
struct MangarIdResulrCollection : View {
    @Environment(UserViewModel.self) private var vm
    @State var buscar :String
    @State var idManga : UserCollection?
    var body: some View {
        ZStack{
            Color.customColor.ignoresSafeArea()
            VStack{
                if let manga = idManga {  // Verifica si idManga no es nil a
                    NavigationLink {
                        MangaDetailVeiw(manga: manga.manga)
                    } label: {
                        UserCellCollection(manga: manga)
                    }
                    
                } else {
                    Text("Manga not faund")  // O un indicador de carga, si idManga es nil
                    ProgressView()
                }
            }
        }
        .onAppear{
            Task{
                await vm.buscarColecionPorID(id: buscar)
                idManga = vm.userCollectionsID
            }
        }
        .onDisappear{
            idManga = nil
            vm.userCollectionsID = nil
        }
        
    }
}
struct ListaTemas:View {
    //    @EnvironmentObject private var vm : MangasViewModel
    //    @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @State var peti : [String] = []
    @State var nume : Int
    @State var numP: Int = 0
    var body: some View {
        ScrollView{
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 16) {
                ForEach(peti, id: \.self) { theme in
                    
                    NavigationLink {
                        ViewMangas(conten: theme,num: numP)
                    } label: {
                        ThemesComponet(theme: theme)
                    }
                }
            }
        }
        .onAppear {
            Task{
                switch nume {
                    case 1:
                        await vm.getGensResponse()
                        peti = vm.generos
                        numP = 3
                    case 2:
                        await vm.getThemesResponse()
                        peti = vm.themes
                        numP = 4
                    case 3:
                        await vm.getDemoResponse()
                        peti = vm.demos
                        numP = 5
                    default:
                        peti = []
                        
                }
            }
        }
    }
}


#Preview ("Vista mangas"){
    ViewMangas()
        .environment(MangasViewModel())
}
#Preview ("resultadoBusqueda"){
    MangarIdResulrCollection(buscar: "74")
        .environment(UserViewModel())
}
#Preview("lsitado de temas"){
    ListaTemas(nume:3)
        .environment(MangasViewModel())
    
}


