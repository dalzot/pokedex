import 'package:flutter/material.dart';
import 'package:teste_pokedex/constants/colors.dart';
import 'package:teste_pokedex/widgets/texts.dart';

class PokeballLoading extends StatelessWidget {
  final Color textColor;
  const PokeballLoading({this.textColor = colorWhite, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 64,
            width: 64,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset("assets/pokeball.png",
                    fit: BoxFit.fill,
                    height: 64,
                    width: 64,
                  ),
                ),
                const SizedBox(
                  height: 64,
                  width: 64,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    backgroundColor: colorGreyShadow,
                    valueColor: AlwaysStoppedAnimation(colorYellow),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: TextComponent("Carregando Pokédex...", textColor: textColor),
          ),
        ],
      ),
    );
  }
}

class ImageLoading extends StatelessWidget {
  final double? progress;
  const ImageLoading({this.progress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 64,
        width: 64,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset("assets/pokeball.png",
                fit: BoxFit.fill,
                height: 64,
                width: 64,
              ),
            ),
            SizedBox(
              height: 64,
              width: 64,
              child: progress != null ? CircularProgressIndicator(
                value: progress!,
                strokeWidth: 6,
                backgroundColor: colorGreyShadow,
                valueColor: const AlwaysStoppedAnimation(colorYellow),
              ) : const CircularProgressIndicator(
                strokeWidth: 6,
                backgroundColor: colorGreyShadow,
                valueColor: AlwaysStoppedAnimation(colorYellow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}