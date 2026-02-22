import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../domain/entities/game_state.dart';
import '../../domain/usecases/move_basket_usecase.dart';
import '../../domain/usecases/update_game_usecase.dart';

class GameController extends ChangeNotifier {
  final UpdateGameUseCase _updateGameUseCase;
  final MoveBasketUseCase _moveBasketUseCase;

  GameState _state = GameState.initial();
  GameState get state => _state;

  Ticker? _ticker;
  Duration _lastTime = Duration.zero;

  GameController(this._updateGameUseCase, this._moveBasketUseCase);

  void start() {
    _state = GameState.initial().copyWith(
      isPlaying: true,
      ballSpeed: 0.8, // initial speed
    );
    notifyListeners();
    _startTicker();
  }

  void pause() {
    _state = _state.copyWith(isPlaying: false);
    _ticker?.stop();
    notifyListeners();
  }

  void resume() {
    if (_state.isGameOver) return;
    _state = _state.copyWith(isPlaying: true);
    _lastTime = Duration.zero; // Reset to avoid large delta jump
    _startTicker();
  }

  void restart() {
    _state = GameState.initial().copyWith(isPlaying: true, ballSpeed: 0.8);
    _lastTime = Duration.zero;
    notifyListeners();
    _startTicker();
  }

  void moveBasket(double deltaX) {
    if (!_state.isPlaying || _state.isGameOver) return;
    _state = _moveBasketUseCase.execute(_state, deltaX);
    notifyListeners(); // Immediate visual feedback
  }

  void dragBasketTo(double localX, double screenWidth) {
    if (!_state.isPlaying || _state.isGameOver) return;

    // convert localX (0 to screenWidth) to -1.0 to 1.0 coordinate space
    double targetX = (localX / screenWidth) * 2 - 1;

    // Smooth or instant movement? Let's do instant mapping for responsive drag
    _state = _state.copyWith(basketX: targetX.clamp(-1.0, 1.0));
    notifyListeners();
  }

  void _startTicker() {
    _ticker?.stop();
    _ticker = Ticker(_onTick);
    _lastTime = Duration.zero;
    _ticker?.start();
  }

  void _onTick(Duration elapsed) {
    if (_lastTime == Duration.zero) {
      _lastTime = elapsed;
      return;
    }

    final deltaTime = elapsed - _lastTime;
    _lastTime = elapsed;

    final newState = _updateGameUseCase.execute(_state, deltaTime);

    if (newState != _state) {
      _state = newState;
      notifyListeners();

      if (_state.isGameOver) {
        _ticker?.stop();
      }
    }
  }

  @override
  void dispose() {
    _ticker?.dispose();
    super.dispose();
  }
}
