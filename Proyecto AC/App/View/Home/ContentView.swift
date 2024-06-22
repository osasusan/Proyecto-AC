//
//  ContentView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/5/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = MangasViewModel()
    @State private var pages = 1
    @State private var text3 = "naru"
    
    
    
    var body: some View {
        ScrollView{
            LazyVStack (alignment: .leading) {
                if let errorMensage = vm.errorMensage{
                    Text(errorMensage)
                        .foregroundStyle(.red)
                        .padding()
                    
                } else{
                    
                    ForEach(vm.contenBg,id: \.id){ be in
                        MangaComponet(mangaURL: be.mainPicture,nameManga: be.title)
                      
                        
                    }
//                    if let metadata = vm.metadata {
//                        ForEach(vm.contenBg, id: \.id) { item in
//                            
//                            MangaComponetDetalle(mangaURL: item.mainPicture ,nameManga:item.title,autorManga: (item.authors?.first?.firstName ?? "") + " " + (item.authors?.first?.lastName ?? " "),scoreMangaa: item.score)
//                            MangaComponet(mangaURL: item.mainPicture,nameManga: item.title)
//                        }
//                        VStack(alignment:.center){
//                            
//                            Text("Page: \(metadata.page)")
//                            Text("Total: \(metadata.total)")
//                            HStack{
//                                Button{
//                                    if metadata.page <= 1 {
//                                        pages = 1
//                                    } else {
//                                        pages -= 1
//                                    }
//                                    Task{
//                                        await vm.listTopMangas(page: pages)}
//                                }label: {
//                                    Image(systemName: "arrowshape.left.fill")
//                                }
//                                Button{
//                                    let pagesTOtal = vm.comprobation(page: pages, totalItem: metadata.total)
//                                    if pagesTOtal != pages {
//                                        pages += 1
//                                    }
//                                    Task{
//                                        await vm.m(conten: text3)
//                                    }
//                                }label: {
//                                    Image(systemName: "arrowshape.right.fill")
//                                }
//                            }
//                        }
//                    } else {
//                        Text("Loading")
//                            .bold()
//                        ProgressView()
//                    }
                }
            }
            .padding()
        }
        .onAppear {
            Task{
                await vm.contaisBegins(conten: text3)
//                await vm.getTemas()
            }
        }
    }
}
struct listaTemas:View {
    @StateObject private var vm = MangasViewModel()
    var body: some View {
        ScrollView{
            if let errorMensage = vm.errorMensage {
                Text(errorMensage)
                    .foregroundStyle(.red)
                    .padding()
            } else {
                //                LazyVGrid(columns: Array(repeating:.init(),count: 3)) {
                //                    ForEach(vm.author, id: \.id) { tema in
                //                        ThemsComponet(theme: tema.firstName.isEmpty ? tema.lastName : tema.firstName)
                //                            .padding(.horizontal,20)
                //                }
                //                    if vm.temas.isEmpty {
                //                        Text("Loading")
                //                            .bold()
                //                        ProgressView()
                //                    }
                //                }
                
                VStack{
                    if let idMnaga = vm.mangasId{
                        MangaComponet(mangaURL: idMnaga.mainPicture, nameManga: idMnaga.title)
                    }
                }
            }
        }
        .onAppear {
            Task{
                //
                await vm.getIdManga(id: 20)
            }
        }
    }
}
#Preview {
    ZStack{
        Color.gray.ignoresSafeArea()
        ContentView()
    }
}
