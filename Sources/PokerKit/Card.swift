public enum CardRank: CaseIterable {
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace
}

public enum CardSuit: CaseIterable {
    case clubs, diamonds, hearts, spades
}

public struct Card: Hashable {
    public let rank: CardRank
    public let suit: CardSuit

    public init(rank: CardRank, suit: CardSuit) {
        self.rank = rank
        self.suit = suit
    }
}