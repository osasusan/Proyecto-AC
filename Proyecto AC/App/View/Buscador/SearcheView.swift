//
//  SearcheView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 17/7/24.
//

import SwiftUI
struct verSearcheView:View {
    @State var ver:Bool = true
    var body: some View {
        SearcheView(show: $ver)
    }
}
struct SearcheView: View {
    //   @EnvironmentObject private var vm : MangasViewModel
    //    @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @State var buscar : String = ""
    @Binding var show : Bool
    var body: some View {
        if show{
            ScrollView(showsIndicators: false){
                VStack(alignment:.leading){
                    Button{
                        withAnimation(.smooth){
                            show.toggle()
                        }
                        
                    }label:{
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 40,height: 40)
                    }
                    Capsule()
                        .frame(width: 350,height: 60)
                        .foregroundStyle(.gray)
                        .overlay {
                            
                            TextField("Search manga",text: $buscar)
                                .font(.title2)
                                .padding(.horizontal)
                        }
                    
                    trustInfo2(camp: "Genres", num: 1 )
                    
                    trustInfo2(camp: "Themes", num: 2 )
                    trustInfo2(camp: "Demographics", num: 3 )
                    
                    Spacer()
                }
                .frame(width:350)
            }
        }
    }
    
}
struct trustInfo2 :View{
    var camp:String
    var num:Int
    @State private var isTrustInfoExpanded = false
    var body: some View{
        VStack(spacing:2){
            Button{
                withAnimation {
                    isTrustInfoExpanded.toggle()
                }
            }label: {
                HStack{
                    Image(systemName: "lock")
                        .foregroundColor(.primary)
                    Text(camp)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isTrustInfoExpanded ? 0 : -90))
                    
                }
                .font(.headline.weight(.semibold))
                .fontWidth(.compressed)
                .padding()
            }
            .background(Color.gray)
            if isTrustInfoExpanded{
                ZStack{
                    Color.gray.opacity(0.3)
                    VStack(alignment: .leading, spacing: 0) {
                        listaTemas(nume: num)
                            .font(.headline)
                            .fontWidth(.compressed)
                    }
                    
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
                    
                    
                    .padding()
                }
            }
        }
        .compositingGroup()
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding()
    }
}

#Preview {
    verSearcheView()
        .environment(MangasViewModel())
}
