//
//  ExtensionMangaViewModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 14/6/24.
//

import Foundation

extension MangasViewModel{
    
    //     Listado de mangas general
    func fetchMangas(pages:Int ,_ per:Int) async throws -> MangasResponse{
        let url = URL.URLPagesChange(url: URL.URLMangas, page: pages, per: per)
        let (data, response) = try await sareed.requiesProvider(false, url: url ,type: .GET, params: nil,nil,nil)
        
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
    
    // Listado de Top mangas
    func topMangas(pages: Int,_ numero:Int) async throws -> MangasResponse {
        
        let url = URL.URLPagesChange(url: URL.URLTopMangas,page:pages, per:numero )
        
        let (data , respose) = try await sareed.requiesProvider(false, url: url, type: .GET, params: nil,nil,nil)
        
        guard let httpRespose = respose as? HTTPURLResponse, httpRespose.statusCode == 200 else {
            throw NetworkError.networkErrorEnum.badRequest
        }
        JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
        do{
            let response = try JSONDecoder().decode(MangasResponse.self, from: data)
            //            print(response)
            return response
        }catch{
            print("Error decoding JSON: \(NetworkError.networkErrorEnum.badRequest)")
            print(error.localizedDescription)
            throw NetworkError.networkErrorEnum.badRequest
        }
    }
    //     Listado de generos de manga
    func mangaGen(page:Int,gen:String ,per:Int) async throws -> MangasResponse {
        
        let url = URL.URLGenresMangaList
        let urlFinal = URL.ContetPages(url: url, contenido: gen, pages: page, por:per)
        
        let (data , respose) = try await sareed.requiesProvider(false, url:urlFinal, type: .GET, params: nil,nil,nil)
        
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
    //     Listado de Generos
    func getGens() async throws -> [String] {
        do{
            let (data , response) = try await NetworkHelper.shared.requiesProvider(false, url: URL.URLGens, type: .GET, params: nil,nil,nil)
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
        
        do{
            let (data , response) = try await NetworkHelper.shared.requiesProvider(false, url: URL.URLTemas, type: .GET, params: nil,nil,nil)
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
    
    func listMangaDemos(pages: Int,gen:String,_ per:Int) async throws -> MangasResponse {
        
        let urL = URL.URLDemosMangaList
        let funalURl = URL.ContetPages(url: urL, contenido: gen, pages:pages, por:per  )
        
        //        let (data , respose) = try await helperr.requiesProvider(url: url, type: .GET, params: nil)
        let (data , respose) = try await sareed.requiesProvider(false, url: funalURl, type: .GET, params: nil,nil,nil)
        
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
        
        do{
            let (data , response) = try await sareed.requiesProvider(false, url: URL.URLDemos, type: .GET, params: nil,nil,nil)
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
        do{
            let (data, response) = try await NetworkHelper.shared.requiesProvider(false, url: URL.URLAutor, type: .GET, params: nil,nil,nil)
            
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
    
    func getMangaID(id: String) async throws -> Item{
        let url = URL.PutContet(url: URL.URLMangasID, content: id)
        
        let (data,response) = try await sareed.requiesProvider(false, url: url, type: .GET, params: nil, nil , nil)
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
    
    //    func mangaContais(conten: String ,pages:Int)async throws -> MangasResponse {
    //        do{
    //            let url = "https://mymanga-acacademy-5607149ebe3d.herokuapp.com/search/mangasContains/\(conten)?page=\(pages)&per=20"
    //            let (data,response) = try await sareed.requiesProvider(false, url: url, type: .GET, params: nil, nil , nil)
    //            guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
    //                throw NetworkError.networkErrorEnum.badRequest
    //            }
    //            let decoder = JSONDecoder()
    //            decoder.keyDecodingStrategy = .convertFromSnakeCase
    //            do{
    //                let response = try decoder.decode(MangasResponse.self,from: data)
    //                return response
    //            } catch{
    //                throw NetworkError.networkErrorEnum.requestFailed
    //            }
    //        }catch{
    //            throw error
    //        }
    //    }
    //empieza por
    func mangaBegings(conten: String)async throws ->[Item]{
        do{
            let url = URL.PutContet(url: URL.URLmangaBegings, content: conten)
            
            let (data,response) = try await sareed.requiesProvider(false, url: url, type: .GET, params: nil,nil,nil)
            
            guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
                throw NetworkError.networkErrorEnum.badRequest
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do{
                let response = try decoder.decode([Item].self,from: data)
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

