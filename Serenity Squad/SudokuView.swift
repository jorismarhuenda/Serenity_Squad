//
//  SudokuView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

struct SudokuView: View {
    @State private var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    @State private var fixedGrid: [[Bool]] = Array(repeating: Array(repeating: false, count: 9), count: 9)
    @State private var selectedCell: (row: Int, column: Int)? = nil
    @State private var difficulty: Difficulty = .easy

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Sudoku")
                    .font(.largeTitle)
                    .padding()

                Picker("Difficulty", selection: $difficulty) {
                    Text("Easy").tag(Difficulty.easy)
                    Text("Medium").tag(Difficulty.medium)
                    Text("Hard").tag(Difficulty.hard)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                GridStack(rows: 9, columns: 9) { row, col in
                    CellView(value: self.grid[row][col], isFixed: self.fixedGrid[row][col])
                        .onTapGesture {
                            if !self.fixedGrid[row][col] {
                                self.selectedCell = (row, col)
                            }
                        }
                        .border(self.selectedCell?.row == row && self.selectedCell?.column == col ? Color.blue : Color.gray)
                }
                .padding()
                
                NumberPadView { number in
                    if let cell = self.selectedCell {
                        self.grid[cell.row][cell.column] = number
                    }
                }
                .padding()

                Button("New Game") {
                    self.startNewGame()
                }
                .padding()
            }
        }
        .onAppear {
            self.startNewGame()
        }
    }
    
    func startNewGame() {
        grid = generateSudoku(difficulty: difficulty)
        selectedCell = nil
    }
    
    func generateSudoku(difficulty: Difficulty) -> [[Int]] {
        var fullGrid = solveSudoku(generateEmptyGrid())
        let clues = difficulty == .easy ? 36 : (difficulty == .medium ? 27 : 18)
        removeNumbers(&fullGrid, clues: clues)
        markFixedCells(grid: fullGrid)
        return fullGrid
    }
    
    func markFixedCells(grid: [[Int]]) {
        for row in 0..<9 {
            for col in 0..<9 {
                fixedGrid[row][col] = grid[row][col] != 0
            }
        }
    }
    
    func generateEmptyGrid() -> [[Int]] {
        return Array(repeating: Array(repeating: 0, count: 9), count: 9)
    }
    
    func solveSudoku(_ grid: [[Int]]) -> [[Int]] {
        var newGrid = grid
        solve(&newGrid)
        return newGrid
    }

    @discardableResult
    func solve(_ grid: inout [[Int]]) -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == 0 {
                    for num in 1...9 {
                        if isValid(grid, row, col, num) {
                            grid[row][col] = num
                            if solve(&grid) {
                                return true
                            }
                            grid[row][col] = 0
                        }
                    }
                    return false
                }
            }
        }
        return true
    }

    func isValid(_ grid: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        for i in 0..<9 {
            if grid[row][i] == num || grid[i][col] == num || grid[row / 3 * 3 + i / 3][col / 3 * 3 + i % 3] == num {
                return false
            }
        }
        return true
    }

    func removeNumbers(_ grid: inout [[Int]], clues: Int) {
        var cellsToRemove = 81 - clues
        while cellsToRemove > 0 {
            let row = Int.random(in: 0..<9)
            let col = Int.random(in: 0..<9)
            if grid[row][col] != 0 {
                grid[row][col] = 0
                cellsToRemove -= 1
            }
        }
    }
}

enum Difficulty {
    case easy, medium, hard
}

struct CellView: View {
    var value: Int
    var isFixed: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isFixed ? Color.gray.opacity(0.3) : Color.white)
            Text(value != 0 ? "\(value)" : "")
                .foregroundColor(isFixed ? .white : .black)
        }
    }
}

struct NumberPadView: View {
    var numberSelected: (Int) -> Void
    
    var body: some View {
        VStack {
            ForEach(1..<4) { row in
                HStack {
                    ForEach(1..<4) { col in
                        let number = (row - 1) * 3 + col
                        Button(action: {
                            self.numberSelected(number)
                        }) {
                            Text("\(number)")
                                .font(.largeTitle)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(5)
                        }
                    }
                }
            }
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(0..<columns, id: \.self) { column in
                        self.content(row, column)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
        .background(Color.black)
    }
}

struct SudokuView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuView()
    }
}
