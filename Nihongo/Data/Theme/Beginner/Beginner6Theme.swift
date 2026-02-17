import Foundation

struct Beginner6Theme:
    Theme,
    LessonTheme
{
    let title = "初級 第六課"

    let vocabularyItems: [ItemProtocol] = [
        LessonItem(value: "すきます", hanValue: "空きます", description: "空"),
        LessonItem(value: "でかけます", hanValue: "出かけます", description: "外出"),
        LessonItem(value: "ひろい", hanValue: "広い", description: "寬廣的"),
        LessonItem(value: "さむい", hanValue: "寒い", description: "寒冷的"),
        LessonItem(value: "あつい", hanValue: "暑い", description: "熱的"),
        LessonItem(value: "あたたかい", hanValue: "暖かい", description: "溫暖的"),
        LessonItem(value: "おいしい", hanValue: "美味しい", description: "好吃的"),
        LessonItem(value: "たかい", hanValue: "高い", description: "貴的"),
        LessonItem(value: "やすい", hanValue: "安い", description: "便宜的"),
        LessonItem(value: "あまい", hanValue: "甘い", description: "甜的"),
        LessonItem(value: "しょっぱい", description: "鹹的"),
        LessonItem(value: "からい", hanValue: "辛い", description: "辣的"),
        LessonItem(value: "うらやましい", hanValue: "羨ましい", description: "羨慕"),
        LessonItem(value: "ちょうどいい", description: "剛剛好"),
        LessonItem(value: "おもしろい", hanValue: "面白い", description: "有趣的"),
        LessonItem(value: "きれい", hanValue: "綺麗", description: "漂亮的"),
        LessonItem(value: "にぎやか", hanValue: "賑やか", description: "熱鬧的"),
        LessonItem(value: "しずか", hanValue: "静か", description: "安靜的"),
        LessonItem(value: "いま", hanValue: "今", description: "現在"),
        LessonItem(value: "まち", hanValue: "街", description: "城鎮"),
        LessonItem(value: "ところ", hanValue: "所", description: "地方"),
        LessonItem(value: "ざっし", hanValue: "雑誌", description: "雜誌"),
        LessonItem(value: "じしょ", hanValue: "辞書", description: "字典"),
        LessonItem(value: "もの", hanValue: "物", description: "東西"),
        LessonItem(value: "こきょう", hanValue: "故郷", description: "故鄉"),
        LessonItem(value: "おなか", hanValue: "お腹", description: "肚子"),
        LessonItem(value: "ひるごはん", hanValue: "昼ご飯", description: "午餐"),
        LessonItem(value: "なつ", hanValue: "夏", description: "夏天"),
        LessonItem(value: "ふゆ", hanValue: "冬", description: "冬天"),
        LessonItem(value: "やちん", hanValue: "家賃", description: "房租"),
        LessonItem(value: "すきやき", hanValue: "すき焼き", description: "壽喜燒"),
        LessonItem(value: "チャーハン", description: "炒飯"),
        LessonItem(value: "ラーメン", description: "拉麵"),
        LessonItem(value: "なっとう", hanValue: "納豆", description: "納豆"),
        LessonItem(value: "なべりょうり", hanValue: "鍋料理", description: "火鍋料理"),
        LessonItem(value: "とても", description: "非常"),
        LessonItem(value: "ちょっと", description: "稍微, 有點"),
        LessonItem(value: "とくに", hanValue: "特に", description: "尤其"),
        LessonItem(value: "つぎの", hanValue: "次の", description: "下次, 下一個"),
        LessonItem(value: "こんな", description: "這樣的, 這麼"),
        LessonItem(value: "そして", description: "然後"),
        LessonItem(value: "どう", description: "如何, 怎麼"),
        LessonItem(value: "どんな", description: "什麼樣的"),
        LessonItem(value: "〜か", description: "雖然, 可是"),
        LessonItem(value: "〜なあ", description: "～啊！"),
        LessonItem(value: "ほっかいどう", hanValue: "北海道", description: "北海道"),
        LessonItem(value: "とうきょう", hanValue: "東京", description: "東京"),
        LessonItem(value: "おおさか", hanValue: "大阪", description: "大阪"),
        LessonItem(value: "きょうと", hanValue: "京都", description: "京都"),
    ]

    let greetingPhrasesItems: [ItemProtocol] = []

    let sentencePatternsItems: [ItemProtocol] = [
        LessonItem(value: "おなかがすきました", hanValue: "おなかが空きました", description: "肚子餓了"),
        LessonItem(value: "〜とおもいますけど", hanValue: "〜と思いますけど", description: "覺得..."),
        LessonItem(value: "そういえば", hanValue: "そう言えば", description: "這麼說的話..."),
    ]
}
