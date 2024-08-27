//
//  HomeVeiw.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 26/6/24.
//

import SwiftUI
@MainActor
struct HomeVeiw: View {
//    @EnvironmentObject var vm : MangasViewModel
   @State var vm = MangasViewModel()
//    @Environment(MangasViewModel.self) var vm
    
    @State var page = 1
    @State private var showdestinationSearchView = false
    var body: some View {
        
        ZStack{
            Color.customColor.ignoresSafeArea()
            
            if showdestinationSearchView{
                SearcheView(show:$showdestinationSearchView)
            }else{
                ScrollView{
                    SearcheAndFilterBar()
                        .onTapGesture {
                            withAnimation(.linear){
                                showdestinationSearchView.toggle()
                            }
                        }
                    VStack(alignment:.leading,spacing:3){
                        sectorView(titulo: "Top mangas",destino:ViewMangas(num: 1))
                        verTop10()
                        sectorView(titulo: "Mangas", destino: ViewMangas(num: 2))
                        verMangas()
                        sectorView(titulo:"Shounen", destino: ViewMangas(conten: "Shounen", num: 5))
                        verDemos(content: "Shounen")
                        
//                                            vermagaID(id: "23")
                    }
                }
            }
        }
    }
}
#Preview {
    HomeVeiw()
       .environment(MangasViewModel())
        
}

