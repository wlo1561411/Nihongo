import Foundation

struct Beginner3Theme: 
    Theme,
    LessonTheme
{
    let title = "初級 第三課"

    let vocabularyItems: [ItemProtocol] = [
        Item(value: "します", description: "做"),
        Item(value: "しょくじ　食事します", description: "吃飯"),
        Item(value: "りょこう　旅行します", description: "旅行"),
        Item(value: "ねます　寝ます", description: "睡覺"),
        Item(value: "おきます　起きます", description: "起床"),
        Item(value: "あいます　会います", description: "見面"),
        Item(value: "べんきょうします　勉強します", description: "學習"),
        Item(value: "はたらきします　働きします", description: "工作"),
        Item(value: "おわります　終わります", description: "結束"),
        Item(value: "ともだち　友達", description: "朋友"),
        Item(value: "えき　駅", description: "車站"),
        Item(value: "としょかん　図書館", description: "圖書館"),
        Item(value: "りょこう　旅行", description: "旅行"),
        Item(value: "しごと　仕事", description: "工作"),
        Item(value: "やすみ　休み", description: "休息, 休假日"),
        Item(value: "ごぜん　午前", description: "上午"),
        Item(value: "ごご　午後", description: "下午"),
        Item(value: "あさ　朝", description: "早上"),
        Item(value: "ひる　昼", description: "白天, 中午"),
        Item(value: "よる　夜", description: "晚上"),
        Item(value: "ばん　晩", description: "晚上"),
        Item(value: "しんや　深夜", description: "深夜"),
        Item(value: "みめい　未明", description: "凌晨"),
        Item(value: "そうちょう　早朝", description: "清晨"),
        Item(value: "ゆうがた　夕方", description: "傍晚"),
        Item(value: "げつようび　月曜日", description: "星期一"),
        Item(value: "かようび　火曜日", description: "星期二"),
        Item(value: "すいようび　水曜日", description: "星期三"),
        Item(value: "もくようび　木曜日", description: "星期四"),
        Item(value: "きんようび　金曜日", description: "星期五"),
        Item(value: "どようび　土曜日", description: "星期六"),
        Item(value: "にちようび　日曜日", description: "星期日"),
        Item(value: "らいげつ　来月", description: "下個月"),
        Item(value: "まいばん　毎晩", description: "每晚"),
        Item(value: "えいぎょうじかん　営業時間", description: "營業時間"),
        Item(value: "まいにちえいぎょう　毎日営業", description: "每天營業"),
        Item(value: "まえ　前", description: "前面"),
        Item(value: "こうこうじだい　高校時代", description: "高中時代"),
        Item(value: "ひがしぐち　東口", description: "東口"),
        Item(value: "にしぐち　西口", description: "西口"),
        Item(value: "ひとりで　一人で", description: "一個人"),
        Item(value: "いっしょに　一緒に", description: "一起"),
        Item(value: "うん", description: "嗯"),
        Item(value: "ええ", description: "嗯, 好呀"),
        Item(value: "〜から", description: "從～開始"),
        Item(value: "〜まで", description: "到～為止"),
        Item(value: "しんじゅく　新宿", description: "新宿"),
    ]

    let greetingPhrasesItem: [ItemProtocol] = [
        Item(value: "いいですね", description: "好呀, 不錯欸"),
        Item(value: "すみません,　ちょっと...", description: "對不起, 有點..."),
        Item(value: "じゃ,　また", description: "那麼, ～的時候再見"),
    ]

    let sentencePatternsItem: [ItemProtocol] = [
        Item(value: "たのしみにしています　楽しみにしています", description: "我很期待著"),
        Item(value: "そうしましょう", description: "就那麼做吧"),
    ]
}
