//
//  ThemsComponet.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 21/6/24.
//

import SwiftUI

struct ThemsComponet: View {
    @State var theme: String?
    var body: some View {
        Button{
            print(theme ?? "error")
            
        }label: {
           Rectangle()
                .frame(width: 150,height: 50)
                .shadow(radius: 20)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .opacity(0.8)
                .foregroundStyle(.gray)
                .overlay{
                    VStack(alignment: .center){
                        Text(theme ?? "Hola que tal")
                            .lineLimit(2)
                            .font(.title2)
                            .fontWidth(.compressed)
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal,5)
        }
    }
}

#Preview {
    ThemsComponet(theme: nil)
}
