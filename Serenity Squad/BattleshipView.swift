//
//  BattleshipView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 11/06/2024.
//

import SwiftUI

struct BattleshipView: View {
    @State private var playerGrid: [[String]] = Array(repeating: Array(repeating: " ", count: 10), count: 10)
    @State private var enemyGrid: [[String]] = Array(repeating: Array(repeating: " ", count: 10), count: 10)
    @State private var playerShips: [(Int, Int)] = []
    @State private var enemyShips: [(Int, Int)] = []
    @State private var gameStatus: String = "Placez vos 8 navires"
    @State private var isPlayerTurn: Bool = true
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var gameStarted: Bool = false
    @State private var showEndGameAlert: Bool = false
    @State private var endGameMessage: String = ""

    let totalShips = 8

    var body: some View {
        VStack {
            Spacer(minLength: 20)

            Text("Battleship")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text(gameStatus)
                .font(.title2)
                .padding(.bottom, 20)

            if gameStarted {
                Text(isPlayerTurn ? "Votre tour" : "Tour de l'ordinateur")
                    .font(.title2)
                    .padding(.bottom, 20)
            }

            if gameStarted {
                BattleshipGridView(grid: isPlayerTurn ? $enemyGrid : $playerGrid, ships: isPlayerTurn ? $enemyShips : $playerShips, isPlayerGrid: !isPlayerTurn, gameStarted: $gameStarted, gameStatus: $gameStatus, isPlayerTurn: $isPlayerTurn, playerGrid: $playerGrid, enemyGrid: $enemyGrid, showEndGameAlert: $showEndGameAlert, endGameMessage: $endGameMessage, totalShips: totalShips)
                    .padding()
            } else {
                VStack {
                    Text("Votre grille")
                        .font(.headline)
                    BattleshipGridView(grid: $playerGrid, ships: $playerShips, isPlayerGrid: true, gameStarted: $gameStarted, gameStatus: $gameStatus, isPlayerTurn: $isPlayerTurn, playerGrid: $playerGrid, enemyGrid: $enemyGrid, showEndGameAlert: $showEndGameAlert, endGameMessage: $endGameMessage, totalShips: totalShips)
                }
                .padding()
            }

            Spacer(minLength: 20)

            if !gameStarted {
                Button(action: startGame) {
                    Text("Commencer le jeu")
                        .padding()
                        .background(playerShips.count == totalShips ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(playerShips.count != totalShips)
                .padding(.bottom, 20)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Battleship"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showEndGameAlert) {
            Alert(title: Text("Fin de jeu"), message: Text(endGameMessage), dismissButton: .default(Text("Nouvelle Partie"), action: {
                resetGame()
            }))
        }
    }

    func startGame() {
        if playerShips.count == totalShips {
            gameStarted = true
            gameStatus = "Jeu en cours"
            enemyShips = placeShips()
        } else {
            alertMessage = "Veuillez placer tous vos navires avant de commencer le jeu."
            showAlert = true
        }
    }

    func placeShips() -> [(Int, Int)] {
        var ships: [(Int, Int)] = []
        while ships.count < totalShips {
            let row = Int.random(in: 0..<10)
            let col = Int.random(in: 0..<10)
            if !ships.contains(where: { $0 == (row, col) }) {
                ships.append((row, col))
                enemyGrid[row][col] = "S"
            }
        }
        return ships
    }

    func resetGame() {
        playerGrid = Array(repeating: Array(repeating: " ", count: 10), count: 10)
        enemyGrid = Array(repeating: Array(repeating: " ", count: 10), count: 10)
        playerShips.removeAll()
        enemyShips.removeAll()
        gameStatus = "Placez vos navires"
        isPlayerTurn = true
        gameStarted = false
        showEndGameAlert = false
    }
}

struct BattleshipGridView: View {
    @Binding var grid: [[String]]
    @Binding var ships: [(Int, Int)]
    var isPlayerGrid: Bool
    @Binding var gameStarted: Bool
    @Binding var gameStatus: String
    @Binding var isPlayerTurn: Bool
    @Binding var playerGrid: [[String]]
    @Binding var enemyGrid: [[String]]
    @Binding var showEndGameAlert: Bool
    @Binding var endGameMessage: String
    let totalShips: Int

    var body: some View {
        VStack(spacing: 2) {
            ForEach(0..<10, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<10, id: \.self) { col in
                        BattleshipCellView(content: $grid[row][col], isPlayerGrid: isPlayerGrid, gameStarted: $gameStarted, row: row, col: col, ships: $ships, gameStatus: $gameStatus, isPlayerTurn: $isPlayerTurn, playerGrid: $playerGrid, enemyGrid: $enemyGrid, showEndGameAlert: $showEndGameAlert, endGameMessage: $endGameMessage, totalShips: totalShips)
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.1))
        .border(Color.black, width: 2)
        .frame(width: 330, height: 330) // Adjusted to fit within the screen
    }
}

struct BattleshipCellView: View {
    @Binding var content: String
    var isPlayerGrid: Bool
    @Binding var gameStarted: Bool
    var row: Int
    var col: Int
    @Binding var ships: [(Int, Int)]
    @Binding var gameStatus: String
    @Binding var isPlayerTurn: Bool
    @Binding var playerGrid: [[String]]
    @Binding var enemyGrid: [[String]]
    @Binding var showEndGameAlert: Bool
    @Binding var endGameMessage: String
    let totalShips: Int

    var body: some View {
        Rectangle()
            .fill(Color.white)
            .border(Color.black)
            .onTapGesture {
                if isPlayerGrid && !gameStarted {
                    placePlayerShip()
                } else if !isPlayerGrid && gameStarted && isPlayerTurn {
                    attackEnemy()
                }
            }
            .overlay(
                Text(displayContent())
                    .font(.caption)
                    .foregroundColor(.black)
            )
    }

    func placePlayerShip() {
        if ships.count < totalShips && content != "S" {
            content = "S"
            ships.append((row, col))
        }
    }

    func attackEnemy() {
        if content == " " {
            content = "O"
            gameStatus = "Raté !"
            isPlayerTurn = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.enemyTurn()
            }
        } else if content == "S" {
            content = "X"
            gameStatus = "Touché !"
        }
        checkEndGame()
    }

    func enemyTurn() {
        var hit = false
        repeat {
            let row = Int.random(in: 0..<10)
            let col = Int.random(in: 0..<10)
            if playerGrid[row][col] == "S" {
                playerGrid[row][col] = "X"
                gameStatus = "L'ordinateur a touché un de vos navires !"
                hit = true
                checkEndGame()
            } else if playerGrid[row][col] == " " {
                playerGrid[row][col] = "O"
                gameStatus = "L'ordinateur a raté son coup !"
                hit = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isPlayerTurn = true
                }
            }
        } while hit
    }

    func displayContent() -> String {
        if isPlayerGrid || (isPlayerGrid == false && (content == "O" || content == "X")) {
            return content
        }
        return " "
    }

    func checkEndGame() {
        let playerShipsRemaining = playerGrid.flatMap { $0 }.filter { $0 == "S" }
        let enemyShipsRemaining = enemyGrid.flatMap { $0 }.filter { $0 == "S" }

        if playerShipsRemaining.isEmpty {
            endGameMessage = "Vous avez perdu !"
            showEndGameAlert = true
        } else if enemyShipsRemaining.isEmpty {
            endGameMessage = "Vous avez gagné !"
            showEndGameAlert = true
        }
    }
}

struct BattleshipView_Previews: PreviewProvider {
    static var previews: some View {
        BattleshipView()
    }
}
