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

@Test func adjacentCardRanksOrderByPokerStrength() {
    for (lower, higher) in zip(CardRank.allCases, CardRank.allCases.dropFirst()) {
        #expect(lower < higher)
        #expect(higher > lower)
    }
}

@Test func twoIsTheLowestCardRankAndAceIsTheHighest() {
    for rank in CardRank.allCases where rank != .two && rank != .ace {
        #expect(CardRank.two < rank)
        #expect(rank < CardRank.ace)
    }
}

@Test func distantCardRanksOrderByPokerStrength() {
    #expect(CardRank.two < CardRank.king)
    #expect(CardRank.three < CardRank.queen)
    #expect(CardRank.five < CardRank.jack)
}

@Test func higherCardRankIsStrongerRegardlessOfSuit() {
    #expect(Card(rank: .ace, suit: .clubs) > Card(rank: .two, suit: .spades))
    #expect(Card(rank: .two, suit: .spades) < Card(rank: .ace, suit: .clubs))
    #expect(!(Card(rank: .ace, suit: .clubs) < Card(rank: .two, suit: .spades)))
}

@Test func cardsWithSameRankAndDifferentSuitTieInStrength() {
    for rank in CardRank.allCases {
        for suitA in CardSuit.allCases {
            for suitB in CardSuit.allCases {
                let a = Card(rank: rank, suit: suitA)
                let b = Card(rank: rank, suit: suitB)
                #expect(!(a < b))
                #expect(!(b < a))
                #expect(a <= b)
                #expect(b <= a)
            }
        }
    }
}

@Test func strengthTieDoesNotCollapseCardIdentity() {
    let clubs = Card(rank: .king, suit: .clubs)
    let diamonds = Card(rank: .king, suit: .diamonds)
    #expect(!(clubs < diamonds))
    #expect(clubs != diamonds)
    #expect(Set([clubs, diamonds]).count == 2)
}

@Test func comparingTheSameCardsTwiceYieldsTheSameResult() {
    let cards = [
        Card(rank: .two, suit: .clubs),
        Card(rank: .seven, suit: .hearts),
        Card(rank: .queen, suit: .spades),
        Card(rank: .ace, suit: .diamonds),
    ]
    for a in cards {
        for b in cards {
            #expect((a < b) == (a < b))
            #expect((a > b) == (a > b))
        }
    }
}