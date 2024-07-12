//
//  TabBar.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 8/7/24.
//

import SwiftUI

struct TabBar: View {
    
    @SceneStorage("tab")
    var tab = Tab.home
    
    var body: some View {
     
        NavigationView{
            TabView(selection: $tab){
                
                HomeVeiw()
                    .tabItem {Label("Home",systemImage: "house")}
                    .tag(Tab.home)
                
                FavoritesVeiw()
                    .tabItem {Label( "Favorites",systemImage: "star.fill")}
                    .tag(Tab.favorites)
                LoginView()
                    .tabItem {Label("Acaunt",systemImage: "person")}
                    .tag(Tab.acaut)
                
            }
            .toolbar{
                if tab == .home{
                    SearcheAndFilterBar()
                        .ignoresSafeArea()
                }
            }
        }
       
    }
    
    
}
enum Tab : String {
    case home
    case favorites
    case acaut
    
}
#Preview {
    TabBar()
}
