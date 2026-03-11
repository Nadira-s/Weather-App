//
//  FontTheme.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 05.02.2026.
//
import SwiftUI

enum FontTheme {

    static func title(weight: Font.Weight = .bold) -> Font {
        .system(size: 26, weight: weight)
    }

    static func largeTemperature() -> Font {
        .system(size: 64, weight: .bold)
    }

    static func body(weight: Font.Weight = .regular) -> Font {
        .system(size: 16, weight: weight)
    }

    static func desc(weight: Font.Weight = .semibold) -> Font {
        .system(size: 14, weight: weight)
    }

    static func caption(weight: Font.Weight = .medium) -> Font {
        .system(size: 12, weight: weight)
    }
}

