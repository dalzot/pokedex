import 'package:flutter/material.dart';
import 'package:teste_pokedex/constants/colors.dart';
import 'package:teste_pokedex/widgets/pokeball_loading.dart';
import 'package:teste_pokedex/widgets/texts.dart';
import 'dart:ui' as ui;

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimaryDark,
      body: Center(
        child: Stack(
          children: [
            Positioned(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              bottom: 225,
              left: 50,
              child: PokedexCircles(),
            ),
            CustomPaint(
              size: Size.copy(MediaQuery.of(context).size),
              painter: PokedexLines(),
            ),
            const PokeballLoading(),
          ],
        ),
      ),
    );
  }
}

class PokedexLines extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    const pointMode = ui.PointMode.polygon;
    final points = [
      const Offset(50, 150),
      const Offset(50, 600),
      Offset(size.width-50, 600),
      Offset(size.width-50, 110),
      Offset((size.width/2)+50, 110),
      Offset((size.width/2)-50, 150),
      const Offset(50, 150),
    ];
    final paint = Paint()
      ..color = colorGreyShadow
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

Widget PokedexCircles() {
  return SizedBox(
    height: 32,
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: colorGreyShadow,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: colorWhite,
            child: CircleAvatar(
              backgroundColor: colorGreyShadow,
              radius: 19,
              child: CircleAvatar(
                backgroundColor: colorBlue,
                radius: 18,
                child: Stack(
                  children: const [
                    Positioned(
                      top: 5,
                      left: 5,
                      child: CircleAvatar(
                        backgroundColor: colorGreyShadow,
                        radius: 6,
                        child: CircleAvatar(
                          backgroundColor: colorBlueLight,
                          radius: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ), // Blue
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 24),
          child: CircleAvatar(
            radius: 9,
            backgroundColor: colorGreyShadow,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: colorRed,
              child: Stack(
                children: const [
                  Positioned(
                    top: 2,
                    left: 2,
                    child: CircleAvatar(
                      backgroundColor: colorGreyShadow,
                      radius: 3,
                      child: CircleAvatar(
                        backgroundColor: colorRedLight,
                        radius: 2.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ), // Red
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 24),
          child: CircleAvatar(
            radius: 9,
            backgroundColor: colorGreyShadow,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: colorYellow2,
              child: Stack(
                children: const [
                  Positioned(
                    top: 2,
                    left: 2,
                    child: CircleAvatar(
                      backgroundColor: colorGreyShadow,
                      radius: 3,
                      child: CircleAvatar(
                        backgroundColor: colorYellow2Light,
                        radius: 2.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ), // Yellow
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 24),
          child: CircleAvatar(
            radius: 9,
            backgroundColor: colorGreyShadow,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: colorGreen,
              child: Stack(
                children: const [
                  Positioned(
                    top: 2,
                    left: 2,
                    child: CircleAvatar(
                      backgroundColor: colorGreyShadow,
                      radius: 3,
                      child: CircleAvatar(
                        backgroundColor: colorGreenLight,
                        radius: 2.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ), // Yellow
      ],
    ),
  );
}

