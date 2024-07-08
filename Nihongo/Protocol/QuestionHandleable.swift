import Foundation

protocol QuestionHandleable: AnyObject {
    var items: [ItemProtocol] { get set }
    var currentItem: ItemProtocol? { get set }

    func fetchNextQuestion()
    func endTest()
    func checkAnswer(_ input: String?)
}

extension QuestionHandleable {
    func prepareForNextQuestion() {
        guard
            let currentItem,
            let index = items.firstIndex(where: { currentItem.value == $0.value })
        else { return }

        items.remove(at: index)
        self.currentItem = items.first

        if items.isEmpty {
            endTest()
        }
        else {
            fetchNextQuestion()
        }
    }
}
