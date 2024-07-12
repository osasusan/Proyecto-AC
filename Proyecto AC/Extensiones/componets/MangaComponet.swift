//
//  MangaComponet.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 13/6/24.
//

import SwiftUI

struct MangaComponet: View {
    
    var manga : Item?
    var body: some View {
        VStack(spacing:3){
            LazyVStack{
                imageAsync(imagen: manga?.mainPicture ?? "nil", width: 100, height: 160, radio: 20)
                
                HStack(){
                    VStack(alignment:.leading) {
                        Text("\(manga?.title ?? "Error")")
                            .lineLimit(3)
                            .font(.footnote)
                            .fontWeight(.regular)
                            .fontWidth(.compressed)
                            .foregroundStyle(Color.white)
                            .frame(width: 65,height: 50,alignment: .topLeading)
                            .padding(.top,5)
                        
                    }
                    // boton el cuan te saca un desplegable donde lo puedes añadir a una favoritos o a una collecion
                    Button{
                        
                    }label:{
                        //Image(systemName: "star")
                        Image(systemName: "ellipsis",variableValue: 2)
                            .rotationEffect(.degrees(90))
                        
                    }
                    //                        .frame(height:15)
                }
            }
        }
        
        .shadow(radius: 1,x: 2)
        .frame(width: 100, height: 225)
    }
}

struct MangaComponetDetalle:View{
    var manga:Item?
    
    var body: some View {
        VStack(spacing:10){
            HStack(alignment: .center){
                imageAsync(imagen: manga?.mainPicture ?? "nil", width: 150, height: 240,radio: 20)
                
                HStack(alignment: .bottom){
                    VStack(alignment:.leading) {
                        VStack{
                            Text(manga?.title ?? "Error")
                                .font(.title3)
                                .lineLimit(4)
                                .fontWeight(.semibold)
                                .fontWidth(.compressed)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity,alignment: .topLeading)
                            
                        }
                        Spacer()
                        Text("\(manga?.authors?.first?.firstName ?? "4") \(manga?.authors?.first?.lastName ?? "3")")
                            .font(.footnote)
                            .fontWeight(.light)
                            .fontWidth(.compressed)
                            .foregroundStyle(.white)
                        
                        HStack{
                            
                            Text(unixToDate(date: manga?.startDate ?? "fecha de inicio sin definir"))
                                .font(.footnote)
                                .fontWeight(.light)
                                .fontWidth(.compressed)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            Text(String(format: "%.2f",manga?.score ?? 0.0))
                                .font(.footnote)
                                .foregroundStyle(.white)
                            // boton el cuan te saca un desplegable donde lo puedes añadir a una favoritos o a una collecion
                            
                            Button{
                                
                            }label: {
                                Image(systemName: "star")
                                    .scaledToFit()
                                    .frame(height:15)
                                    .padding(.bottom,2)
                            }
                            .frame(height:15)
                        }
                    }
                }
            }
            Divider()
        }
        .frame(height: 230)
        .padding()
        
    }
    
}

struct MangaDetailVeiw :View {
    var manga:Item?
    var notAvailable = "Data is not available"
    
    var body: some View{
        ScrollView{
            VStack{
                imageAsync(imagen: manga?.mainPicture ?? "nil",width:360,height: 600,radio: 0)
                mangaName(mangaName: manga?.title ?? "manga sin Nombre" , width: 330)
                trustInfo(camp: "Synopsis", manga:manga?.sypnosis ?? notAvailable )
                trustInfo(camp: "Background", manga:manga?.background ?? notAvailable )
                trustInfo(camp: "Volumens", manga:"\(String(describing: manga?.volumes?.description ?? notAvailable))")
                trustInfo(camp: "Generes", manga: manga?.genres?.map{$0.genre}.joined(separator: "\n") ?? notAvailable )
                trustInfo(camp: "Thems", manga:manga?.themes?.map{$0.theme}.joined(separator: "\n") ?? notAvailable )
                trustInfo(camp: "Demographics", manga: manga?.demographics?.map { $0.demographic! }.joined(separator: "\n") ?? "Data is not available")
                trustInfo(camp: "Authors", manga: manga?.authors?.map {
                    "\($0.firstName) \($0.lastName) -> \($0.role)"
                }.joined(separator: "\n") ?? notAvailable)
                trustInfo(camp: "Other title", manga:"Japan title:\(manga?.titleJapanese ?? notAvailable)\n English title: \(manga?.titleEnglish ?? notAvailable)" )
                trustInfo(camp: "Date", manga:"Inicio: \(unixToDate(date: manga?.startDate ?? notAvailable))\nFinal: \(unixToDate(date:manga?.endDate ?? notAvailable))")
            }
        }
        .background(Color.customColor)
    }
    
}

struct trustInfo :View{
    var camp:String
    var manga:String
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
                        Text(manga)
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

#Preview("MangaComponet") {
    ZStack{
        Color.customColor
            .ignoresSafeArea()
        MangaComponet(manga: nil)
    }
}
#Preview("MangaComponetDetalle"){
    ZStack{
        Color.customColor
            .ignoresSafeArea()
        MangaComponetDetalle(manga: nil)
    }
}
#Preview("MangaDetailVeiw"){
    ZStack{
        Color.customColor
            .ignoresSafeArea()
        MangaDetailVeiw(manga: nil)
    }
}
