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
    var userCollection: [UserCollection] = []
    var userCollectionsID: UserCollection?
    var idManga : Int?
    var isComplet : Bool = false
    var isEliminated : Bool = false
    var volumesOwned : String = ""
    var readingVolume : Int?
    var menssageError : String?
    var menssageBien : String?
    var changetoken :Bool =  false
    
    let userDefaults = UserDefaults.standard
    // renovar token
    func getNewToken() async {
        do{
            let newToken = try await renewToken()
            NetworkHelper.shared.setToken(tokens: newToken)
            userDefaults.set(newToken, forKey: "savedToken")
            print(newToken)
            menssageError = ""
            changetoken = true
        }catch{
           
            menssageError = error.onErrorResposnse()
            userDefaults.removeObject(forKey: "savedToken")
            changetoken = false
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
    func newColletion (id:Int,isComplet:Bool,volumesOwned:String,readingVolume:Int) async{
        do{
            let ownedVolumesArray = parseVolumesOwned(volumesOwned)
            self.menssageBien = try await createNewCollection(manga: id , isComplete: isComplet, volumesOwned: ownedVolumesArray, readingVolume: readingVolume)
           
        }catch{
            alet = error.onErrorResposnse()
        }
        
        func parseVolumesOwned(_ volumesOwned: String) -> [Int] {
            //paso el String a un Int  para lugo hacer un rago de 1 hasta numero indicado
            guard let endVolume = Int(volumesOwned.trimmingCharacters(in: .whitespaces)) else {
                return []
            }
            return Array(1...endVolume)
        }
    }
    private func createNewCollection(manga:Int,isComplete:Bool,volumesOwned:[Int],readingVolume:Int) async throws-> String {
        do{
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
            let ok = "The collection has been added successfully"
            return ok
        }catch{
            throw error
        }
    }
    
    
    // ver collecione
    func showUserCollection ()async{
        
        do{
            self.userCollection = try await userCollections()
        }catch{
            alet = error.onErrorResposnse()
        }
    }
    private func userCollections() async throws ->[UserCollection]{
        let (data,response) = try await NetworkHelper.shared.requiesProvider(url: URL.URLUserCollection, type: .GET, params: nil)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
            throw NetworkError.networkErrorEnum.badRequest
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
    
    // uscar colleccion por ID
    func buscarColecionPorID(id:String)async{
        do{
            self.userCollectionsID = try await shearchIdCollection(id: id)
        }catch{
            alet = error.onErrorResposnse()
        }
    }
    
    private func shearchIdCollection(id:String)async throws -> UserCollection {
        
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
    
    
    // Borrar Collecion
    func delMangaColle(id :String) async{
        do{
            self.menssageBien = try await deleteMnagaColletion(id: id)
            isEliminated.toggle()
            
        }catch{
            menssageError = error.onErrorResposnse()
            isEliminated.toggle()
        }
    }
    
    func deleteMnagaColletion(id:String) async throws ->String{
        
        let url = URL.PutContet(url: URL.URLDelateCollectionID, content: id)
        let (_, response) = try await NetworkHelper.shared.requiesProvider(url: url, type: .DELETE, params: nil)
        guard let httpresponse = response as? HTTPURLResponse,httpresponse.statusCode == 200 else{
            throw NetworkError.networkErrorEnum.validationError("that maga isn't in your collection")
            
        }
        do{
            let response = "Collection has been eliminated "
            return response
        }
    }
}
