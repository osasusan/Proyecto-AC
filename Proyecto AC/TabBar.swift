//
//  TabBar.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 8/7/24.
//

import SwiftUI

struct TabBar: View {
    @Environment(LogViewModel.self) private var vm
    //    @State var log : any View
    @SceneStorage("tab")
    
    var tab = Tab.home
    var body: some View {
     
        NavigationStack{
            
            ZStack{
                TabView(selection: $tab){
                    HomeVeiw()
                        .tabItem {Label("Home",systemImage: "house")}
                        .tag(Tab.home)
                    
                    FavoritesVeiw()
                        .tabItem {Label( "Favorites",systemImage: "star.fill")}
                        .tag(Tab.favorites)
//                    Group{
//                        if vm.isLogede {
//                            UserView()
//                        }else{
//                            LoginView()
//                        }
//                    }
                    AccountView()
                        .tabItem {Label("Acaunt",systemImage: "person")}
                    .   tag(Tab.acaut)
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
        .environment(MangasViewModel())
        .environment(LogViewModel())
}
