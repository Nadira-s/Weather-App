//
//  SplashView.swift
//  Weather App
//
//  Created by Nadira Seitkazy  on 02.02.2026.
//
import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var router: AppRouter
    
    var body: some View{
        VStack(spacing: 24){
            Spacer()
                Image("icon")
                .resizable()
                .frame(width: 96, height: 96)
            
                Text(Strings.Splash.title)
                    .font(FontTheme.title())
            
                Text(Strings.Splash.description)
                    .font(FontTheme.desc())
                    .multilineTextAlignment(.center)
                    .foregroundColor(ColorTheme.desc)
            
            Spacer()
            
            PrimaryButton(title: Strings.Splash.button){
                router.route = .home
            }
            
        }
        .padding(30)
    }
}
