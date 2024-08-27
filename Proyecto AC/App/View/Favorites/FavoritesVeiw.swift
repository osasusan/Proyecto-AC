//
//  FavoritesVeiw.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 8/7/24.
//

import SwiftUI

struct FavoritesVeiw: View {
    //    @EnvironmentObject private var vm : MangasViewModel
    
    //    @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @Environment(LogViewModel.self) private var vmLog
    @State var logView = false
    
    var body: some View {
        
        ZStack{
            Color.customColor.ignoresSafeArea()
            if vmLog.isLogede {
                if !vm.favorites.isEmpty{
                    List{
                        Section("Favorites"){
                            
                            ForEach(vm.favorites,id:\.id){fav in
                                NavigationLink {
                                    withAnimation() {
                                        MangaDetailVeiw(manga: fav)
                                    }
                                    
                                    
                                } label: {
                                    MangaListComponet(manga: fav)
                                    
                                        .swipeActions(edge: .leading){
                                            Button {
                                                withAnimation(.snappy){
                                                    vm.toggleMangaSelection(fav)
                                                }
                                            }label: {
                                                Label("Delate", systemImage: "trash.fill")
                                            }
                                            .tint(.red)
                                        }
                                }
                            }
                            
                        }
                        
                    }
                    .padding()
                    .transparentListStyle()
                }else{
                    VStack(alignment : .center){
                        Text("Your favorites list is empty")
                            .font(.title)
                            .fontWeight(.bold)
                            .fontWidth(.compressed)
                    }
                }
            }else{
                VStack(alignment : .center){
                    Text("You need to log in to see your favorite mangas")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontWidth(.compressed)
                        
                }
                .onAppear{
                    logView.toggle()
                }
            }
        }
        .sheet(isPresented: $logView, content: {
            LoginView()
        })
    }
        
}
struct TransparentListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.clear)
            .scrollContentBackground(.hidden)
    }
}

#Preview {
    FavoritesVeiw()
        .environment(MangasViewModel())
    
}
