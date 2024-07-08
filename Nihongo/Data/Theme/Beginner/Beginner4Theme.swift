import Foundation

struct Beginner4Theme:
    Theme,
    LessonTheme
{
    let title = "初級 第四課"

    let vocabularyItems: [ItemProtocol] = [
        Item(value: "まちます\n待ちます", description: "等待"),
        Item(value: "いきます\n行きます", description: "去"),
        Item(value: "きます\n来ます", description: "來"),
        Item(value: "かえります\n帰ります", description: "回去"),
        Item(value: "びょういん\n病院", description: "醫院"),
        Item(value: "がっこう\n学校", description: "學校"),
        Item(value: "うち", description: "家"),
        Item(value: "レストラン", description: "餐廳"),
        Item(value: "こっち", description: "這裡"),
        Item(value: "でんしゃ\n電車", description: "電車"),
        Item(value: "タクシー", description: "計程車"),
        Item(value: "バス", description: "巴士"),
        Item(value: "じてんしゃ\n自転車", description: "腳踏車"),
        Item(value: "ふね\n船", description: "船"),
        Item(value: "らいねん\n来年", description: "明年"),
        Item(value: "きょう\n今日", description: "今天"),
        Item(value: "きのう\n昨日", description: "昨天"),
        Item(value: "たんじょうび\n誕生日", description: "生日"),
        Item(value: "あるいて\n歩いて", description: "走路"),
        Item(value: "それから", description: "然後"),
        Item(value: "どうやって", description: "怎麼做..."),
        Item(value: "いつ", description: "什麼時候"),
        Item(value: "〜がつ\n〜月", description: "～月"),
        Item(value: "〜にち\n〜日", description: "～日"),
        Item(value: "おきなわ\n沖縄", description: "沖繩"),
        Item(value: "いけぶくろ\n池袋", description: "池袋"),
    ]

    let greetingPhrasesItem: [ItemProtocol] = [
        Item(value: "こんにちは", description: "您好"),
        Item(value: "おきをつけて\nお気をつけて", description: "請小心"),
    ]

    let sentencePatternsItem: [ItemProtocol] = [
        Item(value: "いかがですか", description: "如何"),
        Item(value: "たのしみですね\n楽しみですね", description: "很期待欸"),
        Item(value: "おまたせしました\nお待たせしました", description: "讓你久等了"),
        Item(value: "いえ, そんなに", description: "不, 沒有那麼..."),
    ]
}
