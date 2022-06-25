import 'package:flame/components.dart';
import 'package:mochiko_run/game/game.dart';
import 'package:mochiko_run/game/pudding.dart';
import 'package:mochiko_run/model/hp.dart';

class PuddingManager extends Component with HasGameRef<MochikoRunGame> {
  PuddingManager(this.hp);
  final Hp hp;

  void spawnPudding() {
    final pudding = Pudding(
      size: Vector2(40, 40),
      model: PuddingModel(
        textureSize: Vector2(30, 30),
        speedX: 300 + hp.currentPosition * 8,
      ),
    );
    gameRef.add(pudding);
  }

  late Timer _timer;

  @override
  Future<void>? onLoad() async {
    _timer = Timer(2, repeat: true, onTick: () {
      spawnPudding();
    });

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  removeAllPudding() {
    final puddings = gameRef.children.whereType<Pudding>();
    for (final p in puddings) {
      p.removeFromParent();
    }
  }
}
