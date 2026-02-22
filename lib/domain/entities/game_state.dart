class GameState {
  final int score;
  final int lives;
  final bool isGameOver;
  final bool isPlaying;
  final double ballX;
  final double ballY;
  final double basketX;
  final double ballSpeed; // Y-axis speed

  const GameState({
    required this.score,
    required this.lives,
    required this.isGameOver,
    required this.isPlaying,
    required this.ballX,
    required this.ballY,
    required this.basketX,
    required this.ballSpeed,
  });

  GameState.initial()
      : score = 0,
        lives = 3,
        isGameOver = false,
        isPlaying = false,
        ballX = 0.0,
        ballY = -1.0,
        basketX = 0.0,
        ballSpeed = 0.01;

  GameState copyWith({
    int? score,
    int? lives,
    bool? isGameOver,
    bool? isPlaying,
    double? ballX,
    double? ballY,
    double? basketX,
    double? ballSpeed,
  }) {
    return GameState(
      score: score ?? this.score,
      lives: lives ?? this.lives,
      isGameOver: isGameOver ?? this.isGameOver,
      isPlaying: isPlaying ?? this.isPlaying,
      ballX: ballX ?? this.ballX,
      ballY: ballY ?? this.ballY,
      basketX: basketX ?? this.basketX,
      ballSpeed: ballSpeed ?? this.ballSpeed,
    );
  }
}
