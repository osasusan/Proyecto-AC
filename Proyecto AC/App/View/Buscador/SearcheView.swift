//
//  SearcheView.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 17/7/24.
//

import SwiftUI
struct verSearcheView:View {
    @State var ver:Bool = true
    var body: some View {
        SearcheView(show: $ver)
    }
}
struct SearcheView: View {
    //   @EnvironmentObject private var vm : MangasViewModel
    //    @State private var vm = MangasViewModel()
    @Environment(MangasViewModel.self) private var vm
    @State private var filter : shFilter = .begins
    @State var buscar : String = ""
    @State var toggel : Bool = false
    @State private var navigationToResult = false
    @State private var navigationToIdResult = false
    @State private var navigationToLsitAuthor = false
    @State private var num :Int = 0
    @State private var editTesxEmpty = false
    @Binding var show : Bool
    var body: some View {
        if show{
            ScrollView(showsIndicators: false){
                VStack(alignment:.leading){
                    Button{
                        withAnimation(.smooth){
                            show.toggle()
                        }
                    }label:{
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 40,height: 40)
                    }
                    Capsule()
                        .frame(width: 350,height: 60)
                        .foregroundStyle(.gray)
                        .overlay {
                            HStack{
                                Picker("selec filter", selection: $filter) {
                                    ForEach(shFilter.allCases){option in
                                        Text(option.rawValue).tag(option)
                                    }
                                }
                                .pickerStyle(.menu)
                                .onChange(of: filter) {
                                    buscar = ""
                                    dismissKeyboard()
                                }
                                TextField("Search manga",text: $buscar)
                                    .font(.title2)
                                    .padding(.horizontal)
                                    .textCase(.lowercase)
                                    .keyboardType(chnageKeyBoartFilter())
                            }
                            Spacer()
                        }
                    VStack(alignment:.center){
                        Button {
                            if !buscar.isEmpty {
                                if filter != .id {
                                    if filter == .begins{
                                        num = 6
                                        navigationToResult = true
                                    }else if filter == .contains{
                                        num = 7
                                        navigationToResult = true
                                    }else{
                                        navigationToLsitAuthor = true
                                    }
                                }else{
                                    Task{
                                        await vm.getIdManga(id: buscar)
                                    }
                                    navigationToIdResult = true
                                }
                               
                            }else{
                                editTesxEmpty.toggle()
                            }
                            dismissKeyboard()
                            
                        } label: {
                            Text("Search")
                                .tint(.white)
                                .frame(width: 100,height: 40)
                                .background(.blue)
                                .clipShape(Capsule(style: .continuous))
                        }
                        .padding(.top,15)
                                            }
                    .frame(maxWidth: .infinity)
                    
                    
                    trustInfo2(camp: "Genres", num: 1 )
                    trustInfo2(camp: "Themes", num: 2 )
                    trustInfo2(camp: "Demographics", num: 3 )
                    
                    Spacer()
                }
                .frame(width:350)
                .navigationDestination( isPresented: $navigationToResult){
                    ViewMangas(conten: buscar,num: num)}
                .navigationDestination(isPresented:$navigationToIdResult){
                    MangarIdResulr(buscar: buscar)}
                .navigationDestination(isPresented: $navigationToLsitAuthor){
                    AuthorListName(autorTosearch: buscar)
                }
                .alert(isPresented: $editTesxEmpty){
                    .init(title: Text("ERROR"),message: Text("You can't make a empty search"),dismissButton: .cancel())
                }

            }
        }
    }
    private func chnageKeyBoartFilter() -> UIKeyboardType{
        switch filter {
            case .contains:
                return .default
            case .begins:
                return .default
            case .id:
                return .numberPad
            case .author:
                return .emailAddress
           
        }
    }
}
struct trustInfo2 :View{
    var camp:String
    var num:Int
    @State private var isTrustInfoExpanded = false
    var body: some View{
        VStack(spacing:2){
            Button{
                withAnimation {
                    isTrustInfoExpanded.toggle()
                }
            }label: {
                HStack{
                    
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
                        ListaTemas(nume: num)
                            .font(.headline)
                            .fontWidth(.compressed)
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

#Preview {
    verSearcheView()
        .environment(MangasViewModel())
}
