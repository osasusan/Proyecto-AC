//
//  ContentView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/5/24.
//

import SwiftUI

struct ContentView: View {
    //@EnvironmentObject private var vm : MangasViewModel
    @Environment(MangasViewModel.self) private var vm
//    @State private var vm = MangasViewModel()
    @State var pages = 1
    @State var ola:[Item]?
    @State var numero : Int
    @State var textos :String? = nil
    var body: some View {
        
        VStack{
            ScrollView(showsIndicators: false){
                LazyVStack (alignment: .leading) {
                    if let errorMensage = vm.errorMensage{
                        Text(errorMensage)
                            .foregroundStyle(.red)
                            .padding()
                    } else {
                        if vm.metadata != nil {
                            ForEach(ola ?? [] , id: \.id) { item in
                                NavigationLink(destination:MangaDetailVeiw(manga: item)){
                                    MangaComponetDetalle(manga: item)
                                }
                            }
                        } else {
                            HStack(alignment:.center,spacing: 8){
                                Text("Loading")
                                    .bold()
                                ProgressView()
                                    .foregroundStyle(.primary)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding()
            }
            .background(Color.customColor)
            .onAppear {
                Task{
                    switch numero {
                        case 1: ola = vm.topMangas
                        case 2 : ola = vm.allMangas
                        default:
                            ola = []
                    }
                    
                    await vm.verPeticiones(numP:numero,pages:vm.page, content: textos)
                    vm.errorMensage = nil
                }
            }
           
            if let metadata = vm.metadata{
                Spacer()
                HStack(alignment:.bottom){
                    Button{
                        if metadata.page <= 1 {
                            
                            vm.page = 1
                        } else {
                            vm.page -= 1
                        }
                        Task{
                            await vm.verPeticiones(numP:numero,pages:vm.page,content: textos)
                        }
                    }label: {
                        Image(systemName: "arrowshape.left.fill")
                            .padding()
                    }
                    VStack(alignment:.center){
                        Spacer()
                        Text("Page: \(metadata.page)")
                        Text("Total: \(metadata.total)")
                    }
                    
                    Button{
                        let pagesTOtal = vm.comprobation(page: vm.page, totalItem: metadata.total)
                        if pagesTOtal != vm.page {
                            vm.page += 1
                          
                            
                        }
                        Task{
                            await vm.verPeticiones(numP:numero,pages:vm.page,content:textos)
                        }
                    }label: {
                        Image(systemName: "arrowshape.right.fill")
                            .padding()
                    }
                }
                .frame(height: 37,alignment: .bottom)
                
            }
        }
        .background(Color.grDark)
    }
    
    
}

struct allMnagas : View{
//   @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @State private var pages = 1
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
                            if vm.metadata != nil{
                                ForEach(vm.allMangas, id: \.id) { item in
                                    NavigationLink(destination:MangaDetailVeiw(manga: item)){
                                        MangaComponetDetalle(manga: item)
                                    }
                                }
                            } else {
                                Text("Loading")
                                    .bold()
                                ProgressView()
                            }
                        }
                    }
                    .padding()
                    
                }
                .background(Color.customColor)
                .onAppear {
                    Task{
                        await vm.listMangas(page:pages,20)
                    }
                }
                .refreshable{
                    Task{
                        await vm.listMangas(page:pages,20)
                    }
                    
                }
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
                                await vm.listMangas(page:pages,20)
                                withAnimation{
                                    proxy.scrollTo(vm.allMangas.first?.id,anchor: .top)
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
                                await vm.listMangas(page:pages,20)
                                withAnimation{
                                    proxy.scrollTo(vm.allMangas.first?.id,anchor: .top)
                                }
                            }
                            
                        }label: {
                            Image(systemName: "arrowshape.right.fill")
                        }
                    }
                    .frame(height: 37,alignment: .bottom)
                }
            }
            .background(Color.grDark)
        }
        
    }
    
}
struct TopMangasView : View{
   // @EnvironmentObject private var vm : MangasViewModel
//    @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @State private var pages = 1
    @State var fav:Bool = false
    var body :some View{
        VStack{
            ScrollView{
                LazyVStack (alignment: .leading) {
                    if let errorMensage = vm.errorMensage{
                        Text(errorMensage)
                            .foregroundStyle(.red)
                            .background(.white)
                            .padding()
                        
                    } else{
                        if  vm.metadata != nil{
                            
                            ForEach(vm.topMangas, id: \.id) { item in
                                
                                NavigationLink(destination:MangaDetailVeiw(manga: item)){
                                    MangaComponetDetalle(manga: item)
                                    
                                }
                            }
                        } else {
                            HStack(alignment:.center,spacing: 8){
                                Text("Loading")
                                    .bold()
                                ProgressView()
                                    .foregroundStyle(.primary)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding()
            }
            .background(Color.customColor)
            .onAppear {
                Task{
                    await vm.listTopMangas(page:pages,20)
                }
            }
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
                            await vm.listTopMangas(page:pages,20)
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
                            await vm.listTopMangas(page:pages,20)
                        }
                    }label: {
                        Image(systemName: "arrowshape.right.fill")
                    }
                }
                .frame(height: 37,alignment: .bottom)
            }
        }
        .background(Color.grDark)
    }
}

struct MangaResultView :View {
    @State var texto = ""
//    @EnvironmentObject private var vm : MangasViewModel
//    @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @State private var pages = 1
    @State var contaisOrBegis: Bool
    @State var fav: Bool = false
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVStack (alignment: .leading) {
                    if let errorMensage = vm.errorMensage{
                        Text(errorMensage)
                            .foregroundStyle(.red)
                            .background(.white)
                            .padding()
                        
                    } else{
                        let shManga = contaisOrBegis ? vm.contenBg : vm.contenSh
                        //                        {
                        ForEach(shManga, id: \.id) { item in
                            NavigationLink(destination:MangaDetailVeiw(manga: item)){
                                MangaComponetDetalle(manga: item,favsi: fav)
                                
                                
                            }
                        }
                        //                        } else {
                        //                            HStack(alignment:.center,spacing: 8){
                        //                                Text("Loading")
                        //                                    .bold()
                        //                                ProgressView()
                        //                                    .foregroundStyle(.primary)
                        //                            }
                        //                            .frame(maxWidth: .infinity)
                        //                        }
                    }
                }
                .padding()
            }
            .background(Color.customColor)
            .onAppear {
                
                Task{
                    contaisOrBegis ? await vm.beginsMangalIst(conten: texto) : await vm.contaisMangaList(conten: texto, page: pages)
                }
            }
            
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
                            contaisOrBegis ? await vm.beginsMangalIst(conten: texto) : await vm.contaisMangaList(conten: texto, page: pages)
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
                            contaisOrBegis ? await vm.beginsMangalIst(conten: texto) : await vm.contaisMangaList(conten: texto, page: pages)
                        }
                    }label: {
                        Image(systemName: "arrowshape.right.fill")
                    }
                }
                .frame(height: 37,alignment: .bottom)
            }
        }
        .background(Color.grDark)
    }
}
struct listaTemas:View {
//    @EnvironmentObject private var vm : MangasViewModel
//    @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @State var peti : [String] = []
    @State var nume : Int
    var body: some View {
        ScrollView{
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 16) {
                ForEach(peti, id: \.self) { theme in
                    
                    NavigationLink {
                        listMagaGenDemoTheme(contetn: theme,num: nume)
                    } label: {
                        ThemesComponet(theme: theme, num: nume)
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
                    case 2:
                        await vm.getThemesResponse()
                        peti = vm.themes
                        
                    case 3:
                        await vm.getDemoResponse()
                        peti = vm.demos
                    default:
                        peti = []
                        
                }
            }
        }
    }
}

struct listMagaGenDemoTheme : View {
//    @EnvironmentObject var vm : MangasViewModel
//    @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @State var contetn : String = "Horror"
    @State var pages = 1
    @State var list : [Item] = []
    @State var num: Int?
    var body: some View {
        VStack{
            ScrollView(showsIndicators: false){
                LazyVStack (alignment: .center) {
                    if let errorMensage = vm.errorMensage{
                        Text(errorMensage)
                            .foregroundStyle(.red)
                            .background(.white)
                            .padding()
                        
                    } else{
                        if  vm.metadata != nil{
                            
                            ForEach(list, id: \.id) { item in
                                
                                NavigationLink(destination:MangaDetailVeiw(manga: item)){
                                    MangaComponetDetalle(manga: item)
                                    
                                }
                            }
                        } else {
                            HStack(alignment:.center,spacing: 8){
                                Text("Loading")
                                    .bold()
                                ProgressView()
                                    .foregroundStyle(.primary)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding()
            }
            .toolbarRole(.automatic)
            .background(Color.customColor)
            .onAppear {
                Task{
                    await cambiar()
                }
            }
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
                        }
                    }label: {
                        Image(systemName: "arrowshape.right.fill")
                    }
                }
                .frame(height: 37,alignment: .bottom)
            }
        }
        .background(Color.grDark)
    }
    func cambiar() async{
        switch num{
            case 1:  await vm.listMangaGen(page: pages, gen: contetn)
                list = vm.mangaListGen
            case 2:  await vm.listMangaThemes(page: pages, themes: contetn)
                list = vm.mangaListThemes
              
            case 3 :  await vm.listMangaDemo(page: pages, demos: contetn, 20)
                list = vm.mangaListDemos
            default : num = 0
        }
    }
}
#Preview {
    ZStack{
        Color.gray.ignoresSafeArea()
        TopMangasView()
//            .environmentObject(MangasViewModel())
        
    }
}
#Preview {
    ZStack{
        Color.gray.ignoresSafeArea()
        MangaResultView(texto: "air", contaisOrBegis: true)
//            .environmentObject(MangasViewModel())
        
    }
}
#Preview("lsitado de temas"){
    
    listaTemas(nume:3)
//        .environmentObject(MangasViewModel())
    
}

#Preview("categrys result"){
    listMagaGenDemoTheme()
//        .environmentObject(MangasViewModel())
}
