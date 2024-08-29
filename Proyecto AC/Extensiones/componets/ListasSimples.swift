//
//  ListasSimples.swift
//  Proyecto AC
//
//  Created by Osasu sanchez on 3/7/24.
//

import SwiftUI

struct ListasSimples: View {
    @State private var selectedOption: FilterOption = .id

    var body: some View {
              VStack {
                  Picker("Select Filter", selection: $selectedOption) {
                      ForEach(FilterOption.allCases) { option in
                          Text(option.rawValue).tag(option)
                      }
                  }
                  .pickerStyle(MenuPickerStyle()) // Puedes cambiar el estilo del picker
                  .padding()
                  
                  // Mostrar la opción seleccionada
               
                      .padding()
                  
                  Spacer()
              }
              .padding()
          }
    
}
enum FilterOption: String, CaseIterable, Identifiable {
    case id = "ID"
    case contains = "Contains"
    case begins = "Begins"
    case custom = "Custom"

    var id: String { self.rawValue }
}
#Preview {
    ListasSimples()
}
