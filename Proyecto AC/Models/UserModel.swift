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
        case password = "pass"
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<UserModel.CodingKeys> = try decoder.container(keyedBy: UserModel.CodingKeys.self)
        
        self.email = try container.decode(String.self, forKey: UserModel.CodingKeys.email)
        self.password = try container.decode(String.self, forKey: UserModel.CodingKeys.password)
        
    }
    
    func encode(to encoder: any Encoder) throws {
        var container: KeyedEncodingContainer<UserModel.CodingKeys> = encoder.container(keyedBy: UserModel.CodingKeys.self)
        
        try container.encode(self.email, forKey: UserModel.CodingKeys.email)
        try container.encode(self.password, forKey: UserModel.CodingKeys.password)
    }
    
}

