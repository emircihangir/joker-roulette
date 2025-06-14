import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);

  // Enable full-screen (immersive) mode
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(MyApp());
}

// ignore: non_constant_identifier_names
Widget MyApp() {
  return CupertinoApp(
    home: CupertinoPageScaffold(
      child: Row(
        children: [
          Expanded(child: AnimatedBuilderExample()),
          Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset('assets/joker.svg'))),
          Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset('assets/ace-of-spades.svg'))),
          Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset('assets/ace-of-diamonds.svg'))),
          Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset('assets/ace-of-clubs.svg'))),
          Expanded(child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset('assets/ace-of-hearts.svg'))),
        ],
      ),
    ),
  );
}

class AnimatedBuilderExample extends StatefulWidget {
  const AnimatedBuilderExample({super.key});

  @override
  State<AnimatedBuilderExample> createState() => _AnimatedBuilderExampleState();
}

class _AnimatedBuilderExampleState extends State<AnimatedBuilderExample> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    animationBehavior: AnimationBehavior.preserve,
    vsync: this,
  )..forward();

  late final CurvedAnimation _curvedAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curvedAnimation,
      child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset('assets/joker.svg')),
      builder: (BuildContext context, Widget? child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateY(_controller.value * pi),
          child: child,
        );
      },
    );
  }
}
