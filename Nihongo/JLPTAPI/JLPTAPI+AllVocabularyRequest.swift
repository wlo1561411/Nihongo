import FMFoundation
import Foundation

extension JLPTAPI {
    struct AllVocabularyRequest: JLPTAPI.Request {
        typealias Response = [Vocabulary]

        let path = "/api/words/all"
        let method: APIHttpMethod = .GET
        var parameters: any APIParameterConvertible = [:]
        let contentType: APIContentType = .json
    }
}
