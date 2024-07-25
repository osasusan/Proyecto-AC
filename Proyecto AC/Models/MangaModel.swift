//
//  MangaModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 13/6/24.
//

import Foundation
import SwiftData

struct MangasResponse: Codable {
    let metadata: Metadata?
    let items: [Item]
}

struct Demographic :Codable{
    let demographic : String?
    let id : String?
}
struct Theme:Codable {
    let theme: String
    let id: String
}

struct Genre:Codable{
    let id : String
    let genre : String
  
}
struct Author:Codable{
    let lastName: String
    let firstName: String
    let role: String
    let id: String
}

struct Metadata:Codable {
    let per: Int
    let page: Int
    let total: Int
}

class Item : Codable{
    
    let background: String?
    let title: String
    let url: String?
    let demographics: [Demographic]?
    let themes: [Theme]?
    let score: Double?
    let volumes: Int?
    let titleJapanese: String?
    let sypnosis: String?
    let genres: [Genre]?
    let mainPicture: String?
    let startDate: String?
    let id: Int
    let status: String?
    let chapters: Int?
    let authors: [Author]?
    let endDate: String?
    let titleEnglish: String?
    
    init(background: String?, title: String, url: String?, demographics: [Demographic]?, themes: [Theme]?, score: Double?, volumes: Int?, titleJapanese: String?, sypnosis: String?, genres: [Genre]?, mainPicture: String?, startDate: String?, id: Int, status: String?, chapters: Int?, authors: [Author]?, endDate: String?, titleEnglish: String?) {
        self.background = background
        self.title = title
        self.url = url
        self.demographics = demographics
        self.themes = themes
        self.score = score
        self.volumes = volumes
        self.titleJapanese = titleJapanese
        self.sypnosis = sypnosis
        self.genres = genres
        self.mainPicture = mainPicture
        self.startDate = startDate
        self.id = id
        self.status = status
        self.chapters = chapters
        self.authors = authors
        self.endDate = endDate
        self.titleEnglish = titleEnglish
    }
    
   
    
}
struct ItemsResponse :Codable{
    let items : [Item]
}






