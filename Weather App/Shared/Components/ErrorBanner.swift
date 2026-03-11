//
//  ErrorBanner.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 05.02.2026.
//

import SwiftUI

struct ErrorBanner: View {
    let message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(ColorTheme.input)
            .padding()
            .background(ColorTheme.error)
            .cornerRadius(8)
    }
}
