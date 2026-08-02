import SwiftUI

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static let defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) { }
}

struct ObservableScrollView<Content: View>: View {
    private let scrollCoordinateSpace = "scroll"

    private let onChange: (CGPoint) -> Void
    private let content: () -> Content

    init(
        onChange: @escaping (CGPoint) -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.onChange = onChange
        self.content = content
    }

    var body: some View {
        ScrollView {
            offsetReader
            content()
        }
        .coordinateSpace(name: scrollCoordinateSpace)
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
            onChange(offset)
        }
    }

    private var offsetReader: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: ScrollOffsetPreferenceKey.self,
                    value: proxy.frame(in: .named(scrollCoordinateSpace)).origin
                )
        }
        .frame(height: 0)
    }
}
