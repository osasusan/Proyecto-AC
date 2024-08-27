//
//  RegiesterView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 5/8/24.
//

import SwiftUI

struct RegiesterView: View {
    
    @Environment(LogViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss
    @State var error = ""
    @State var pass2 = ""
    //    @Bindable var modell = LoginVeiwModel()
    @State var newAcaunt : Bool = false
    var body: some View {
        @Bindable var modell = viewModel
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
                            .textCase(.lowercase)
                        
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
                 Capsule()
                    .foregroundStyle(.gray)
                    .frame(height: 50)
                    .overlay {
                        
                        SecureField("Repit pass", text: $pass2)
                            .frame(width: 250,height: 50)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal,50)
                
                
                Text(error)
                    .foregroundStyle(.red)
               
                Button{
                    Task{
                        if !viewModel.email.isEmpty && !viewModel.pass.isEmpty && !pass2.isEmpty{
                            if pass2 == viewModel.pass{
                                await viewModel.newUser(user:viewModel.email,pass:viewModel.pass)
                                
                                newAcaunt.toggle()
                                   
                                error = ""
                                dismiss.callAsFunction()
                            }else{
                                error = "Las contraseñas no coinciden"
                            }
                                
                        }else {
                           
                            error = "los campos estan vacions"
                        }
                    }
                }label:{
                    Text("Create accaunt")
                    
                }
                .alert(isPresented: $newAcaunt){
                    .init(title: Text("WELCOME"),message: Text("Now you can login"),dismissButton: .default(Text("Done")))
                }
                    
                
                
                Text(viewModel.errorMensage ?? "")
                    
                    .tint(.blue)
                
            }
        }
    }
}



#Preview {
    RegiesterView()
        .environment(LogViewModel())
}
