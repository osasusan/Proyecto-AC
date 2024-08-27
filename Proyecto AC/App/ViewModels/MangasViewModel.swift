//
//  MangasViewModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 13/6/24.
//

import Foundation


@Observable class MangasViewModel{
    var topMangas: [Manga] = []
    var favorites: [Manga] = []
    var allMangas: [Manga] = []
    var contenSh: [Manga] = []
    var contenBg:[Manga] = []
    var mangasId: Manga!
    var themes : [String] = []
    var mangaListThemes : [Manga] = []
    var mangaListGen : [Manga] = []
    var mangaListDemos : [Manga] = []
    var author : [Author] = []
    var shAuthor : [Author] = []
    var authorManga : [Manga] = []
    var generos : [String] = []
    var listaGenerosMnaga : [Manga] = []
    var demos : [String] = []
    var metadata: Metadata?
    var errorMensage: String?
    var errorMensage2: String?
    var searchM: String = ""
    var page = 1
    
    var sareed: NetworkProtocol
    
    init(sareed: NetworkProtocol = NetworkHelper()) {
        self.sareed = sareed
    }
    //MARK: FUNCIONES QUE MANEGAN LAS RESPUESTAS DE LAS DIFERENTES SOLICITUDES A LA API
    
    // respuesta de listado de todos los mangas.
    func listMangas(page:Int , _ per: Int) async {
        do {
            let response = try await allamngaList(pages: page, per)
            self.allMangas = response.items
            self.metadata = response.metadata
            errorMensage = nil
            // Mensage de error custom
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    // respuesta de listados de mangas de mayora a menor puntuacion
    func listTopMangas(page:Int,_ numeros:Int) async {
        do {
            let response = try await topMangas(pages: page, numeros )
            
            self.topMangas = response.items
            self.metadata = response.metadata
            errorMensage = nil
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    // lista de mangas de un genero escifico
    
    func listMangaGen(page:Int,gen: String )async {
        do {
            let response = try await mangaGen(page: page,gen: gen, per: 20)
            
            self.mangaListGen = response.items
            self.metadata = response.metadata
            errorMensage = nil
            // Mensage de error custom
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    //Lista de mangase de un tematica específica
    func listMangaThemes(page:Int,themes: String )async {
        do {
            let response = try await getMangaTheme(pages: page , theme: themes)
            
            self.mangaListThemes = response.items
            self.metadata = response.metadata
            errorMensage = nil
            // Mensage de error custom
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    
    //     listado de Mangas para un publico dirigido
    func listMangaDemo(page:Int,demos: String,_ per:Int)async {
        do {
            let response = try await listMangaDemos(pages: page,gen: demos,per)
            
            self.mangaListDemos = response.items
            self.metadata = response.metadata
            errorMensage = nil
            // Mensage de error custom
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    
    // respusta de listadp de generos
    func getGensResponse() async {
        do {
            self.generos = try await getGenres()
            //            print(generos)
            errorMensage = nil
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    //    listado de temas totales
    func getThemesResponse() async {
        do {
            self.themes = try await getThemes()
            //            print(themes)
            errorMensage = nil
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    //    listado de demogrtafias
    func getDemoResponse() async {
        do {
            self.demos = try await getDemos()
            //            print(demos)
            errorMensage = nil
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    //    Listado de autores
    func getAutor() async {
        do{
            self.author = try await getAuthor()
            errorMensage = nil
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    func getAutorManga(pages:Int,idAuthor:String) async {
        do{
            let response = try await getMangasAuhtor(pages: pages, author: idAuthor, 20)
            self.authorManga = response.items
            self.metadata = response.metadata
            errorMensage = nil
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    
    //MARK: Respuesta de buscadores
    
    //    busqueda de manga por ID
    func getIdManga(id : String) async {
        do{
            self.mangasId = try await getMangaID(id: id)
            errorMensage = nil
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    // contiene..
    func contaisMangaList(conten: String,page:Int)async {
        do {
            let response = try await mangaContais(conten: conten, pages: page,20)
            self.contenSh = response.items
            self.metadata = response.metadata
            errorMensage = nil
            // Mensage de error custom
        } catch{
            errorMensage = error.onErrorResposnse()
        }
        
    }
    // empiieza por ..
    func beginsMangalIst(conten: String) async {
        do {
            let response = try await mangaBegings(conten: conten)
            self.contenBg = response
            errorMensage = nil
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    func sharchAuthor(content:String) async{
        do{
            self.shAuthor = try await authorSearch(content: content)
            errorMensage = nil
        }catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    
    //    MARK: PETICIONES API MANGAS
    
    //     Listado de mangas general
    private func allamngaList(pages:Int ,_ per:Int) async throws -> MangasResponse{
        let url = URL.URLPagesChange(url: URL.URLMangas, page: pages, per: per)
        let (data, response) = try await sareed.requiesProvider( url: url ,type: .GET, params: nil)
        
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
    private func topMangas(pages: Int,_ numero:Int) async throws -> MangasResponse {
        
        let url = URL.URLPagesChange(url: URL.URLTopMangas,page:pages, per:numero)
        let (data , respose) = try await sareed.requiesProvider( url: url, type: .GET, params: nil)
        
        guard let httpRespose = respose as? HTTPURLResponse, httpRespose.statusCode == 200 else {
            throw NetworkError.networkErrorEnum.badRequest
        }
        JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
        do{
            let response = try JSONDecoder().decode(MangasResponse.self, from: data)
           
            return response
        }catch{
            throw error
        }
    }
    //     Listado de generos de manga
    private func mangaGen(page:Int,gen:String ,per:Int) async throws -> MangasResponse {
        
        let url = URL.URLGenresMangaList
        let urlFinal = URL.ContetPages(url: url, contenido: gen, pages: page, por:per)
        
        let (data , respose) = try await sareed.requiesProvider(url:urlFinal, type: .GET, params: nil)
        
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
            throw error
        }
    }
    //     Listado de Generos
    private func getGenres() async throws -> [String] {
        do{
            let (data , response) = try await sareed.requiesProvider(url: URL.URLGens, type: .GET, params: nil)
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
    private func getThemes() async throws -> [String] {
        
        do{
            let (data , response) = try await sareed.requiesProvider( url: URL.URLThemes, type: .GET, params: nil)
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
    // listado de magas de tema
    private func getMangaTheme(pages: Int,theme:String) async throws -> MangasResponse{
        let url = URL.ContetPages(url: URL.URLMagasThemes, contenido: theme, pages: pages, por: 20)
        let (data , respose) = try await sareed.requiesProvider( url:url, type: .GET, params: nil)
        
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
    //Listado de demografias de mangas
    private func listMangaDemos(pages: Int,gen:String,_ per:Int) async throws -> MangasResponse {
        
        let urL = URL.URLDemosMangaList
        let funalURl = URL.ContetPages(url: urL, contenido: gen, pages:pages, por:per  )
        let (data , respose) = try await sareed.requiesProvider( url: funalURl, type: .GET, params: nil)
        
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
    private func getDemos() async throws -> [String] {
        
        do{
            let (data , response) = try await sareed.requiesProvider( url: URL.URLDemos, type: .GET, params: nil)
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
    private func getAuthor() async throws -> [Author] {
        do{
            let (data, response) = try await sareed.requiesProvider( url: URL.URLAutor, type: .GET, params: nil)
            
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
    // listado de mangas de Autor{
    private func getMangasAuhtor(pages:Int,author:String,_ per:Int) async throws -> MangasResponse {
        do{
            let url = URL.ContetPages(url: URL.URLMangaAuthor, contenido: author, pages: pages, por: per)
            let (data ,response) = try await sareed.requiesProvider(url: url, type: .GET, params: nil)
            guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
                throw NetworkError.networkErrorEnum.badRequest
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do{
                let response = try decoder.decode(MangasResponse.self, from: data)
                return response
            }catch{
                print("Error decoding JSON: \(NetworkError.networkErrorEnum.badRequest)")
                print(error.localizedDescription)
                throw NetworkError.networkErrorEnum.badRequest
            }
        }catch{
            throw error
        }
        
    }
    private func authorSearch(content:String) async throws -> [Author]{
    
        let url = URL.PutContet(url: URL.URLSearchAuthor, content: content)
        let(data,response) = try await sareed.requiesProvider(url: url, type: .GET, params: nil)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
            throw NetworkError.networkErrorEnum.failed
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do{
            let response = try decoder.decode([Author].self, from: data)
            return response
        }catch{
            throw error
        }
    }
    // Manga por id
    private func  getMangaID(id: String) async throws -> Manga{
        let url = URL.PutContet(url: URL.URLMangasID, content: id)
        print(url)
        let (data,response) = try await sareed.requiesProvider( url: url, type: .GET, params: nil)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
            throw NetworkError.networkErrorEnum.badRequest
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do{
            
            let response = try decoder.decode(Manga.self,from: data)
            return response
            
        }catch{
            throw NetworkError.networkErrorEnum.requestFailed
        }
    }
    // buscada por contenido
    
    private func mangaContais(conten: String ,pages:Int,_ numero:Int)async throws -> MangasResponse {
        do{
            let url = URL.ContetPages(url: URL.URLmangaContais, contenido: conten, pages: pages, por: numero)
            let (data,response) = try await sareed.requiesProvider( url: url, type: .GET, params: nil)
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
    private func mangaBegings(conten: String)async throws ->[Manga]{
        do{
            let url = URL.PutContet(url: URL.URLmangaBegings, content: conten)
            
            let (data,response) = try await sareed.requiesProvider( url: url, type: .GET,params: nil)
            
            guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else{
                throw NetworkError.networkErrorEnum.badRequest
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do{
                let response = try decoder.decode([Manga].self,from: data)
                return response
            } catch{
                throw NetworkError.networkErrorEnum.requestFailed
            }
        }catch{
            print(error.localizedDescription)
            throw error
        }
    }
    
    //    MARK: OTRAS FUNCIONALIDADES
    
    // funcion de compobacion de paginas mangas totales
    func comprobation(page:Int,totalItem:Int) ->Int{
        let totalPages = totalItem/20
        return totalPages + 1
    }
    
    // compruaba si el manga esta dentro de del array de favoritos , si esta lo elimina si no lo añade 
    func toggleMangaSelection(_ manga: Manga) {
        if let index = favorites.firstIndex(where: { $0.id == manga.id }){
            favorites.remove(at: index)
            print("eliminado \(manga.title)")
        } else {
            favorites.append(manga)
            print("añadido \(manga.title)")
        }
    }
}
