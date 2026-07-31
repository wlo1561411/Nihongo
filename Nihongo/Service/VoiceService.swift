import AVFoundation
import Foundation

protocol VoiceService {
    func play(for text: String?, mode: SpeechMode)
}

enum SpeechMode {
    case sentence
    case word
    case syllable
}

@MainActor
struct JapaneseVoiceService: VoiceService {
    static let shared = JapaneseVoiceService()

    private static let sentenceSeparators: Set<Character> = ["。", "！", "？", "、"]

    private let synthesizer = AVSpeechSynthesizer()

    private init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, options: [.mixWithOthers])
    }

    func play(for text: String?, mode: SpeechMode) {
        guard
            let text,
            !text.isEmpty,
            !synthesizer.isSpeaking
        else {
            return
        }

        switch mode {
        case .sentence:
            makeSentenceUtterances(for: text)
                .forEach {
                    synthesizer.speak($0)
                }

        case .word, .syllable:
            synthesizer.speak(makeUtterance(for: text, mode: mode))
        }
    }

    /// 建立日文朗讀 utterance，並依朗讀模式套用語速與音高。
    private func makeUtterance(for text: String, mode: SpeechMode) -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: text.trimmingCharacters(in: .whitespacesAndNewlines))
        utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")

        switch mode {
        case .sentence:
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.82
            utterance.pitchMultiplier = 1.0
            utterance.postUtteranceDelay = 0.15

        case .word:
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.65
            utterance.pitchMultiplier = 1.05
            utterance.postUtteranceDelay = 0.05

        case .syllable:
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.38
            utterance.pitchMultiplier = 1.12
            utterance.postUtteranceDelay = 0.18
        }

        return utterance
    }

    /// 依日文標點切分句子，讓系統在片語與短句之間保有自然停頓。
    private func makeSentenceUtterances(for text: String) -> [AVSpeechUtterance] {
        sentenceComponents(from: text)
            .map {
                makeUtterance(for: $0, mode: .sentence)
            }
    }

    private func sentenceComponents(from text: String) -> [String] {
        var components: [String] = []
        var current = ""

        for character in text {
            current.append(character)

            if Self.sentenceSeparators.contains(character) {
                let component = current.trimmingCharacters(in: .whitespacesAndNewlines)

                if component.isEmpty == false {
                    components.append(component)
                }

                current = ""
            }
        }

        let remaining = current.trimmingCharacters(in: .whitespacesAndNewlines)

        if remaining.isEmpty == false {
            components.append(remaining)
        }

        return components
    }
}
