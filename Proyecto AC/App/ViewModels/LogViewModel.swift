//
//  LogViewModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 26/6/24.
//

import Foundation
import Observation

@Observable class LogViewModel{
    
    var email : String = "jcfmunoz@icloud.com"
    var newEmail : String = ""
    var pass : String = ""
    var newPass : String = ""
    var newPass2 : String = ""
    var token : String?
    var errorMensage :String?
    var isLogede = false
    let userDefaults = UserDefaults.standard
    // inicio de sesion
    func logUser(user:String,pass:String) async {
        do{
            let (token,error) = try await login(username:user,pass:pass)
            print(token!)
            
            isLogede = true
            errorMensage = ""
            NetworkHelper.shared.setToken(tokens: token!)
            userDefaults.set(token, forKey: "savedToken")
            if (error != nil){
                errorMensage = error?.reason.description
            }
            
        }catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    private func login(username:String,pass:String) async throws -> (String?,APIErrorResponse?){
        
        let url = URL.URLLogin
        
        let (data,response) = try await NetworkHelper.shared.requiesProviderUser(url: url, type:.POST,username,pass)
        
        guard let httpResonse = response as? HTTPURLResponse,httpResonse.statusCode == 200 else{
            
            throw NetworkError.networkErrorEnum.authenticationError
        }
        do{
            if let token = String(data: data, encoding: .utf8) {
                return (token,nil)
            }else{
                let apiError = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                return (nil, apiError)
            }
        }catch{
            throw error
        }
    }
    
    //new User
    func newUser(user:String,pass:String) async {
        do{
            let (menasage,apiError) = try await createAcaunt(username:user,pass:pass)
            if let menasage = menasage {
                print(menasage)
                errorMensage = ""
            }else{
                errorMensage = NetworkError.networkErrorEnum.validationError(apiError!.reason).customLocalizedDescription
            }
        }catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    private func createAcaunt(username:String,pass:String) async throws -> (String?,APIErrorResponse?){
        let url = URL.URLCreateAccout
        let newUser : [String: Any] = [
            "email": username,
            "password": pass
        ]
        
        let (data,response) = try await NetworkHelper.shared.requiesProvider(url: url, type: .POST, params: newUser)
        guard let httpResponse = response as? HTTPURLResponse ,(200..<599).contains(httpResponse.statusCode) else {
            throw NetworkError.networkErrorEnum.invalidData
        }
        
        do {
            if httpResponse.statusCode == 201 {
                return ("Usuario creado", nil)
            } else {
                // Si el código de estado no es 201, decodificar la respuesta de error
                let apiError = try JSONDecoder().decode(APIErrorResponse.self, from: data)
                return (nil, apiError)
            }
        } catch {
            // Manejar errores de decodificación
            throw error
        }
    }
    
    func logOut() {
        userDefaults.removeObject(forKey: "savedToken")
        userDefaults.removeObject(forKey: "favorites")
        
        NetworkHelper.shared.setToken(tokens: "")
        isLogede = false
    }
}

