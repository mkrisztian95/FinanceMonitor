import UIKitPlus

class TransactionItemView: NibInitiableView {

    struct ViewState {
        let category: String
        let price: String
        let date: String
        let summary: String
        let icon: UIImage
    }

    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var categoryLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var summaryLabel: UILabel!

    @discardableResult
    func apply(_ viewState: ViewState) -> Self {
        iconImageView.image = viewState.icon
        categoryLabel.text = viewState.category
        priceLabel.text = viewState.price
        dateLabel.text = viewState.date
        summaryLabel.text = viewState.summary
        return self
    }
}
