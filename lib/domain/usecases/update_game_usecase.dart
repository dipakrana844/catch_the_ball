import 'dart:math';

import '../entities/game_state.dart';

class UpdateGameUseCase {
  final Random _random = Random();

  GameState execute(GameState currentState, Duration deltaTime) {
    if (currentState.isGameOver || !currentState.isPlaying) return currentState;

    double dt = deltaTime.inMilliseconds / 1000.0; // delta time in seconds

    double newBallY = currentState.ballY + currentState.ballSpeed * dt;
    double newBallX = currentState.ballX;

    int newScore = currentState.score;
    int newLives = currentState.lives;
    double newSpeed = currentState.ballSpeed;
    bool isGameOver = currentState.isGameOver;

    // Basket Y position
    const double basketY = 0.8;
    // Radius of basket width in coordinate space (0.2 means it spans -0.2 to +0.2 around basketX)
    const double basketHalfWidth = 0.25;

    // Has it crossed the basket line?
    if (currentState.ballY <= basketY && newBallY > basketY) {
      if ((newBallX - currentState.basketX).abs() <= basketHalfWidth) {
        // Catch successful
        newScore++;
        newSpeed += 0.05; // gradually increase speed

        // Reset ball
        newBallY = -1.0;
        newBallX = (_random.nextDouble() * 2) - 1; // Random -1.0 to 1.0
      }
    }

    // Has it reached the bottom (Missed)?
    if (newBallY > 1.0) {
      newLives--;
      if (newLives <= 0) {
        isGameOver = true;
      } else {
        // Reset ball
        newBallY = -1.0;
        newBallX = (_random.nextDouble() * 2) - 1;
      }
    }

    return currentState.copyWith(
      ballX: newBallX,
      ballY: newBallY,
      score: newScore,
      lives: newLives,
      ballSpeed: newSpeed,
      isGameOver: isGameOver,
      isPlaying: !isGameOver,
    );
  }
}
