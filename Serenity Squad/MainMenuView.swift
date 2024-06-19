//
//  MainMenuView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 12/06/2024.
//

import SwiftUI

struct MainMenuView: View {
    @State private var showMiniGames = false
    @State private var showWriting = false
    @State private var showRelaxation = false
    
    var body: some View {
        VStack {
            Spacer()

            Text("Bienvenue")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            VStack(spacing: 20) {
                NavigationLink(destination: MiniGamesView(), isActive: $showMiniGames) {
                    MainMenuButton(title: "Mini-jeux")
                }
                .isDetailLink(false)

                NavigationLink(destination: WritingView(), isActive: $showWriting) {
                    MainMenuButton(title: "Écriture")
                }
                .isDetailLink(false)
                
                NavigationLink(destination: RelaxationExercisesView(), isActive: $showRelaxation) {
                    MainMenuButton(title: "Espace détente!")
                }
                .isDetailLink(false)
            }
            .padding(.horizontal)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
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
