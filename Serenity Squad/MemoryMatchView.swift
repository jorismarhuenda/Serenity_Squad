//
//  MemoryMatchView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 08/06/2024.
//

import SwiftUI

struct MemoryMatchView: View {
    @State private var selectedCategory: String = "cars"
    @State private var grid: [Card] = []
    @State private var flippedCards: [Int] = []
    @State private var matchedCards: Set<Int> = []
    @State private var themeColor: Color = .blue

    let categories = [
        "cars": Theme(items: ["🚙", "🚜", "✈️", "🚀", "🚗", "🚠", "🚂", "🛶", "🚒", "🛳", "🏍", "🛴", "🛵", "🚔", "🛺"], color: .blue),
        "food": Theme(items: ["🍏", "🥐", "🌭", "🍞", "🥗", "🥘", "🍆", "🍔", "🍙", "🍰", "🧃"], color: .green),
        "flags": Theme(items: ["🏴‍☠️", "🇬🇧" ,"🇳🇴", "🇷🇺", "🇲🇰", "🇼🇸", "🇺🇸" ,"🇵🇭", "🇨🇿", "🇫🇷", "🇯🇵"], color: .red),
        "animals": Theme(items: ["🐶", "🦊", "🐻", "🐵", "🐨", "🦁", "🐯", "🐷", "🐸", "🐤", "🐗"], color: .orange),
        "zodiacs": Theme(items: ["♈️", "♉️" ,"♊️", "♋️", "♌️", "♍️", "♎️" ,"♏️", "♐️", "♑️", "♒️", "♓️"], color: .yellow),
        "tech": Theme(items: ["⌚️", "📱" ,"💻", "🖥", "🖨", "☎️", "📺" ,"🎥"], color: .gray)
    ]

    var body: some View {
        VStack {
            Text("Memory Match")
                .font(.largeTitle)
                .padding()

            Picker("Category", selection: $selectedCategory) {
                ForEach(categories.keys.sorted(), id: \.self) { category in
                    Text(category.capitalized).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedCategory) { _ in
                startNewGame()
            }

            MemoryGridStack(rows: 4, columns: 4) { row, col in
                let index = row * 4 + col
                CardView(card: self.grid[index], isFlipped: self.flippedCards.contains(index) || self.matchedCards.contains(index), themeColor: self.themeColor)
                    .onTapGesture {
                        flipCard(at: index)
                    }
                    .padding(4)
            }
            .padding()

            HStack {
                Button("New Game") {
                    startNewGame()
                }
                .padding()
                
                Button("Shuffle") {
                    shuffleCards()
                }
                .padding()
            }
        }
        .onAppear {
            startNewGame()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }

    func startNewGame() {
        guard let theme = categories[selectedCategory] else { return }
        themeColor = theme.color
        grid = createGrid(with: theme.items)
        flippedCards.removeAll()
        matchedCards.removeAll()
    }

    func createGrid(with items: [String]) -> [Card] {
        let pairs = Array(items.shuffled().prefix(8))
        let cards = (pairs + pairs).shuffled().enumerated().map { index, item in
            Card(id: index, emoji: item)
        }
        return cards
    }

    func flipCard(at index: Int) {
        guard !matchedCards.contains(index) else { return }
        flippedCards.append(index)
        if flippedCards.count == 2 {
            checkForMatch()
        }
    }

    func checkForMatch() {
        let firstIndex = flippedCards[0]
        let secondIndex = flippedCards[1]
        if grid[firstIndex].emoji == grid[secondIndex].emoji {
            matchedCards.insert(firstIndex)
            matchedCards.insert(secondIndex)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            flippedCards.removeAll()
        }
    }
    
    func shuffleCards() {
        grid.shuffle()
        flippedCards.removeAll()
        matchedCards.removeAll()
    }
}

struct Card {
    var id: Int
    var emoji: String
}

struct Theme {
    var items: [String]
    var color: Color
}

struct CardView: View {
    var card: Card
    var isFlipped: Bool
    var themeColor: Color

    var body: some View {
        ZStack {
            if isFlipped {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 60, height: 80)
                    .overlay(Text(card.emoji).font(.largeTitle))
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(themeColor)
                    .frame(width: 60, height: 80)
            }
        }
    }
}

struct MemoryGridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(0..<columns, id: \.self) { column in
                        self.content(row, column)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
        .background(Color.black)
    }
}

struct MemoryMatchView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryMatchView()
    }
}
