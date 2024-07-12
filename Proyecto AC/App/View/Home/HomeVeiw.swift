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
            Color.customColor.ignoresSafeArea()
            ScrollView{
                VStack(alignment:.leading,spacing:3){
                    sectorView(titulo: "Top mangas",destino:TopMangasView())
                    verTop10()
                    sectorView(titulo: "Mangas", destino: allMnagas())
                    verMangas()
                    //                        vermagaID(id: "23")
                    
                }
            }
        }
    }
}

#Preview {
    HomeVeiw()
}

