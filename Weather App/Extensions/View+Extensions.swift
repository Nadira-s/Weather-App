//
//  View+Extensions.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 18.02.2026.
//

import SwiftUI

extension View {
    func poppinFont(_ fontWeight: PoppinFontWeight? = .regular, _ size: CGFloat? = nil) -> some View {
        self.font(.poppinFont(fontWeight ?? .regular, size ?? 16))
    }
    
    func interFont(_ fontWeight: InterFontWeight? = .regular, _ size: CGFloat? = nil) -> some View {
        self.font(.interFont(fontWeight ?? .regular, size ?? 16))
    }
}
