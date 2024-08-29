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
    private var userToken : String = ""
    
    func setToken(tokens:String){
        userToken = tokens
    }
    func getToken() -> String {
        return userToken
    }
    public static let shared = NetworkHelper()
    
    private func requestApi(request : URLRequest) async throws -> (Data, URLResponse){
        return try await URLSession.shared.data(for: request)
    }
    //MARK: METODOS PUBLICOS PARA PETICION A API

    func requiesProviderUser(url : URL ,type : RequestType ,_ username:String? ,_ password:String?)async throws -> (Data,URLResponse){
        
        guard !url.absoluteString.isEmpty else {
            throw NetworkError.networkErrorEnum.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        let token = "-------------------------------"
        
        request.addValue( token , forHTTPHeaderField: "App-Token")
        if let username = username, let password = password {
            let credentials = "\(username):\(password)"
            guard let credentialsData = credentials.data(using: .utf8) else {
                throw NetworkError.networkErrorEnum.invalidData
            }
            let credentialsEncode = credentialsData.base64EncodedString()
            
            request.addValue("Basic \(credentialsEncode)", forHTTPHeaderField: "Authorization")
        }
        
        return try await requestApi(request: request)
    }
    
    func requiesProvider( url : URL ,type : RequestType ,params : [String: Any]?)async throws -> (Data,URLResponse){
        
        guard !url.absoluteString.isEmpty else {
            throw NetworkError.networkErrorEnum.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        
        if let dictionary = params {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            request.httpBody = data
            
        }
        request.addValue("Bearer \( getToken())", forHTTPHeaderField: "Authorization")
        let token = "------------------------------------"
        request.addValue("\(token)", forHTTPHeaderField: "App-Token")
       
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        return try await requestApi(request: request)
    }
    
}
