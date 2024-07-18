import Foundation

struct Beginner4Theme:
    Theme,
    LessonTheme
{
    let title = "初級 第四課"

    let vocabularyItems: [ItemProtocol] = [
        Item(value: "まちます　待ちます", description: "等待"),
        Item(value: "いきます　行きます", description: "去"),
        Item(value: "きます　来ます", description: "來"),
        Item(value: "かえります　帰ります", description: "回去"),
        Item(value: "びょういん　病院", description: "醫院"),
        Item(value: "がっこう　学校", description: "學校"),
        Item(value: "うち", description: "家"),
        Item(value: "レストラン", description: "餐廳"),
        Item(value: "こっち", description: "這裡"),
        Item(value: "でんしゃ　電車", description: "電車"),
        Item(value: "タクシー", description: "計程車"),
        Item(value: "バス", description: "巴士"),
        Item(value: "じてんしゃ　自転車", description: "腳踏車"),
        Item(value: "ふね　船", description: "船"),
        Item(value: "らいねん　来年", description: "明年"),
        Item(value: "きょう　今日", description: "今天"),
        Item(value: "きのう　昨日", description: "昨天"),
        Item(value: "たんじょうび　誕生日", description: "生日"),
        Item(value: "あるいて　歩いて", description: "走路"),
        Item(value: "それから", description: "然後"),
        Item(value: "どうやって", description: "怎麼做..."),
        Item(value: "いつ", description: "什麼時候"),
        Item(value: "〜がつ　〜月", description: "～月"),
        Item(value: "〜にち　〜日", description: "～日"),
        Item(value: "おきなわ　沖縄", description: "沖繩"),
        Item(value: "いけぶくろ　池袋", description: "池袋"),
    ]

    let greetingPhrasesItem: [ItemProtocol] = [
        Item(value: "こんにちは", description: "您好"),
        Item(value: "おきをつけて　お気をつけて", description: "請小心"),
    ]

    let sentencePatternsItem: [ItemProtocol] = [
        Item(value: "いかがですか", description: "如何"),
        Item(value: "たのしみですね　楽しみですね", description: "很期待欸"),
        Item(value: "おまたせしました　お待たせしました", description: "讓你久等了"),
        Item(value: "いえ, そんなに", description: "不, 沒有那麼..."),
    ]
}
