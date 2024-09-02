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
   
    @State var newAcaunt : Bool = false
    var body: some View {
        @Bindable var modell = viewModel
        ZStack{
            Color.customColor.ignoresSafeArea()
            VStack{
                TextField("username", text: $modell.newEmail)
                    .keyboardType(.emailAddress)
                    .textCase(.lowercase)
                    .multilineTextAlignment(.center)
                    .frame(width: 300,height: 50)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                   
                SecureField("Pass", text: $modell.newPass)
                    .multilineTextAlignment(.center)
                    .frame(width: 300,height: 50)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                 
                SecureField("Repit pass", text: $pass2)
                    .multilineTextAlignment(.center)
                    .frame(width: 300,height: 50)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                  
                Text(error)
                    .foregroundStyle(.red)
               
                Button{
                    Task{
                        if !viewModel.newEmail.isEmpty && !viewModel.newPass.isEmpty && !pass2.isEmpty{
                            if pass2 == viewModel.newPass{
                                await viewModel.newUser(user:viewModel.newEmail,pass:viewModel.newPass)
                                
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
                        .tint(.white)
                        .frame(width: 200)
                        .padding(10)
                        .background(.blue)
                        .clipShape(Capsule())
                    
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
