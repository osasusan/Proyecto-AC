//
//  LoginView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 26/6/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(LogViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State var error = ""
    
    @State var newUser: Bool = false
    //    @Bindable var modell = LoginVeiwModel()
    var body: some View {
        @Bindable var modell = viewModel
        ZStack{
            Color.customColor.ignoresSafeArea()
            
            VStack{
                
                TextField("username", text: $modell.email)
                    .textCase(.lowercase)
                    .multilineTextAlignment(.center)
                    .frame(width: 300,height: 50)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
                SecureField("Pass", text: $modell.pass)
                    .multilineTextAlignment(.center)
                    .frame(width: 300,height: 50)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                Text(error)
                    .foregroundStyle(.red)
                
                Button{
                    Task{
                        if !viewModel.email.isEmpty && !viewModel.pass.isEmpty{
                            await viewModel.logUser(user:viewModel.email,pass:viewModel.pass)
                            if viewModel.isLogede {
                                dismiss.callAsFunction()
                            }
                            error = ""
                           
                        }else {
                            error = "los campos estan vacions"
                        }
                    }
                }label:{
                    Text("Log In")
                        .tint(.white)
                        .frame(width: 100)
                        .padding(10)
                        .background(.blue)
                        .clipShape(Capsule())
                }
                .padding(.top,20)
                
                Button{
                    Task{
                        newUser.toggle()
                    }
                }label:{
                    Text("New user")
                        .tint(.white)
                        .frame(width: 100)
                        .padding(10)
                        .background(.blue)
                        .clipShape(Capsule())
                    
                }
                .padding(.top,20)
                
            
                Text(viewModel.errorMensage ?? "")
                    .foregroundStyle(.red)
                    
            }
        }
        .sheet(isPresented: $newUser , content: {
            RegiesterView()
            
        })
    }
}

#Preview {
    LoginView()
        .environment(LogViewModel())
    
}
