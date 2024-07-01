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
    public static let shared = NetworkHelper()
    
    private func requestApi(request : URLRequest) async throws -> (Data, URLResponse){
        return try await URLSession.shared.data(for: request)
    }
    
    func requiesProvider(_ neToken : Bool ,url : URL ,type : RequestType ,params :[String: Any]?/*,_ username:String? ,_ password:String?*/)async throws -> (Data,URLResponse){
        
        guard !url.absoluteString.isEmpty else {
            throw NetworkError.networkErrorEnum.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        
        if let diction = params {
            let data = try JSONSerialization.data(withJSONObject: diction, options: [])
            request.httpBody = data
            
        }
//        if neToken == true{
//
//            let token = "------------------f----------"
//            request.addValue("Bearer" + token , forHTTPHeaderField: "App-Token")
////            request.addValue("Basic \(String(describing: username)):\(String(describing: password))" , forHTTPHeaderField: "Authorization")
//        }
        request.addValue("Bearer" , forHTTPHeaderField: "Authorization")
       
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        if let username = username, let password = password {
//            let credentials = "\(username):\(password)"
//            guard let credentialsData = credentials.data(using: .utf8) else {
//                throw NetworkError.networkErrorEnum.invalidData
//            }
//            let base64Credentials = credentialsData.base64EncodedString()
//            request.addValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
//        }
        return try await requestApi(request: request)
    }
}
