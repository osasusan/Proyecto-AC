//
//  loginVeiwModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 26/6/24.
//

import Foundation
@MainActor
class LoginVeiwModel : ObservableObject{
    
    
    @Published var email : String = "jcfmunoz@icloud.com"
    @Published var pass : String = ""
    @Published var token : String = ""
    @Published var errorMensage :String?
    @Published var errorMensage2 :String?
    
    
    
    func logUser(user:String,pass:String)async {
        do{
            let response = try await login(username:user,pass:pass)
            print(response)
            NetworkHelper.shared.setToken(tokens: response)
           
        }catch let error as NetworkError.networkErrorEnum{
            errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
            print("Failed to fetch mangas: \(error.customLocalizedDescription)")
        }catch{
            errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
            errorMensage = errorMensage2
        }
    }
  private func login(username:String,pass:String) async throws -> String{
        
        let url = URL.URLLogin
        let userRequies : [String:Any] = [
            "email" : username,
            "password": pass
        ]
        let (data,response) = try await NetworkHelper.shared.requiesProvider(true, url: url, type:.POST, params: userRequies,username,pass)
        
        guard let httpResonse = response as? HTTPURLResponse,(200..<599).contains(httpResonse.statusCode)else{
            
            return NetworkError.networkErrorEnum.authenticationError.customLocalizedDescription
        }
        do{
            if let token = String(data: data, encoding: .utf8) {
                return token
            }else{
                throw NetworkError.networkErrorEnum.invalidData
            }
        }catch{
            throw error
        }
    }
    
    func onError(error: String) -> Error{
        return NetworkError.networkErrorEnum.validationError(error)
    }
}
