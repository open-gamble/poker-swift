public enum Rank: CaseIterable {
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace
}

public enum Suit: CaseIterable {
    case clubs, diamonds, hearts, spades
}

public struct Card: Hashable {
    public let rank: Rank
    public let suit: Suit

    public init(rank: Rank, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }
}
