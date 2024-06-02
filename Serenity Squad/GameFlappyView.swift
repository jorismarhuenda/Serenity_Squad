//
//  GameFlappyView.swift
//  Serenity Squad
//
//  Created by marhuenda joris on 02/06/2024.
//

import SwiftUI
import Combine

struct GameFlappyView: View {
    @State private var smileyPosition = CGPoint(x: 100, y: 300)
    @State private var obstacles = [Obstacle]()
    @State private var gameTimer: Timer?
    @State private var isGameOver = false
    @State private var score = 0
    @State private var lastObstacleHeight: CGFloat = 300

    let smileySize: CGFloat = 50
    let gravity: CGFloat = 10  // Increased gravity for faster descent
    let jumpHeight: CGFloat = -80
    let gapHeight: CGFloat = 200  // Ensure a passable gap height

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                LinearGradient(gradient: Gradient(colors: [Color.pastelPink, Color.pastelBlue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                // Smiley Pacman
                Circle()
                    .fill(Color.yellow)
                    .frame(width: smileySize, height: smileySize)
                    .position(smileyPosition)
                    .onAppear {
                        startGame(size: geometry.size)
                    }

                // Obstacles
                ForEach(obstacles) { obstacle in
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: obstacle.width, height: obstacle.height)
                        .position(obstacle.position)
                }

                // Score
                VStack {
                    Text("Score: \(score)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                    Spacer()
                }
                .padding(.top, 20)

                // Game Over
                if isGameOver {
                    VStack {
                        Text("Game Over")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .padding()

                        Button(action: {
                            resetGame(size: geometry.size)
                        }) {
                            Text("Restart")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 5, x: 0, y: 5)
                        }
                    }
                }
            }
            .onTapGesture {
                if !isGameOver {
                    jump()
                }
            }
        }
    }

    func startGame(size: CGSize) {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            gameLoop(size: size)
        }
    }

    func resetGame(size: CGSize) {
        smileyPosition = CGPoint(x: 100, y: 300)
        obstacles.removeAll()
        score = 0
        isGameOver = false
        lastObstacleHeight = 300
        startGame(size: size)
    }

    func jump() {
        smileyPosition.y += jumpHeight
    }

    func gameLoop(size: CGSize) {
        if isGameOver { return }

        // Gravity
        smileyPosition.y += gravity

        // Generate Obstacles
        if Int.random(in: 0..<10) < 2 {
            generateObstacle(size: size)
        }

        // Move Obstacles
        for index in obstacles.indices {
            obstacles[index].position.x -= 10
        }

        // Remove Off-Screen Obstacles
        obstacles.removeAll { $0.position.x < -$0.width }

        // Check Collisions
        checkCollisions(size: size)
    }

    func generateObstacle(size: CGSize) {
        let obstacleWidth: CGFloat = 50
        let minHeight: CGFloat = 50

        let variation = CGFloat.random(in: -50...50)
        let topHeight = min(max(lastObstacleHeight + variation, minHeight), size.height - gapHeight - minHeight)
        let bottomHeight = size.height - topHeight - gapHeight

        let topObstacle = Obstacle(position: CGPoint(x: size.width + obstacleWidth / 2, y: topHeight / 2),
                                   width: obstacleWidth,
                                   height: topHeight)
        let bottomObstacle = Obstacle(position: CGPoint(x: size.width + obstacleWidth / 2, y: size.height - bottomHeight / 2),
                                      width: obstacleWidth,
                                      height: bottomHeight)

        obstacles.append(contentsOf: [topObstacle, bottomObstacle])
        lastObstacleHeight = topHeight
    }

    func checkCollisions(size: CGSize) {
        // Check collision with ground and ceiling
        if smileyPosition.y < smileySize / 2 || smileyPosition.y > size.height - smileySize / 2 {
            gameOver()
        }

        // Check collision with obstacles
        for obstacle in obstacles {
            let obstacleFrame = CGRect(x: obstacle.position.x - obstacle.width / 2,
                                       y: obstacle.position.y - obstacle.height / 2,
                                       width: obstacle.width,
                                       height: obstacle.height)

            let smileyFrame = CGRect(x: smileyPosition.x - smileySize / 2,
                                     y: smileyPosition.y - smileySize / 2,
                                     width: smileySize,
                                     height: smileySize)

            if obstacleFrame.intersects(smileyFrame) {
                gameOver()
            }
        }

        // Update score
        score += 1
    }

    func gameOver() {
        isGameOver = true
        gameTimer?.invalidate()
    }
}

struct Obstacle: Identifiable {
    var id = UUID()
    var position: CGPoint
    var width: CGFloat
    var height: CGFloat
}

struct GameFlappyView_Previews: PreviewProvider {
    static var previews: some View {
        GameFlappyView()
    }
}
