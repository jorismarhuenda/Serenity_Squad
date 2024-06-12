//
//  WritingView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 12/06/2024.
//

import SwiftUI

struct WritingView: View {
    @State private var selectedCategory = "Famille"
    @State private var selectedTheme: String?
    @State private var text = ""
    @AppStorage("savedTexts") private var savedTextsData: Data = Data() // Utilisation d'AppStorage pour persister les données
    @State private var savedTexts: [String: String] = [:]
    @State private var showAllTexts = false

    let categories = ["Famille", "Amour", "Travail", "Santé", "Loisirs"]
    let themes = [
        "Famille": ["Parents", "Enfants", "Frères", "Sœurs", "Grand-parents", "Maison", "Souvenirs", "Vacances", "Repas de famille", "Mariage", "Oncle", "Tante", "Cousin", "Cousine", "Neveu", "Nièce", "Belle-famille", "Naissance", "Héritage", "Adoption", "Famille recomposée", "Famille nombreuse", "Monoparentalité", "Famille élargie", "Famille nucléaire", "Relations familiales", "Arbre généalogique", "Histoire de famille", "Traditions familiales", "Réunions de famille", "Conflits familiaux", "Rituels familiaux", "Valeurs familiales", "Support familial", "Environnement familial", "Changement familial", "Départ de la maison", "Mariages dans la famille", "Divorce dans la famille", "Décès dans la famille", "Naissances dans la famille", "Fêtes de famille", "Éducation des enfants", "Transmission de valeurs", "Vivre ensemble", "Histoires d'enfance", "Photos de famille", "Films de famille"],
        "Amour": ["Couple", "Romance", "Premier rendez-vous", "Cœur brisé", "Mariage", "Complicité", "Relations à distance", "Fiançailles", "Séparation", "Affection", "Baisers", "Amour de jeunesse", "Amour platonique", "Amour secret", "Déclaration d'amour", "Lettre d'amour", "Poèmes d'amour", "Chansons d'amour", "Amour interdit", "Amour éternel", "Amour perdu", "Amour passionnel", "Amitié amoureuse", "Amour non partagé", "Premier amour", "Relations amoureuses", "Histoires d'amour", "Amour maternel", "Amour paternel", "Amour fraternel", "Amour propre", "Amour-propre", "Amour-propre blessé", "Amour universel", "Amour inconditionnel", "Étreintes", "Câlins", "Séduire", "Charme", "Séduction", "Jalousie", "Amour-propre blessé", "Amour-propre exagéré", "Passion amoureuse", "Relations intimes", "Compromis amoureux", "Engagement amoureux", "Dévotion", "Amour-propre sain"],
        "Travail": ["Carrière", "Promotion", "Collègues", "Projets", "Télétravail", "Réunions", "Stress", "Équilibre vie-travail", "Démission", "Nouveaux défis", "Évolution professionnelle", "Formations", "Développement personnel", "Productivité", "Leadership", "Entrepreneuriat", "Innovation", "Créativité", "Gestion du temps", "Motivation", "Reconnaissance", "Évaluation", "Objectifs", "Résultats", "Compétences", "Networking", "Mentorat", "Bureau", "Culture d'entreprise", "Ambiance de travail", "Compétition", "Collaboration", "Communication", "Feedback", "Responsabilités", "Confiance", "Respect", "Éthique professionnelle", "Télétravail", "Bien-être au travail", "Satisfaction au travail", "Rétroaction", "Flexibilité", "Horaires", "Salaire", "Congés", "Retraite", "Balance vie-travail", "Relations professionnelles"],
        "Santé": ["Bien-être", "Exercice", "Alimentation", "Sommeil", "Médecine", "Hôpital", "Stress", "Santé mentale", "Récupération", "Prévention", "Hygiène de vie", "Nutrition", "Fitness", "Yoga", "Méditation", "Thérapie", "Reiki", "Acupuncture", "Homéopathie", "Santé publique", "Épidémie", "Pandémie", "Vaccination", "Traitement", "Chirurgie", "Convalescence", "Maladie", "Diagnostic", "Symptômes", "Réhabilitation", "Physiothérapie", "Dentiste", "Ophtalmologiste", "Cardiologue", "Pédiatre", "Gynécologue", "Urologue", "Dermatologue", "Psychologue", "Psychiatre", "Soutien", "Compassion", "Soins palliatifs", "Soin de soi", "Relaxation", "Spiritualité", "Plantes médicinales", "Herboristerie", "Soin infirmier", "Praticien"],
        "Loisirs": ["Sports", "Lecture", "Voyages", "Musique", "Cinéma", "Jeux vidéo", "Photographie", "Cuisine", "Jardinage", "Peinture", "Randonnée", "Camping", "Pêche", "Chasse", "Équitation", "Natation", "Surf", "Plongée", "Ski", "Snowboard", "Yoga", "Danse", "Théâtre", "Concerts", "Festivals", "Expositions", "Parcs d'attractions", "Shopping", "Bricolage", "Décoration", "Mode", "Beauté", "Automobile", "Motocyclisme", "Cyclisme", "Voyage en train", "Voyage en avion", "Croisières", "Montagne", "Plage", "Forêt", "Désert", "Villes", "Villages", "Cultures", "Traditions", "Langues", "Histoires", "Art"]
    ]

    var body: some View {
        VStack {
            Spacer() // Ajout de Spacer pour descendre le contenu vers le bas

            Text("Écriture")
                .font(.largeTitle)
                .padding()

            HStack {
                Text("Catégorie:")
                    .font(.headline)
                Picker("Choisissez une catégorie", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()

            HStack {
                Text("Thème:")
                    .font(.headline)
                Picker("Choisissez un thème", selection: $selectedTheme) {
                    if let themesForCategory = themes[selectedCategory] {
                        ForEach(themesForCategory, id: \.self) { theme in
                            Text(theme).tag(theme as String?)
                        }
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()

            if let selectedTheme = selectedTheme {
                TextEditor(text: $text)
                    .frame(height: 300)
                    .border(Color.gray, width: 1)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .onAppear {
                        self.loadSavedTexts()
                        self.text = savedTexts[selectedTheme] ?? ""
                    }

                Button(action: {
                    self.saveText(for: selectedTheme)
                }) {
                    Text("Enregistrer")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 20)
                }
            }

            Spacer()

            Button(action: {
                self.showAllTexts.toggle()
            }) {
                Text("Voir tous les textes")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)
            .sheet(isPresented: $showAllTexts) {
                AllTextsView(savedTexts: self.savedTexts)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            self.loadSavedTexts()
        }
    }

    func loadSavedTexts() {
        if let loadedTexts = try? JSONDecoder().decode([String: String].self, from: savedTextsData) {
            savedTexts = loadedTexts
        }
    }

    func saveText(for theme: String) {
        savedTexts[theme] = text
        if let encodedData = try? JSONEncoder().encode(savedTexts) {
            savedTextsData = encodedData
        }
    }
}

struct AllTextsView: View {
    let savedTexts: [String: String]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(savedTexts.keys.sorted(), id: \.self) { key in
                    VStack(alignment: .leading) {
                        Text(key)
                            .font(.headline)
                            .padding(.top, 10)
                        Text(self.savedTexts[key] ?? "")
                            .padding(.bottom, 10)
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .navigationBarTitle("Tous les textes", displayMode: .inline)
    }
}

struct WritingView_Previews: PreviewProvider {
    static var previews: some View {
        WritingView()
    }
}
