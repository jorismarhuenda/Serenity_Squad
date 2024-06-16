//
//  QuestionnaireView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

struct QuestionnaireView: View {
    @State private var currentQuestionIndex = 0
    @State private var selectedOption: String? = nil
    @State private var showNextQuestion = false
    @State private var questionnaireCompleted = false

    let questions = [
        Question(text: "Comment vous sentez-vous aujourd'hui ?", options: ["Bien", "Moyen", "Mal"]),
        Question(text: "Quel est votre niveau de stress ?", options: ["Faible", "Modéré", "Élevé"]),
        Question(text: "Avez-vous bien dormi ?", options: ["Oui", "Non"]),
        Question(text: "Quelle est la source de votre stress ?", options: ["Famille", "Pensées obscures", "Travail", "Quotidien"])
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(questions[currentQuestionIndex].text)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    showNextQuestion = true
                }) {
                    Text(option)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedOption == option ? Color.green : Color.blue)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
            
            Spacer()
            
            if showNextQuestion {
                Button(action: {
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
                        selectedOption = nil
                        showNextQuestion = false
                    } else {
                        // Fin du questionnaire, stocker la date de complétion
                        questionnaireCompleted = true
                        UserDefaults.standard.set(Date(), forKey: "lastQuestionnaireCompletionDate")
                    }
                }) {
                    Text("Suivant")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
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
        .navigationBarTitle("Questionnaire", displayMode: .inline)
        .onAppear {
            if let lastCompletionDate = UserDefaults.standard.object(forKey: "lastQuestionnaireCompletionDate") as? Date {
                let elapsedTime = Date().timeIntervalSince(lastCompletionDate)
                let hoursElapsed = elapsedTime / 3600
                if hoursElapsed < 24 {
                    questionnaireCompleted = true
                }
            }
        }
        .disabled(questionnaireCompleted)
        .overlay(
            questionnaireCompleted ? NavigationLink(destination: MainMenuView()) {
                Text("Terminer le questionnaire")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
            }
            .padding() : nil
        )
    }
}

struct Question {
    let text: String
    let options: [String]
}

struct QuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView()
    }
}
