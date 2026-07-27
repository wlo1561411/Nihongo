import FMFoundation
import Foundation

nonisolated struct JLPTAPI {
    protocol Request: APIRequest { }


}

extension JLPTAPI.Request {
    nonisolated var baseURL: URL? {
        URL(string: "https://jlpt-vocab-api.vercel.app")
    }
}
