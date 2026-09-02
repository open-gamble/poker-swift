import Testing
import PokerKit

@Test func rankSetContainsExactlyThirteenDistinctCases() {
    #expect(Rank.allCases.count == 13)
    #expect(Set(Rank.allCases).count == Rank.allCases.count)
}

@Test func rankSetContainsExactlyTheStandardRanks() {
    let expected: Set<Rank> = [
        .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten,
        .jack, .queen, .king, .ace,
    ]
    #expect(Set(Rank.allCases) == expected)
}

@Test func suitSetContainsExactlyFourDistinctCases() {
    #expect(Suit.allCases.count == 4)
    #expect(Set(Suit.allCases).count == Suit.allCases.count)
}

@Test func suitSetContainsExactlyTheStandardSuits() {
    let expected: Set<Suit> = [.clubs, .diamonds, .hearts, .spades]
    #expect(Set(Suit.allCases) == expected)
}

@Test func cardsWithIdenticalRankAndSuitAreEqual() {
    #expect(Card(rank: .ace, suit: .spades) == Card(rank: .ace, suit: .spades))
}

@Test func cardsWithSameRankAndDifferentSuitAreNotEqual() {
    #expect(Card(rank: .ace, suit: .spades) != Card(rank: .ace, suit: .hearts))
}

@Test func cardsWithDifferentRankAndSameSuitAreNotEqual() {
    #expect(Card(rank: .king, suit: .spades) != Card(rank: .ace, suit: .spades))
}

@Test func equalCardsHaveEqualHashesAndOccupyOneSetSlot() {
    let a = Card(rank: .ace, suit: .spades)
    let b = Card(rank: .ace, suit: .spades)
    #expect(a.hashValue == b.hashValue)
    #expect(Set([a, b]).count == 1)
}
