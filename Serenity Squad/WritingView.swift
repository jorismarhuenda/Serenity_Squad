//
//  WritingView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 12/06/2024.
//

import SwiftUI

struct WritingView: View {
    @State private var selectedCategory: String?
    @State private var selectedTopic: String?
    @State private var writingText: String = ""
    @State private var savedEntries: [String: String] = UserDefaults.standard.dictionary(forKey: "savedEntries") as? [String: String] ?? [:]
    @State private var showSavedEntries: Bool = false

    let categories = ["Famille", "Amour", "Travail", "Santé", "Loisirs"]
    let topics = [
        "Famille": ["Parents", "Enfants", "Grand-parents", "Frères et Sœurs", "Cousins", "Oncles et Tantes"],
        "Amour": ["Partenaire", "Amis", "Romance", "Coup de foudre", "Mariage", "Relations"],
        "Travail": ["Collègues", "Projet", "Carrière", "Bureau", "Télétravail", "Employeur"],
        "Santé": ["Exercice", "Nutrition", "Bien-être", "Médecine", "Repos", "Santé mentale"],
        "Loisirs": ["Sport", "Musique", "Voyage", "Lecture", "Cuisine", "Art"]
    ]

    var body: some View {
        VStack {
            if showSavedEntries {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(savedEntries.sorted(by: >), id: \.key) { key, value in
                            VStack(alignment: .leading, spacing: 5) {
                                Text(key)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(value)
                                    .foregroundColor(.white)
                                Divider()
                            }
                            .padding()
                            .background(Color.pastelPink.opacity(0.8))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
                .navigationTitle("Écrits Sauvegardés")
                .toolbar {
                    Button(action: { showSavedEntries.toggle() }) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                    }
                }
            } else {
                VStack {
                    Spacer(minLength: 150)
                    
                    Text("Écriture Quotidienne")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    if let selectedCategory = selectedCategory {
                        if let selectedTopic = selectedTopic {
                            Text("Sujet: \(selectedTopic)")
                                .font(.title2)
                                .padding()
                                .background(Color.pastelPink.opacity(0.8))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            
                            TextEditor(text: $writingText)
                                .padding()
                                .background(Color.pastelPink.opacity(0.6))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.horizontal)
                                .frame(maxHeight: 200)
                            
                            Button(action: saveEntry) {
                                Text("Enregistrer")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .padding(.horizontal)
                            }
                            
                            Button(action: { self.selectedTopic = nil }) {
                                Text("Changer de Sujet")
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                        } else {
                            VStack {
                                Text("Choisissez un sujet")
                                    .font(.title2)
                                    .padding()
                                
                                ScrollView {
                                    VStack(spacing: 10) {
                                        ForEach(topics[selectedCategory] ?? [], id: \.self) { topic in
                                            Button(action: {
                                                self.selectedTopic = topic
                                            }) {
                                                Text(topic)
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                                    .padding()
                                                    .background(Color.pastelPink.opacity(0.8))
                                                    .cornerRadius(10)
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                
                                Button(action: { self.selectedCategory = nil }) {
                                    Text("Changer de Catégorie")
                                        .foregroundColor(.blue)
                                        .padding()
                                }
                            }
                        }
                    } else {
                        VStack {
                            Text("Choisissez une catégorie")
                                .font(.title2)
                                .padding()
                            
                            ScrollView {
                                VStack(spacing: 10) {
                                    ForEach(categories, id: \.self) { category in
                                        Button(action: {
                                            self.selectedCategory = category
                                        }) {
                                            Text(category)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.pastelPink.opacity(0.8))
                                                .cornerRadius(10)
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(20)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
                .edgesIgnoringSafeArea(.all)
                .toolbar {
                    Button(action: { showSavedEntries.toggle() }) {
                        Image(systemName: "book")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
    
    private func saveEntry() {
        guard let selectedTopic = selectedTopic, !writingText.isEmpty else { return }
        savedEntries[selectedTopic] = writingText
        UserDefaults.standard.setValue(savedEntries, forKey: "savedEntries")
        self.writingText = ""
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView()
    }
}
