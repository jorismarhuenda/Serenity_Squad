//
//  MainMenuView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 12/06/2024.
//

import SwiftUI

struct MainMenuView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer() // Ajoute un espace en haut pour déplacer le contenu vers le bas

                Text("Bienvenue")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                VStack(spacing: 20) {
                    NavigationLink(destination: MiniGamesView()) {
                        MainMenuButton(title: "Mini-jeux")
                    }

                    NavigationLink(destination: WritingView()) {
                        MainMenuButton(title: "Écriture")
                    }
                }
                .padding(.horizontal)

                Spacer()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MainMenuButton: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.title2)
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.clear)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
            )
            .padding(.horizontal)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
