import AVFoundation
import Foundation

protocol VoiceService {
    func play(for text: String?, rate: VoiceRate)
}

enum VoiceRate {
    case low
    case normal
    case fast

    var value: Float {
        switch self {
        case .low:
            AVSpeechUtteranceMinimumSpeechRate
        case .normal:
            AVSpeechUtteranceDefaultSpeechRate
        case .fast:
            AVSpeechUtteranceMaximumSpeechRate
        }
    }
}

@MainActor
struct JapaneseVoiceService: VoiceService, Sendable {
    static let shared = JapaneseVoiceService()

    private let synthesizer = AVSpeechSynthesizer()

    private init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
    }

    func play(for text: String?, rate: VoiceRate) {
        guard
            let text,
            !text.isEmpty
        else {
            return
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.rate = rate.value
        
        synthesizer.speak(utterance)
    }
}
