//
//  SearcheAndFilterBar.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 10/7/24.
//

import SwiftUI

struct SearcheAndFilterBar: View {
    var body: some View {
        ZStack{
            HStack{
                Image(systemName: "magnifyingglass")
                VStack(alignment: .leading,spacing: 3){
                    Text("¿Que manga quieres ver?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Text("Cualquier geneto · Cualquier tema · Autores")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .foregroundStyle(.black)
                }
                
            }
            
            .padding(.horizontal,8)
            .padding(.vertical,5)
            .overlay{
                Capsule()
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(Color(.systemGray4))
                    .shadow(color: .black.opacity(0.6), radius:3)
            }
            
            
            .padding(.horizontal,16)
        }
        .background(Color.clear)
            
        }
}
#Preview {
    SearcheAndFilterBar()
}
