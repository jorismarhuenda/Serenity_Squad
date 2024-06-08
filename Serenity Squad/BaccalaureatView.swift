//
//  BaccalaureatView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 08/06/2024.
//

import SwiftUI

struct BaccalaureatView: View {
    @State private var letter: String = "A"
    @State private var themes: [String] = ["Prénom masculin", "Prénom féminin", "Animal", "Ville", "Pays", "Fruit"]
    @State private var answers: [String] = Array(repeating: "", count: 6)
    @State private var showAlert = false
    @State private var score: Double = 0
    @State private var showInstructions: Bool = false

    var body: some View {
        VStack {
            Spacer() // Ajout de Spacer pour descendre le contenu

            HStack {
                Spacer()
                Text("Baccalauréat")
                    .font(.title)
                Spacer()
                Button(action: {
                    self.showInstructions.toggle()
                }) {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 10)
                }
                .alert(isPresented: $showInstructions) {
                    Alert(title: Text("Instructions"), message: Text("Trouver un mot pour chaque thème qui commence par la lettre donnée."), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.bottom, 20)

            Text("Lettre: \(letter)")
                .font(.title)
                .padding()

            Text("Score: \(score, specifier: "%.1f") / 1.0")
                .font(.title2)
                .padding(.bottom, 20)

            ForEach(0..<themes.count, id: \.self) { index in
                HStack {
                    Text(self.themes[index])
                        .padding()
                    TextField("Réponse", text: self.$answers[index])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                .padding(.horizontal)
            }

            Spacer()

            Button(action: {
                self.checkAnswers()
            }) {
                Text("Valider")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                self.startNewGame()
            }) {
                Text("Nouvelle Partie")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20) // Ajustement du bouton pour qu'il soit proche de la limite basse

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all) // Assurer que le fond pastel couvre toute la vue
        .onAppear {
            self.startNewGame()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Résultat"), message: Text("Votre score est de \(score, specifier: "%.1f") / 1.0"), dismissButton: .default(Text("OK")))
        }
    }

    func startNewGame() {
        letter = String("ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement()!)
        answers = Array(repeating: "", count: themes.count)
        score = 0
    }

    func checkAnswers() {
        var correctAnswers = 0
        for answer in answers {
            if answer.uppercased().first == letter.first {
                correctAnswers += 1
            }
        }
        score = Double(correctAnswers) / Double(themes.count)
        showAlert = true
    }
}

struct BaccalaureatView_Previews: PreviewProvider {
    static var previews: some View {
        BaccalaureatView()
    }
}
