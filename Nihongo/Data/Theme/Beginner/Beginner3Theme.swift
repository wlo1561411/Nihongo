import Foundation

struct Beginner3Theme:
    Theme,
    LessonTheme {
    let title = "初級 第三課"

    let vocabularyItems: [ItemProtocol] = [
        LessonItem(value: "します", description: "做"),
        LessonItem(value: "しょくじします", hanValue: "食事します", description: "吃飯"),
        LessonItem(value: "りょこうします", hanValue: "旅行します", description: "旅行"),
        LessonItem(value: "ねます", hanValue: "寝ます", description: "睡覺"),
        LessonItem(value: "おきます", hanValue: "起きます", description: "起床"),
        LessonItem(value: "あいます", hanValue: "会います", description: "見面"),
        LessonItem(value: "べんきょうします", hanValue: "勉強します", description: "學習"),
        LessonItem(value: "はたらきます", hanValue: "働きます", description: "工作"),
        LessonItem(value: "おわります", hanValue: "終わります", description: "結束"),
        LessonItem(value: "ともだち", hanValue: "友達", description: "朋友"),
        LessonItem(value: "えき", hanValue: "駅", description: "車站"),
        LessonItem(value: "としょかん", hanValue: "図書館", description: "圖書館"),
        LessonItem(value: "りょこう", hanValue: "旅行", description: "旅行"),
        LessonItem(value: "しごと", hanValue: "仕事", description: "工作"),
        LessonItem(value: "やすみ", hanValue: "休み", description: "休息, 休假日"),
        LessonItem(value: "ごぜん", hanValue: "午前", description: "上午"),
        LessonItem(value: "ごご", hanValue: "午後", description: "下午"),
        LessonItem(value: "あさ", hanValue: "朝", description: "早上"),
        LessonItem(value: "ひる", hanValue: "昼", description: "白天, 中午"),
        LessonItem(value: "よる", hanValue: "夜", description: "晚上"),
        LessonItem(value: "ばん", hanValue: "晩", description: "晚上"),
        LessonItem(value: "しんや", hanValue: "深夜", description: "深夜"),
        LessonItem(value: "みめい", hanValue: "未明", description: "凌晨"),
        LessonItem(value: "そうちょう", hanValue: "早朝", description: "清晨"),
        LessonItem(value: "ゆうがた", hanValue: "夕方", description: "傍晚"),
        LessonItem(value: "げつようび", hanValue: "月曜日", description: "星期一"),
        LessonItem(value: "かようび", hanValue: "火曜日", description: "星期二"),
        LessonItem(value: "すいようび", hanValue: "水曜日", description: "星期三"),
        LessonItem(value: "もくようび", hanValue: "木曜日", description: "星期四"),
        LessonItem(value: "きんようび", hanValue: "金曜日", description: "星期五"),
        LessonItem(value: "どようび", hanValue: "土曜日", description: "星期六"),
        LessonItem(value: "にちようび", hanValue: "日曜日", description: "星期日"),
        LessonItem(value: "らいげつ", hanValue: "来月", description: "下個月"),
        LessonItem(value: "まいばん", hanValue: "毎晩", description: "每晚"),
        LessonItem(value: "えいぎょうじかん", hanValue: "営業時間", description: "營業時間"),
        LessonItem(value: "まいにちえいぎょう", hanValue: "毎日営業", description: "每天營業"),
        LessonItem(value: "まえ", hanValue: "前", description: "前面"),
        LessonItem(value: "こうこうじだい", hanValue: "高校時代", description: "高中時代"),
        LessonItem(value: "ひがしぐち", hanValue: "東口", description: "東口"),
        LessonItem(value: "にしぐち", hanValue: "西口", description: "西口"),
        LessonItem(value: "ひとりで", hanValue: "一人で", description: "一個人"),
        LessonItem(value: "いっしょに", hanValue: "一緒に", description: "一起"),
        LessonItem(value: "うん", description: "嗯"),
        LessonItem(value: "ええ", description: "嗯, 好呀"),
        LessonItem(value: "〜から", description: "從～開始"),
        LessonItem(value: "〜まで", description: "到～為止"),
        LessonItem(value: "しんじゅく", hanValue: "新宿", description: "新宿"),
    ]

    let greetingPhrasesItems: [ItemProtocol] = [
        LessonItem(value: "いいですね", description: "好呀, 不錯欸"),
        LessonItem(value: "すみません,　ちょっと...", description: "對不起, 有點..."),
        LessonItem(value: "じゃ,　また", description: "那麼, ～的時候再見"),
    ]

    let sentencePatternsItems: [ItemProtocol] = [
        LessonItem(value: "たのしみにしています", hanValue: "楽しみにしています", description: "我很期待著"),
        LessonItem(value: "そうしましょう", description: "就那麼做吧"),
    ]
}
