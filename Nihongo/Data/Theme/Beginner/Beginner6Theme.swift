import Foundation

struct Beginner6Theme:
    Theme,
    LessonTheme
{
    let title = "初級 第六課"

    let vocabularyItems: [ItemProtocol] = [
        Item(value: "すきます　空きます", description: "空"),
        Item(value: "でかけます　出かけます", description: "外出"),
        Item(value: "ひろい　広い", description: "寬廣的"),
        Item(value: "さむい　寒い", description: "寒冷的"),
        Item(value: "あつい　暑い", description: "熱的"),
        Item(value: "あたたかい　暖かい", description: "溫暖的"),
        Item(value: "おいしい　美味しい", description: "好吃的"),
        Item(value: "たかい　高い", description: "貴的"),
        Item(value: "やすい　安い", description: "便宜的"),
        Item(value: "あまい　甘い", description: "甜的"),
        Item(value: "しょっぱい", description: "鹹的"),
        Item(value: "からい　辛い", description: "辣的"),
        Item(value: "うらやましい　羨ましい", description: "羨慕"),
        Item(value: "ちょうどいい", description: "剛剛好"),
        Item(value: "おもしろい　面白い", description: "有趣的"),
        Item(value: "きれい　綺麗", description: "漂亮的"),
        Item(value: "にぎやか　賑やか", description: "熱鬧的"),
        Item(value: "しずか　静か", description: "安靜的"),
        Item(value: "いま　今", description: "現在"),
        Item(value: "まち　街", description: "城鎮"),
        Item(value: "ところ　所", description: "地方"),
        Item(value: "ざっし　雑誌", description: "雜誌"),
        Item(value: "じしょ　辞書", description: "字典"),
        Item(value: "もの　物", description: "東西"),
        Item(value: "こきょう　故郷", description: "故鄉"),
        Item(value: "おなか　お腹", description: "肚子"),
        Item(value: "ひるごはん　昼ご飯", description: "午餐"),
        Item(value: "なつ　夏", description: "夏天"),
        Item(value: "ふゆ　冬", description: "冬天"),
        Item(value: "やちん　家賃", description: "房租"),
        Item(value: "すきやき　すき焼き", description: "壽喜燒"),
        Item(value: "チャーハン", description: "炒飯"),
        Item(value: "ラーメン", description: "拉麵"),
        Item(value: "なっとう　納豆", description: "納豆"),
        Item(value: "なべりょうり　鍋料理", description: "火鍋料理"),
        Item(value: "とても", description: "非常"),
        Item(value: "ちょっと", description: "稍微, 有點"),
        Item(value: "とくに　特に", description: "尤其"),
        Item(value: "つぎの　次の", description: "下次, 下一個"),
        Item(value: "こんな", description: "這樣的, 這麼"),
        Item(value: "そして", description: "然後"),
        Item(value: "どう", description: "如何, 怎麼"),
        Item(value: "どんな", description: "什麼樣的"),
        Item(value: "〜か", description: "雖然, 可是"),
        Item(value: "〜なあ", description: "～啊！"),
        Item(value: "ほっかいどう　北海道", description: "北海道"),
        Item(value: "とうきょう　東京", description: "東京"),
        Item(value: "おおさか　大阪", description: "大阪"),
        Item(value: "きょうと　京都", description: "京都"),
    ]

    let greetingPhrasesItem: [ItemProtocol] = []

    let sentencePatternsItem: [ItemProtocol] = [
        Item(value: "おなかがすきました　おなかが空きました", description: "肚子餓了"),
        Item(value: "〜とおもいますけど　〜と思いますけど", description: "覺得..."),
        Item(value: "そういえば　そう言えば", description: "這麼說的話..."),
    ]
}
