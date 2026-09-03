public enum CardRank: Int, CaseIterable, Comparable {
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace

    public static func < (lhs: CardRank, rhs: CardRank) -> Bool { lhs.rawValue < rhs.rawValue }
}

public enum CardSuit: CaseIterable {
    case clubs, diamonds, hearts, spades
}

public struct Card: Hashable, Comparable {
    public let rank: CardRank
    public let suit: CardSuit

    public init(rank: CardRank, suit: CardSuit) {
        self.rank = rank
        self.suit = suit
    }

    public static func < (lhs: Card, rhs: Card) -> Bool { lhs.rank < rhs.rank }
}