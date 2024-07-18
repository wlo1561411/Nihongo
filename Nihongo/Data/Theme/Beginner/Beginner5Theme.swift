import Foundation

struct Beginner5Theme:
    Theme,
    LessonTheme
{
    let title = "初級 第五課"

    let vocabularyItems: [ItemProtocol] = [
        Item(value: "かきます　書きます", description: "寫"),
        Item(value: "よみます　読みます", description: "讀"),
        Item(value: "みます　見ます", description: "看"),
        Item(value: "たべます　食べます", description: "吃"),
        Item(value: "やすみます　休みます", description: "休息"),
        Item(value: "かいもの〜します　買い物〜します", description: "買東西"),
        Item(value: "すごい", description: "厲害, 了不起"),
        Item(value: "てがみ　手紙", description: "信件"),
        Item(value: "えいが　映画", description: "電影"),
        Item(value: "パン", description: "麵包"),
        Item(value: "たまご　卵", description: "蛋"),
        Item(value: "やさい　野菜", description: "蔬菜"),
        Item(value: "さかな　魚", description: "魚"),
        Item(value: "にく　肉", description: "肉"),
        Item(value: "ひ　日", description: "日子"),
        Item(value: "しゅうまつ　週末", description: "週末"),
        Item(value: "しょうせつ　小説", description: "小說"),
        Item(value: "ミステリー", description: "mystery"),
        Item(value: "れんあい　恋愛", description: "戀愛"),
        Item(value: "かいけい　会計", description: "結帳"),
        Item(value: "いつも", description: "總是"),
        Item(value: "よく", description: "經常"),
        Item(value: "ときどき　時々", description: "有時"),
        Item(value: "あまり", description: "不常...後面接否定"),
        Item(value: "ぜんぜん　全然", description: "完全不...後面接否定"),
        Item(value: "やっばり", description: "仍然, 還是"),
        Item(value: "ゆっくり", description: "好好地"),
        Item(value: "そろそろ", description: "差不多...了"),
        Item(value: "へえ", description: "欸 驚訝"),
    ]

    let greetingPhrasesItem: [ItemProtocol] = [
        Item(value: "いえいえ", description: "不, 不; 哪裡哪裡"),
    ]

    let sentencePatternsItem: [ItemProtocol] = [
        Item(value: "どうしますか", description: "要怎麼做"),
        Item(value: "べつべつにおねがいしなす　別々にお願いします", description: "請分開"),
    ]
}
