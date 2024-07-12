//
//  ContentView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/5/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = MangasViewModel()
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
                            ForEach(ola ?? vm.allMangas, id: \.id) { item in
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
                vm.verPeticiones(numP:numero,pages:vm.page, content: textos)
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
                        vm.verPeticiones(numP:numero,pages:vm.page,content: textos)
                        
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
                            print(vm.page)
                            
                        }
                        vm.verPeticiones(numP:numero,pages:vm.page,content:textos)
                        
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
    @StateObject private var vm = MangasViewModel()
    @State private var pages = 1
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
struct TopMangasView : View{
    @StateObject private var vm = MangasViewModel()
    @State private var pages = 1
    
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

struct mangaResultView :View {
    @State var texto = ""
    @StateObject private var vm = MangasViewModel()
    @State private var pages = 22
    @State var contaisOrBegis: Bool
    
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
                                MangaComponetDetalle(manga: item)
                                
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
    @StateObject private var vm = MangasViewModel()
    var body: some View {
        ScrollView{
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 16) {
                ForEach(vm.themes, id: \.self) { theme in
                    ThemsComponet(theme: theme)
                }
            }
            
        }
        .onAppear {
            
            Task{
                await vm.getThemas()
            }
        }
    }
}
#Preview {
    ZStack{
        Color.gray.ignoresSafeArea()
        TopMangasView()
    }
}
#Preview {
    ZStack{
        Color.gray.ignoresSafeArea()
        mangaResultView(texto: "air", contaisOrBegis: true)
    }
}
#Preview("lsitado de temas"){
    
    listaTemas()
}
