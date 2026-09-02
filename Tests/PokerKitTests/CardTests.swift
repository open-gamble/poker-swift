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

private func allRankSuitCards() -> [Card] {
    Rank.allCases.flatMap { rank in Suit.allCases.map { Card(rank: rank, suit: $0) } }
}

@Test func exhaustiveRankSuitCombinationsProduceExactlyFiftyTwoCards() {
    #expect(allRankSuitCards().count == 52)
}

@Test func setOfAllRankSuitCombinationsContainsExactlyFiftyTwoUniqueCards() {
    #expect(Set(allRankSuitCards()).count == 52)
}

@Test func everyRankSuitCombinationAppearsExactlyOnce() {
    let all = allRankSuitCards()
    for rank in Rank.allCases {
        for suit in Suit.allCases {
            #expect(all.filter { $0.rank == rank && $0.suit == suit }.count == 1)
        }
    }
}

@Test func everyRankAppearsWithAllFourSuitsAndEverySuitWithAllThirteenRanks() {
    let all = allRankSuitCards()
    for rank in Rank.allCases {
        #expect(Set(all.filter { $0.rank == rank }.map(\.suit)) == Set(Suit.allCases))
    }
    for suit in Suit.allCases {
        #expect(Set(all.filter { $0.suit == suit }.map(\.rank)) == Set(Rank.allCases))
    }
}

@Test func constructingTheSameRankSuitTwiceYieldsEqualCards() {
    for rank in Rank.allCases {
        for suit in Suit.allCases {
            let a = Card(rank: rank, suit: suit)
            let b = Card(rank: rank, suit: suit)
            #expect(a == b)
            #expect(a.hashValue == b.hashValue)
            #expect(Set([a, b]).count == 1)
        }
    }
}
