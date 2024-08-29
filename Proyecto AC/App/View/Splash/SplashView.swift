//
//  SplashView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/8/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive: Bool = false
    @State var userDefaults = UserDefaults.standard
    @State private var size = 0.9
    @State private var opacity = 1.0
    @Environment(UserViewModel.self)var vm
    @Environment(LogViewModel.self)var vmLog
    @Environment(MangasViewModel.self)var vmManga
    var body: some View {
        
        VStack{
            if isActive{
                
                TabBar()
            }else {
                ZStack {
                    Color.coHueso
                        .ignoresSafeArea()
                    VStack {
                        VStack {
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.size.width/1.1, height: UIScreen.main.bounds.size.height/1.1)
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear {
                            
                            withAnimation(.easeOut(duration: 1.2)) {
                                self.size = 0
                                self.opacity = 0
                            }
                        }
                    }
                }
                .onAppear {
                    let token = userDefaults.string(forKey: "savedToken")
                    NetworkHelper.shared.setToken(tokens: "\(token ?? "")")
                    Task{ await vm.getNewToken()
                        if vm.changetoken{
                            vmLog.isLogede = true
                             vmManga.loadFavorites()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    SplashView()
        .environment(UserViewModel())
        .environment(LogViewModel())
}
