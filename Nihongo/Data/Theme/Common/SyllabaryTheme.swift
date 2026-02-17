//
//  SyllabaryTheme.swift
//  Nihongo
//
//  Created by Finn on 2025/11/27.
//

import Foundation

struct SyllabaryTheme:
    Theme,
    JapaneseSyllabaryTheme
{
    private let hiragana = HiraganaTheme()
    private let katakana = KatakanaTheme()

    let title = "平/片假名"

    let normalItems: [ItemProtocol]

    let voicedItem: [ItemProtocol]

    let semiVoicedItem: [ItemProtocol]

    init() {
        normalItems = hiragana.normalItems + katakana.normalItems
        voicedItem = hiragana.voicedItem + katakana.voicedItem
        semiVoicedItem = hiragana.semiVoicedItem + katakana.semiVoicedItem
    }
}
