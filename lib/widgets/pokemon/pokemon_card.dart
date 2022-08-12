import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teste_pokedex/constants/colors.dart';
import 'package:teste_pokedex/extensions/string_extensions.dart';
import 'package:teste_pokedex/helpers/clients/dio_client.dart';
import 'package:teste_pokedex/models/pokemon.dart';
import 'package:teste_pokedex/widgets/favorite_icon.dart';
import 'package:teste_pokedex/widgets/pokeball_loading.dart';
import 'package:teste_pokedex/widgets/texts.dart';

class PokemonCard extends StatelessWidget {
  final int index;
  final ResultsModel pokemon;
  final bool fromFavoriteScreen;
  const PokemonCard(this.pokemon, this.index, {this.fromFavoriteScreen = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),),
          elevation: 4,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: colorGreyShadow,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: TextComponent("Nº${pokemon.id}", fontSize: 16),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: FavoriteIcon(pokemon, inAppBar: false, fromFavoriteScreen: fromFavoriteScreen),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 128,
                      width: 128,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: DioClient.getOriginalImageUrl(pokemon.id!),
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            ImageLoading(progress: downloadProgress.progress),
                        errorWidget: (context, url, error) => Image.asset('assets/pokeball_64.png',
                          color: Colors.white.withOpacity(0.25),
                        ),
                      ),
                    ),
                    TextComponent(pokemon.name!.firstUpperCase(), fontSize: 20, textColor: colorBlue),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
