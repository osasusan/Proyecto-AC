//
//  UserView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 8/8/24.
//

import SwiftUI

struct UserView: View {
    @Environment(UserViewModel.self) private var vm
    @State var ok :Bool = false
    var body: some View {
        VStack{
            Button{
                Task{
                    await vm.getNewToken()
                }
                
            }label: {
                Text("renovar Token")
            }
            Button{
                Task{
//                    await vm.newColletion()
                    await vm.showUserCollection()
//                    await vm.buscarColecionPorID()
                    
                }
                ok.toggle()
                
            }label: {
                Text("crear colecion")
            }
            Text(vm.token)
                .foregroundStyle(.red)
        }
        .alert(isPresented: $ok) {
            .init(title:Text( "create"),message: Text(vm.alet),dismissButton: .cancel())
            
        }
    }
}
struct viewMyCollections:View {
    @Environment(UserViewModel.self) private var vm
    var body: some View {
        VStack{
            if !vm.userCollections.isEmpty{
                
            }
        }
    }
}

#Preview {
    UserView()
        .environment(UserViewModel())
}
