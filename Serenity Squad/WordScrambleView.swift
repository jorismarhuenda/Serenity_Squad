//
//  WordScrambleView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 09/06/2024.
//

import SwiftUI

struct WordScrambleView: View {
    @State private var currentWord: String = ""
    @State private var scrambledWord: String = ""
    @State private var userAnswer: String = ""
    @State private var score: Int = 0
    @State private var showAlert = false
    @State private var alertMessage = ""

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

    var body: some View {
        VStack {
            Spacer() // Ajout de Spacer pour descendre le contenu

            Text("Word Scramble")
                .font(.title)
                .padding()

            Text("Score: \(score)")
                .font(.title2)
                .padding(.bottom, 20)

            Text(scrambledWord)
                .font(.largeTitle)
                .padding()

            TextField("Votre réponse", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )

            Button(action: {
                self.checkAnswer()
            }) {
                Text("Valider")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                self.nextWord()
            }) {
                Text("Mot Suivant")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.nextWord()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Résultat"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func nextWord() {
        currentWord = words.randomElement() ?? "AMOUR"
        scrambledWord = String(currentWord.shuffled())
        userAnswer = ""
    }

    func checkAnswer() {
        if userAnswer.uppercased() == currentWord {
            score += 1
            alertMessage = "Correct!"
        } else {
            alertMessage = "Incorrect. Le bon mot est \(currentWord)."
        }
        showAlert = true
    }
}

struct WordScrambleView_Previews: PreviewProvider {
    static var previews: some View {
        WordScrambleView()
    }
}
