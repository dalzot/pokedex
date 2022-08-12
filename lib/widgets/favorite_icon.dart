import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_pokedex/constants/colors.dart';
import 'package:teste_pokedex/helpers/clients/favorites_client.dart';
import 'package:teste_pokedex/helpers/pokemon/pokemon_bloc.dart';
import 'package:teste_pokedex/models/pokemon.dart';

class FavoriteIcon extends StatelessWidget {
  final ResultsModel pokemon;
  final bool inAppBar, fromFavoriteScreen;
  FavoriteIcon(this.pokemon, {this.inAppBar = true, this.fromFavoriteScreen = false, Key? key}) : super(key: key);

  FavoritesClient favoritesClient = FavoritesClient();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(pokemon.favorited! ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: pokemon.favorited! ? inAppBar ? colorWhite : colorPrimary : inAppBar ? colorWhiteShadow.withOpacity(0.5) : colorGrey.withOpacity(0.15)),
          onPressed: () async {
            if(!pokemon.favorited!) {
              BlocProvider.of<PokemonBloc>(context).add(fromFavoriteScreen ? AddFromFavoriteEvent(pokemon) : AddPokemonFavoriteEvent(pokemon));
              ResultsModel f = await favoritesClient.addFavorite(ResultsModel(
                favorited: true,
                name: pokemon.name,
                url: pokemon.url,
                id: pokemon.id,
              ));
            } else {
              BlocProvider.of<PokemonBloc>(context).add(fromFavoriteScreen ? RemoveFromFavoriteEvent(pokemon) : RemovePokemonFavoriteEvent(pokemon));
              int i = await favoritesClient.removeFavorite(pokemon.id!);
            }
          },
        );
      },
    );
  }
}
