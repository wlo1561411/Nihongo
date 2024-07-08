import Foundation

struct Beginner3Theme: 
    Theme,
    LessonTheme
{
    let title = "初級 第三課"

    let vocabularyItems: [ItemProtocol] = [
        Item(value: "します", description: "做"),
        Item(value: "しょくじ\n食事します", description: "吃飯"),
        Item(value: "りょこう\n旅行します", description: "旅行"),
        Item(value: "ねます\n寝ます", description: "睡覺"),
        Item(value: "おきます\n起きます", description: "起床"),
        Item(value: "あいます\n会います", description: "見面"),
        Item(value: "べんきょうします\n勉強します", description: "學習"),
        Item(value: "はたらきします\n働きします", description: "工作"),
        Item(value: "おわります\n終わります", description: "結束"),
        Item(value: "ともだち\n友達", description: "朋友"),
        Item(value: "えき\n駅", description: "車站"),
        Item(value: "としょかん\n図書館", description: "圖書館"),
        Item(value: "りょこう\n旅行", description: "旅行"),
        Item(value: "しごと\n仕事", description: "工作"),
        Item(value: "やすみ\n休み", description: "休息, 休假日"),
        Item(value: "ごぜん\n午前", description: "上午"),
        Item(value: "ごご\n午後", description: "下午"),
        Item(value: "あさ\n朝", description: "早上"),
        Item(value: "ひる\n昼", description: "白天, 中午"),
        Item(value: "よる\n夜", description: "晚上"),
        Item(value: "ばん\n晩", description: "晚上"),
        Item(value: "しんや\n深夜", description: "深夜"),
        Item(value: "みめい\n未明", description: "凌晨"),
        Item(value: "そうちょう\n早朝", description: "清晨"),
        Item(value: "ゆうがた\n夕方", description: "傍晚"),
        Item(value: "げつようび\n月曜日", description: "星期一"),
        Item(value: "かようび\n火曜日", description: "星期二"),
        Item(value: "すいようび\n水曜日", description: "星期三"),
        Item(value: "もくようび\n木曜日", description: "星期四"),
        Item(value: "きんようび\n金曜日", description: "星期五"),
        Item(value: "どようび\n土曜日", description: "星期六"),
        Item(value: "にちようび\n日曜日", description: "星期日"),
        Item(value: "らいげつ\n来月", description: "下個月"),
        Item(value: "まいばん\n毎晩", description: "每晚"),
        Item(value: "えいぎょうじかん\n営業時間", description: "營業時間"),
        Item(value: "まいにちえいぎょう\n毎日営業", description: "每天營業"),
        Item(value: "まえ\n前", description: "前面"),
        Item(value: "こうこうじだい\n高校時代", description: "高中時代"),
        Item(value: "ひがしぐち\n東口", description: "東口"),
        Item(value: "にしぐち\n西口", description: "西口"),
        Item(value: "ひとりで\n一人で", description: "一個人"),
        Item(value: "いっしょに\n一緒に", description: "一起"),
        Item(value: "うん", description: "嗯"),
        Item(value: "ええ", description: "嗯, 好呀"),
        Item(value: "〜から", description: "從～開始"),
        Item(value: "〜まで", description: "到～為止"),
        Item(value: "しんじゅく\n新宿", description: "新宿"),
    ]

    let greetingPhrasesItem: [ItemProtocol] = [
        Item(value: "いいですね", description: "好呀, 不錯欸"),
        Item(value: "すみません,　ちょっと...", description: "對不起, 有點..."),
        Item(value: "じゃ,　また", description: "那麼, ～的時候再見"),
    ]

    let sentencePatternsItem: [ItemProtocol] = [
        Item(value: "たのしみにしています\n楽しみにしています", description: "我很期待著"),
        Item(value: "そうしましょう", description: "就那麼做吧"),
    ]
}
