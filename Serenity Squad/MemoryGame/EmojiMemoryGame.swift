//
//  EmojiMemoryGame.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 08/06/2024.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private(set) var theme: Theme
    static func createMemoryGame(withTheme theme: Theme) -> MemoryGame<String> {
        let shuffledItems = theme.items.shuffled()
        return MemoryGame<String>(numberOfPairs: min(theme.items.count, theme.pairsToShow)) { index in
            shuffledItems[index]
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    init(themed theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(withTheme: theme)
    }
    
    var cards: Array<Card> { model.cards }
    
    var score: Int { model.score }
    
    // MARK: - Intent (s)
    
    func choose( _ card: Card) {
        model.choose(card)
    }
    
    func changeTheme(to theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(withTheme: theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
