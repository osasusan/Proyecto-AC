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
        NavigationStack{
            ScrollView{
                LazyVStack (alignment: .leading) {
                    if let errorMensage = vm.errorMensage{
                        Text(errorMensage)
                            .foregroundStyle(.red)
                            .padding()
                        
                    } else{
                        if let metadata = vm.metadata {
                            
                            List(vm.mangas, id: \.id) { item in
                                NavigationLink(destination:MangaDetailVeiw(manga: item)){
                                    MangaComponetDetalle(manga: item)
                                        .foregroundStyle(.black)
                                }
                            }
                            VStack(alignment:.center){
                                
                                Text("Page: \(metadata.page)")
                                Text("Total: \(metadata.total)")
                                HStack(alignment:.bottom){
                                    Button{
                                        if metadata.page <= 1 {
                                            pages = 1
                                        } else {
                                            pages -= 1
                                        }
                                        Task{
                                            await vm.listTopMangas(page: pages)}
                                    }label: {
                                        Image(systemName: "arrowshape.left.fill")
                                    }
                                    Button{
                                        let pagesTOtal = vm.comprobation(page: pages, totalItem: metadata.total)
                                        if pagesTOtal != pages {
                                            pages += 1
                                        }
                                        Task{
                                            await vm.listTopMangas(page:pages)
                                        }
                                        
                                    }label: {
                                        Image(systemName: "arrowshape.right.fill")
                                    }
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
            .onAppear {
                Task{
                    
                    await vm.listTopMangas(page:pages)
                }
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
                
                VStack{
                    if let idMnaga = vm.mangasId{
                        MangaComponet(manga: idMnaga)
                    }
                }
            }
        }
        .onAppear {
            //            Task{
            //                //
            //                await vm.getIdManga()
            //            }
        }
    }
}
#Preview {
    ZStack{
        Color.gray.ignoresSafeArea()
        ContentView()
    }
}