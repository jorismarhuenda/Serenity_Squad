//
//  CrosswordPuzzleView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 04/06/2024.
//

import SwiftUI

struct CrosswordPuzzleView: View {
    @State private var grid: [[CrosswordCell]] = Array(repeating: Array(repeating: CrosswordCell(letter: " ", isEditable: false), count: 10), count: 10)
    @State private var selectedCell: SelectedCell? = nil
    @State private var words: [CrosswordWord] = []
    @State private var definitions: [String] = []
    
    var body: some View {
        VStack {
            Text("Mots Croisés")
                .font(.largeTitle)
                .padding()
            
            VStack {
                ForEach(0..<definitions.count, id: \.self) { index in
                    HStack {
                        Text("\(index + 1). \(self.definitions[index])")
                            .padding(.horizontal)
                        Spacer()
                    }
                }
            }
            .padding()
            
            CrosswordGridStack(rows: 10, columns: 10) { row, col in
                CrosswordCellView(cell: self.grid[row][col])
                    .background(self.backgroundColor(for: self.grid[row][col]))
                    .overlay(self.selectedCell?.row == row && self.selectedCell?.col == col ? Color.yellow.opacity(0.5) : Color.clear)
                    .onTapGesture {
                        if self.grid[row][col].isEditable {
                            self.selectedCell = SelectedCell(row: row, col: col)
                        }
                    }
                    .border(Color.black)
            }
            .padding()
            
            Button("Nouvelle Partie") {
                self.startNewGame()
            }
            .padding()
        }
        .onAppear {
            self.startNewGame()
        }
        .sheet(item: $selectedCell) { cell in
            VStack {
                Text("Entrer une lettre")
                    .font(.headline)
                TextField("Lettre", text: self.binding(for: cell))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 50)
                    .multilineTextAlignment(.center)
                    .keyboardType(.alphabet)
                Button("OK") {
                    self.selectedCell = nil
                }
                .padding()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
    
    func startNewGame() {
        grid = Array(repeating: Array(repeating: CrosswordCell(letter: " ", isEditable: false), count: 10), count: 10)
        selectedCell = nil
        
        let wordList = [
            ("AMOUR", "Sentiment intense d'affection et d'attachement."),
            ("BEAUTE", "Qualité de quelqu'un ou de quelque chose qui plaît."),
            ("VOYAGE", "Action de se déplacer d'un lieu à un autre."),
            ("SERENITE", "Etat de tranquillité et d'apaisement."),
            ("BONHEUR", "Etat de satisfaction parfaite."),
            ("FAMILLE", "Groupe de personnes liées par le sang."),
            ("SOLEIL", "Étoile autour de laquelle la Terre tourne."),
            ("PLAGE", "Rivage sablonneux au bord de la mer."),
            ("RIRE", "Exprimer la joie par un mouvement de la bouche."),
            ("JOIE", "Sentiment de bonheur intense."),
            ("ESPOIR", "Sentiment d'attente confiante."),
            ("AMITIE", "Relation affective entre deux personnes."),
            ("CALME", "État de tranquillité et de paix."),
            ("SANTE", "État de bien-être physique et mental."),
            ("MUSIQUE", "Art de combiner les sons."),
            ("NATURE", "Ensemble des éléments naturels."),
            ("DANSE", "Mouvement du corps en rythme."),
            ("MER", "Grande étendue d'eau salée."),
            ("FLEUR", "Partie colorée de la plante."),
            ("ETOILE", "Corps céleste brillant."),
            ("HARMONIE", "État de cohérence entre les éléments."),
            ("TRANQUILLE", "Calme et paisible."),
            ("PLAISIR", "Sentiment agréable ressenti."),
            ("EQUILIBRE", "Stabilité entre plusieurs éléments."),
            ("CONFIANCE", "Sentiment de sécurité."),
            ("VITALITE", "État de pleine énergie."),
            ("ESPOIR", "Sentiment d'attente confiante."),
            ("INSPIRATION", "Stimulation de l'esprit."),
            ("REVES", "Pensées idéales durant le sommeil."),
            ("PASSION", "Sentiment intense pour quelque chose."),
            ("RECONFORT", "Sentiment de consolation."),
            ("SENTIMENT", "État affectif complexe."),
            ("VOLUPTE", "Plaisir intense des sens."),
            ("ADMIRATION", "Respect et estime profonde."),
            ("ALLEGRESSE", "Joie intense et légère."),
            ("BIENVEILLANCE", "Disposition à faire le bien."),
            ("CONTENTEMENT", "État de satisfaction."),
            ("DELECTATION", "Plaisir savouré pleinement."),
            ("SERENITE", "État de calme absolu."),
            ("ZESTE", "Petite quantité ajoutant du goût."),
            ("BIENFAIT", "Acte de générosité."),
            ("CHARME", "Qualité de ce qui séduit."),
            ("DECOUVERTE", "Action de trouver quelque chose."),
            ("ENCHANTEMENT", "Sentiment de bonheur merveilleux."),
            ("EPANOUISSEMENT", "Développement complet."),
            ("EUPHORIE", "Sensation intense de bien-être."),
            ("GRATITUDE", "Reconnaissance pour un bienfait."),
            ("JUBILATION", "Joie intense et expansive."),
            ("QUIETUDE", "État de tranquillité profonde."),
            ("RAVISSEMENT", "Enchantement et plaisir extrême.")
        ].shuffled().prefix(10)
        
        words = []
        definitions = []
        
        for (index, (word, definition)) in wordList.enumerated() {
            if let placedWord = placeWordInGrid(word: word, index: index) {
                words.append(placedWord)
                definitions.append(definition)
            }
        }
    }
    
    func placeWordInGrid(word: String, index: Int) -> CrosswordWord? {
        let directions: [Direction] = [.horizontal, .vertical]
        let letters = Array(word)
        
        for _ in 0..<100 {
            let row = Int.random(in: 0..<10)
            let col = Int.random(in: 0..<10)
            let direction = directions.randomElement()!
            
            if canPlaceWord(word: letters, at: (row, col), direction: direction) {
                for (i, letter) in letters.enumerated() {
                    let r = row + (direction == .vertical ? i : 0)
                    let c = col + (direction == .horizontal ? i : 0)
                    if i == 0 {
                        grid[r][c] = CrosswordCell(letter: letter, isEditable: false, number: index + 1)
                    } else {
                        grid[r][c] = CrosswordCell(letter: " ", isEditable: true)
                    }
                }
                return CrosswordWord(text: word, row: row, col: col, direction: direction)
            }
        }
        return nil
    }
    
    func canPlaceWord(word: [Character], at start: (row: Int, col: Int), direction: Direction) -> Bool {
        for (i, _) in word.enumerated() {
            let r = start.row + (direction == .vertical ? i : 0)
            let c = start.col + (direction == .horizontal ? i : 0)
            
            if r >= 10 || c >= 10 || (grid[r][c].isEditable) {
                return false
            }
        }
        return true
    }
    
    func backgroundColor(for cell: CrosswordCell) -> Color {
        if cell.number != nil {
            return Color.blue.opacity(0.3)
        } else if cell.isEditable {
            return Color.white
        } else {
            return Color.gray.opacity(0.5)
        }
    }
    
    private func binding(for cell: SelectedCell) -> Binding<String> {
        return Binding<String>(
            get: {
                return self.grid[cell.row][cell.col].letter == " " ? "" : String(self.grid[cell.row][cell.col].letter)
            },
            set: {
                if $0.count == 1, let char = $0.uppercased().first, char.isLetter {
                    self.grid[cell.row][cell.col].letter = char
                } else {
                    self.grid[cell.row][cell.col].letter = " "
                }
            }
        )
    }
}

struct SelectedCell: Identifiable {
    var id = UUID()
    var row: Int
    var col: Int
}

struct CrosswordCell {
    var letter: Character
    var isEditable: Bool
    var number: Int?
}

struct CrosswordWord {
    var text: String
    var row: Int
    var col: Int
    var direction: Direction
}

enum Direction {
    case horizontal, vertical
}

struct CrosswordCellView: View {
    var cell: CrosswordCell
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(cell.isEditable ? Color.white : Color.gray.opacity(0.5))
            if let number = cell.number {
                Text(String(number))
                    .font(.caption)
                    .foregroundColor(.red)
                    .position(x: 10, y: 10)
            }
            Text(String(cell.letter))
                .foregroundColor(cell.isEditable ? .black : .white)
                .fontWeight(cell.isEditable ? .regular : .bold)
        }
        .frame(width: 30, height: 30)
    }
}

struct CrosswordGridStack<Content: View>: View {
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

struct CrosswordPuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        CrosswordPuzzleView()
    }
}
