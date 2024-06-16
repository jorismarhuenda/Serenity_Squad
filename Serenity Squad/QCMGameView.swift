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

    let quizQuestions: [QuizQuestion] = [
        QuizQuestion(questionText: "Quelle est la capitale de la France ?", answers: ["Paris", "Londres", "Berlin", "Madrid"], correctAnswerIndex: 0),
        QuizQuestion(questionText: "Quelle est la plus grande planète du système solaire ?", answers: ["Terre", "Mars", "Jupiter", "Saturne"], correctAnswerIndex: 2),
        QuizQuestion(questionText: "Qui a écrit 'Les Misérables' ?", answers: ["Victor Hugo", "Émile Zola", "Gustave Flaubert", "Honoré de Balzac"], correctAnswerIndex: 0),
        QuizQuestion(questionText: "En quelle année a eu lieu la Révolution française ?", answers: ["1789", "1776", "1799", "1804"], correctAnswerIndex: 0),
        QuizQuestion(questionText: "Quel est le symbole chimique de l'or ?", answers: ["Au", "Ag", "Fe", "O"], correctAnswerIndex: 0),
        QuizQuestion(questionText: "Quel est l'animal le plus rapide du monde ?", answers: ["Guépard", "Faucon pèlerin", "Lion", "Gazelle"], correctAnswerIndex: 1),
        QuizQuestion(questionText: "Quel est le plus grand océan de la Terre ?", answers: ["Atlantique", "Pacifique", "Indien", "Arctique"], correctAnswerIndex: 1),
        QuizQuestion(questionText: "Qui a peint la 'Joconde' ?", answers: ["Michel-Ange", "Vincent van Gogh", "Pablo Picasso", "Léonard de Vinci"], correctAnswerIndex: 3),
        QuizQuestion(questionText: "Quel est le pays le plus peuplé du monde ?", answers: ["Inde", "États-Unis", "Chine", "Brésil"], correctAnswerIndex: 2),
        QuizQuestion(questionText: "Quel est le plus long fleuve du monde ?", answers: ["Nil", "Amazon", "Yangtsé", "Mississippi"], correctAnswerIndex: 1),
        QuizQuestion(questionText: "Quel est le plus grand désert du monde ?", answers: ["Sahara", "Arctique", "Antarctique", "Gobi"], correctAnswerIndex: 2),
        QuizQuestion(questionText: "Quelle est la langue la plus parlée dans le monde ?", answers: ["Anglais", "Espagnol", "Chinois", "Hindi"], correctAnswerIndex: 2),
        QuizQuestion(questionText: "Quel est le pays d'origine des sushis ?", answers: ["Chine", "Corée", "Japon", "Vietnam"], correctAnswerIndex: 2),
        QuizQuestion(questionText: "Quel est le plus petit pays du monde ?", answers: ["Monaco", "Liechtenstein", "Saint-Marin", "Vatican"], correctAnswerIndex: 3),
        QuizQuestion(questionText: "Quelle est la ville des Lumières ?", answers: ["Londres", "Berlin", "Paris", "Rome"], correctAnswerIndex: 2),
        QuizQuestion(questionText: "Qui a inventé le téléphone ?", answers: ["Nikola Tesla", "Alexander Graham Bell", "Thomas Edison", "Guglielmo Marconi"], correctAnswerIndex: 1),
        QuizQuestion(questionText: "Quelle est la planète la plus proche du Soleil ?", answers: ["Vénus", "Mars", "Mercure", "Jupiter"], correctAnswerIndex: 2),
        QuizQuestion(questionText: "Quel est l'élément chimique représenté par le symbole 'O' ?", answers: ["Or", "Oxygène", "Osmium", "Oganesson"], correctAnswerIndex: 1),
        QuizQuestion(questionText: "Quel est le nom de la plus haute montagne du monde ?", answers: ["Mont Everest", "K2", "Kangchenjunga", "Lhotse"], correctAnswerIndex: 0),
        QuizQuestion(questionText: "Quelle est la monnaie du Japon ?", answers: ["Yuan", "Won", "Yen", "Ringgit"], correctAnswerIndex: 2),
        QuizQuestion(questionText: "Quel est le plus petit continent ?", answers: ["Europe", "Antarctique", "Australie", "Amérique du Sud"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quel est l'élément chimique représenté par le symbole 'Fe' ?", answers: ["Fer", "Fluor", "Phosphore", "Francium"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Qui a écrit '1984' ?", answers: ["George Orwell", "Aldous Huxley", "Ray Bradbury", "Jules Verne"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Quel est le pays d'origine de la pizza ?", answers: ["France", "Grèce", "États-Unis", "Italie"], correctAnswerIndex: 3),
            QuizQuestion(questionText: "Quelle est la monnaie utilisée en Allemagne ?", answers: ["Franc", "Euro", "Livre", "Dollar"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quel est le plus grand mammifère ?", answers: ["Éléphant", "Baleine bleue", "Requin blanc", "Girafe"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quel est l'animal national du Canada ?", answers: ["Castor", "Aigle", "Lion", "Ours"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Qui a peint 'La Nuit étoilée' ?", answers: ["Pablo Picasso", "Claude Monet", "Vincent van Gogh", "Paul Cézanne"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quel est le sport le plus pratiqué au monde ?", answers: ["Basketball", "Cricket", "Football", "Tennis"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quelle est la langue officielle du Brésil ?", answers: ["Espagnol", "Portugais", "Français", "Anglais"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quel est le plus long fleuve d'Afrique ?", answers: ["Congo", "Nil", "Niger", "Zambèze"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Qui a composé la Symphonie n°9 en ré mineur, op. 125 ?", answers: ["Wolfgang Amadeus Mozart", "Ludwig van Beethoven", "Johann Sebastian Bach", "Franz Schubert"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quel est le plus grand lac d'eau douce au monde ?", answers: ["Lac Victoria", "Lac Supérieur", "Lac Baïkal", "Lac Tanganyika"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quelle est la capitale de l'Australie ?", answers: ["Sydney", "Melbourne", "Canberra", "Perth"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quel est le plus grand archipel du monde ?", answers: ["Indonésie", "Philippines", "Japon", "Malaisie"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Quel est l'organe le plus grand du corps humain ?", answers: ["Foie", "Peau", "Cerveau", "Poumons"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quel est le pays avec le plus grand nombre de volcans actifs ?", answers: ["Japon", "Indonésie", "États-Unis", "Italie"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quelle est la langue officielle du Mexique ?", answers: ["Anglais", "Portugais", "Espagnol", "Français"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quel est le symbole chimique de l'eau ?", answers: ["HO", "H2O", "H2", "O2"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quelle est la planète la plus chaude du système solaire ?", answers: ["Mercure", "Vénus", "Terre", "Mars"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Qui a écrit 'Roméo et Juliette' ?", answers: ["Charles Dickens", "Jane Austen", "William Shakespeare", "Mark Twain"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quelle est la monnaie de la Chine ?", answers: ["Yen", "Won", "Dollar", "Yuan"], correctAnswerIndex: 3),
            QuizQuestion(questionText: "Quel est le plus grand pays du monde par superficie ?", answers: ["Canada", "Chine", "États-Unis", "Russie"], correctAnswerIndex: 3),
            QuizQuestion(questionText: "Quel est le principal gaz de l'atmosphère terrestre ?", answers: ["Oxygène", "Hydrogène", "Azote", "Dioxyde de carbone"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quelle est la capitale du Canada ?", answers: ["Toronto", "Ottawa", "Vancouver", "Montréal"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quel est l'océan situé à l'ouest de l'Afrique ?", answers: ["Océan Indien", "Océan Atlantique", "Océan Pacifique", "Océan Arctique"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Qui a inventé l'ampoule électrique ?", answers: ["Nikola Tesla", "Albert Einstein", "Thomas Edison", "Isaac Newton"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quel est le plus grand désert de sable du monde ?", answers: ["Désert de Gobi", "Désert du Kalahari", "Sahara", "Désert de Sonora"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quel est le pays d'origine du tango ?", answers: ["Brésil", "Mexique", "Espagne", "Argentine"], correctAnswerIndex: 3),
            QuizQuestion(questionText: "Quel est le plus grand pays d'Amérique du Sud ?", answers: ["Brésil", "Argentine", "Colombie", "Pérou"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Quelle est la capitale de l'Italie ?", answers: ["Milan", "Florence", "Venise", "Rome"], correctAnswerIndex: 3),
            QuizQuestion(questionText: "Quel est le plus grand continent en termes de superficie ?", answers: ["Afrique", "Asie", "Amérique du Nord", "Europe"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quelle est la capitale de l'Espagne ?", answers: ["Madrid", "Barcelone", "Séville", "Valence"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Quel est l'élément chimique représenté par le symbole 'He' ?", answers: ["Hydrogène", "Hélium", "Hafnium", "Holmium"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Qui a écrit 'Le Petit Prince' ?", answers: ["Antoine de Saint-Exupéry", "Victor Hugo", "Marcel Proust", "Albert Camus"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Quel est le plus grand pays d'Afrique ?", answers: ["Algérie", "Nigéria", "Égypte", "Afrique du Sud"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Quelle est la langue officielle de l'Argentine ?", answers: ["Portugais", "Anglais", "Espagnol", "Français"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quel est le pays avec le plus grand nombre de prix Nobel ?", answers: ["États-Unis", "Royaume-Uni", "Allemagne", "France"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Quelle est la monnaie utilisée en Suisse ?", answers: ["Euro", "Franc suisse", "Dollar", "Livre"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Qui a peint 'Guernica' ?", answers: ["Salvador Dalí", "Henri Matisse", "Pablo Picasso", "Joan Miró"], correctAnswerIndex: 2),
            QuizQuestion(questionText: "Quel est le plus haut sommet de l'Amérique du Sud ?", answers: ["Mont Denali", "Aconcagua", "Mont McKinley", "Mont Fitz Roy"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quelle est la plus grande île du monde ?", answers: ["Madagascar", "Groenland", "Nouvelle-Guinée", "Bornéo"], correctAnswerIndex: 1),
            QuizQuestion(questionText: "Quel est le pays le plus riche du monde par PIB par habitant ?", answers: ["Luxembourg", "Singapour", "Suisse", "Norvège"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Quelle est la capitale du Japon ?", answers: ["Tokyo", "Osaka", "Kyoto", "Nagoya"], correctAnswerIndex: 0),
            QuizQuestion(questionText: "Quel est le pays avec la plus grande population musulmane ?", answers: ["Arabie Saoudite", "Pakistan", "Indonésie", "Égypte"], correctAnswerIndex: 3),
            QuizQuestion(questionText: "Quelle est la langue officielle de la Russie ?", answers: ["Russe", "Ukrainien", "Bélarusse", "Polonais"], correctAnswerIndex: 0)
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
