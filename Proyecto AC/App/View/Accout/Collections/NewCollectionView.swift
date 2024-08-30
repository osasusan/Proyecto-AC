//
//  NewCollectionView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 27/8/24.
//

import SwiftUI

struct NewCollectionView: View {
    @Environment(UserViewModel.self) private var vm
    @Environment(\.dismiss) private var dismiss
    @State var mensageAlet:String = ""
    @State var alert = false
    var body: some View {
        @Bindable var viewModell = vm
        Form{
            Section("Manga Details") {
                TextField("Manga ID", value: $viewModell.idManga,format: .number)
                    .keyboardType(.numberPad)
                
                
                TextField("Volumes owned", text:$viewModell.volumesOwned)
                    .keyboardType(.numberPad)
                
                TextField("Reading volume", value: $viewModell.readingVolume,format: .number)
                    .keyboardType(.numberPad)
            }
            Section{
                Toggle(isOn: $viewModell.isComplet) {
                    Text("Complet collection")
                }
            }
            Section {
                Button {
                    guard let idManga = viewModell.idManga, let readingVolume = viewModell.readingVolume, !viewModell.volumesOwned.isEmpty else {
                        mensageAlet = "Please complete all fields"
                        alert.toggle()
                        return
                    }
                    Task{
                        await vm.newColletion(id: idManga, isComplet: vm.isComplet, volumesOwned: vm.volumesOwned, readingVolume: readingVolume)
                        mensageAlet = vm.menssageBien!
                        alert.toggle()
                        dismiss()
                            
                    }
                }label: {
                    HStack{
                        Spacer()
                        Text("SAVE")
                            .bold()
                        Spacer()
                    }
                }
            }
            
            .alert(isPresented: $alert) {
                .init(title: Text("Notification"),message: Text(mensageAlet),dismissButton: .default(Text("Done")))
            }
            
        }
    }
}



#Preview {
    NavigationView{
        NewCollectionView()
            .environment(UserViewModel())
    }
}
