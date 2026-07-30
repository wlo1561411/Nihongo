import SwiftUI

struct FavoriteButton: View {
    var size: CGFloat = 16
    let isFavorite: Bool
    let onTapped: (Bool) -> Void

    var body: some View {
        Button(
            action: {
                onTapped(isFavorite)
            },
            label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundStyle(isFavorite ? Color.accentYellowPrimary : Color.textThirdly)
                    .animation(isFavorite ? .easeInOut(duration: 0.18) : nil, value: isFavorite)
            }
        )
        .buttonStyle(IconButtonPressStyle())
    }
}
