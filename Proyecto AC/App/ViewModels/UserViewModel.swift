//
//  UserViewModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 29/7/24.
//

import Foundation


@Observable class UserViewModel {
    var alet = ""
    var token  = NetworkHelper.shared.getToken()
    var userCollections: [UserCollection] = []
    var userCollectionsID: UserCollection?

    // renovar token
    func getNewToken() async {
        do{
           
            let newToken = try await renewToken()
            NetworkHelper.shared.setToken(tokens: newToken)
            print(newToken)
        }catch{
            token = error.onErrorResposnse()
        }
        
    }
    private func renewToken () async throws -> String{
       let (data,response) = try await NetworkHelper.shared.requiesProvider(url: URL.URLReToken, type: .POST, params: nil)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
            throw NetworkError.networkErrorEnum.badRequest
        }
        do{
            if let token = String(data: data,encoding: .utf8){
               
                return token
            } else{
                throw NetworkError.networkErrorEnum.badRequest
            }
        }catch{
            throw error
        }
    }
    //
    
    //   crear colleccion
    func newColletion () async{
        do{
            self.alet = try await createNewCollection(manga: 19, isComplete: false, volumesOwned: [1,2,3,5,6,7,8,9,10,11], readingVolume: 5)
        }catch{
            alet = error.onErrorResposnse()
        }
    }
    private func createNewCollection(manga:Int,isComplete:Bool,volumesOwned:[Int],readingVolume:Int) async throws-> String {
        let parametros:[String:Any] = [
            "manga": manga,
            "completeCollection" : isComplete,
            "volumesOwned" : volumesOwned,
            "readingVolume" : readingVolume
        ]
        let(_,response) = try await NetworkHelper.shared.requiesProvider(url: URL.URLNewCollection,type: .POST, params: parametros)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 201  else {
            throw NetworkError.networkErrorEnum.badRequest
        }
        let oksas = "todo bien"
        return oksas
        
    }
    
    func showUserCollection ()async{
        
        do{
            self.userCollections = try await userCollections()
        }catch{
            alet = error.onErrorResposnse()
        }
    }
    private func userCollections() async throws -> [UserCollection]{
        let (data,response) = try await NetworkHelper.shared.requiesProvider(url: URL.URLUserCollection, type: .GET, params: nil)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
            throw NetworkError.networkErrorEnum.failed
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do{
            let response = try decoder.decode([UserCollection].self,from: data)
            return response
        }catch{
            throw error
        }
        
    }
    func buscarColecionPorID()async{
        do{
            self.userCollectionsID = try await shearchidCollection(id: "19")
        }catch{
            alet = error.onErrorResposnse()
        }
    }
    
    private func shearchidCollection(id:String)async throws -> UserCollection {
        
        let url = URL.PutContet(url: URL.URLUserCollectionID, content: id)
        let (data, response) = try await NetworkHelper.shared.requiesProvider(url: url, type: .GET, params: nil)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
            throw NetworkError.networkErrorEnum.invalidData
        }
        let decoder = JSONDecoder()
        
        do{
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(UserCollection.self, from: data)
            return response
            
        }catch{
            
            throw error
        }
    }
}
