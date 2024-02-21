enum SubscriptionStatus {
    case awaitingSubscription
    case subscribed(Subscription)
    case pendingTerminal(Subscription)
    case terminal
}

extension SubscriptionStatus {

    var isAwaitingSubscription: Bool {
        switch self {
        case .awaitingSubscription:
            true
        default:
            false
        }
    }

    var subscription: Subscription? {
        switch self {
        case .awaitingSubscription, 
             .terminal:
            nil
        case let .subscribed(subscription),
             let .pendingTerminal(subscription):
            subscription
        }
    }
}
