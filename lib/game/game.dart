import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:mochiko_run/game/mochiko.dart';
import 'package:mochiko_run/game/pudding_manager.dart';
import 'package:mochiko_run/model/hp.dart';
import 'package:mochiko_run/widgets/game_over_menu.dart';
import 'package:mochiko_run/widgets/hud.dart';
import 'package:mochiko_run/widgets/won_menu.dart';

class MochikoRunGame extends FlameGame with HasCollisionDetection, TapDetector {
  late Map<MochikoState, SpriteAnimation> animations;
  late Mochiko _mochiko;
  late PuddingManager _puddingManager;
  late Hp hp;

  late Timer _positionTimer;

  @override
  Future<void>? onLoad() async {
    hp = Hp();
    _positionTimer = Timer(1, repeat: true, autoStart: false, onTick: () {
      hp.step();
    });
    await loadMochiko();
    // _puddingManager = PuddingManager(hp);

    await images.load('pudding.png');

    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('background/background_1.png'),
        ParallaxImageData('background/background_2.png'),
        ParallaxImageData('background/background_3.png'),
        ParallaxImageData('background/background_4.png'),
        ParallaxImageData('background/background_5.png'),
      ],
      baseVelocity: Vector2(10, 0),
      velocityMultiplierDelta: Vector2(1.4, 0),
    );
    add(parallaxBackground);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _positionTimer.update(dt);
    if (hp.gameOver) {
      overlays.add(GameOverMenu.id);
      overlays.remove(Hud.id);
      pauseEngine();
    } else if (hp.won) {
      overlays.add(WonMenu.id);
      overlays.remove(Hud.id);
      pauseEngine();
    }

    super.update(dt);
  }

  void reset() {
    _positionTimer.reset();
    _disconnectActors();
    print('disconnect');
  }

  void startGamePlay() {
    hp = Hp();
    _positionTimer.start();
    _mochiko = Mochiko(
      hp: hp,
      size: Vector2.all(160),
      animations: animations,
    );
    _puddingManager = PuddingManager(hp);
    add(_puddingManager);
    add(_mochiko);
  }

  void _disconnectActors() {
    _mochiko.removeFromParent();
    _puddingManager.removeAllPudding();
    _puddingManager.removeFromParent();
  }

  loadMochiko() async {
    final walk = await loadSpriteAnimation(
      'mochiko_walk.png',
      SpriteAnimationData.sequenced(
        amount: 16,
        stepTime: .1,
        textureSize: Vector2.all(320),
      ),
    );
    final jump = await loadSpriteAnimation(
      'mochiko_jump.png',
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: .3,
        textureSize: Vector2.all(600),
      ),
    );

    animations = {
      MochikoState.walk: walk,
      MochikoState.jump: jump,
    };
  }

  @override
  void onTap() {
    _mochiko.jump();
    super.onTap();
  }
}
