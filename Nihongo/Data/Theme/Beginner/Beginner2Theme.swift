import Foundation

struct Beginner2Theme: 
    Theme,
    LessonTheme
{
    let title = "初級 第二課"

    let vocabularyItems: [ItemProtocol] = [
        Item(value: "おおきい\n大きい", description: "大的"),
        Item(value: "これ", description: "這～ 靠近我"),
        Item(value: "それ", description: "那～ 靠近你"),
        Item(value: "あれ", description: "那～ 都不靠近"),
        Item(value: "どれ", description: "哪～"),
        Item(value: "この", description: "這個～ 靠近我"),
        Item(value: "その", description: "那個～ 靠近你"),
        Item(value: "あの", description: "那個～ 都不靠近"),
        Item(value: "どの", description: "哪個～"),
        Item(value: "ここ", description: "這裡 靠近我"),
        Item(value: "そこ", description: "那裡 靠近你"),
        Item(value: "あそこ", description: "那裡 都不靠近"),
        Item(value: "どこ", description: "哪裡"),
        Item(value: "こちら", description: "這(個, 裡, 位) 靠近我"),
        Item(value: "そちら", description: "那(個, 裡, 位) 靠近你"),
        Item(value: "あちら", description: "那(個, 裡, 位) 都不靠近"),
        Item(value: "どちら", description: "哪(個, 裡, 位)"),
        Item(value: "トイレ", description: "洗手間"),
        Item(value: "おてあらい\nお手洗い", description: "洗手間"),
        Item(value: "うけつけ\n受付", description: "櫃檯"),
        Item(value: "きょうしつ\n教室", description: "教室"),
        Item(value: "デパート", description: "百貨公司"),
        Item(value: "かばん", description: "包包"),
        Item(value: "でんわ\n電話", description: "電話"),
        Item(value: "かさ\n傘", description: "傘"),
        Item(value: "ほん\n本", description: "書"),
        Item(value: "てちょう\n手帳", description: "筆記本"),
        Item(value: "めがね\n眼鏡", description: "眼鏡"),
        Item(value: "パスポート", description: "護照"),
        Item(value: "けいさんき\n計算機", description: "計算機"),
        Item(value: "ようふく\n洋服", description: "洋裝"),
        Item(value: "うりば\n売場", description: "賣場"),
        Item(value: "ふじんふく\n婦人服", description: "女裝"),
        Item(value: "ハンカチ", description: "手帕"),
        Item(value: "スカーフ", description: "領巾"),
        Item(value: "ネクタイ", description: "領帶"),
        Item(value: "シャツ", description: "襯衫"),
        Item(value: "パンコン", description: "個人電腦"),
        Item(value: "ぜんぶで\n全部で", description: "全部總共"),
        Item(value: "じゃあ", description: "那麼"),
        Item(value: "わあ", description: "哇"),
        Item(value: "あのう", description: "嗯..."),
        Item(value: "いくら", description: "多少錢"),
        Item(value: "まん\n万", description: "萬"),
        Item(value: "せん\n千", description: "千"),
        Item(value: "ひゃく\n百", description: "百"),
        Item(value: "じゅう\n十", description: "十"),
        Item(value: "〜ご\n〜語", description: "～語"),
        Item(value: "〜かい\n〜階", description: "～樓"),
        Item(value: "～えん\n〜円", description: "～日圓"),
        Item(value: "なん\n何", description: "什麼"),
    ]

    let greetingPhrasesItem: [ItemProtocol] = [
        Item(value: "ありがとうございました", description: "謝謝"),
        Item(value: "すみません", description: "對不起"),
        Item(value: "そうですね", description: "對啊"),
        Item(value: "いらっしゃいませ", description: "歡迎光臨"),
    ]

    let sentencePatternsItem: [ItemProtocol] = [
        Item(value: "はいってみましょう\n入ってみましょう", description: "進去看看吧"),
        Item(value: "〜でございます", description: "在～"),
        Item(value: "きれいですね", description: "真漂亮啊"),
        Item(value: "どうしますか", description: "打算怎麼做呢？"),
        Item(value: "ちょっとかんがえます\nちょっと考えます", description: "考慮一下"),
        Item(value: "〜をください", description: "請給我～"),
    ]
}
