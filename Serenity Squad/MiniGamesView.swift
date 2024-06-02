//
//  MiniGamesView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

struct MiniGamesView: View {
    var body: some View {
        VStack {
            Text("Choisissez un mini-jeu")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            VStack(spacing: 20) {
                NavigationLink(destination: Game2048View()) {
                    GameButton(title: "2048", backgroundColor: .green)
                }

                NavigationLink(destination: GameFlappyView()) {
                    GameButton(title: "Flappy", backgroundColor: .orange)
                }

                NavigationLink(destination: SudokuView()) {
                    GameButton(title: "Sudoku", backgroundColor: .blue)
                }

                NavigationLink(destination: WordSearchView()) {
                    GameButton(title: "Word Search", backgroundColor: .purple)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct GameButton: View {
    var title: String
    var backgroundColor: Color

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
            .padding(.horizontal)
    }
}

struct MiniGamesView_Previews: PreviewProvider {
    static var previews: some View {
        MiniGamesView()
    }
}
