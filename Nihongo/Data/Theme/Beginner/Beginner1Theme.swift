import Foundation

struct Beginner1Theme:
    Theme,
    LessonTheme
{
    let title = "初級 第一課"

    let vocabularyItems: [ItemProtocol] = [
        LessonItem(value: "わたし", hanValue: "私", description: "我"),
        LessonItem(value: "あなた", description: "你"),
        LessonItem(value: "あのひと", hanValue: "あの人", description: "那個人"),
        LessonItem(value: "かれ", hanValue: "彼", description: "他"),
        LessonItem(value: "かのじょ", hanValue: "彼女", description: "她"),
        LessonItem(value: "がくせい", hanValue: "学生", description: "學生"),
        LessonItem(value: "かいしゃいん", hanValue: "会社員", description: "公司職員"),
        LessonItem(value: "しゃいん", hanValue: "社員", description: "職員"),
        LessonItem(value: "どうりょう", hanValue: "同僚", description: "同事"),
        LessonItem(value: "しゅふ", hanValue: "主婦", description: "家庭主婦"),
        LessonItem(value: "くに", hanValue: "国", description: "國家"),
        LessonItem(value: "にほん", hanValue: "日本", description: "日本"),
        LessonItem(value: "アメリカ　America", description: "美國"),
        LessonItem(value: "たいわん", hanValue: "台湾", description: "台灣"),
        LessonItem(value: "なまえ", hanValue: "名前", description: "名字"),
        LessonItem(value: "かいしゃ", hanValue: "会社", description: "公司"),
        LessonItem(value: "けいたいでんわ", hanValue: "携帯電話", description: "手機"),
        LessonItem(value: "ばんごう", hanValue: "番号", description: "號碼"),
        LessonItem(value: "ぼうえき", hanValue: "貿易", description: "貿易"),
        LessonItem(value: "なんばん", hanValue: "何番", description: "幾號"),
        LessonItem(value: "だれ", hanValue: "誰", description: "誰"),
        LessonItem(value: "どなた", hanValue: "誰方", description: "哪一位"),
        LessonItem(value: "せんもん", hanValue: "専門", description: "專門"),
        LessonItem(value: "けいざい", hanValue: "経済", description: "經濟"),
        LessonItem(value: "メールアドレス", description: "電子郵件"),
        LessonItem(value: "コンピューター", description: "電腦"),
        LessonItem(value: "だいがく", hanValue: "大学", description: "大學"),
    ]

    let greetingPhrasesItems: [ItemProtocol] = [
        LessonItem(value: "おはよう", description: "早安"),
        LessonItem(value: "はじめまして", hanValue: "初めまして", description: "初次見面 您好"),
        LessonItem(value: "どうぞよろしく", description: "請多關照"),
        LessonItem(value: "こちらこそよろしく", description: "彼此彼此"),
        LessonItem(value: "おいくつですか", description: "您幾歲"),
    ]

    let sentencePatternsItems: [ItemProtocol] = [
        LessonItem(value: "おくにはどちらですか", hanValue: "お国はどちらですか", description: "是哪一國人？"),
        LessonItem(value: "〜からきました", hanValue: "から来ました", description: "來自～"),
        LessonItem(value: "〜をおしえてください", hanValue: "を教えてください", description: "請告訴我～"),
    ]
}
