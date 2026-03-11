//
//  SearchBar.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 05.02.2026.
//

import SwiftUI

struct SearchBar: View {

    @Binding var text: String
    let onSubmit: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName:Strings.magnifyingglass )
                .foregroundColor(ColorTheme.desc)

            TextField(Strings.search, text: $text)
                .font(FontTheme.body())
                .submitLabel(.search)
                .onSubmit(onSubmit)
        }
        .padding()
        .background(ColorTheme.input)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(ColorTheme.border)
        )
    }
}


