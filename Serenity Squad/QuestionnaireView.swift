//
//  QuestionnaireView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI

struct QuestionnaireView: View {
    var onComplete: () -> Void

    @State private var selectedSourceOfStress: String?
    @State private var selectedActivity: String?
    
    let sourcesOfStress = ["Famille", "Pensées obscures", "Travail", "Quotidien"]
    let activities = ["Mini-jeux", "Écriture", "Lecture"]
    
    var body: some View {
        VStack {
            Text("Questionnaire de bien-être")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Form {
                Section(header: Text("Quelle est la source de votre stress ?")) {
                    Picker("Source de stress", selection: $selectedSourceOfStress) {
                        ForEach(sourcesOfStress, id: \.self) { source in
                            Text(source).tag(source as String?)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Qu'est-ce qui vous ferait du bien aujourd'hui ?")) {
                    Picker("Activité", selection: $selectedActivity) {
                        ForEach(activities, id: \.self) { activity in
                            Text(activity).tag(activity as String?)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            
            Button(action: {
                onComplete()
            }) {
                Text("Terminer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
            }
            .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct QuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireView(onComplete: {})
    }
}
