//
//  ExtesionHomeView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 1/7/24.
//

import Foundation
import SwiftUI

extension HomeVeiw{
     func verMangas()->some View{
        ScrollView(.horizontal,showsIndicators: false){
            Divider()
            HStack{
                ForEach(vm.allmAngas, id: \.id) { item in
                    NavigationLink {
                        MangaDetailVeiw(manga: item)
                    } label: {
                        MangaComponet(manga: item)
                    }
                }
            }
            .padding(.horizontal)
        }
        .onAppear{
            Task{
                await vm.listMangas(page:1,11)
            }
        }
    }
     func vermagaID(id:String)->some View{
        VStack{
            MangaComponet(manga: vm.mangasId)
        }
        .onAppear(){
            Task {
                await vm.getIdManga(id: id)
            }
        }
    }
    func sectorView<view: View>(titulo:String, destino: view)-> some View {
        HStack{
            Text("Top Mangas")
                .font(.title)
                .fontWeight(.bold)
                .fontWidth(.compressed)
                .padding(.leading,20)
            Spacer()
            NavigationLink (destination:destino) {
                Text("Ver todos")
                    .fontWeight(.bold)
                    .padding(.trailing, 20)
            }
        }
    }
    func verTop10()->some View {
        ScrollView(.horizontal,showsIndicators: false){
            Divider()
            HStack{
                ForEach(vm.TopMangas , id: \.id) { item in
                    NavigationLink {
                        MangaDetailVeiw(manga: item)
                    } label: {
                        MangaComponet(manga: item)
                    }
                }
            }.padding(.horizontal)
        }
        .onAppear{
            Task{
                await vm.listTopMangas(page:1,11)
            }
        }
    }
}



