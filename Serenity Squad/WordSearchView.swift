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
    @State private var selectedLetters: [(row: Int, col: Int)] = []
    @State private var foundWords: Set<String> = []
    @State private var selectedWord: String = ""
    
    let words = [
        "AMOUR", "JOIE", "BONHEUR", "BEAUTE", "PAIX", "HARMONIE", "SERENITE", "PLAISIR", "RIRE", "SOURIRE",
        "CARESSE", "TENDRESSE", "AFFECTION", "ENCHANTEMENT", "EMERVEILLEMENT", "SOUVENIR", "DOUCEUR", "CALME", "RECONFORT", "FELICITE",
        "GRACE", "CHARME", "EMOTION", "PASSION", "AMITIE", "JUBILATION", "RAVISSEMENT", "VOLUPTE", "EXTASE", "DELECTATION",
        "ECLOSION", "EPANOUISSEMENT", "RADIEUX", "LUMINEUX", "SOLEIL", "CAMPAGNE", "PARADIS", "PAISIBLE", "EQUILIBRE", "BIENVEILLANCE",
        "ADMIRATION", "COMPASSION", "DELICE", "TENDRE", "SENSUALITE", "EUPHORIE", "ENVOL", "MAGIE", "INNOCENCE", "PARFAIT",
        "EXQUISE", "ELEGANCE", "SUBLIME", "MERVEILLE", "REVE", "ROMANTIQUE", "DECOUVERTE", "FANTAISIE", "INSPIRATION", "LUMIERE",
        "NATURE", "PROFONDEUR", "PURETE", "QUIETUDE", "REVERIE", "SYMPHONIE", "UNION", "VALSE", "VELVET", "ZENITH",
        "ALLURE", "AMABILITE", "AQUARELLE", "ARCHE", "BIJOU", "BLEU", "BLOOM", "BRISE", "CADENCE", "CAPTIVE",
        "CELEBRER", "CHARISME", "CLARTE", "CLOCHETTE", "CONFORT", "CONFIANCE", "COQUELICOT", "CUPIDON", "DANSE", "DELICATESSE",
        "DOUCE", "ECLAT", "ECRIN", "EFFUSION", "ELEGANT", "EMBRUN", "EMOTIONNEL", "ENCHANTE", "ENGLOUTIR", "ENNOBLIR",
        "EPANOUIT", "ETINCELER", "EXALTANT", "EXQUISE", "FLAMBOYANT", "FLORAL", "FRAICHEUR", "FRAGRANCE", "FUSION", "GAITE",
        "GALANT", "GENEREUX", "GRATITUDE", "HARMONIEUX", "HEUREUX", "IDYLLE", "IMMORTEL", "INNOCENT", "INTENSITE", "IRIS",
        "JASMIN", "JOUISSANCE", "JOVIAL", "LAVANDE", "LEGATO", "LISERON", "LOYAUTE", "LUSTRER", "MERVEILLEUX", "MOUSSELINE",
        "MUSE", "MUSIQUE", "NAISSANCE", "NOSTALGIE", "ODEUR", "OPALE", "ORIGINE", "PAMPRE", "PAPILLON", "PASTEL",
        "PATIENCE", "PETILLANT", "PRECIEUX", "PROMENADE", "PURE", "RAYONNANT", "REFLET", "REMEDE", "ROMANTISME", "RUBIS",
        "SAGESSE", "SATIN", "SCINTILLER", "SEDUISANT", "SERENITE", "SIMPLICITE", "SOLEIL", "SONATE", "SPIRITUEL", "SUAVITE",
        "SUCRE", "SYMPATHIE", "TENDREMENT", "TRANQUILLE", "VALENTIN", "VAPOREUX", "VIBRANT", "VIVACITE", "VOLUPTUEUX", "ZEN"
    ]
    let gridSize = 10
    
    var body: some View {
        VStack {
            Text("Word Search")
                .font(.largeTitle)
                .padding()

            Text("Trouves ces mots:")
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
                    .background(self.selectedLetters.contains(where: { $0.row == row && $0.col == col }) ? Color.yellow : Color.white)
                    .onTapGesture {
                        self.letterTapped(row: row, col: col)
                    }
                    .border(Color.black)
            }
            .padding()
            
            Button("Nouvelle partie") {
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
        selectedWord = ""
        wordsToFind = Array(words.shuffled().prefix(10))
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
                    if newRow < 0 || newRow >= gridSize || newCol < 0 || newCol >= gridSize || grid[newRow][newCol] != " " {
                        placed = false
                        break
                    } else {
                        grid[newRow][newCol] = char
                        placed = true
                    }
                }
            }
        }
    }
    
    func canPlaceWord(word: String, row: Int, col: Int, direction: (Int, Int)) -> Bool {
        for (index, _) in word.enumerated() {
            let newRow = row + index * direction.0
            let newCol = col + index * direction.1
            
            if newRow < 0 || newRow >= gridSize || newCol < 0 || newCol >= gridSize || grid[newRow][newCol] != " " {
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
        if let index = selectedLetters.firstIndex(where: { $0.row == row && $0.col == col }) {
            selectedLetters.remove(at: index)
        } else {
            selectedLetters.append((row: row, col: col))
        }
        updateSelectedWord()
        checkSelectedWord()
    }
    
    func updateSelectedWord() {
        selectedWord = selectedLetters.map { String(grid[$0.row][$0.col]) }.joined()
    }

    func checkSelectedWord() {
        if wordsToFind.contains(selectedWord) {
            foundWords.insert(selectedWord)
            selectedLetters.removeAll()
            selectedWord = ""
        }
    }
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
