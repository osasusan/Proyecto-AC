//
//  HomeVeiw.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 26/6/24.
//

import SwiftUI

struct HomeVeiw: View {
    @StateObject var vm = MangasViewModel()
    
    @State var page = 1
    var body: some View {
        ZStack{
            NavigationStack{
                HStack(spacing: 300){
                    Image("logo")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 50,height: 50)
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ScrollView{
                    VStack(alignment:.leading,spacing:3){
                        sectorView(titulo: "Top mangas",destino: ContentView())
                        verTop10()
                        sectorView(titulo: "Mangas", destino: allMnagas())
                        verMangas()
                        vermagaID(id: "42")
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack{
        Color.gray
            .ignoresSafeArea()
        HomeVeiw()
    }
}

