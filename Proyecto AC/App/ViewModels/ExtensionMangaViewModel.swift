//
//  ExtensionMangaViewModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 14/6/24.
//

import Foundation

extension MangasViewModel{
    
    // Listado de mangas general
    func fetchMangas(pages:Int) async throws -> MangasResponse{
        
        let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/mangas?page=\(pages)&per=20"
        
        let (data, response) = try await sareed.requiesProvider(url: url ,type: .GET, params: nil)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else{
            throw NetworkError.networkErrorEnum.badRequest
        }
        JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let response = try JSONDecoder().decode(MangasResponse.self, from: data)
            return response
        } catch {
            print("Error decoding JSON: \(NetworkError.networkErrorEnum.badRequest)")
            print(error.localizedDescription)
            throw NetworkError.networkErrorEnum.badRequest
        }
    }
    // Listado de TOp mangas
    func topMangas(pages: Int) async throws -> MangasResponse {
        
        let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/bestMangas?page=\(pages)&per=20"
        
        let (data , respose) = try await sareed.requiesProvider(url: url, type: .GET, params: nil)
        
        guard let httpRespose = respose as? HTTPURLResponse, httpRespose.statusCode == 200 else {
            throw NetworkError.networkErrorEnum.badRequest
        }
        JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
        do{
            let response = try JSONDecoder().decode(MangasResponse.self, from: data)
            print(data)
            return response
        }catch{
            print("Error decoding JSON: \(NetworkError.networkErrorEnum.badRequest)")
            print(error.localizedDescription)
            throw NetworkError.networkErrorEnum.badRequest
        }
    }
    // Listado de generos de manga
    func mangaGen(pages: Int,gen:String) async throws -> MangasResponse {
        
        let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/mangaByGenre/\(gen)?page=\(pages)&per=20"
        
        //        let (data , respose) = try await helperr.requiesProvider(url: url, type: .GET, params: nil)
        let (data , respose) = try await sareed.requiesProvider(url: url, type: .GET, params: nil)
        
        guard let httpRespose = respose as? HTTPURLResponse, httpRespose.statusCode == 200 else {
            throw NetworkError.networkErrorEnum.badRequest
        }
        
        JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
        do{
            let response = try JSONDecoder().decode(MangasResponse.self, from: data)
            return response
        }catch{
            print("Error decoding JSON: \(NetworkError.networkErrorEnum.badRequest)")
            print(error.localizedDescription)
            throw NetworkError.networkErrorEnum.badRequest
        }
    }
    // Listado de Generos
    func getGens() async throws -> [String] {
        let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/genres"
        do{
            let (data , response) = try await NetworkHelper.shared.requiesProvider(url: url, type: .GET, params: nil)
            guard let httpRespose = response as? HTTPURLResponse, httpRespose.statusCode == 200 else {
                throw NetworkError.networkErrorEnum.badRequest
            }
            
            let decoder = JSONDecoder()
            do{
                let themes = try decoder.decode([String].self, from: data)
                
                return themes
            } catch {
                print("Error decoding JSON: \(error)")
                throw NetworkError.networkErrorEnum.badRequest
            }
        }catch{
            
            print(error.localizedDescription)
            throw error
        }
    }
    // Listado de temas de mangas
    func getThema() async throws -> [String] {
        let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/themes"
        do{
            let (data , response) = try await NetworkHelper.shared.requiesProvider(url: url, type: .GET, params: nil)
            guard let httpRespose = response as? HTTPURLResponse, httpRespose.statusCode == 200 else {
                throw NetworkError.networkErrorEnum.badRequest
            }
            
            let decoder = JSONDecoder()
            do{
                let themes = try decoder.decode([String].self, from: data)
                
                return themes
            } catch {
                print("Error decoding JSON: \(error)")
                throw NetworkError.networkErrorEnum.badRequest
            }
        }catch{
            print(error.localizedDescription)
            throw error
        }
    }
    //Listado de demografias de mangas
    
    func listMangaDemos(pages: Int,gen:String) async throws -> MangasResponse {
        
        let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/mangaByDemographic/\(gen)?page=\(pages)&per=20"
        
        //        let (data , respose) = try await helperr.requiesProvider(url: url, type: .GET, params: nil)
        let (data , respose) = try await sareed.requiesProvider(url: url, type: .GET, params: nil)
        
        guard let httpRespose = respose as? HTTPURLResponse, httpRespose.statusCode == 200 else {
            throw NetworkError.networkErrorEnum.badRequest
        }
        
        JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
        do{
            let response = try JSONDecoder().decode(MangasResponse.self, from: data)
            return response
        }catch{
            print("Error decoding JSON: \(NetworkError.networkErrorEnum.badRequest)")
            print(error.localizedDescription)
            throw NetworkError.networkErrorEnum.badRequest
        }
    }
    //Listado de Demografias
    func getDemos() async throws -> [String] {
        let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/demographics"
        do{
            let (data , response) = try await NetworkHelper.shared.requiesProvider(url: url, type: .GET, params: nil)
            guard let httpRespose = response as? HTTPURLResponse, httpRespose.statusCode == 200 else {
                throw NetworkError.networkErrorEnum.badRequest
            }
            
            let decoder = JSONDecoder()
            do{
                let themes = try decoder.decode([String].self, from: data)
                return themes
            } catch {
                print("Error decoding JSON: \(error)")
                throw NetworkError.networkErrorEnum.badRequest
            }
        }catch{
            
            print(error.localizedDescription)
            throw error
        }
    }
    
    //Listado de Autores
    
    func getAuthor() async throws -> [Author] {
        let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/list/authors"
        do{
            let (data, response) = try await NetworkHelper.shared.requiesProvider(url: url, type: .GET, params: nil)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                throw NetworkError.networkErrorEnum.badRequest
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do{
                let response = try decoder.decode([Author].self,from: data)
                return response
            }catch{
                throw NetworkError.networkErrorEnum.requestFailed
            }
        }catch{
            print(error.localizedDescription)
            throw error
        }
    }
    
    func getMangaID(id: Int) async throws -> Item{
        let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/search/manga/\(id)"
        
        let (data,response) = try await sareed.requiesProvider(url: url, type: .GET, params: nil)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
            throw NetworkError.networkErrorEnum.badRequest
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do{
            
            let response = try decoder.decode(Item.self,from: data)
            print(response)
            return response
            
        }catch{
            throw NetworkError.networkErrorEnum.requestFailed
        }
    }
    // buscada por contenido
    
    func mangaContais(conten: String ,pages:Int)async throws -> MangasResponse {
        do{
            let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/search/mangasContains/\(conten)?page=\(pages)&per=20"
            let (data,response) = try await sareed.requiesProvider(url: url, type: .GET, params: nil)
            guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
                throw NetworkError.networkErrorEnum.badRequest
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do{
                let response = try decoder.decode(MangasResponse.self,from: data)
                return response
            } catch{
                throw NetworkError.networkErrorEnum.requestFailed
            }
        }catch{
            throw error
        }
    }
    //empieza por 
    func mangaBegings(conten: String)async throws -> Item {
        do{
            let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/search/mangasBeginsWith/\(conten)"
            let (data,response) = try await sareed.requiesProvider(url: url, type: .GET, params: nil)
            guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
                throw NetworkError.networkErrorEnum.badRequest
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do{
                let response = try decoder.decode(Item.self,from: data)
                print(response)
                return response
            } catch{
                throw NetworkError.networkErrorEnum.requestFailed
            }
        }catch{
            print(error.localizedDescription)
            throw error
        }
    }
}
