import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mochiko_run/game/game.dart';
import 'package:mochiko_run/game/pudding.dart';
import 'package:mochiko_run/model/hp.dart';

enum MochikoState { walk, jump }

class Mochiko extends SpriteAnimationGroupComponent<MochikoState>
    with HasGameRef<MochikoRunGame>, CollisionCallbacks {
  Mochiko({
    required this.hp,
    required Vector2 size,
    required Map<MochikoState, SpriteAnimation> animations,
  }) : super(
          size: size,
          animations: animations,
          current: MochikoState.walk,
        );

  // The max distance from top of the screen beyond which
  // dino should never go. Basically the screen height - ground height
  double _yMax = 0.0;

  // Dino's current speed along y-axis.
  double _speedY = 0.0;
  static const gravity = 1200.0;

  bool get isOnGround => (y >= _yMax);

  final Hp hp;

  final Timer _hpTimer = Timer(1, repeat: true);

  final Timer _hitTimer = Timer(1);
  bool isHit = false;

  @override
  Future<void>? onLoad() {
    position = Vector2(32, gameRef.size.y - size.y - 16);
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Pudding && !isHit) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    hp.getPudding();
    isHit = true;
    _hitTimer.start();
  }

  @override
  void onGameResize(Vector2 size) {
    position = Vector2(32, size.y - this.size.y - 16);
    _yMax = y;
    super.onGameResize(size);
  }

  @override
  void onMount() {
    _yMax = y;
    add(RectangleHitbox(
      position: Vector2(40, 20),
      size: Vector2(80, 140),
    ));
    _hitTimer.onTick = () {
      isHit = false;
    };
    _hpTimer.onTick = () {
      hp.lostHp(2);
    };

    super.onMount();
  }

  void jump() {
    if (isOnGround) {
      _speedY = -700;
      current = MochikoState.jump;
    }
  }

  @override
  void update(double dt) {
    // v = u + at
    _speedY += gravity * dt;
    // d = s0 + s * t
    y += _speedY * dt;

    if (isOnGround) {
      y = _yMax;
      _speedY = 0.0;
      current = MochikoState.walk;
    }
    _hitTimer.update(dt);
    _hpTimer.update(dt);

    super.update(dt);
  }
}
