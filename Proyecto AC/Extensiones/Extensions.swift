//
//  Extensions.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/6/24.
//

import Foundation
import SwiftUI



extension URL{
//    mangas
    static var URLMangas :URL{return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/mangas")!}
    static var URLTopMangas:URL {return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/bestMangas")!}
    
  // temas
    static var URLThemes:URL { return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/themes")!}
    static var URLMagasThemes:URL { return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/mangaByTheme/")!}
    
//    Autro
    static var URLAutor:URL { return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/authors")!}
    static var URLMangaAuthor:URL {return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/mangaByAuthor/998C1B16-E3DB-47D1-8157-8389B5345D03")!}
//    Generos
    static var URLGens:URL { return URL( string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/genres")!}
    static var URLGenresMangaList:URL {return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/mangaByGenre/")!}

//    Demografia
    static var URLDemosMangaList:URL {return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/mangaByDemographic/")!}
    static var URLDemos:URL { return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/demographics")!}
    
    //bUscadores de mangas
    static var URLmangaBegings:URL {return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/search/mangasBeginsWith/")!}
    static var URLmangaContais:URL {return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/search/mangasContains/")!}
    static var URLMangasID:URL {return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/search/manga/")!}
    
    static var URLLogin:URL {return URL(string:"https://mymanga-acacademy-5607149ebe3d.herokuapp.com/users/login")!}
  
    
    static func PutContet(url:URL ,content: String) -> URL{
        return  url.appendingPathComponent(content)
    }
    static func URLPagesChange(url: URL,page: Int,per:Int?) -> URL{
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per", value: "\(per ?? 20)")
        ]
        components?.queryItems = queryItems
        return components?.url ?? url
        
    }
    static func ContetPages(url:URL,contenido:String, pages:Int,por:Int?)-> URL {
        let contetPages = URL.PutContet(url: url, content:contenido )
        let UrlFinal = URL.URLPagesChange(url:contetPages,page: pages, per: por ?? 20)
        return UrlFinal
    }
}
//MARK: Formto de timpo unico
func unixToDate(date: String) -> String {
    // Crear un ISO8601DateFormatter
    let isoFormatter = ISO8601DateFormatter()
    
    // Convertir la cadena a un objeto Date
    if let isodate = isoFormatter.date(from: date) {
        // Extraer componentes de fecha (año, mes, día) sin la hora
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd,MMMM yyyy"
        return dayTimePeriodFormatter.string(from: isodate)
    }
    return date
    
}
extension View{
    func mangaName(mangaName:String,width:CGFloat)->some View{
        Text(mangaName)
            .frame(width: width ,alignment: .leading)
            .font(.title)
            .bold()
            .fontWidth(.compressed)
            .foregroundStyle(Color.white)
    }
    
    func imageAsync(imagen: String,width:CGFloat,height:CGFloat,radio:CGFloat)-> some View{
        VStack{
            AsyncImage(url: URL(string: cleanUrl(imagen))){ phase in
                switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            
                            .clipShape(RoundedRectangle(cornerRadius: radio))
                            .frame(width: width, height: height)
                    case .failure:
                        Image(systemName: "photo")
                            
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: radio))
                            .frame(width: width, height: height)
                    default:
                        EmptyView()
                }
            }
        }
    }
    
    //limpiar url de la Imgen
     func cleanUrl(_ urlString: String) -> String {
        var cleanedUrl = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanedUrl = cleanedUrl.replacingOccurrences(of: "\"", with: "")
        return cleanedUrl
    }
    func transparentListStyle() -> some View {
        self.modifier(TransparentListStyle())
    }
}
//MARK: Color priopio
extension Color{
    static var customColor :LinearGradient{
        LinearGradient(colors: [Color.pdark,Color.grDark], startPoint: .top, endPoint: .bottom)
    }
}
extension Error{
    func onErrorResposnse() -> String{
        if let errors = self as? NetworkError.networkErrorEnum {
            return "Failed to fetch mangas: \(errors.customLocalizedDescription)"
        }else{
            return "Failed to fetch mangas: \(self.localizedDescription)"
        }
    }
}


enum shFilter : String ,CaseIterable{
    case topMangas = "Top mangas"
    case temas = "Temas"
    case demos = "Demographics"
    case genres = "Generos"
}
