//
//  AccountView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 26/8/24.
//

import SwiftUI

struct AccountView: View {
    @Environment(LogViewModel.self) var vm
    var body: some View {
        VStack{
            if  !vm.isLogede{
                LoginView()
            }else{
                
                withAnimation(.snappy){
                    UserView()
                }
            }
        }
    }
}

#Preview {
    AccountView()
        .environment(LogViewModel())
}
