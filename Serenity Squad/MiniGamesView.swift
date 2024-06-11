//
//  MiniGamesView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

enum MiniGame: String {
    case game2048, flappy, sudoku, crossword, memory, hangman, wordsearch, baccalaureat, mathquiz, wordscramble, whackamole, pierrepapier, battleship, morpion

    var title: String {
        switch self {
        case .game2048: return "2048"
        case .flappy: return "Flappy"
        case .sudoku: return "Sudoku"
        case .crossword: return "Mots fléchés"
        case .memory: return "Jeu de mémoire"
        case .hangman: return "Jeu du pendu"
        case .wordsearch: return "Mots croisés"
        case .baccalaureat: return "Mini Bac"
        case .mathquiz: return "Maths en folie"
        case .wordscramble: return "Mots en folie"
        case .whackamole: return "Taupe en vue!"
        case .pierrepapier: return "Pierre, papier, ciseaux!"
        case .battleship: return "Navire en vue capitaine!"
        case .morpion: return "Morpion"
        }
    }

    var imageName: String {
            switch self {
            case .game2048: return "2048"
            case .flappy: return "flappy"
            case .sudoku: return "sudoku"
            case .crossword: return "crossword"
            case .memory: return "memory"
            case .hangman: return "hangman"
            case .wordsearch: return "wordsearch"
            case .baccalaureat: return "baccalaureat"
            case .mathquiz: return "mathquiz"
            case .wordscramble: return "wordscramble"
            case .whackamole: return "whack"
            case .pierrepapier: return "pierrepapier"
            case .battleship: return "battleship"
            case .morpion: return "morpion"
            }
        }

    @ViewBuilder
    var view: some View {
        switch self {
        case .game2048: Game2048View()
        case .flappy: GameFlappyView()
        case .sudoku: SudokuView()
        case .crossword: CrosswordPuzzleView()
        case .memory: ThemeManager()
        case .hangman: HangmanView()
        case .wordsearch: WordSearchView()
        case .baccalaureat: BaccalaureatView()
        case .mathquiz: MathQuizView()
        case .wordscramble: WordScrambleView()
        case .whackamole: WhackAMoleView()
        case .pierrepapier: RockPaperScissorsView()
        case .battleship: BattleshipView()
        case .morpion: TicTacToeView()
        }
    }
}

struct MiniGamesView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @State private var currentPage = 0

    let games: [MiniGame] = [
        .game2048, .flappy, .sudoku, .crossword, .memory,
        .hangman, .wordsearch, .baccalaureat, .mathquiz, .wordscramble, .whackamole, .pierrepapier, .battleship, .morpion
    ]

    var body: some View {
        VStack {
            Spacer(minLength: 100) // Ajout d'un espace en haut

            Text("Choisissez un mini-jeu")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Spacer(minLength: 20) // Ajustement de l'espace entre le titre et les boutons

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(currentPageGames, id: \.self) { game in
                        NavigationLink(destination: game.view) {
                            GameButton(title: game.title, imageName: game.imageName)
                        }
                    }
                }
                .padding()
            }

            Spacer() // Ajout d'un espace en bas pour permettre le défilement

            HStack {
                if currentPage > 0 {
                    Button(action: {
                        currentPage -= 1
                    }) {
                        Text("Précédent")
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.pastelPink.opacity(0.7), Color.pastelBlue.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                }
                Spacer()
                if currentPage < totalPages - 1 {
                    Button(action: {
                        currentPage += 1
                    }) {
                        Text("Suivant")
                            .padding()
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.pastelPink.opacity(0.7), Color.pastelBlue.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                            )
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }

    var currentPageGames: ArraySlice<MiniGame> {
        let start = currentPage * 10
        let end = min(start + 10, games.count)
        return games[start..<end]
    }

    var totalPages: Int {
        (games.count + 9) / 10
    }
}

struct GameButton: View {
    var title: String
    var imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )

            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 5)
        }
        .frame(width: 120, height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(10)
        .shadow(color: .gray, radius: 5, x: 0, y: 5)
        .padding(5)
    }
}

struct MiniGamesView_Previews: PreviewProvider {
    static var previews: some View {
        MiniGamesView()
    }
}
