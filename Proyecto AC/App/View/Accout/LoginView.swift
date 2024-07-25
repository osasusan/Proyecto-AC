//
//  LoginView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 26/6/24.
//

import SwiftUI
import SwiftData
struct LoginView: View {
    @Environment(LoginVeiwModel.self) private var model
    @State var error = ""
//    @Bindable var modell = LoginVeiwModel()
    var body: some View {
      @Bindable var modell = model
        ZStack{
            Color.customColor.ignoresSafeArea()
            VStack{
                Capsule()
                    .frame(height: 50)
                    .foregroundStyle(.gray)
                    .overlay {
                       
                        TextField("username", text: $modell.email)
                            .frame(width: 250,height: 50)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal,50)
              Capsule()
                    .foregroundStyle(.gray)
                    .frame(height: 50)
                    .overlay {
                       
                        SecureField("Pass", text: $modell.pass)
                            .frame(width: 250,height: 50)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal,50)
              
                      
                        Text(error)
                            .foregroundStyle(.red)
              
                Button{
                    Task{
                        if !model.email.isEmpty && !model.pass.isEmpty{
                            await model.logUser(user:model.email,pass:model.pass)
                           
                            error = ""
                           
                        }else {
                            error = "los campos estan vacions"
                        }
                    }
                }label:{
                    Text("log")
                }
                Text(model.token ?? "hoal")
                    .foregroundStyle(.yellow   )
                
                Text(model.errorMensage ?? "hola que tal ")
                    .foregroundStyle(.red)
                    .tint(.blue)
              
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(LoginVeiwModel())
        
}
