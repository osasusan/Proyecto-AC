//
//  UserModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 15/6/24.
//

import Foundation

struct UserModel:Codable{
    let email : String
    let password : String
    
    enum CodingKeys: String,CodingKey {
        case email
        case password 
    }
}
struct UserColectionRequest: Codable {
    var manga: Int
    var completeCollection: Bool
    var volumesOwned: [Int]
    var readingVolume: Int?
}


