import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mochiko_run/game/game.dart';
import 'package:mochiko_run/widgets/hud.dart';

class MainMenu extends StatelessWidget {
  static const id = 'main';
  const MainMenu(this.gameRef, {Key? key}) : super(key: key);
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
                    'mochiko walk',
                    style: GoogleFonts.permanentMarker(
                      fontWeight: FontWeight.w100,
                      fontSize: 55,
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '~ Road to Tokyo ~',
                    style: GoogleFonts.permanentMarker(
                      fontWeight: FontWeight.w100,
                      fontSize: 22,
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    gameRef.overlays.remove(MainMenu.id);
                    gameRef.overlays.add(Hud.id);
                    gameRef.startGamePlay();
                  },
                  child: const Text('Play'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
