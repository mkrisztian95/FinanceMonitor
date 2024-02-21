import Foundation

struct TransactionEntity: Decodable {
    enum TransactionCategory: String, Decodable {
        case housing
        case travel
        case food
        case utilities
        case insurance
        case healthcare
        case financial
        case lifestyle
        case entertainment
        case miscellaneous
        case clothing
        case unknown
    }

    let id: String
    let summary: String
    let category: TransactionCategory
    let sum: Double
    let currency: String
    let paid: Date

    enum CodingKeys: String, CodingKey {
        case id, summary, category, sum, currency, paid
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        summary = try container.decode(String.self, forKey: .summary)
        category = try container.decodeIfPresent(TransactionCategory.self, forKey: .category) ?? .unknown
        sum = try container.decode(Double.self, forKey: .sum)
        currency = try container.decode(String.self, forKey: .currency)

        let paidString = try container.decode(String.self, forKey: .paid)
        let formatter = ISO8601DateFormatter()
        paid = formatter.date(from: paidString) ?? Date()
    }
}
