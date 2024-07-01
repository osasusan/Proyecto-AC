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
                AsyncImage(url: URL(string: cleanUrl(manga?.mainPicture ?? "nil"))){ phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        case .failure:
                            Image("Naruto")
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        default:
                            EmptyView()
                    }
                }
                .scaledToFit()
                .frame(width: 100,height: 160)
                
                HStack(alignment: .center){
                    VStack(alignment:.leading) {
                        Text("\(manga?.title ?? "Error")")
                            .lineLimit(3)
                            .font(.footnote)
                            .fontWeight(.regular)
                        
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
                AsyncImage(url: URL(string: cleanUrl(manga?.mainPicture ?? "nil"))){ phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        case .failure:
                            Image("Naruto")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 240)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        default:
                            EmptyView()
                    }
                }
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
                AsyncImage(url: URL(string: cleanUrl(manga?.mainPicture ?? "nil"))){ phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 390, height: 600)
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 390, height: 500)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        default:
                            EmptyView()
                    }
                    
                    Text(manga?.title ?? "Nombre del manga")
                        .frame(width: 330 ,alignment: .leading)
                        .font(.title)
                        .bold()
                        .fontWidth(.compressed)
                    
                }
            }
        }
        
    }
}
private func cleanUrl(_ urlString: String) -> String {
    var cleanedUrl = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
    cleanedUrl = cleanedUrl.replacingOccurrences(of: "\"", with: "")
    return cleanedUrl
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
