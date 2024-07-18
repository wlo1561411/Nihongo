import Foundation

struct Beginner1Theme:
    Theme,
    LessonTheme
{
    let title = "初級 第一課"

    let vocabularyItems: [ItemProtocol] = [
        Item(value: "わたし　私", description: "我"),
        Item(value: "あなた", description: "你"),
        Item(value: "あのひと　あの人", description: "那個人"),
        Item(value: "かれ　彼", description: "他"),
        Item(value: "かのじょ　彼女", description: "她"),
        Item(value: "がくせん　学生", description: "學生"),
        Item(value: "かいしゃいん　会社員", description: "公司職員"),
        Item(value: "じゃいん　社員", description: "職員"),
        Item(value: "どうりょう　同僚", description: "同事"),
        Item(value: "しゅふ　主婦", description: "家庭主婦"),
        Item(value: "くに　国", description: "國家"),
        Item(value: "にほん　日本", description: "日本"),
        Item(value: "アメリカ　America", description: "美國"),
        Item(value: "たいわん　台湾", description: "台灣"),
        Item(value: "なまえ　名前", description: "名字"),
        Item(value: "かいしゃ　会社", description: "公司"),
        Item(value: "けいたいでんわ　携帯電話", description: "手機"),
        Item(value: "ばんごう　番号", description: "號碼"),
        Item(value: "ぼうえき　貿易", description: "貿易"),
        Item(value: "なんばん　何番", description: "幾號"),
        Item(value: "だれ　誰", description: "誰"),
        Item(value: "どなた　誰方", description: "哪一位"),
        Item(value: "せんもん　専門", description: "專門"),
        Item(value: "けいざい　経済", description: "經濟"),
        Item(value: "メールアドレス", description: "電子郵件"),
        Item(value: "コンピューター", description: "電腦"),
        Item(value: "だいがく　大学", description: "大學"),
    ]

    let greetingPhrasesItem: [ItemProtocol] = [
        Item(value: "おはよう", description: "早安"),
        Item(value: "はじめまして　初めまして", description: "初次見面 您好"),
        Item(value: "どうぞよろしく", description: "請多關照"),
        Item(value: "こちらこそよろしく", description: "彼此彼此"),
        Item(value: "おいくつですか", description: "您幾歲"),
    ]

    let sentencePatternsItem: [ItemProtocol] = [
        Item(value: "お国はどちらてすか", description: "是哪一國人？"),
        Item(value: "〜からきました　から来ました", description: "來自～"),
        Item(value: "〜をおしえてください　を教えてください", description: "請告訴我～"),
    ]
}
