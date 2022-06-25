import 'package:flutter/material.dart';
import 'package:mochiko_run/game/game.dart';
import 'package:mochiko_run/model/hp.dart';
import 'package:provider/provider.dart';

class Hud extends StatelessWidget {
  static const id = 'hud';
  final MochikoRunGame gameRef;

  const Hud(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Hp>.value(
      value: gameRef.hp,
      child: Card(
        color: Colors.black.withAlpha(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Selector<Hp, int>(
                selector: (context, hp) => hp.hp,
                builder: (context, hp, child) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'LIFE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.lightGreen,
                        value: hp.toDouble() / Hp.maxHp.toDouble(),
                      ),
                    ),
                  ],
                ),
              ),
              Selector<Hp, int>(
                selector: (context, hp) => hp.currentPosition,
                builder: (context, current, child) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Start',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.pink,
                        value: current.toDouble() / Hp.goal,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Goal',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
