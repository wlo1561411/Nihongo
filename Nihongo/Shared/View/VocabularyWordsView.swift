import SwiftUI

struct VocabularyWordsView: View {
    let title: String
    let titleSize: CGFloat
    let subTitle: String
    let subTitleSize: CGFloat
    let meaning: String
    let meaningSize: CGFloat
    var reading: String = ""
    var readingSize: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if subTitle.isEmpty == false {
                Text(subTitle)
                    .font(.system(size: subTitleSize, weight: .semibold))
                    .foregroundStyle(Color.accentBluePrimary)
            }

            Text(title)
                .font(.system(size: titleSize, weight: .bold))
                .foregroundStyle(Color.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(meaning)
                .font(.system(size: meaningSize, weight: .regular))
                .foregroundStyle(Color.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)

            if !reading.isEmpty {
                Text(reading)
                    .font(.system(size: readingSize, weight: .semibold))
                    .foregroundStyle(Color.textSecondary)
                    .padding(.top, 4)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    VocabularyWordsView(
        title: "Test",
        titleSize: 36,
        subTitle: "This is test.",
        subTitleSize: 16,
        meaning: "測試",
        meaningSize: 20
    )
    .fixedSize()
}
