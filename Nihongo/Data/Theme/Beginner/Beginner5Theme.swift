import Foundation

struct Beginner5Theme:
    Theme,
    LessonTheme
{
    let title = "初級 第五課"

    let vocabularyItems: [ItemProtocol] = [
        LessonItem(value: "かきます", hanValue: "書きます", description: "寫"),
        LessonItem(value: "よみます", hanValue: "読みます", description: "讀"),
        LessonItem(value: "みます", hanValue: "見ます", description: "看"),
        LessonItem(value: "たべます", hanValue: "食べます", description: "吃"),
        LessonItem(value: "やすみます", hanValue: "休みます", description: "休息"),
        LessonItem(value: "かいものします", hanValue: "買い物します", description: "買東西"),
        LessonItem(value: "すごい", description: "厲害, 了不起"),
        LessonItem(value: "てがみ", hanValue: "手紙", description: "信件"),
        LessonItem(value: "えいが", hanValue: "映画", description: "電影"),
        LessonItem(value: "パン", description: "麵包"),
        LessonItem(value: "たまご", hanValue: "卵", description: "蛋"),
        LessonItem(value: "やさい", hanValue: "野菜", description: "蔬菜"),
        LessonItem(value: "さかな", hanValue: "魚", description: "魚"),
        LessonItem(value: "にく", hanValue: "肉", description: "肉"),
        LessonItem(value: "ひ", hanValue: "日", description: "日子"),
        LessonItem(value: "しゅうまつ", hanValue: "週末", description: "週末"),
        LessonItem(value: "しょうせつ", hanValue: "小説", description: "小說"),
        LessonItem(value: "ミステリー", description: "mystery 神秘"),
        LessonItem(value: "れんあい", hanValue: "恋愛", description: "戀愛"),
        LessonItem(value: "かいけい", hanValue: "会計", description: "結帳"),
        LessonItem(value: "いつも", description: "總是"),
        LessonItem(value: "よく", description: "經常"),
        LessonItem(value: "ときどき", hanValue: "時々", description: "有時"),
        LessonItem(value: "あまり", description: "不常...後面接否定"),
        LessonItem(value: "ぜんぜん", hanValue: "全然", description: "完全不...後面接否定"),
        LessonItem(value: "やっぱり", description: "仍然, 還是"),
        LessonItem(value: "ゆっくり", description: "好好地"),
        LessonItem(value: "そろそろ", description: "差不多...了"),
        LessonItem(value: "へえ", description: "欸 驚訝"),
    ]

    let greetingPhrasesItems: [ItemProtocol] = [
        LessonItem(value: "いえいえ", description: "不, 不; 哪裡哪裡"),
    ]

    let sentencePatternsItems: [ItemProtocol] = [
        LessonItem(value: "どうしますか", description: "要怎麼做"),
        LessonItem(value: "べつべつにおねがいします", hanValue: "別々にお願いします", description: "請分開 (結帳, 分袋裝)"),
    ]
}
