//
//  NetworkProtocols.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/5/24.
//

import Foundation

protocol NetworkProtocol {
    
 
    func requiesProvider(url: String, type: NetworkHelper.RequestType , params:[String: Any]?) async throws -> (Data, URLResponse)
}
extension NetworkProtocol {
    func requiesProvider(url: String, type: NetworkHelper.RequestType, params: [String: Any]?) async throws -> (Data, URLResponse){
        return try await requiesProvider(url: url, type: type, params: nil)
    }
    
}
