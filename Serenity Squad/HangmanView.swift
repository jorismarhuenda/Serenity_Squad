//
//  HangmanView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 08/06/2024.
//

import SwiftUI

struct HangmanView: View {
    @State private var wordToGuess = "AMOUR"
    @State private var guessedLetters: [Character] = []
    @State private var incorrectGuesses: [Character] = []
    @State private var maxIncorrectGuesses = 10
    
    var body: some View {
        VStack {
            Text("Le Pendu")
                .font(.largeTitle)
                .padding()
            
            Text(currentWord)
                .font(.largeTitle)
                .padding()
            
            HStack {
                Text("Lettres incorrectes: ")
                    .font(.headline)
                ForEach(incorrectGuesses, id: \.self) { letter in
                    Text(String(letter))
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            .padding()
            
            HangmanDrawing(incorrectGuesses: incorrectGuesses.count)
                .frame(width: 200, height: 200)
                .padding()
            
            Text("Devine la lettre:")
                .font(.headline)
                .padding()
            
            LetterPadView(letterSelected: guessLetter)
                .padding()
            
            if isGameOver {
                VStack {
                    Text("Game Over")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .padding()
                    
                    Button(action: startNewGame) {
                        Text("Nouvelle Partie")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                    .padding()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: startNewGame)
    }
    
    var currentWord: String {
        var displayWord = ""
        for letter in wordToGuess {
            if guessedLetters.contains(letter) {
                displayWord += "\(letter) "
            } else {
                displayWord += "_ "
            }
        }
        return displayWord
    }
    
    var isGameOver: Bool {
        incorrectGuesses.count >= maxIncorrectGuesses || currentWord.replacingOccurrences(of: " ", with: "") == wordToGuess
    }
    
    func guessLetter(_ letter: Character) {
        if wordToGuess.contains(letter) {
            guessedLetters.append(letter)
        } else {
            incorrectGuesses.append(letter)
        }
    }
    
    func startNewGame() {
        let words = ["AMOUR", "JOIE", "BONHEUR", "BEAUTE", "PAIX", "HARMONIE", "SERENITE", "PLAISIR", "RIRE", "SOURIRE",
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
                     "SUCRE", "SYMPATHIE", "TENDREMENT", "TRANQUILLE", "VALENTIN", "VAPOREUX", "VIBRANT", "VIVACITE", "VOLUPTUEUX", "ZEN"]
        wordToGuess = words.randomElement()!
        guessedLetters.removeAll()
        incorrectGuesses.removeAll()
    }
}

struct HangmanDrawing: View {
    var incorrectGuesses: Int
    
    var body: some View {
        ZStack {
            ForEach(0..<incorrectGuesses, id: \.self) { index in
                HangmanPart(part: index)
            }
        }
    }
}

struct HangmanPart: View {
    var part: Int
    
    var body: some View {
        switch part {
        case 0:
            return AnyView(Path { path in
                path.move(to: CGPoint(x: 50, y: 200))
                path.addLine(to: CGPoint(x: 150, y: 200))
            }
                .stroke(Color.black, lineWidth: 2))
        case 1:
            return AnyView(Path { path in
                path.move(to: CGPoint(x: 100, y: 200))
                path.addLine(to: CGPoint(x: 100, y: 50))
            }
                .stroke(Color.black, lineWidth: 2))
        case 2:
            return AnyView(Path { path in
                path.move(to: CGPoint(x: 100, y: 50))
                path.addLine(to: CGPoint(x: 150, y: 50))
            }
                .stroke(Color.black, lineWidth: 2))
        case 3:
            return AnyView(Path { path in
                path.move(to: CGPoint(x: 150, y: 50))
                path.addLine(to: CGPoint(x: 150, y: 70))
            }
                .stroke(Color.black, lineWidth: 2))
        case 4:
            return AnyView(Circle().stroke(Color.black, lineWidth: 2).frame(width: 20, height: 20).position(x: 150, y: 85))
        case 5:
            return AnyView(Path { path in
                path.move(to: CGPoint(x: 150, y: 95))
                path.addLine(to: CGPoint(x: 150, y: 140))
            }
                .stroke(Color.black, lineWidth: 2))
        case 6:
            return AnyView(Path { path in
                path.move(to: CGPoint(x: 150, y: 105))
                path.addLine(to: CGPoint(x: 130, y: 120))
            }
                .stroke(Color.black, lineWidth: 2))
        case 7:
            return AnyView(Path { path in
                path.move(to: CGPoint(x: 150, y: 105))
                path.addLine(to: CGPoint(x: 170, y: 120))
            }
                .stroke(Color.black, lineWidth: 2))
        case 8:
            return AnyView(Path { path in
                path.move(to: CGPoint(x: 150, y: 140))
                path.addLine(to: CGPoint(x: 130, y: 160))
            }
                .stroke(Color.black, lineWidth: 2))
        case 9:
            return AnyView(Path { path in
                path.move(to: CGPoint(x: 150, y: 140))
                path.addLine(to: CGPoint(x: 170, y: 160))
            }
                .stroke(Color.black, lineWidth: 2))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct LetterPadView: View {
    var letterSelected: (Character) -> Void
    
    var body: some View {
        VStack {
            ForEach(0..<4) { row in
                HStack {
                    ForEach(0..<7) { col in
                        let letter = self.letter(forRow: row, col: col)
                        if letter != nil {
                            Button(action: {
                                self.letterSelected(letter!)
                            }) {
                                Text(String(letter!))
                                    .font(.title)
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(5)
                                    .padding(2)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func letter(forRow row: Int, col: Int) -> Character? {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let index = row * 7 + col
        guard index < letters.count else { return nil }
        return letters[letters.index(letters.startIndex, offsetBy: index)]
    }
}

struct HangmanView_Previews: PreviewProvider {
    static var previews: some View {
        HangmanView()
    }
}
