import SwiftUI

struct SpeakerButton: View {
    let onTapped: () -> Void

    var body: some View {
        Button(
            action: {
                onTapped()
            },
            label: {
                Image(systemName: "speaker.wave.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.accentBluePrimary)
            }
        )
    }
}
