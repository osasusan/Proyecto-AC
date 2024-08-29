//
//  AuthorListName.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 25/8/24.
//

import SwiftUI

struct AuthorListName: View {
    
    @Environment(MangasViewModel.self) var vm
    @State var autorTosearch = ""
    var body: some View {
        ZStack{
            Color.customColor.ignoresSafeArea()
            ScrollView{
                VStack{
                    if let errorMensage = vm.errorMensage{
                        Text(errorMensage)
                            .foregroundStyle(.red)
                            .background(.white)
                            .padding()
                    }else{
                        if !vm.shAuthor.isEmpty{
                            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 16) {
                                ForEach(vm.shAuthor,id: \.id){author in
                                    NavigationLink {
                                        ViewMangas(conten: author.id,num: 8)
                                    } label: {
                                        ThemesComponet(theme: author.firstName + " " + author.lastName)
                                    }
                                }
                            }
                        } else {
                            Text("Author not found")
                                .bold()
                                .font(.title2)
                                .fontWidth(.compressed)
                        }
                    }
                }
            }
        }
        .onAppear{
            Task{
                await vm.sharchAuthor(content:autorTosearch)
            }
        }
    }
}
#Preview {
    AuthorListName(autorTosearch: "akira")
        .environment(MangasViewModel())
}
