//
//  UserCollectionView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 28/8/24.
//

import SwiftUI

struct UserCollectionView: View {
    @Environment(UserViewModel.self) var vm
    
    @State var recargar = false
    @State var edidt = false
    var body: some View {
        @Bindable var vm2 = vm
        ZStack{
            Color.customColor.ignoresSafeArea()
            
            if !vm.userCollection.isEmpty{
                List{
                    Section("Collection"){
                        
                        ForEach(vm.userCollection,id:\.id){fav in
                            NavigationLink {
                                withAnimation() {
                                    MangaDetailVeiw(manga: fav.manga)
                                }
                                
                            } label: {
                                UserCellCollection(manga: fav)
                                    .swipeActions(){
                                        Button {
                                            vm.isComplet = fav.completeCollection
                                            vm.readingVolume = fav.readingVolume
                                            vm.idManga = fav.manga.id
                                            vm.volumesOwned = fav.volumesOwned?.last?.description ?? "0"
                                            edidt.toggle()
                                        } label: {
                                            Label("Edidt",systemImage: "pencil" )
                                        }
                                        .tint(.blue)

                                    }
                                    .swipeActions(edge: .leading){
                                        Button {
                                            withAnimation(.smooth){
                                            }
                                            Task{
                                                await vm.delMangaColle(id:"\(fav.manga.id)")
                                                recargar.toggle()
                                            }
                                        }label: {
                                            Label("Delate", systemImage: "trash.fill")
                                        }
                                        .tint(.red)
                                    }
                                    
                            }
                            .sheet(isPresented: $edidt){
                                NewCollectionView()
                                    .onDisappear{
                                        vm.volumesOwned = ""
                                        vm.idManga = nil
                                        vm.readingVolume = nil
                                        vm.isComplet = false
                                    }
                            }
                        }
                    }
                    .onChange(of: recargar){
                        Task {
                            await vm.showUserCollection()
                        }
                    }
                }
                .padding()
                .transparentListStyle()
            }else{
                VStack(alignment : .center){
                    Text("Your collection list is empty")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontWidth(.compressed)
                }
            }
            
        }
        .alert(isPresented: $vm2.isEliminated){
            .init(title:Text("Eliminated"),message: Text(vm.menssageBien!),dismissButton: .default(Text("Done")))
        }
    }
}

#Preview {
    UserCollectionView()
        .environment(UserViewModel())
    
}
