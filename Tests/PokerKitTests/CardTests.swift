import Testing
import PokerKit

@Test func cardRankSetContainsExactlyThirteenDistinctCases() {
    #expect(CardRank.allCases.count == 13)
    #expect(Set(CardRank.allCases).count == CardRank.allCases.count)
}

@Test func cardRankSetContainsExactlyTheStandardRanks() {
    let expected: Set<CardRank> = [
        .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten,
        .jack, .queen, .king, .ace,
    ]
    #expect(Set(CardRank.allCases) == expected)
}

@Test func cardSuitSetContainsExactlyFourDistinctCases() {
    #expect(CardSuit.allCases.count == 4)
    #expect(Set(CardSuit.allCases).count == CardSuit.allCases.count)
}

@Test func cardSuitSetContainsExactlyTheStandardSuits() {
    let expected: Set<CardSuit> = [.clubs, .diamonds, .hearts, .spades]
    #expect(Set(CardSuit.allCases) == expected)
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

private func allCardRankSuitCards() -> [Card] {
    CardRank.allCases.flatMap { rank in CardSuit.allCases.map { Card(rank: rank, suit: $0) } }
}

@Test func exhaustiveCardRankSuitCombinationsProduceExactlyFiftyTwoCards() {
    #expect(allCardRankSuitCards().count == 52)
}

@Test func setOfAllCardRankSuitCombinationsContainsExactlyFiftyTwoUniqueCards() {
    #expect(Set(allCardRankSuitCards()).count == 52)
}

@Test func everyCardRankSuitCombinationAppearsExactlyOnce() {
    let all = allCardRankSuitCards()
    for rank in CardRank.allCases {
        for suit in CardSuit.allCases {
            #expect(all.filter { $0.rank == rank && $0.suit == suit }.count == 1)
        }
    }
}

@Test func everyCardRankAppearsWithAllFourSuitsAndEverySuitWithAllThirteenRanks() {
    let all = allCardRankSuitCards()
    for rank in CardRank.allCases {
        #expect(Set(all.filter { $0.rank == rank }.map(\.suit)) == Set(CardSuit.allCases))
    }
    for suit in CardSuit.allCases {
        #expect(Set(all.filter { $0.suit == suit }.map(\.rank)) == Set(CardRank.allCases))
    }
}

@Test func constructingTheSameCardRankSuitTwiceYieldsEqualCards() {
    for rank in CardRank.allCases {
        for suit in CardSuit.allCases {
            let a = Card(rank: rank, suit: suit)
            let b = Card(rank: rank, suit: suit)
            #expect(a == b)
            #expect(a.hashValue == b.hashValue)
            #expect(Set([a, b]).count == 1)
        }
    }
}