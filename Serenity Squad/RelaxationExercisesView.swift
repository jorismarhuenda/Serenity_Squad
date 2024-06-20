//
//  RelaxationExercisesView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 17/06/2024.
//

import SwiftUI

struct Exercise: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let duration: Int // Duration in seconds
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let exercises: [Exercise]
}

struct RelaxationExercisesView: View {
    @State private var selectedCategory: Category?
    @State private var showInstructions: Bool = false

    let breathingExercises = [
        Exercise(name: "Respiration profonde", description: "Inspirez profondément par le nez pendant 4 secondes, retenez votre souffle pendant 7 secondes, puis expirez lentement par la bouche pendant 8 secondes.", duration: 300),
        Exercise(name: "Respiration alternée", description: "Bouchez la narine droite et inspirez par la narine gauche. Bouchez les deux narines et retenez votre souffle. Débouchez la narine droite et expirez par cette narine. Répétez en alternant les narines.", duration: 300),
        Exercise(name: "Respiration abdominale", description: "Allongez-vous sur le dos, placez une main sur votre ventre et respirez profondément en gonflant votre abdomen. Expirez lentement en rentrant votre ventre.", duration: 300),
        Exercise(name: "Respiration en 4-4-4-4", description: "Inspirez par le nez pendant 4 secondes, retenez votre souffle pendant 4 secondes, expirez par la bouche pendant 4 secondes, puis retenez votre souffle pendant 4 secondes. Répétez.", duration: 300),
        Exercise(name: "Respiration en boîte", description: "Inspirez par le nez pendant 4 secondes, retenez votre souffle pendant 4 secondes, expirez par la bouche pendant 4 secondes, puis retenez votre souffle pendant 4 secondes. Répétez.", duration: 300),
        Exercise(name: "Respiration à lèvres pincées", description: "Inspirez par le nez pendant 2 secondes, puis expirez lentement par la bouche en pinçant les lèvres, comme si vous souffliez dans une paille.", duration: 300),
        Exercise(name: "Respiration à 2 pour 1", description: "Inspirez profondément par le nez et expirez lentement par la bouche, en faisant en sorte que votre expiration dure deux fois plus longtemps que votre inspiration.", duration: 300),
        Exercise(name: "Respiration avec visualisation", description: "Inspirez profondément en imaginant une lumière apaisante entrant dans votre corps. Expirez en visualisant les tensions quittant votre corps.", duration: 300),
        Exercise(name: "Respiration guidée", description: "Utilisez une application de respiration guidée pour suivre des exercices de respiration contrôlée et relaxante.", duration: 300),
        Exercise(name: "Respiration 4-7-8", description: "Inspirez profondément par le nez pendant 4 secondes, retenez votre souffle pendant 7 secondes, puis expirez lentement par la bouche pendant 8 secondes. Répétez.", duration: 300)
    ]
    
    let yogaPoses = [
        Exercise(name: "Posture de l'enfant", description: "Agenouillez-vous, asseyez-vous sur vos talons et penchez-vous en avant pour poser votre front sur le sol. Étendez vos bras devant vous.", duration: 180),
        Exercise(name: "Chien tête en bas", description: "Commencez à quatre pattes, puis poussez vos hanches vers le haut et en arrière, formant un V inversé avec votre corps.", duration: 180),
        Exercise(name: "Posture du cadavre", description: "Allongez-vous sur le dos, les bras le long du corps, les paumes tournées vers le ciel. Fermez les yeux et relâchez tous les muscles.", duration: 300),
        Exercise(name: "Posture du cobra", description: "Allongez-vous sur le ventre, placez vos mains sous vos épaules et poussez le haut de votre corps vers le haut, en gardant vos hanches sur le sol.", duration: 180),
        Exercise(name: "Posture de la montagne", description: "Tenez-vous debout, les pieds écartés à la largeur des hanches, les bras le long du corps. Redressez-vous et allongez votre colonne vertébrale.", duration: 180),
        Exercise(name: "Posture de l'arbre", description: "Tenez-vous debout, placez un pied sur la cuisse opposée et levez les bras au-dessus de la tête, en joignant les paumes.", duration: 180),
        Exercise(name: "Posture du guerrier", description: "Faites un grand pas en arrière avec une jambe, pliez le genou avant et étendez les bras au-dessus de la tête.", duration: 180),
        Exercise(name: "Posture du triangle", description: "Écartez les pieds, penchez-vous sur le côté et touchez votre pied avec la main, tout en levant l'autre main vers le ciel.", duration: 180),
        Exercise(name: "Posture du chat-vache", description: "À quatre pattes, alternez entre cambrer et arrondir le dos, en synchronisant le mouvement avec votre respiration.", duration: 180),
        Exercise(name: "Posture de la tête au genou", description: "Asseyez-vous, étendez une jambe et pliez l'autre, en amenant le pied contre l'intérieur de la cuisse. Penchez-vous vers l'avant pour toucher votre pied.", duration: 180)
    ]
    
    let sophrologyExercises = [
        Exercise(name: "Relaxation dynamique", description: "Debout, les yeux fermés, concentrez-vous sur votre respiration. Inspirez en levant les bras au-dessus de la tête, expirez en abaissant les bras. Répétez en synchronisant votre respiration avec les mouvements.", duration: 600),
        Exercise(name: "Visualisation positive", description: "Asseyez-vous confortablement, fermez les yeux et imaginez un lieu paisible. Visualisez chaque détail de cet endroit, sentez-vous en sécurité et détendu.", duration: 600),
        Exercise(name: "Balayage corporel", description: "Allongez-vous et fermez les yeux. Concentrez-vous sur chaque partie de votre corps, en commençant par les pieds et en remontant jusqu'à la tête. Relâchez les tensions à chaque étape.", duration: 600),
        Exercise(name: "Respiration abdominale", description: "Asseyez-vous confortablement et placez une main sur votre ventre. Inspirez profondément en gonflant votre abdomen, puis expirez lentement en rentrant votre ventre.", duration: 600),
        Exercise(name: "Ancrage", description: "Debout, les pieds écartés à la largeur des hanches, imaginez des racines qui partent de vos pieds et s'enfoncent dans le sol. Sentez-vous stable et ancré.", duration: 600),
        Exercise(name: "Relaxation musculaire progressive", description: "Allongez-vous et fermez les yeux. Contractez et relâchez progressivement chaque groupe musculaire de votre corps, en commençant par les pieds et en remontant jusqu'à la tête.", duration: 600),
        Exercise(name: "Sophro-déplacement du négatif", description: "Asseyez-vous confortablement et fermez les yeux. Concentrez-vous sur une sensation négative dans votre corps et imaginez-la se déplacer et sortir de votre corps à chaque expiration.", duration: 600),
        Exercise(name: "Future projection", description: "Asseyez-vous confortablement et fermez les yeux. Imaginez-vous dans une situation future réussie et positive. Visualisez chaque détail et ressentez les émotions positives associées.", duration: 600),
        Exercise(name: "Concentration sur un objet", description: "Choisissez un objet et concentrez-vous uniquement sur lui. Observez chaque détail de l'objet, ses couleurs, sa texture, sa forme. Essayez de ne penser à rien d'autre.", duration: 600),
        Exercise(name: "Sophro-substitution sensorielle", description: "Asseyez-vous confortablement et fermez les yeux. Concentrez-vous sur une sensation agréable, comme la chaleur du soleil ou la douceur d'une brise. Imprégnez-vous de cette sensation positive.", duration: 600)
    ]
    
    var categories: [Category] {
        [
            Category(name: "Exercices de respiration", icon: "wind", exercises: breathingExercises),
            Category(name: "Postures de yoga", icon: "figure.walk", exercises: yogaPoses),
            Category(name: "Exercices de sophrologie", icon: "leaf.arrow.circlepath", exercises: sophrologyExercises)
        ]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 150)
                
                Text("Exercices de Relaxation")
                    .font(.largeTitle)
                    .padding(.bottom, 40) // Adjust padding to position the title correctly
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 40) {
                        ForEach(categories) { category in
                            NavigationLink(destination: ExerciseListView(category: category)) {
                                HStack {
                                    Image(systemName: category.icon)
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding()
                                    Text(category.name)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ExerciseListView: View {
    var category: Category
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Spacer(minLength: 100)
            
            Text(category.name)
                .font(.largeTitle)
                .padding(.top)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(category.exercises) { exercise in
                        NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                            HStack {
                                Text(exercise.name)
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding()
            }

            Spacer()
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Retour")
                    .font(.headline)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ExerciseDetailView: View {
    let exercise: Exercise
    @State private var timeRemaining: Int
    @State private var isTimerRunning: Bool = false
    @State private var timer: Timer?

    init(exercise: Exercise) {
        self.exercise = exercise
        self._timeRemaining = State(initialValue: exercise.duration)
    }
    
    var body: some View {
        VStack {
            Text(exercise.name)
                .font(.largeTitle)
                .padding(.top)
            
            ScrollView {
                Text(exercise.description)
                    .font(.body)
                    .padding()
            }
            
            Text("Durée : \(timeFormatted(timeRemaining))")
                .font(.headline)
                .padding()
            
            HStack(spacing: 20) {
                Button(action: {
                    self.toggleTimer()
                }) {
                    Text(isTimerRunning ? "Pause" : "Démarrer")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    self.timer?.invalidate()
                    self.isTimerRunning = false
                    self.timeRemaining = exercise.duration
                }) {
                    Text("Réinitialiser")
                        .font(.headline)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
            if isTimerRunning {
                DynamicAnimationView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding()
        .onDisappear {
            self.timer?.invalidate()
        }
    }

    func toggleTimer() {
        if isTimerRunning {
            timer?.invalidate()
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.invalidate()
                    self.isTimerRunning = false
                }
            }
        }
        isTimerRunning.toggle()
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct DynamicAnimationView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            ForEach(0..<10) { i in
                Circle()
                    .stroke(Color.blue.opacity(Double(i) / 10), lineWidth: 2)
                    .frame(width: CGFloat(i) * 40, height: CGFloat(i) * 40)
                    .rotationEffect(.degrees(self.isAnimating ? 360 : 0))
            }
            ForEach(0..<10) { i in
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.green.opacity(Double(i) / 10), lineWidth: 2)
                    .frame(width: CGFloat(i) * 30, height: CGFloat(i) * 30)
                    .rotationEffect(.degrees(self.isAnimating ? -360 : 0))
            }
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                self.isAnimating = true
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct RelaxationExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        RelaxationExercisesView()
            .previewInterfaceOrientation(.portrait)
    }
}
