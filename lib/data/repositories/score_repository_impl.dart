import '../../domain/repositories/score_repository.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  int _highScore = 0;

  @override
  Future<int> getHighScore() async {
    // In a real app, this would fetch from SharedPreferences or a database.
    return _highScore;
  }

  @override
  Future<void> saveHighScore(int score) async {
    // In a real app, this would save to SharedPreferences or a database.
    if (score > _highScore) {
      _highScore = score;
    }
  }
}
