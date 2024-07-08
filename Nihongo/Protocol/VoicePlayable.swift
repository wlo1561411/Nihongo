import AVFoundation
import Foundation

private let synthesizer = AVSpeechSynthesizer()

protocol VoicePlayable { }

extension VoicePlayable {
    func speakJapanese(_ text: String?, rate: Float) {
        guard
            let text,
            !text.isEmpty
        else { return }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.voice.compact.ja-JP.Kyoko")
        utterance.rate = rate

        synthesizer.speak(utterance)
    }
}
