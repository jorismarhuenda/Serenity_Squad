//
//  ContentView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var canTakeQuestionnaire = true

    let proverbs = [
        "La beauté est dans les yeux de celui qui regarde.",
        "La vie est un voyage, pas une destination.",
        "L'amour est la seule chose qui grandit quand on la partage.",
        "Le bonheur est une direction, pas une destination.",
        "La vie est belle, apprécie chaque instant.",
        "Le sourire est le langage universel de la bonté.",
        "L'amour ne se voit pas avec les yeux, mais avec le cœur.",
        "Chaque jour est une seconde chance.",
        "La beauté commence au moment où vous décidez d'être vous-même.",
        "La vie est faite de petits bonheurs.",
        "L'amour est la poésie des sens.",
        "Le plus beau voyage est celui qu'on n'a pas encore fait.",
        "Le bonheur est la clé du succès.",
        "La beauté sans la grâce est un hameçon sans appât.",
        "La vie est courte, profitez de chaque instant.",
        "L'amour est une force plus formidable que toute autre.",
        "Le sourire est le soleil de l'âme.",
        "La beauté est une lumière dans le cœur.",
        "La vie est trop courte pour être petite.",
        "L'amour est un trésor inestimable.",
        "La simplicité est la clé de la véritable élégance.",
        "La vie est un cadeau, ouvrez-le.",
        "L'amour est un feu qui réchauffe l'âme.",
        "La beauté est éternelle quand elle est intérieure.",
        "Le bonheur est contagieux, partagez-le.",
        "L'amour est l'essence de la vie.",
        "La beauté est la promesse du bonheur.",
        "La vie est pleine de surprises, appréciez-les.",
        "L'amour est une aventure sans fin.",
        "La vraie beauté est celle du cœur.",
        "Le bonheur est fait de petites choses.",
        "L'amour est un jardin qu'il faut cultiver.",
        "La vie est un rêve, faites-en une réalité.",
        "La beauté intérieure illumine l'extérieur.",
        "L'amour est la seule chose qui ne diminue pas en étant partagée.",
        "Le bonheur est une décision.",
        "La vie est un poème que chacun écrit.",
        "La beauté est une fleur éphémère.",
        "L'amour est la clé qui ouvre toutes les portes.",
        "Le bonheur est dans les choses simples.",
        "La vie est une aventure, osez la vivre.",
        "La beauté de l'âme est éternelle.",
        "L'amour est la réponse à toutes les questions.",
        "Le bonheur est un voyage, pas une destination.",
        "La vie est belle, ne la gâchez pas.",
        "La beauté réside dans la vérité.",
        "L'amour est une musique que l'âme entend.",
        "Le bonheur est une fleur à cultiver.",
        "La vie est un mystère à découvrir.",
        "La beauté est le reflet de l'âme."
    ]

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text(proverbs.randomElement()!)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                if canTakeQuestionnaire {
                    NavigationLink(destination: QuestionnaireView()) {
                        Text("Commencer le questionnaire")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                    .padding()
                } else {
                    NavigationLink(destination: MainMenuView()) {
                        Text("Bienvenue et bon amusement! <3")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                    .padding()
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                if let lastCompletionDate = UserDefaults.standard.object(forKey: "lastQuestionnaireCompletionDate") as? Date {
                    let elapsedTime = Date().timeIntervalSince(lastCompletionDate)
                    let hoursElapsed = elapsedTime / 3600
                    if hoursElapsed < 24 {
                        canTakeQuestionnaire = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
