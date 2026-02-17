import Foundation

struct Beginner2Theme: 
    Theme,
    LessonTheme
{
    let title = "初級 第二課"

    let vocabularyItems: [ItemProtocol] = [
        LessonItem(value: "おおきい", hanValue: "大きい", description: "大的"),
        LessonItem(value: "これ", description: "這～ 靠近我"),
        LessonItem(value: "それ", description: "那～ 靠近你"),
        LessonItem(value: "あれ", description: "那～ 都不靠近"),
        LessonItem(value: "どれ", description: "哪～"),
        LessonItem(value: "この", description: "這個～ 靠近我"),
        LessonItem(value: "その", description: "那個～ 靠近你"),
        LessonItem(value: "あの", description: "那個～ 都不靠近"),
        LessonItem(value: "どの", description: "哪個～"),
        LessonItem(value: "ここ", description: "這裡 靠近我"),
        LessonItem(value: "そこ", description: "那裡 靠近你"),
        LessonItem(value: "あそこ", description: "那裡 都不靠近"),
        LessonItem(value: "どこ", description: "哪裡"),
        LessonItem(value: "こちら", description: "這(個, 裡, 位) 靠近我"),
        LessonItem(value: "そちら", description: "那(個, 裡, 位) 靠近你"),
        LessonItem(value: "あちら", description: "那(個, 裡, 位) 都不靠近"),
        LessonItem(value: "どちら", description: "哪(個, 裡, 位)"),
        LessonItem(value: "トイレ", description: "洗手間"),
        LessonItem(value: "おてあらい", hanValue: "お手洗い", description: "洗手間"),
        LessonItem(value: "うけつけ", hanValue: "受付", description: "櫃檯"),
        LessonItem(value: "きょうしつ", hanValue: "教室", description: "教室"),
        LessonItem(value: "デパート", description: "百貨公司"),
        LessonItem(value: "かばん", description: "包包"),
        LessonItem(value: "でんわ", hanValue: "電話", description: "電話"),
        LessonItem(value: "かさ", hanValue: "傘", description: "傘"),
        LessonItem(value: "ほん", hanValue: "本", description: "書"),
        LessonItem(value: "てちょう", hanValue: "手帳", description: "筆記本"),
        LessonItem(value: "めがね", hanValue: "眼鏡", description: "眼鏡"),
        LessonItem(value: "パスポート", description: "護照"),
        LessonItem(value: "けいさんき", hanValue: "計算機", description: "計算機"),
        LessonItem(value: "ようふく", hanValue: "洋服", description: "洋裝"),
        LessonItem(value: "うりば", hanValue: "売場", description: "賣場"),
        LessonItem(value: "ふじんふく", hanValue: "婦人服", description: "女裝"),
        LessonItem(value: "ハンカチ", description: "手帕"),
        LessonItem(value: "スカーフ", description: "領巾"),
        LessonItem(value: "ネクタイ", description: "領帶"),
        LessonItem(value: "シャツ", description: "襯衫"),
        LessonItem(value: "パソコン", description: "個人電腦"),
        LessonItem(value: "ぜんぶで", hanValue: "全部で", description: "全部總共"),
        LessonItem(value: "じゃあ", description: "那麼"),
        LessonItem(value: "わあ", description: "哇"),
        LessonItem(value: "あのう", description: "嗯..."),
        LessonItem(value: "いくら", description: "多少錢"),
        LessonItem(value: "まん", hanValue: "万", description: "萬"),
        LessonItem(value: "せん", hanValue: "千", description: "千"),
        LessonItem(value: "ひゃく", hanValue: "百", description: "百"),
        LessonItem(value: "じゅう", hanValue: "十", description: "十"),
        LessonItem(value: "〜ご", hanValue: "〜語", description: "～語"),
        LessonItem(value: "〜かい", hanValue: "〜階", description: "～樓"),
        LessonItem(value: "～えん", hanValue: "〜円", description: "～日圓"),
        LessonItem(value: "なん", hanValue: "何", description: "什麼"),
    ]

    let greetingPhrasesItems: [ItemProtocol] = [
        LessonItem(value: "ありがとうございました", description: "謝謝"),
        LessonItem(value: "すみません", description: "對不起"),
        LessonItem(value: "そうですね", description: "對啊"),
        LessonItem(value: "いらっしゃいませ", description: "歡迎光臨"),
    ]

    let sentencePatternsItems: [ItemProtocol] = [
        LessonItem(value: "はいってみましょう", hanValue: "入ってみましょう", description: "進去看看吧"),
        LessonItem(value: "〜でございます", description: "在～"),
        LessonItem(value: "きれいですね", description: "真漂亮啊"),
        LessonItem(value: "どうしますか", description: "打算怎麼做呢？"),
        LessonItem(value: "ちょっとかんがえます", hanValue: "ちょっと考えます", description: "考慮一下"),
        LessonItem(value: "〜をください", description: "請給我～"),
    ]
}
