import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mochiko_run/game/game.dart';
import 'package:mochiko_run/game/mochiko.dart';

class Pudding extends SpriteAnimationComponent
    with HasGameRef<MochikoRunGame>, CollisionCallbacks {
  Pudding({
    required Vector2 size,
    required this.model,
  }) : super(
          size: size,
        ) {
    _height = _random.nextDouble() * 9 * model.textureSize.y;
  }
  final PuddingModel model;

  final Random _random = Random();

  late double _height;

  @override
  void update(double dt) {
    position.x -= model.speedX * dt;
    if (position.x < -model.textureSize.x) {
      removeFromParent();
    }

    super.update(dt);
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    position.x = gameRef.size.x - 32;
    position.y = gameRef.size.y - 80 - _height;
    animation = SpriteAnimation.fromFrameData(
      gameRef.images.fromCache('pudding.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 10,
        textureSize: Vector2.all(300),
      ),
    );

    add(RectangleHitbox(position: Vector2.all(10), size: Vector2.all(20)));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Mochiko) {
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onGameResize(Vector2 size) {
    position.y = gameRef.size.y - 80 - _height;
    super.onGameResize(size);
  }
}

class PuddingModel {
  // final Image image;
  // final int nFrames;
  // final double stepTime;
  final Vector2 textureSize;
  final double speedX;

  const PuddingModel({
    // required this.image,
    // required this.nFrames,
    // required this.stepTime,
    required this.textureSize,
    required this.speedX,
  });
}
