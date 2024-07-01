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
                imageAsinc(imagen: manga?.mainPicture ?? "nil", width: 100, height: 160, radio: 20)
                
                
                
                HStack(alignment: .center){
                    VStack(alignment:.leading) {
                        Text("\(manga?.title ?? "Error")")
                            .lineLimit(3)
                            .font(.footnote)
                            .fontWeight(.regular)
                            .fontWidth(.compressed)
                        
                            .frame(height: 50,alignment: .topLeading)
                            .padding(.top,5)
                        
                        //                            .padding(.top,5)
                        //                            .fixedSize(horizontal: false, vertical: true)
                    }
                    // boton el cuan te saca un desplegable donde lo puedes añadir a una favoritos o a una collecion
                    
                    Spacer()
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
        .frame(width: 100, height: 225)
    }
}

struct MangaComponetDetalle:View{
    var manga:Item?
    
    var body: some View {
        VStack(spacing:10){
            HStack(alignment: .center){
                imageAsinc(imagen: manga?.mainPicture ?? "nil", width: 150, height: 240,radio: 20)
                
                HStack(alignment: .bottom){
                    VStack(alignment:.leading) {
                        Text(manga?.title ?? "Error")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .fontWidth(.compressed)
                            .frame(width: 160,height: 100,alignment: .topLeading)
                           
                        Spacer()
                        Text("\(manga?.authors?.first?.firstName ?? "4") \(manga?.authors?.first?.lastName ?? "3")")
                            .font(.footnote)
                            .fontWeight(.light)
                            .fontWidth(.compressed)
                        HStack{
                            
                            Text(unixToDate(date: manga?.startDate ?? "fecha de inicio sin definir"))
                                .font(.footnote)
                                .fontWeight(.light)
                                .fontWidth(.compressed)
                            
                            Spacer()
                            Text(String(format: "%.2f",manga?.score ?? 0.0))
                                .font(.footnote)
                            
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
        }
        .frame(height: 230)
        .padding()
    }
}

struct MangaDetailVeiw :View {
    var manga:Item?
    
    var body: some View{
        ScrollView{
            VStack{
                imageAsinc(imagen: manga?.mainPicture ?? "nil",width:360,height: 600,radio: 0)
                mangaName(mangaName: manga?.title ?? "manga sin Nombre" , width: 330)
            }
        }
    }
}

#Preview("MangaComponet") {
    ZStack{
        Color.gray
            .ignoresSafeArea()
        MangaComponet(manga: nil)
    }
}
#Preview("MangaComponetDetalle"){
    ZStack{
        Color.gray
            .ignoresSafeArea()
        MangaComponetDetalle(manga: nil)
    }
}
#Preview("MangaDetailVeiw"){
    ZStack{
        Color.gray
            .ignoresSafeArea()
        MangaDetailVeiw(manga: nil)
    }
}
