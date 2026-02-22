import 'package:flutter/material.dart';

import '../../domain/usecases/move_basket_usecase.dart';
import '../../domain/usecases/update_game_usecase.dart';
import '../widgets/ball_widget.dart';
import '../widgets/basket_widget.dart';
import '../widgets/game_over_dialog.dart';
import '../widgets/score_board_widget.dart';
import 'game_controller.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GameController(UpdateGameUseCase(), MoveBasketUseCase());

    _controller.addListener(_onGameStateChanged);
    // Start game on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.start();
    });
  }

  void _onGameStateChanged() {
    if (_controller.state.isGameOver) {
      _showGameOverDialog();
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return GameOverDialog(
          score: _controller.state.score,
          onRestart: () {
            Navigator.of(context).pop();
            _controller.restart();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onGameStateChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Score board
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ScoreBoardWidget(
                    score: _controller.state.score,
                    lives: _controller.state.lives,
                  );
                },
              ),

              // Top Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) => Icon(
                        _controller.state.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    onPressed: () {
                      if (_controller.state.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.resume();
                      }
                    },
                  ),
                  const SizedBox(width: 16),
                ],
              ),

              // Game Area
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        _controller.dragBasketTo(
                          details.localPosition.dx,
                          constraints.maxWidth,
                        );
                      },
                      onPanDown: (details) {
                        _controller.dragBasketTo(
                          details.localPosition.dx,
                          constraints.maxWidth,
                        );
                      },
                      child: Container(
                        color: Colors.transparent, // Capture gestures
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            final state = _controller.state;
                            return Stack(
                              children: [
                                // Ball
                                Align(
                                  alignment: Alignment(
                                    state.ballX,
                                    state.ballY,
                                  ),
                                  child: const BallWidget(),
                                ),
                                // Basket
                                Align(
                                  // basket is near the bottom
                                  alignment: Alignment(state.basketX, 0.8),
                                  child: const BasketWidget(),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
