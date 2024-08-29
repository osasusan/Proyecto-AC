//
//  MangaComponet.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 13/6/24.
//

import SwiftUI

struct MangaComponet: View {
    
    @State var manga : Manga?
    @Environment(MangasViewModel.self) private var vm
    @Environment(LogViewModel.self) private var viewModel
    @State var favsi :Bool = false
    var body: some View {
        VStack(spacing:3){
            LazyVStack{
                imageAsync(imagen: manga?.mainPicture ?? "nil", width: 100, height: 160, radio: 20)
                
                HStack(){
                    VStack(alignment:.leading) {
                        Text("\(manga?.title ?? "Error")")
                            .lineLimit(3)
                            .font(.footnote)
                            .fontWeight(.regular)
                            .fontWidth(.compressed)
                            .foregroundStyle(Color.white)
                            .frame(width: 65,height: 50,alignment: .topLeading)
                            .padding(.top,5)
                        
                    }
                    // boton el cuan te saca un desplegable donde lo puedes añadir a una favoritos o a una collecion
                    if viewModel.isLogede == true{
                        Button{
                            favsi.toggle()
                            vm.toggleMangaSelection(manga!)
                        }label: {
                            
                            let image = favsi ? Image(systemName: "star.fill"): Image(systemName: "star")
                                
                            image
                                .tint(.yellow)
                                .scaledToFit()
                                .frame(height:10)
                                .padding(.bottom,2)
                        }
                        .frame(height:15)
                    }
                    
                    //                    }label:{
                    //                        //Image(systemName: "star")
                    //                        Image(systemName: "ellipsis",variableValue: 2)
                    //                            .rotationEffect(.degrees(90))
                    //
                    //                    }
                    
                }
            }
        }
        .shadow(radius: 1,x: 2)
        .frame(width: 100, height: 225)
        .onAppear{
            Task{
                if viewModel.isLogede{
                    comprovationFav(manga!)
                }
            }
            
        }
    }
    func comprovationFav(_ manga: Manga){
        if (vm.favorites.firstIndex(where: { $0.id == manga.id }) != nil) {
            favsi = true
        }
    }
}

struct MangaComponetDetalle:View{
    //    @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @Environment(LogViewModel.self) private var viewModel
    
    @State var manga:Manga?
    @State var manga2 = Manga(background: "prueba", title: "prueba", url: nil, demographics: [], themes: [], score: 0.00, volumes: 1, titleJapanese: "prueba", sypnosis: "prueba", genres: [], mainPicture: nil, startDate: nil, id: 788989, status: "prueba", chapters: 2, authors: [], endDate: nil, titleEnglish: "prueba")
    @State var favsi :Bool = false
    var body: some View {
        
        VStack(spacing:10){
            HStack(alignment: .center){
                imageAsync(imagen: manga?.mainPicture ?? "nil", width: 150, height: 240,radio: 20)
                
                
                VStack(alignment:.leading) {
                    
                    Text(manga?.title ?? "Error ")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .fontWidth(.compressed)
                        .tint(.white)
                        .lineLimit(4)
                    
                    
                    Text("id:\(manga?.id ?? 0)")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .fontWidth(.compressed)
                    
                    
                    Spacer()
                    Text("\(manga?.authors?.first?.firstName ?? "4") \(manga?.authors?.first?.lastName ?? "3")")
                        .font(.footnote)
                        .fontWeight(.light)
                        .fontWidth(.compressed)
                        .foregroundStyle(.white)
                    
                    HStack{
                        
                        Text(unixToDate(date: manga?.startDate ?? "fecha de inicio sin definir"))
                            .font(.footnote)
                            .fontWeight(.light)
                            .fontWidth(.compressed)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        Text(String(format: "%.2f",manga?.score ?? 0.0))
                            .font(.footnote)
                            .foregroundStyle(.white)
                        
                        if viewModel.isLogede == true{
                            Button{
                                favsi.toggle()
                                vm.toggleMangaSelection(manga!)
                            }label: {
                                
                                let image = favsi ? Image(systemName: "star.fill"): Image(systemName: "star")
                                   
                                image
                                    .tint(.yellow)
                                    .scaledToFit()
                                    .frame(height:15)
                                    .padding(.bottom,2)
                            }
                            .frame(height:15)
                        }
                    }
                }
                
            }
            Divider()
        }
        .frame(height: 230)
        .padding()
        .onAppear{
            Task{
                if !vm.favorites.isEmpty{
                    comprovationFav(manga ?? manga2)
                }
            }
        }
    }
    func comprovationFav(_ manga: Manga){
        if (vm.favorites.firstIndex(where: { $0.id == manga.id }) != nil) {
            favsi = true
        }
    }
}
struct UserCellCollection :View{
    @State var manga:UserCollection?
    @State var favsi :Bool = false
    var body: some View {
        
        VStack(spacing:10){
            HStack(alignment: .center){
                imageAsync(imagen: manga?.manga.mainPicture ?? "nil", width: 130, height: 220,radio: 20)
                
                HStack(alignment: .bottom){
                    VStack(alignment:.leading) {
                        
                        Text(manga?.manga.title ?? "Error")
                            .font(.title3)
                            .lineLimit(4)
                            .fontWeight(.semibold)
                            .fontWidth(.compressed)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity,alignment: .topLeading)
                        Text("id:\(manga?.manga.id ?? 0)")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .fontWidth(.compressed)
                        
                        Text("Volumes owned: \( manga?.volumesOwned?.last?.description ?? "vacio")")
                            .font(.footnote)
                            .bold()
                            .fontWeight(.light)
                            .fontWidth(.compressed)
                            .foregroundStyle(.white)
                        Text("Volumes reading: \( manga?.readingVolume?.description ?? "vacio")")
                            .font(.footnote)
                            .fontWeight(.light)
                            .fontWidth(.compressed)
                            .foregroundStyle(.white)
                        let textCompler = manga!.completeCollection ? "complete " : "not complete"
                        Text(textCompler)
                            .font(.footnote)
                            .fontWeight(.light)
                            .fontWidth(.compressed)
                            .foregroundStyle(.white)
                        Spacer()
                        Text("\(manga?.manga.authors?.first?.firstName ?? "4") \(manga?.manga.authors?.first?.lastName ?? "3")")
                            .font(.footnote)
                            .fontWeight(.light)
                            .fontWidth(.compressed)
                            .foregroundStyle(.white)
                        
                        HStack{
                            
                            Text(unixToDate(date: manga?.manga.startDate ?? "fecha de inicio sin definir"))
                                .font(.footnote)
                                .fontWeight(.light)
                                .fontWidth(.compressed)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            Text(String(format: "%.2f",manga?.manga.score ?? 0.0))
                                .font(.footnote)
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
           
        }
        .frame(height: 230)
        .padding()
    }
}
struct MangaDetailVeiw :View {
    @State var manga:Manga?
    @Environment(LogViewModel.self)var vmLog
    @Environment(UserViewModel.self)var vm
    @State var addCollection = false
    var notAvailable = "Data is not available"
    
    var body: some View{
        ScrollView{
            VStack{
                
                imageAsync(imagen: manga?.mainPicture ?? "nil",width:360,height: 600,radio: 0)
                HStack(spacing: -20){
                    
                    mangaName(mangaName: manga?.title ?? "manga sin Nombre" , width: 330)
                        .lineLimit(3)
                    
                    Text((String(format: "%.2f",manga?.score ?? 0.0)))
                        .font(.headline )
                        .fontWidth(.compressed)
                        .padding(.leading,20)
                    
                }
                if vmLog.isLogede{ // compureba si esta logeado para poder mosrtar el boton
                    Button {
                        addCollection.toggle()
                        vm.idManga = manga?.id
                    } label: {
                        Text("Add to my callections")
                            .tint(.white)
                            .padding(10)
                            .padding(.horizontal,10)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                }
                trustInfo(camp: "Synopsis", manga:manga?.sypnosis ?? notAvailable )
                trustInfo(camp: "Background", manga:manga?.background ?? notAvailable )
                trustInfo(camp: "Volumens", manga:"\(String(describing: manga?.volumes?.description ?? notAvailable))")
                trustInfo(camp: "Genres", manga: manga?.genres?.map{$0.genre}.joined(separator: "\n") ?? notAvailable )
                trustInfo(camp: "Themes", manga:manga?.themes?.map{$0.theme}.joined(separator: "\n") ?? notAvailable )
                trustInfo(camp: "Demographics", manga: manga?.demographics?.map { $0.demographic! }.joined(separator: "\n") ?? "Data is not available")
                trustInfo(camp: "Authors", manga: manga?.authors?.map {
                    "\($0.firstName) \($0.lastName) -> \($0.role)"
                }.joined(separator: "\n") ?? notAvailable)
                trustInfo(camp: "Other title", manga:"Japan title:\(manga?.titleJapanese ?? notAvailable)\n English title: \(manga?.titleEnglish ?? notAvailable)" )
                trustInfo(camp: "Date", manga:"Inicio: \(unixToDate(date: manga?.startDate ?? notAvailable))\nFinal: \(unixToDate(date:manga?.endDate ?? notAvailable))")
                trustInfo(camp: "URL", manga: manga?.url ?? notAvailable)
            }
        }
        .background(Color.customColor)
        
        .sheet(isPresented: $addCollection) {
            NewCollectionView()
                .onDisappear{
                    vm.volumesOwned = ""
                    vm.idManga = nil
                    vm.readingVolume = nil
                    vm.isComplet = false
                }
        }
    }
    
    
}

struct trustInfo :View{
    var camp:String
    var manga:String
    @State private var isTrustInfoExpanded = false
    var body: some View{
        VStack(spacing:2){
            Button{
                withAnimation {
                    isTrustInfoExpanded.toggle()
                }
            }label: {
                HStack{
                    let image = isTrustInfoExpanded ?  Image(systemName: "lock.open") : Image(systemName: "lock")
                    image
                        .foregroundColor(.primary)
                    Text(camp)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isTrustInfoExpanded ? 0 : -90))
                    
                }
                .font(.headline.weight(.semibold))
                .fontWidth(.compressed)
                .padding()
            }
            .background(Color.gray)
            if isTrustInfoExpanded{
                ZStack{
                    Color.gray.opacity(0.3)
                    VStack(alignment: .leading, spacing: 0) {
                        if camp == "URL", let url = URL(string: cleanUrl(manga)) {
                            Link("Go to Web", destination: url)
                                .foregroundStyle(.blue)
                                .font(.headline)
                                .fontWidth(.compressed)
                        } else {
                            Text(manga)
                                .font(.headline)
                                .fontWidth(.compressed)
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
                    .padding()
                }
            }
        }
        .compositingGroup()
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding()
    }
}
#Preview("MangaComponet") {
    ZStack{
        Color.customColor
            .ignoresSafeArea()
        MangaComponet()
    }
}
#Preview("MangaCellComponet") {
    ZStack{
        Color.customColor
            .ignoresSafeArea()
        MangaComponetDetalle()
            .environment(MangasViewModel())
            .environment(LogViewModel())
    }
}
#Preview ("UserColectionView"){
    ZStack{
        Color.customColor
            .ignoresSafeArea()
        UserCellCollection()
    }
}
#Preview("MangaComponetDetalle"){
    ZStack{
        Color.customColor
            .ignoresSafeArea()
        MangaComponetDetalle(manga: Manga(background: "prueba", title: "prueba", url: nil, demographics: [], themes: [], score: 0.00, volumes: 1, titleJapanese: "prueba", sypnosis: "prueba", genres: [], mainPicture: nil, startDate: nil, id: 788989, status: "prueba", chapters: 2, authors: [], endDate: nil, titleEnglish: "prueba"))
            .environment(MangasViewModel())
            .environment(LogViewModel())
            .environment(UserViewModel())
        
    }
}
#Preview("MangaDetailVeiw"){
    MangaDetailVeiw()
        .environment(LogViewModel())
    
}
