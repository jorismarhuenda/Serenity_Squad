//
//  Game2048View.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

struct Tile: Identifiable {
    var id = UUID()
    var value: Int
    var merged: Bool = false
}

struct Game2048View: View {
    @State private var tiles: [[Tile]] = Array(repeating: Array(repeating: Tile(value: 0), count: 4), count: 4)
    @State private var score = 0
    @State private var gameOver = false
    
    let tileSize: CGFloat = 75
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Score: \(score)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            VStack(spacing: 4) {
                ForEach(0..<tiles.count, id: \.self) { row in
                    HStack(spacing: 4) {
                        ForEach(0..<tiles[row].count, id: \.self) { column in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(tileColor(value: tiles[row][column].value))
                                    .frame(width: tileSize, height: tileSize)
                                Text(tiles[row][column].value != 0 ? "\(tiles[row][column].value)" : "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(4)
                            .transition(.scale)
                        }
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Color.gray.opacity(0.5)))
            
            Spacer()
            
            if gameOver {
                VStack {
                    Text("Game Over")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.red)
                    
                    Button(action: {
                        withAnimation {
                            startNewGame()
                        }
                    }) {
                        Text("Restart")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                    .padding()
                }
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .gesture(DragGesture().onEnded { value in
            if !gameOver {
                withAnimation {
                    handleSwipe(translation: value.translation)
                }
            }
        })
        .onAppear {
            withAnimation {
                startNewGame()
            }
        }
        .navigationBarTitle("2048", displayMode: .inline)
    }
    
    func startNewGame() {
        for row in 0..<tiles.count {
            for column in 0..<tiles[row].count {
                tiles[row][column].value = 0
            }
        }
        score = 0
        gameOver = false
        generateRandomTile()
        generateRandomTile()
    }
    
    func tileColor(value: Int) -> Color {
        switch value {
        case 2:
            return Color.red
        case 4:
            return Color.blue
        case 8:
            return Color.green
        case 16:
            return Color.orange
        case 32:
            return Color.purple
        case 64:
            return Color.pink
        case 128:
            return Color.yellow
        case 256:
            return Color.cyan
        case 512:
            return Color.teal
        case 1024:
            return Color.indigo
        case 2048:
            return Color.black
        default:
            return Color.gray
        }
    }
    
    func generateRandomTile() {
        var emptyTiles: [(Int, Int)] = []
        
        for row in 0..<tiles.count {
            for column in 0..<tiles[row].count {
                if tiles[row][column].value == 0 {
                    emptyTiles.append((row, column))
                }
            }
        }
        
        if emptyTiles.isEmpty {
            checkGameOver()
            return
        }
        
        let randomIndex = Int.random(in: 0..<emptyTiles.count)
        let (row, column) = emptyTiles[randomIndex]
        let newValue = Int.random(in: 1...2) * 2 // Nouvelle valeur: soit 2, soit 4
        
        tiles[row][column].value = newValue
    }
    
    func handleSwipe(translation: CGSize) {
        let direction: SwipeDirection
        
        if abs(translation.width) > abs(translation.height) {
            direction = translation.width > 0 ? .right : .left
        } else {
            direction = translation.height > 0 ? .down : .up
        }
        
        moveTiles(direction: direction)
    }
    
    func moveTiles(direction: SwipeDirection) {
        var moved = false
        
        for row in 0..<tiles.count {
            for column in 0..<tiles[row].count {
                tiles[row][column].merged = false
            }
        }
        
        switch direction {
        case .up:
            for column in 0..<4 {
                var currentIndex = 0
                for row in 1..<4 {
                    if tiles[row][column].value != 0 {
                        var currentRow = row
                        while currentRow > currentIndex {
                            if tiles[currentRow - 1][column].value == 0 {
                                tiles[currentRow - 1][column].value = tiles[currentRow][column].value
                                tiles[currentRow][column].value = 0
                                moved = true
                            } else if tiles[currentRow - 1][column].value == tiles[currentRow][column].value && !tiles[currentRow - 1][column].merged && !tiles[currentRow][column].merged {
                                tiles[currentRow - 1][column].value *= 2
                                tiles[currentRow - 1][column].merged = true
                                tiles[currentRow][column].value = 0
                                score += tiles[currentRow - 1][column].value
                                moved = true
                                currentIndex += 1
                                break
                            } else {
                                currentIndex += 1
                                break
                            }
                            currentRow -= 1
                        }
                    }
                }
            }
        case .down:
            for column in 0..<4 {
                var currentIndex = 3
                for row in (0..<3).reversed() {
                    if tiles[row][column].value != 0 {
                        var currentRow = row
                        while currentRow < currentIndex {
                            if tiles[currentRow + 1][column].value == 0 {
                                tiles[currentRow + 1][column].value = tiles[currentRow][column].value
                                tiles[currentRow][column].value = 0
                                moved = true
                            } else if tiles[currentRow + 1][column].value == tiles[currentRow][column].value && !tiles[currentRow + 1][column].merged && !tiles[currentRow][column].merged {
                                tiles[currentRow + 1][column].value *= 2
                                tiles[currentRow + 1][column].merged = true
                                tiles[currentRow][column].value = 0
                                score += tiles[currentRow + 1][column].value
                                moved = true
                                currentIndex -= 1
                                break
                            } else {
                                currentIndex -= 1
                                break
                            }
                            currentRow += 1
                        }
                    }
                }
            }
        case .left:
            for row in 0..<4 {
                var currentIndex = 0
                for column in 1..<4 {
                    if tiles[row][column].value != 0 {
                        var currentColumn = column
                        while currentColumn > currentIndex {
                            if tiles[row][currentColumn - 1].value == 0 {
                                tiles[row][currentColumn - 1].value = tiles[row][currentColumn].value
                                tiles[row][currentColumn].value = 0
                                moved = true
                            } else if tiles[row][currentColumn - 1].value == tiles[row][currentColumn].value && !tiles[row][currentColumn - 1].merged && !tiles[row][currentColumn].merged {
                                tiles[row][currentColumn - 1].value *= 2
                                tiles[row][currentColumn - 1].merged = true
                                tiles[row][currentColumn].value = 0
                                score += tiles[row][currentColumn - 1].value
                                moved = true
                                currentIndex += 1
                                break
                            } else {
                                currentIndex += 1
                                break
                            }
                            currentColumn -= 1
                        }
                    }
                }
            }
        case .right:
            for row in 0..<4 {
                var currentIndex = 3
                for column in (0..<3).reversed() {
                    if tiles[row][column].value != 0 {
                        var currentColumn = column
                        while currentColumn < currentIndex {
                            if tiles[row][currentColumn + 1].value == 0 {
                                tiles[row][currentColumn + 1].value = tiles[row][currentColumn].value
                                tiles[row][currentColumn].value = 0
                                moved = true
                            } else if tiles[row][currentColumn + 1].value == tiles[row][currentColumn].value && !tiles[row][currentColumn + 1].merged && !tiles[row][currentColumn].merged {
                                tiles[row][currentColumn + 1].value *= 2
                                tiles[row][currentColumn + 1].merged = true
                                tiles[row][currentColumn].value = 0
                                score += tiles[row][currentColumn + 1].value
                                moved = true
                                currentIndex -= 1
                                break
                            } else {
                                currentIndex -= 1
                                break
                            }
                            currentColumn += 1
                        }
                    }
                }
            }
        }
        
        if moved {
            generateRandomTile()
        }
        
        checkGameOver()
    }
    
    func checkGameOver() {
        for row in 0..<4 {
            for column in 0..<4 {
                if tiles[row][column].value == 0 {
                    return
                }
                if row > 0 && tiles[row][column].value == tiles[row - 1][column].value {
                    return
                }
                if row < 3 && tiles[row][column].value == tiles[row + 1][column].value {
                    return
                }
                if column > 0 && tiles[row][column].value == tiles[row][column - 1].value {
                    return
                }
                if column < 3 && tiles[row][column].value == tiles[row][column + 1].value {
                    return
                }
            }
        }
        
        gameOver = true
    }
    
    enum SwipeDirection {
        case up, down, left, right
    }
}

struct Game2048View_Previews: PreviewProvider {
    static var previews: some View {
        Game2048View()
    }
}
