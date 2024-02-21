import Charts
import Depin
import UIKit

class UserProfileViewStateFactory {

    typealias ViewState = UserProfileViewController.ViewState

    func make(
        transactionModel: TransactionModel
    ) -> ViewState {
        ViewState(
            transactionsViewState: transactionModel.items.map {
                TransactionItemView.ViewState(
                    category: $0.category.rawValue,
                    price: formatCurrency(amount: $0.sum, code: $0.currency),
                    date: $0.paid.date(with: .short),
                    summary: $0.summary,
                    icon: .icTransaction
                )
            },
            availableCategories: Array(Set(transactionModel.items.map { $0.category })),
            chartData: getChartData(transactionModel.aggregatedAverage)
        )
    }

    private func formatCurrency(amount: Double, code: String) -> String {
        amount.formatted(.currency(code: code))
    }

    private func generateColors(baseColor: UIColor, count: Int) -> [UIColor] {
        var colors: [UIColor] = []
        let step: CGFloat = 1.0 / CGFloat(count)
        for i in 1...count {
            let alpha = CGFloat(i) * step
            let newColor = baseColor.withAlphaComponent(alpha)
            colors.append(newColor)
        }
        return colors
    }

    private func getChardDataSet(_ data: [String: Double]) -> PieChartDataSet {
        let entries = data.enumerated().map { args in
            ChartDataEntry(
                x: Double(args.offset),
                y: Double(Int(args.element.value)),
                icon: nil,
                data: args.element.key
            )
        }

        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 10
        set.colors = generateColors(baseColor: .black500, count: data.count)

        return set
    }

    func getChartData(_ data: [String: Double]) -> PieChartData {
        let data = PieChartData(dataSet: getChardDataSet(data))

        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))

        data.setValueFont(.systemFont(ofSize: 11, weight: .bold))
        data.setValueTextColor(.black)

        return data
    }
}

private extension Date {

    enum DateFormat: String {
        case full = "EEEE, MMMM d, yyyy"
        case short = "MMM d, yyyy"
        case time = "h:mm a"
        case fancy = "EEEE, MMMM d 'at' h:mm a"
    }

    func date(with format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
