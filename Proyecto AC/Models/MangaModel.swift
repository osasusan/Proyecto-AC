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
    let items: [Manga]
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
struct APIErrorResponse:Codable {
    let reason: String
    let error: Bool
}
struct Manga : Codable{
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
}

struct User: Codable {
    let id: String
}

// MARK: - UserCollection
struct UserCollection: Codable {
    let readingVolume: Int
    let user: User
    let completeCollection: Bool
    let id: String
    let manga: Manga
    let volumesOwned: [Int]
}








