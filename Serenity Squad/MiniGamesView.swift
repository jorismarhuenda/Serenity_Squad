//
//  MiniGamesView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

enum MiniGame: String, CaseIterable {
    case game2048, flappy, sudoku, crossword, memory, hangman, wordsearch, baccalaureat, mathquiz, wordscramble, whackamole, pierrepapier, battleship, morpion, quiz

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
        case .quiz: return "Quiz"
        }
    }

    var description: String {
        switch self {
        case .game2048: return "Combinez les chiffres pour atteindre 2048."
        case .flappy: return "Évitez les obstacles en volant."
        case .sudoku: return "Remplissez la grille avec des chiffres."
        case .crossword: return "Complétez les mots croisés."
        case .memory: return "Trouvez les paires correspondantes."
        case .hangman: return "Devinez le mot avant d'être pendu."
        case .wordsearch: return "Trouvez les mots cachés dans la grille."
        case .baccalaureat: return "Trouvez des mots commençant par une lettre donnée."
        case .mathquiz: return "Répondez aux questions mathématiques."
        case .wordscramble: return "Réorganisez les lettres pour former des mots."
        case .whackamole: return "Tapez sur les taupes qui apparaissent."
        case .pierrepapier: return "Pierre, papier, ciseaux classique."
        case .battleship: return "Trouvez et coulez les navires ennemis."
        case .morpion: return "Alignez trois symboles pour gagner."
        case .quiz: return "Répondez aux questions de culture générale."
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
        case .quiz: QCMGameView()
        }
    }

    @ViewBuilder
    var design: some View {
        switch self {
        case .game2048:
            VStack {
                Text("2048")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .flappy:
            VStack {
                Image(systemName: "arrowtriangle.up.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                Text("Flappy")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .sudoku:
            VStack {
                ForEach(0..<3) { _ in
                    HStack {
                        ForEach(0..<3) { _ in
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 30, height: 30)
                                .shadow(radius: 1)
                        }
                    }
                }
                Text("Sudoku")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .crossword:
            VStack {
                ForEach(0..<3) { _ in
                    HStack {
                        ForEach(0..<3) { _ in
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 30, height: 30)
                                .shadow(radius: 1)
                        }
                    }
                }
                Text("Mots Fléchés")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .memory:
            VStack {
                HStack {
                    Circle().fill(Color.white).frame(width: 30, height: 30)
                    Circle().fill(Color.white).frame(width: 30, height: 30)
                }
                HStack {
                    Circle().fill(Color.white).frame(width: 30, height: 30)
                    Circle().fill(Color.white).frame(width: 30, height: 30)
                }
                Text("Mémoire")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .hangman:
            VStack {
                Text("HANG")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                Text("MAN")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .wordsearch:
            VStack {
                ForEach(0..<3) { _ in
                    HStack {
                        ForEach(0..<3) { _ in
                            Text("W")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
                Text("Mots Croisés")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .baccalaureat:
            VStack {
                Text("ABC")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                Text("Mini Bac")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .mathquiz:
            VStack {
                Text("1 + 1")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                Text("Maths")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .wordscramble:
            VStack {
                Text("WORD")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                Text("Scramble")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .whackamole:
            VStack {
                Image(systemName: "hammer.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                Text("Taupe en Vue!")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .pierrepapier:
            VStack {
                Image(systemName: "hand.raised.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                Image(systemName: "scissors")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                Image(systemName: "doc.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(.white)
                Text("Pierre Papier Ciseaux")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .battleship:
            VStack {
                Image(systemName: "airplane")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                Text("Navire en Vue!")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .morpion:
            VStack {
                Text("X O")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                Text("Morpion")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        case .quiz:
            VStack {
                Text("?")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                Text("Quiz")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }
        }
    }
}

struct MiniGamesView: View {
    @State private var selectedGameIndex: Int = 0

    let games: [MiniGame] = MiniGame.allCases

    var body: some View {
        VStack {
            Spacer() // Ajout d'un espace en haut

            Text("Choisissez un mini-jeu")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Spacer(minLength: 20) // Ajustement de l'espace entre le titre et les jeux

            TabView(selection: $selectedGameIndex) {
                ForEach(0..<games.count) { index in
                    let game = games[index]
                    VStack(spacing: 20) {
                        Text(game.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 20)

                        Text(game.description)
                            .font(.body)
                            .padding(.horizontal)

                        ZStack {
                            RoundedRectangle(cornerRadius: 120)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
                                .frame(width: 200, height: 300)
                                .shadow(radius: 5)

                            game.design
                        }
                        .frame(height: 350)

                        Spacer() // Espace pour pousser le bouton vers le bas
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 450) // Ajustement de la hauteur du TabView

            NavigationLink(destination: games[selectedGameIndex].view) {
                Text("Jouer")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.bottom, 40) // Espace en bas pour le bouton "Jouer"

            Spacer() // Ajout d'un espace en bas pour permettre le défilement
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MiniGamesView_Previews: PreviewProvider {
    static var previews: some View {
        MiniGamesView()
    }
}
