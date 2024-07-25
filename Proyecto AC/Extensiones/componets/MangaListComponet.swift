//
//  MangaListComponet.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 24/7/24.
//

import SwiftUI

struct MangaListComponet: View {
    @State var manga:Item?
    var body: some View {
        
        VStack(spacing:10){
            HStack(alignment: .center){
                imageAsync(imagen: manga?.mainPicture ?? "nil", width: 150, height: 220,radio: 20)
                    .padding()
                VStack(alignment:.leading) {
                    
                    Text(manga?.title ?? "Error")
                        .font(.title3)
                        .lineLimit(4)
                        .fontWeight(.semibold)
                        .fontWidth(.compressed)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity,alignment: .topLeading)
                        .padding(.bottom,60)
                    Text("\(manga?.authors?.first?.firstName ?? "4") \(manga?.authors?.first?.lastName ?? "3")")
                        .font(.footnote)
                        .fontWeight(.light)
                        .fontWidth(.compressed)
                        .foregroundStyle(.white)
                    
                    Text(unixToDate(date: manga?.startDate ?? "fecha de inicio sin definir"))
                        .font(.footnote)
                        .fontWeight(.light)
                        .fontWidth(.compressed)
                        .foregroundStyle(.white)
                }
            }
        }
        .frame(height: 230)
    }
}

#Preview {
    MangaListComponet()
}
