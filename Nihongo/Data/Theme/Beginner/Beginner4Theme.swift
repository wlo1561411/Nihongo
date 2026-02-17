import Foundation

struct Beginner4Theme:
    Theme,
    LessonTheme
{
    let title = "初級 第四課"

    let vocabularyItems: [ItemProtocol] = [
        LessonItem(value: "まちます", hanValue: "待ちます", description: "等待"),
        LessonItem(value: "いきます", hanValue: "行きます", description: "去"),
        LessonItem(value: "きます", hanValue: "来ます", description: "來"),
        LessonItem(value: "かえります", hanValue: "帰ります", description: "回去"),
        LessonItem(value: "びょういん", hanValue: "病院", description: "醫院"),
        LessonItem(value: "がっこう", hanValue: "学校", description: "學校"),
        LessonItem(value: "うち", description: "家"),
        LessonItem(value: "レストラン", description: "餐廳"),
        LessonItem(value: "こっち", description: "這裡"),
        LessonItem(value: "でんしゃ", hanValue: "電車", description: "電車"),
        LessonItem(value: "タクシー", description: "計程車"),
        LessonItem(value: "バス", description: "巴士"),
        LessonItem(value: "じてんしゃ", hanValue: "自転車", description: "腳踏車"),
        LessonItem(value: "ふね", hanValue: "船", description: "船"),
        LessonItem(value: "らいねん", hanValue: "来年", description: "明年"),
        LessonItem(value: "きょう", hanValue: "今日", description: "今天"),
        LessonItem(value: "きのう", hanValue: "昨日", description: "昨天"),
        LessonItem(value: "たんじょうび", hanValue: "誕生日", description: "生日"),
        LessonItem(value: "あるいて", hanValue: "歩いて", description: "走路"),
        LessonItem(value: "それから", description: "然後"),
        LessonItem(value: "どうやって", description: "怎麼做..."),
        LessonItem(value: "いつ", description: "什麼時候"),
        LessonItem(value: "〜がつ", hanValue: "〜月", description: "～月"),
        LessonItem(value: "〜にち", hanValue: "〜日", description: "～日"),
        LessonItem(value: "おきなわ", hanValue: "沖縄", description: "沖繩"),
        LessonItem(value: "いけぶくろ", hanValue: "池袋", description: "池袋"),
    ]

    let greetingPhrasesItems: [ItemProtocol] = [
        LessonItem(value: "こんにちは", description: "您好"),
        LessonItem(value: "おきをつけて", hanValue: "お気をつけて", description: "請小心"),
    ]

    let sentencePatternsItems: [ItemProtocol] = [
        LessonItem(value: "いかがですか", description: "如何"),
        LessonItem(value: "たのしみですね", hanValue: "楽しみですね", description: "很期待欸"),
        LessonItem(value: "おまたせしました", hanValue: "お待たせしました", description: "讓你久等了"),
        LessonItem(value: "いえ, そんなに", description: "不, 沒有那麼..."),
    ]
}
