
import SwiftUI

struct InfoItemView: View {
    let item: WeatherInfoItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                if let icon = item.weatherIcon {
                    Image(systemName: icon)
                        .foregroundColor(ColorTheme.desc)
                }
                Text(item.title.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(ColorTheme.desc)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.value)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(ColorTheme.primary)
                
                if let subtitle = item.subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(ColorTheme.secondary)
                }
            }
            
            
            if item.type == .uvIndex  {
                Capsule()
                    .fill(LinearGradient(colors: [.green, .yellow, .orange, .red], startPoint: .leading, endPoint: .trailing))
                    .frame(height: 4)
                    .overlay(
                        Circle()
                            .fill(ColorTheme.primary)
                            .frame(width: 8, height: 8)
                            .offset(x: -20)
                    )
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 140)
        .background(ColorTheme.card)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}
