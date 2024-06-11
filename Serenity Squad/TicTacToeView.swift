//
//  TicTacToeView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 11/06/2024.
//

import SwiftUI

struct TicTacToeView: View {
    @State private var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @State private var currentPlayer: String = "X"
    @State private var winner: String? = nil
    @State private var showAlert = false

    var body: some View {
        VStack {
            Text("Morpion")
                .font(.largeTitle)
                .padding()

            VStack(spacing: 10) {
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<3, id: \.self) { col in
                            TicTacToeCellView(symbol: self.$board[row][col])
                                .onTapGesture {
                                    self.cellTapped(row: row, col: col)
                                }
                        }
                    }
                }
            }
            .padding()
            
            if let winner = winner {
                Text("Gagnant: \(winner)")
                    .font(.title)
                    .padding()
            } else if board.joined().allSatisfy({ !$0.isEmpty }) {
                Text("Match nul")
                    .font(.title)
                    .padding()
            }

            Button(action: {
                self.resetGame()
            }) {
                Text("Nouvelle Partie")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(winner != nil ? "Félicitations!" : "Match nul"), message: Text(winner != nil ? "\(winner!) a gagné!" : "Aucun gagnant"), dismissButton: .default(Text("OK")) {
                self.resetGame()
            })
        }
    }

    func cellTapped(row: Int, col: Int) {
        if board[row][col].isEmpty && winner == nil {
            board[row][col] = currentPlayer
            if checkWin(for: currentPlayer) {
                winner = currentPlayer
                showAlert = true
            } else if board.joined().allSatisfy({ !$0.isEmpty }) {
                showAlert = true
            } else {
                currentPlayer = currentPlayer == "X" ? "O" : "X"
                if currentPlayer == "O" {
                    makeComputerMove()
                }
            }
        }
    }

    func makeComputerMove() {
        let emptyCells = board.flatMap { $0 }.enumerated().filter { $0.element.isEmpty }
        if let randomCell = emptyCells.randomElement() {
            let row = randomCell.offset / 3
            let col = randomCell.offset % 3
            board[row][col] = "O"
            if checkWin(for: "O") {
                winner = "O"
                showAlert = true
            } else if board.joined().allSatisfy({ !$0.isEmpty }) {
                showAlert = true
            } else {
                currentPlayer = "X"
            }
        }
    }

    func checkWin(for player: String) -> Bool {
        // Check rows and columns
        for i in 0..<3 {
            if board[i].allSatisfy({ $0 == player }) || (0..<3).allSatisfy({ board[$0][i] == player }) {
                return true
            }
        }
        // Check diagonals
        if (0..<3).allSatisfy({ board[$0][$0] == player }) || (0..<3).allSatisfy({ board[$0][2 - $0] == player }) {
            return true
        }
        return false
    }

    func resetGame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        currentPlayer = "X"
        winner = nil
    }
}

struct TicTacToeCellView: View {
    @Binding var symbol: String

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            Text(symbol)
                .font(.largeTitle)
                .foregroundColor(.black)
        }
        .frame(width: 100, height: 100)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2)
        )
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
