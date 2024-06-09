//
//  Whack-a-Mole.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 09/06/2024.
//

import SwiftUI

struct WhackAMoleView: View {
    @State private var molePosition: Int = Int.random(in: 0..<9)
    @State private var score: Int = 0
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var timer: Timer?

    let gridSize = 3

    var body: some View {
        VStack {
            Spacer() // Ajout de Spacer pour descendre le contenu

            Text("Whack-a-Mole")
                .font(.title)
                .padding()

            Text("Score: \(score)")
                .font(.title2)
                .padding(.bottom, 20)

            VStack {
                ForEach(0..<gridSize, id: \.self) { row in
                    HStack {
                        ForEach(0..<self.gridSize, id: \.self) { col in
                            let index = row * self.gridSize + col
                            Button(action: {
                                self.whack(index: index)
                            }) {
                                Circle()
                                    .fill(self.molePosition == index ? Color.brown : Color.gray)
                                    .frame(width: 80, height: 80)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 20)

            Button(action: {
                self.startGame()
            }) {
                Text("Démarrer Jeu")
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
            self.startGame()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Résultat"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func startGame() {
        score = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.molePosition = Int.random(in: 0..<9)
        }
    }

    func whack(index: Int) {
        if index == molePosition {
            score += 1
            alertMessage = "Bien joué !"
        } else {
            score -= 1
            alertMessage = "Raté !"
        }
        showAlert = true
    }
}

struct WhackAMoleView_Previews: PreviewProvider {
    static var previews: some View {
        WhackAMoleView()
    }
}
