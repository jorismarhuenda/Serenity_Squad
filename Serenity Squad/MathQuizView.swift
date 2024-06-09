//
//  MathQuizView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 09/06/2024.
//

import SwiftUI

struct MathQuizView: View {
    @State private var currentQuestion: String = ""
    @State private var currentAnswer: String = ""
    @State private var userAnswer: String = ""
    @State private var score: Int = 0
    @State private var questionNumber: Int = 1
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Spacer() // Ajout de Spacer pour descendre le contenu

            Text("Math Quiz")
                .font(.title)
                .padding()

            Text("Score: \(score)")
                .font(.title2)
                .padding(.bottom, 20)

            Text(currentQuestion)
                .font(.largeTitle)
                .padding()

            TextField("Votre réponse", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1)
                )

            Button(action: {
                self.checkAnswer()
            }) {
                Text("Valider")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                self.nextQuestion()
            }) {
                Text("Question Suivante")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.nextQuestion()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Résultat"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func nextQuestion() {
        let operations = ["+", "-", "*", "/"]
        let firstNumber = Int.random(in: 1...20)
        let secondNumber = Int.random(in: 1...20)
        let operation = operations.randomElement()!

        switch operation {
        case "+":
            currentQuestion = "\(firstNumber) + \(secondNumber)"
            currentAnswer = String(firstNumber + secondNumber)
        case "-":
            currentQuestion = "\(firstNumber) - \(secondNumber)"
            currentAnswer = String(firstNumber - secondNumber)
        case "*":
            currentQuestion = "\(firstNumber) * \(secondNumber)"
            currentAnswer = String(firstNumber * secondNumber)
        case "/":
            currentQuestion = "\(firstNumber * secondNumber) / \(secondNumber)"
            currentAnswer = String(firstNumber)
        default:
            break
        }

        userAnswer = ""
        questionNumber += 1
    }

    func checkAnswer() {
        if userAnswer == currentAnswer {
            score += 1
            alertMessage = "Correct!"
        } else {
            alertMessage = "Incorrect. La bonne réponse est \(currentAnswer)."
        }
        showAlert = true
    }
}

struct MathQuizView_Previews: PreviewProvider {
    static var previews: some View {
        MathQuizView()
    }
}
