//
//  RockPaperScissorsView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 09/06/2024.
//

import SwiftUI

struct RockPaperScissorsView: View {
    enum Move: String, CaseIterable {
        case rock = "Pierre"
        case paper = "Feuille"
        case scissors = "Ciseaux"

        var imageName: String {
            switch self {
            case .rock: return "rock"
            case .paper: return "paper"
            case .scissors: return "scissors"
            }
        }
    }

    @State private var playerScore: Int = 0
    @State private var computerScore: Int = 0
    @State private var playerMove: Move?
    @State private var computerMove: Move?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var playerMovePosition: CGFloat = -150
    @State private var computerMovePosition: CGFloat = 150

    var body: some View {
        VStack {
            Spacer()

            Text("Pierre, Feuille, Ciseaux")
                .font(.title)
                .padding()

            Text("Score: Joueur \(playerScore) - Ordinateur \(computerScore)")
                .font(.title2)
                .padding(.bottom, 20)

            Spacer()

            if let playerMove = playerMove, let computerMove = computerMove {
                HStack {
                    Image(playerMove.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .offset(x: playerMovePosition)
                        .animation(.easeInOut(duration: 0.5), value: playerMovePosition)

                    Spacer()

                    Image(computerMove.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .offset(x: computerMovePosition)
                        .animation(.easeInOut(duration: 0.5), value: computerMovePosition)
                }
                .padding(.bottom, 20)
            }

            HStack {
                ForEach(Move.allCases, id: \.self) { move in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.playerMove = move
                            self.playerMovePosition = 0
                            self.playGame()
                        }
                    }) {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(move.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(10)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    .padding(10)
                }
            }
            .padding(.bottom, 40)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Résultat"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                if playerScore == 3 || computerScore == 3 {
                    resetGame()
                } else {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.playerMovePosition = -150
                        self.computerMovePosition = 150
                    }
                }
            })
        }
    }

    func playGame() {
        computerMove = Move.allCases.randomElement()
        guard let playerMove = playerMove, let computerMove = computerMove else { return }

        withAnimation(.easeInOut(duration: 0.5)) {
            self.playerMovePosition = 0
            self.computerMovePosition = 0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            switch (playerMove, computerMove) {
            case let (x, y) where x == y:
                alertMessage = "Égalité avec \(playerMove.rawValue)!"
            case (.rock, .scissors), (.scissors, .paper), (.paper, .rock):
                playerScore += 1
                alertMessage = "Vous avez gagné cette manche!"
            default:
                computerScore += 1
                alertMessage = "L'ordinateur a gagné cette manche!"
            }

            showAlert = true
        }
    }

    func resetGame() {
        playerScore = 0
        computerScore = 0
        playerMove = nil
        computerMove = nil
        playerMovePosition = -150
        computerMovePosition = 150
    }
}

struct RockPaperScissorsView_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperScissorsView()
    }
}
