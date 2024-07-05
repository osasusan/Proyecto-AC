//
//  MangasViewModel.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 13/6/24.
//

import Foundation

@MainActor
class MangasViewModel: ObservableObject {
    @Published var TopMangas: [Item] = []
    @Published var allmAngas: [Item] = []
    @Published var contenSh: [Item] = []
    @Published var contenBg:[Item] = []
    @Published var mangasId: Item!
    @Published var temas : [String] = []
    @Published var author : [Author] = []
    @Published var generos : [String] = []
    @Published var listaGenerosMnaga : [Item] = []
    @Published var demos : [String] = []
    @Published var metadata: Metadata?
    @Published var errorMensage: String?
    @Published var errorMensage2: String?
    
//    @Published var pages: Int = 1
//    @Published var numero: Int?
    @Published var showTopmangas = false
    @Published var showAllMangas = false
    @Published var showAllAhuthor = false
    
    
    //    private var sareed :NetworkProtocol
    //    init(sareed: NetworkProtocol = NetworkHelper()) {
    //        self.sareed = sareed
    //    }
    //
    var sareed: NetworkProtocol
    
    init(sareed: NetworkProtocol = NetworkHelper()) {
        self.sareed = sareed
    }
    
    func listMangas(page:Int , _ per: Int) async {
            do {
                let response = try await fetchMangas(pages: page, per)
                self.allmAngas = response.items
                self.metadata = response.metadata
                // Mensage de error custom
            } catch let error as NetworkError.networkErrorEnum{
                errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
                print("Failed to fetch mangas: \(error)")
                // Mensage de error generico
            }catch {
                errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
                errorMensage = errorMensage2
            }
        }
    
    func listTopMangas(page:Int ,_ numeros:Int) async {
        do {
            let response = try await topMangas(pages: page, numeros )
            
            self.TopMangas = response.items
            self.metadata = response.metadata
            // Mensage de error custom
        } catch let error as NetworkError.networkErrorEnum{
            errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
            print("Failed to fetch mangas: \(error)")
            // Mensage de error generico
        }catch {
            errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
            errorMensage = errorMensage2
            
        }
    }
        func listMangaGen(page:Int,gen: String )async {
            do {
                let response = try await mangaGen(page: page,gen: gen, per: 20)
    
                self.listaGenerosMnaga = response.items
                self.metadata = response.metadata
                // Mensage de error custom
            } catch let error as NetworkError.networkErrorEnum{
                errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
                print("Failed to fetch mangas: \(error)")
                // Mensage de error generico
            }catch {
                errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
                errorMensage = errorMensage2
            }
        }
    
    
    func listMangaDemo(page:Int,gen: String,_ per:Int)async {
            do {
                let response = try await listMangaDemos(pages: page,gen: gen,per)
    
                self.TopMangas = response.items
                self.metadata = response.metadata
                // Mensage de error custom
            } catch let error as NetworkError.networkErrorEnum{
                errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
                print("Failed to fetch mangas: \(error)")
                // Mensage de error generico
            }catch {
                errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
                errorMensage = errorMensage2
            }
        }
        func comprobation(page:Int,totalItem:Int) ->Int{
            let totalPages = totalItem/20
            return totalPages + 1
        }
    //
        func getTemas() async {
            do {
                self.generos = try await getGens()
            }catch let error as NetworkError.networkErrorEnum{
                errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
                print("Failed to fetch mangas: \(error)")
            }catch{
                errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
                errorMensage = errorMensage2
            }
        }
        func getDemo() async {
            do {
                self.generos = try await getDemos()
            }catch let error as NetworkError.networkErrorEnum{
                errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
                print("Failed to fetch mangas: \(error)")
            }catch{
                errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
                errorMensage = errorMensage2
            }
        }
        func getAutor() async {
            do{
                self.author = try await getAuthor()
    
            }catch let error as NetworkError.networkErrorEnum{
                errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
                print("Failed to fetch mangas: \(error)")
            }catch{
                errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
                errorMensage = errorMensage2
            }
        }
        func getIdManga(id : String) async {
            do{
                self.mangasId = try await getMangaID(id: id)
    
            }catch let error as NetworkError.networkErrorEnum{
                errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
                print("Failed to fetch mangas: \(error)")
            }catch{
                errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
                errorMensage = errorMensage2
            }
        }
    ////    func contaisManga(conten: String,page:Int)async {
    ////        do {
    ////            let response = try await mangaContais(conten: conten, pages: page)
    ////            self.contenSh = response.items
    ////            self.metadata = response.metadata
    ////            // Mensage de error custom
    ////        } catch let error as NetworkError.networkErrorEnum{
    ////            errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
    ////            print("Failed to fetch mangas: \(error)")
    ////            // Mensage de error generico
    ////        }catch {
    ////            errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
    ////            errorMensage = errorMensage2
    ////        }
    ////    }
    //
    //    func contaisBegins(conten: String) async {
    //        do {
    //           let response = try await mangaBegings(conten: conten)
    //            self.contenBg = response
    //
    //        }catch let error as NetworkError.networkErrorEnum{
    //            errorMensage = ("Failed to fetch mangas: \(error.customLocalizedDescription)")
    //            print("Failed to fetch mangas: \(error)")
    //
    //        }catch {
    //            errorMensage2 = ("Failed to fetch mangas: \(error.localizedDescription)")
    //            errorMensage = errorMensage2
    //        }
    //    }
    //
    
    }


