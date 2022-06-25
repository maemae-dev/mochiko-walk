import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mochiko_run/game/game.dart';
import 'package:mochiko_run/widgets/game_over_menu.dart';
import 'package:mochiko_run/widgets/hud.dart';
import 'package:mochiko_run/widgets/main_menu.dart';
import 'package:mochiko_run/widgets/won_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.setLandscape();

  runApp(const MainApp());
}

final game = MochikoRunGame();

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        game: game,
        loadingBuilder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorBuilder: (context, ex) {
          debugPrint(ex.toString());
          return const Center(
            child: Text('Sorry, something went wrong. Reload me'),
          );
        },
        overlayBuilderMap: {
          MainMenu.id: (_, MochikoRunGame gameRef) => MainMenu(gameRef),
          Hud.id: (_, MochikoRunGame gameRef) => Hud(gameRef),
          WonMenu.id: (_, MochikoRunGame gameRef) => WonMenu(gameRef),
          GameOverMenu.id: (_, MochikoRunGame gameRef) => GameOverMenu(gameRef),
        },
        initialActiveOverlays: const [MainMenu.id],
      ),
    );
  }
}
