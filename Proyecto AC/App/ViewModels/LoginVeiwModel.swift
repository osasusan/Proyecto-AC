//
//  loginVeiwModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 26/6/24.
//

import Foundation
import Observation

@Observable class LoginVeiwModel {
    
     var email : String = "jcfmunoz@icloud.com"
     var pass : String = ""
     var token : String?
    var errorMensage :String?
   
    
    func logUser(user:String,pass:String)async {
        do{
            token = try await login(username:user,pass:pass)
            print(token ?? "")
            NetworkHelper.shared.setToken(tokens: token!)
      
        }catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    private func login(username:String,pass:String) async throws -> String{
        
        let url = URL.URLLogin
        
        let (data,response) = try await NetworkHelper.shared.requiesProvider(true, url: url, type:.POST, params: nil,username,pass)
        
        guard let httpResonse = response as? HTTPURLResponse,httpResonse.statusCode == 200 else{
            
            throw NetworkError.networkErrorEnum.authenticationError
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
