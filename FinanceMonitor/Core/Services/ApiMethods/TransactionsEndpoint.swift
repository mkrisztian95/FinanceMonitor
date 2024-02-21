import Foundation

enum TransactionsEndpoint: Endpoint {

    case transactions

    var host: String {
        switch Environment.current {
        case .testing:
            "https://development.sprintform.com/"
        case .production:
            "https://sprintform.com/"
        }
    }

    var path: String {
        switch self {
        case .transactions:
            "/transactions.json"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .transactions:
            nil
        }
    }

    var method: HTTPMethod {
        switch self {
        case .transactions:
                .get
        }
    }

    var body: Encodable? {
        switch self {
        case .transactions:
            nil
        }
    }
}
