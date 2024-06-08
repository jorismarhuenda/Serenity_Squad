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
                    GameButton(title: "2048")
                }

                NavigationLink(destination: GameFlappyView()) {
                    GameButton(title: "Flappy")
                }

                NavigationLink(destination: SudokuView()) {
                    GameButton(title: "Sudoku")
                }

                NavigationLink(destination: CrosswordPuzzleView()) {
                    GameButton(title: "Mots croisés")
                }
                NavigationLink(destination: ThemeManager()) {
                    GameButton(title: "Jeu de mémoire")
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

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .cornerRadius(10)
            .padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct MiniGamesView_Previews: PreviewProvider {
    static var previews: some View {
        MiniGamesView()
    }
}
