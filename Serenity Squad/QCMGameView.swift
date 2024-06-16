//
//  QCMGameView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 16/06/2024.
//

import SwiftUI

// Modèle de question
struct QuizQuestion: Identifiable, Codable {
    var id = UUID()
    var questionText: String
    var answers: [String]
    var correctAnswerIndex: Int
}

struct QCMGameView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndex: Int?
    @State private var score = 0
    @State private var showScore = false
    @State private var showCorrectAnswer = false

    // Liste des questions en français
    let quizQuestions: [QuizQuestion] = [
        QuizQuestion(questionText: "Quelle est la capitale de la France ?", answers: ["Paris", "Londres", "Berlin", "Madrid"], correctAnswerIndex: 0),
        QuizQuestion(questionText: "Quelle est la plus grande planète du système solaire ?", answers: ["Terre", "Mars", "Jupiter", "Saturne"], correctAnswerIndex: 2),
        QuizQuestion(questionText: "Qui a écrit 'Les Misérables' ?", answers: ["Victor Hugo", "Émile Zola", "Gustave Flaubert", "Honoré de Balzac"], correctAnswerIndex: 0),
        QuizQuestion(questionText: "En quelle année a eu lieu la Révolution française ?", answers: ["1789", "1776", "1799", "1804"], correctAnswerIndex: 0),
        QuizQuestion(questionText: "Quel est le symbole chimique de l'or ?", answers: ["Au", "Ag", "Fe", "O"], correctAnswerIndex: 0)
        // Ajoutez plus de questions ici
    ]
    
    var body: some View {
        VStack {
            Spacer() // Ajout de Spacer pour descendre le contenu vers le bas

            if showScore {
                VStack {
                    Text("Votre score est de \(score) sur \(quizQuestions.count)")
                        .font(.largeTitle)
                        .padding()

                    Button(action: {
                        self.resetGame()
                    }) {
                        Text("Rejouer")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            } else {
                Text(quizQuestions[currentQuestionIndex].questionText)
                    .font(.title)
                    .padding()

                // Affichage des réponses en grille 2x2
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(0..<quizQuestions[currentQuestionIndex].answers.count, id: \.self) { index in
                        Button(action: {
                            self.selectedAnswerIndex = index
                            self.checkAnswer()
                        }) {
                            Text(self.quizQuestions[self.currentQuestionIndex].answers[index])
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .background(self.buttonColor(for: index))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }
                    }
                }

                Spacer()

                if selectedAnswerIndex != nil {
                    Button(action: {
                        self.nextQuestion()
                    }) {
                        Text("Question suivante")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.top, 20)
                    }
                }
            }

            Spacer() // Ajout de Spacer pour descendre le contenu vers le bas
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.showCorrectAnswer = false
        }
    }

    func buttonColor(for index: Int) -> Color {
        if let selectedAnswerIndex = selectedAnswerIndex {
            if selectedAnswerIndex == index {
                return index == quizQuestions[currentQuestionIndex].correctAnswerIndex ? Color.green : Color.red
            } else if showCorrectAnswer && index == quizQuestions[currentQuestionIndex].correctAnswerIndex {
                return Color.green.opacity(0.6) // Affichage en vert pour la bonne réponse
            }
        }
        return Color.white
    }

    func checkAnswer() {
        if let selectedAnswerIndex = selectedAnswerIndex {
            if selectedAnswerIndex == quizQuestions[currentQuestionIndex].correctAnswerIndex {
                score += 1
            } else {
                showCorrectAnswer = true
            }
        }
    }

    func nextQuestion() {
        if currentQuestionIndex < quizQuestions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            showCorrectAnswer = false
        } else {
            showScore = true
        }
    }

    func resetGame() {
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
        score = 0
        showScore = false
        showCorrectAnswer = false
    }
}

struct QCMGameView_Previews: PreviewProvider {
    static var previews: some View {
        QCMGameView()
    }
}
