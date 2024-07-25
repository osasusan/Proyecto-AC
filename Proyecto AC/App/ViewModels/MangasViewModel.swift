//
//  MangasViewModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 13/6/24.
//

import Foundation


@Observable class MangasViewModel{
    var topMangas: [Item] = []
    var favorites: [Item] = []
    var allMangas: [Item] = []
    var contenSh: [Item] = []
    var contenBg:[Item] = []
    var mangasId: Item!
    var themes : [String] = []
    var mangaListThemes : [Item] = []
    var mangaListGen : [Item] = []
    var mangaListDemos : [Item] = []
    var author : [Author] = []
    var generos : [String] = []
    var listaGenerosMnaga : [Item] = []
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
            let response = try await fetchMangas(pages: page, per)
            self.allMangas = response.items
            self.metadata = response.metadata
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
            // Mensage de error custom
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
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    //    listado de temas totales
    func getThemesResponse() async {
        do {
            self.themes = try await getThemes()
            //            print(themes)
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    //    listado de demogrtafias
    func getDemoResponse() async {
        do {
            self.demos = try await getDemos()
            //            print(demos)
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    //    Listado de autores
    func getAutor() async {
        do{
            self.author = try await getAuthor()
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    
    //MARK: Respuesta de buscadores
    
    //    busqueda de manga por ID
    func getIdManga(id : String) async {
        do{
            self.mangasId = try await getMangaID(id: id)
            
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
            
        } catch{
            errorMensage = error.onErrorResposnse()
        }
    }
    
    //    MARK: PETICIONES API MANGAS
    
    //     Listado de mangas general
    private func fetchMangas(pages:Int ,_ per:Int) async throws -> MangasResponse{
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
    private func topMangas(pages: Int,_ numero:Int) async throws -> MangasResponse {
        
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
    private func mangaGen(page:Int,gen:String ,per:Int) async throws -> MangasResponse {
        
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
    private func getGenres() async throws -> [String] {
        do{
            let (data , response) = try await sareed.requiesProvider(false, url: URL.URLGens, type: .GET, params: nil,nil,nil)
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
            
            let (data , response) = try await sareed.requiesProvider(false, url: URL.URLThemes, type: .GET, params: nil,nil,nil)
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
        let (data , respose) = try await sareed.requiesProvider(false, url:url, type: .GET, params: nil,nil,nil)
        
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
    private func getDemos() async throws -> [String] {
        
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
    private func getAuthor() async throws -> [Author] {
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
    // listado de mangas de Autor{
    private func getMangasAuhtor (pages:Int,author:String,_ per:Int) async throws -> MangasResponse{
        let url = URL.ContetPages(url: URL.URLMangaAuthor, contenido: author, pages: pages, por: per)
        let (data ,response) = try await sareed.requiesProvider(false, url: url, type: .GET, params: nil, nil, nil)
        guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
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
    // Manga por id
    private func getMangaID(id: String) async throws -> Item{
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
    
    private func mangaContais(conten: String ,pages:Int,_ numero:Int)async throws -> MangasResponse {
        do{
            let url = URL.ContetPages(url: URL.URLmangaContais, contenido: conten, pages: pages, por: numero)
            let (data,response) = try await sareed.requiesProvider(false, url: url, type: .GET, params: nil, nil , nil)
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
    private func mangaBegings(conten: String)async throws ->[Item]{
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
    
    //    MARK: OTRAS FUNCIONALIDADES
    
    // funcion de compobacion de paginas mangas totales
    func comprobation(page:Int,totalItem:Int) ->Int{
        let totalPages = totalItem/20
        return totalPages + 1
    }
    
    func verPeticiones(numP: Int,pages: Int,content:String?)async {
        switch numP{
            case 1 : await listMangas(page:pages, 20)
            case 2 : await listTopMangas(page:pages,20)
                //            case 3 : await listMangaGen(page: pages, gen: content ?? "nil")
                //            case 4 : await listTopMangas(20)
            default:
                print("Número de tarea inválido")
        }
    }
  
    func toggleMangaSelection(_ manga: Item) {
        
        
        if let index = favorites.firstIndex(where: { $0.id == manga.id }){
            
            favorites.remove(at: index)
            print("eliminado \(manga.title)")
        } else {
            favorites.append(manga)
            print("añadido \(manga.title)")
        }
    }
}
