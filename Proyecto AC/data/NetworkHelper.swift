//
//  NetworkHelper.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/5/24.
//

import Foundation



class NetworkHelper : NetworkProtocol {
    enum RequestType : String{
        case POST
        case GET
        case PUT
        case DELETE
    }
    
    private func requestApi(request : URLRequest) async throws -> (Data, URLResponse){
        return try await URLSession.shared.data(for: request)
    }

    func requiesProvider (url : String ,type : RequestType ,params :[String: Any]? )async throws -> (Data,URLResponse){
        
        guard let urlNotNil = URL(string: url) else {
            throw NetworkError.networkErrorEnum.invalidUrl
        }
        var request = URLRequest(url: urlNotNil)
        request.httpMethod = type.rawValue
        
        
        if let diction = params {
            let data = try JSONSerialization.data(withJSONObject: diction, options: [])
            request.httpBody = data
            
        }
        
        request.addValue("Bearer" , forHTTPHeaderField: "Authorization")
        
        request.addValue("application/json", forHTTPHeaderField: "Contetn-Type")
        return try await requestApi(request: request)
    }
}
