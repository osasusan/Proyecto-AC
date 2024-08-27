//
//  ExtesionHomeView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 1/7/24.
//

import Foundation
import SwiftUI

@MainActor
extension HomeVeiw{
     func verMangas()->some View{
        ScrollView(.horizontal,showsIndicators: false){
            Divider()
            HStack{
                ForEach(vm.allMangas, id: \.id) { item in
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
                await vm.listMangas(page:page,11)
            }
        }
    }
    //Ver los el top 10 + 1 de magas con mas puntuacion
    func verTop10()->some View {
        ScrollView(.horizontal,showsIndicators: false){
            Divider()
            HStack{
                ForEach(vm.topMangas , id: \.id) { item in
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
                await vm.listTopMangas(page: page, 11)
            }
        }
    }
    func verDemos(content:String)->some View{
       ScrollView(.horizontal,showsIndicators: false){
           Divider()
           HStack{
               ForEach(vm.mangaListDemos, id: \.id) { item in
                   NavigationLink {
                       withAnimation(.smooth) {
                           MangaDetailVeiw(manga: item)
                       }
                   } label: {
                       MangaComponet(manga: item)
                   }
               }
           }
           .padding(.horizontal)
       }
      
       .onAppear{
           Task{
               await vm.listMangaDemo(page:page,demos:content,11)
           }
       }
   }
    public func vermagaID(id:String)->some View{
        VStack{
            MangaComponetDetalle(manga: vm.mangasId)
        }
        .onAppear(){
            Task {
                await vm.getIdManga(id: id)
            }
        }
    }
    func sectorView<view: View>(titulo:String, destino: view)-> some View {
        HStack{
            Text(titulo)
                .font(.title)
                .fontWeight(.bold)
                .fontWidth(.compressed)
                .foregroundStyle(Color.white)
                .padding(.leading,20)
            Spacer()
            NavigationLink (destination:destino) {
                Text("Show all")
                    .fontWeight(.bold)
                    .padding(.trailing, 20)
            }
        }
    }
    
}



