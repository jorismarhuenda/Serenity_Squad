//
//  MiniGamesView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

struct MiniGamesView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            Spacer(minLength: 100) // Ajout d'un espace en haut

            Text("Choisissez un mini-jeu")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Spacer(minLength: 20) // Ajustement de l'espace entre le titre et les boutons

            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    NavigationLink(destination: Game2048View()) {
                        GameButton(title: "2048", imageName: "2048")
                    }

                    NavigationLink(destination: GameFlappyView()) {
                        GameButton(title: "Flappy", imageName: "flappy")
                    }

                    NavigationLink(destination: SudokuView()) {
                        GameButton(title: "Sudoku", imageName: "sudoku")
                    }

                    NavigationLink(destination: CrosswordPuzzleView()) {
                        GameButton(title: "Mots fléchés", imageName: "crossword")
                    }

                    NavigationLink(destination: ThemeManager()) {
                        GameButton(title: "Jeu de mémoire", imageName: "memory")
                    }
                    
                    NavigationLink(destination: HangmanView()) {
                        GameButton(title: "Jeu du pendu", imageName: "hangman")
                    }
                    
                    NavigationLink(destination: WordSearchView()) {
                        GameButton(title: "Mots croisés", imageName: "wordsearch")
                    }
                    
                    NavigationLink(destination: BaccalaureatView()) {
                        GameButton(title: "Mini Bac", imageName: "baccalaureat")
                    }
                }
                .padding()
            }

            Spacer() // Ajout d'un espace en bas pour permettre le défilement
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct GameButton: View {
    var title: String
    var imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )

            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 5)
        }
        .frame(width: 120, height: 150)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(10)
        .shadow(color: .gray, radius: 5, x: 0, y: 5)
        .padding(5)
    }
}

struct MiniGamesView_Previews: PreviewProvider {
    static var previews: some View {
        MiniGamesView()
    }
}
