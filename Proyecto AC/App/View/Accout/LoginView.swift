//
//  LoginView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 26/6/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginVeiwModel()
    @State var error = ""
    var body: some View {
        ZStack{
            Color.customColor.ignoresSafeArea()
            VStack{
                TextField("username", text: $vm.email)
                    .frame(width: 200,height: 50)
                    .foregroundStyle(.white)
                SecureField("Pass", text: $vm.pass)
                    .frame(width: 200,height: 50)
                    .foregroundStyle(.white)
                Text(error)
                    .foregroundStyle(.red)
               
                Button{
                    Task{
                        if !vm.email.isEmpty || !vm.pass.isEmpty{
                            await vm.logUser(user:vm.email,pass:vm.pass)
                        }else {
                            
                            error = "los campos estan vacions"
                            
                        }
                    }
                }label:{
                    Text("log")
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
