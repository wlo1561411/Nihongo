import Foundation

struct KatakanaTheme: Theme {
    let title = "片假名"
    let voiceRate: Float = 0.2

    var allItems: [any ItemProtocol] = [
        Item(value: "ア", description: "a"),
        Item(value: "イ", description: "i"),
        Item(value: "ウ", description: "u"),
        Item(value: "エ", description: "e"),
        Item(value: "オ", description: "o"),
        Item(value: "カ", description: "ka"),
        Item(value: "キ", description: "ki"),
        Item(value: "ク", description: "ku"),
        Item(value: "ケ", description: "ke"),
        Item(value: "コ", description: "ko"),
        Item(value: "サ", description: "sa"),
        Item(value: "シ", description: "shi"),
        Item(value: "ス", description: "su"),
        Item(value: "セ", description: "se"),
        Item(value: "ソ", description: "so"),
        Item(value: "タ", description: "ta"),
        Item(value: "チ", description: "chi"),
        Item(value: "ツ", description: "tsu"),
        Item(value: "テ", description: "te"),
        Item(value: "ト", description: "to"),
        Item(value: "ナ", description: "na"),
        Item(value: "ニ", description: "ni"),
        Item(value: "ヌ", description: "nu"),
        Item(value: "ネ", description: "ne"),
        Item(value: "ノ", description: "no"),
        Item(value: "ハ", description: "ha"),
        Item(value: "ヒ", description: "hi"),
        Item(value: "フ", description: "fu"),
        Item(value: "ヘ", description: "he"),
        Item(value: "ホ", description: "ho"),
        Item(value: "マ", description: "ma"),
        Item(value: "ミ", description: "mi"),
        Item(value: "ム", description: "mu"),
        Item(value: "メ", description: "me"),
        Item(value: "モ", description: "mo"),
        Item(value: "ヤ", description: "ya"),
        Item(value: "ユ", description: "yu"),
        Item(value: "ヨ", description: "yo"),
        Item(value: "ラ", description: "ra"),
        Item(value: "リ", description: "ri"),
        Item(value: "ル", description: "ru"),
        Item(value: "レ", description: "re"),
        Item(value: "ロ", description: "ro"),
        Item(value: "ワ", description: "wa"),
        Item(value: "ヲ", description: "wo"),
        Item(value: "ン", description: "n"),

        // 濁音
        Item(value: "ガ", description: "ga"),
        Item(value: "ギ", description: "gi"),
        Item(value: "グ", description: "gu"),
        Item(value: "ゲ", description: "ge"),
        Item(value: "ゴ", description: "go"),
        Item(value: "ザ", description: "za"),
        Item(value: "ジ", description: "ji"),
        Item(value: "ズ", description: "zu"),
        Item(value: "ゼ", description: "ze"),
        Item(value: "ゾ", description: "zo"),
        Item(value: "ダ", description: "da"),
        Item(value: "ヂ", description: "ji"),
        Item(value: "ヅ", description: "zu"),
        Item(value: "デ", description: "de"),
        Item(value: "ド", description: "do"),
        Item(value: "バ", description: "ba"),
        Item(value: "ビ", description: "bi"),
        Item(value: "ブ", description: "bu"),
        Item(value: "ベ", description: "be"),
        Item(value: "ボ", description: "bo"),

        // 半濁音
        Item(value: "パ", description: "pa"),
        Item(value: "ピ", description: "pi"),
        Item(value: "プ", description: "pu"),
        Item(value: "ペ", description: "pe"),
        Item(value: "ポ", description: "po"),
    ]
}
