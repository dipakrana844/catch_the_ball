import '../entities/game_state.dart';

class MoveBasketUseCase {
  GameState execute(GameState currentState, double deltaX) {
    if (currentState.isGameOver || !currentState.isPlaying) return currentState;

    double newX = currentState.basketX + deltaX;

    // Bounds checking
    if (newX < -1.0) newX = -1.0;
    if (newX > 1.0) newX = 1.0;

    return currentState.copyWith(basketX: newX);
  }
}
