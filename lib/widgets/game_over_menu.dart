import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mochiko_run/game/game.dart';
import 'package:mochiko_run/widgets/hud.dart';

class GameOverMenu extends StatelessWidget {
  static const id = 'game over';
  const GameOverMenu(this.gameRef, {Key? key}) : super(key: key);
  final MochikoRunGame gameRef;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          color: Colors.white.withAlpha(0),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Game over',
                    style: GoogleFonts.permanentMarker(
                      fontWeight: FontWeight.w100,
                      fontSize: 55,
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    gameRef.overlays.remove(GameOverMenu.id);
                    gameRef.overlays.add(Hud.id);
                    gameRef.resumeEngine();
                    gameRef.reset();
                    gameRef.startGamePlay();
                  },
                  child: const Text('Retry'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
