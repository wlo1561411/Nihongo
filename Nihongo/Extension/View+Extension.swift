import SwiftUI

extension View {
    nonisolated
    func statusBarColor(_ color: Color) -> some View {
        overlay(alignment: .top) {
            color
                .ignoresSafeArea(edges: .top)
                // This will constrain the overlay to only go above the top safe area and not under.
                .frame(height: 0)
        }
    }
}
