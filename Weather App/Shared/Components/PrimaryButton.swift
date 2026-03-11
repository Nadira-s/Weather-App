//
//  PrimaryButton.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 05.02.2026.
//

import SwiftUI

struct PrimaryButton: View{
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            Text(title)
                .font(FontTheme.body())
                .foregroundColor(ColorTheme.input)
                .frame(maxWidth: .infinity)
                .padding()
                .background(ColorTheme.primary)
                .cornerRadius(10)
            
        }
    }
}
