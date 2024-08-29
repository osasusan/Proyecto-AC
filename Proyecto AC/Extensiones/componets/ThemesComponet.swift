//
//  ThemesComponet.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 21/6/24.
//

import SwiftUI

struct ThemesComponet: View {
    @State var theme: String = "hola que tal "
  
//    @EnvironmentObject var vm : MangasViewModel
    var body: some View {
       
           Rectangle()
                .frame(width: 140,height: 50)
                .shadow(radius: 20)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .opacity(0.8)
                .foregroundStyle(.gray)
                .overlay{
                    VStack(alignment: .center){
                        Text(theme)
                            .lineLimit(2)
                            .font(.title2)
                            .fontWidth(.compressed)
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal,3)
        }
    
    
}


#Preview {
    ThemesComponet()
}
