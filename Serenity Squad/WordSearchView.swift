//
//  WordSearchView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

struct WordSearchView: View {
    @State private var grid: [[Character]] = Array(repeating: Array(repeating: " ", count: 10), count: 10)
    @State private var wordsToFind: [String] = []
    @State private var selectedLetters: [GridPosition] = []
    @State private var foundWords: Set<String> = []
    @State private var selectedWord: String = ""
    @State private var markedLetters: Set<GridPosition> = []
    
    let words = [
        "AMOUR", "JOIE", "BONHEUR", "BEAUTE", "PAIX", "HARMONIE", "SERENITE", "PLAISIR", "RIRE", "SOURIRE",
        "CARESSE", "TENDRESSE", "AFFECTION", "SOUVENIR", "DOUCEUR", "CALME", "RECONFORT", "FELICITE",
        "GRACE", "CHARME", "EMOTION", "PASSION", "AMITIE", "JUBILATION", "VOLUPTE", "EXTASE", "DELECTATION"
    ].filter { $0.count <= 10 } // Limitation à des mots de 10 lettres maximum

    let gridSize = 10
    let cellSize: CGFloat = 30.0

    var body: some View {
        VStack {
            Text("Word Search")
                .font(.largeTitle)
                .padding()

            Text("Find these words:")
                .font(.headline)
            
            VStack {
                ForEach(wordsToFind, id: \.self) { word in
                    HStack {
                        Text(word)
                            .strikethrough(foundWords.contains(word))
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
            .padding()

            WordSearchGridStack(rows: gridSize, columns: gridSize) { row, col in
                WordCellView(letter: self.grid[row][col])
                    .background(self.markedLetters.contains(GridPosition(row: row, col: col)) ? Color.green : (self.selectedLetters.contains(GridPosition(row: row, col: col)) ? Color.yellow : Color.white))
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let location = value.location
                            let row = Int(location.y / self.cellSize)
                            let col = Int(location.x / self.cellSize)
                            if row >= 0 && row < self.gridSize && col >= 0 && col < self.gridSize {
                                self.letterTapped(row: row, col: col)
                            }
                        }
                        .onEnded { _ in
                            self.checkSelectedWord()
                        })
                    .border(Color.black)
            }
            .padding()
            .frame(width: self.cellSize * CGFloat(gridSize), height: self.cellSize * CGFloat(gridSize))
            
            Button("New Game") {
                self.startNewGame()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.startNewGame()
        }
    }

    func startNewGame() {
        grid = Array(repeating: Array(repeating: " ", count: gridSize), count: gridSize)
        selectedLetters.removeAll()
        foundWords.removeAll()
        markedLetters.removeAll()
        selectedWord = ""
        wordsToFind = Array(words.shuffled().prefix(5)) // Réduction du nombre de mots
        fillGridWithWords()
    }
    
    func fillGridWithWords() {
        for word in wordsToFind {
            placeWordInGrid(word: word)
        }
        fillEmptySpaces()
    }

    func placeWordInGrid(word: String) {
        let directions = [(0, 1), (1, 0), (1, 1), (1, -1)]
        var placed = false
        
        while !placed {
            let row = Int.random(in: 0..<gridSize)
            let col = Int.random(in: 0..<gridSize)
            let direction = directions.randomElement()!
            
            if canPlaceWord(word: word, row: row, col: col, direction: direction) {
                for (index, char) in word.enumerated() {
                    let newRow = row + index * direction.0
                    let newCol = col + index * direction.1
                    grid[newRow][newCol] = char
                }
                placed = true
            }
        }
    }
    
    func canPlaceWord(word: String, row: Int, col: Int, direction: (Int, Int)) -> Bool {
        for (index, char) in word.enumerated() {
            let newRow = row + index * direction.0
            let newCol = col + index * direction.1
            
            if newRow < 0 || newRow >= gridSize || newCol < 0 || newCol >= gridSize || (grid[newRow][newCol] != " " && grid[newRow][newCol] != char) {
                return false
            }
        }
        return true
    }

    func fillEmptySpaces() {
        for row in 0..<gridSize {
            for col in 0..<gridSize {
                if grid[row][col] == " " {
                    grid[row][col] = Character(UnicodeScalar(Int.random(in: 65...90))!)
                }
            }
        }
    }
    
    func letterTapped(row: Int, col: Int) {
        let position = GridPosition(row: row, col: col)
        if !selectedLetters.contains(position) {
            selectedLetters.append(position)
        }
        updateSelectedWord()
    }
    
    func updateSelectedWord() {
        selectedWord = selectedLetters.map { String(grid[$0.row][$0.col]) }.joined()
    }

    func checkSelectedWord() {
        if wordsToFind.contains(selectedWord) {
            foundWords.insert(selectedWord)
            markedLetters.formUnion(selectedLetters)
        }
        selectedLetters.removeAll()
        selectedWord = ""
    }
}

struct GridPosition: Hashable {
    let row: Int
    let col: Int
}

struct WordCellView: View {
    var letter: Character
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            Text(String(letter))
                .foregroundColor(.black)
        }
        .frame(width: 30, height: 30)
    }
}

struct WordSearchGridStack<Content: View>: View {
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

struct WordSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WordSearchView()
    }
}
