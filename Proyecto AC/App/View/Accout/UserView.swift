//
//  UserView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 8/8/24.
//

import SwiftUI

struct UserView: View {
    @Environment(UserViewModel.self) private var vm
    @Environment(LogViewModel.self) private var vmLog
    @State var ok :Bool = false
    @State var idSh :Bool = false
    @State private var inputText: String = ""
    @State private var idContent: String = ""
    @State private var navigateToNextView: Bool = false
    @State var goToCollection :Bool = false
    @State var goToCollectionID:Bool = false
    @State var crearCollection :Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color.customColor.ignoresSafeArea()
                VStack{
                    Button{
                        crearCollection.toggle()
                    }label: {
                        Text("Create a New Colletion")
                            .tint(.white)
                            .frame(width: 200)
                            .padding(10)
                            .background(.blue)
                            .clipShape(Capsule())
                        
                    }
                    Button{
                        Task{
                            await vm.showUserCollection()
                        }
                        goToCollection.toggle()
                        
                    }label: {
                        Text("View my collections")
                            .tint(.white)
                            .frame(width: 200)
                            .padding(10)
                            .background(.blue)
                            .clipShape(Capsule())
                        
                    }
                    Button{
                        idSh.toggle()
                        
                    }label: {
                        Text("Search in collections")
                            .tint(.white)
                            .frame(width: 200)
                            .padding(10)
                            .background(.blue)
                        
                            .clipShape(Capsule())
                        
                        
                    }
                    .frame(alignment: .bottom)
                    
                    Text(vm.token)
                        .foregroundStyle(.red)
                }
                VStack{
                    Spacer()
                    Button {
                        vmLog.logOut()
                    } label: {
                        Text("Log Out")
                            .tint(.red)
                            .padding(10)
                            .padding(.horizontal,54)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                    .padding(.bottom,20)
                }
            }
            
            .alert(isPresented: $ok) {
                .init(title:Text( "create"),message: Text(vm.alet),dismissButton: .cancel())
                
            }
            .navigationDestination(isPresented: $goToCollection) {
                UserCollectionView()
            }
            .navigationDestination(isPresented: $goToCollectionID){
                MangarIdResulrCollection(buscar: idContent)
            }
            .sheet(isPresented: $crearCollection) {
                NewCollectionView()
                    .onDisappear{
                        vm.volumesOwned = ""
                        vm.idManga = nil
                        vm.readingVolume = nil
                        vm.isComplet = false
                    }
            }
        }
        .alert("collections finder",isPresented: $idSh){
            TextField("ID",text: $inputText)
                .keyboardType(.numberPad)
            Button("Search") {
                if !inputText.isEmpty{
                    goToCollectionID = true
                    idContent = inputText
                    inputText = ""
                }
            }
            Button("Cancel",role: .cancel) { }
        } message: {
            Text("Search for your collection by id")
        }
        
    }
}


#Preview {
    NavigationView{
        UserView()
            .environment(UserViewModel())
            .environment(LogViewModel())
        
    }
}
