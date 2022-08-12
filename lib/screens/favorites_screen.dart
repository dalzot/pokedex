import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_pokedex/constants/colors.dart';
import 'package:teste_pokedex/helpers/pokemon/pokemon_bloc.dart';
import 'package:teste_pokedex/models/pokemon.dart';
import 'package:teste_pokedex/screens/loading_screen.dart';
import 'package:teste_pokedex/widgets/pokemon/pokemon_card.dart';
import 'package:teste_pokedex/widgets/texts.dart';
import 'pokemon_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  @override
  void initState() {
    BlocProvider.of<PokemonBloc>(context).add(GetFavoritesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state){
        if(state is AllFavoritesLoaded) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 84,
              backgroundColor: colorGreyShadow,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Image.asset("assets/pokeball_64.png", height: 32),
                  ),
                  TextComponent("Favoritos", fontSize: 32, fontWeight: FontWeight.bold),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Image.asset("assets/pokeball_64.png", height: 32),
                  ),
                ],
              ),
              actions: const [
                IconButton(
                  icon: Icon(Icons.filter_list_rounded, color: Colors.transparent),
                  onPressed: null,
                )
              ],
            ),
            body: state.favorites.length == 0 ? EmptyList(context) :
            SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    itemCount: state.favorites.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PokemonScreen(state.favorites[index], fromFavoriteScreen: true)),
                          );
                          BlocProvider.of<PokemonBloc>(context).add(GetFavoritesEvent());
                        },
                        child: PokemonCard(state.favorites[index], index, fromFavoriteScreen: true),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const LoadingScreen();//textColor: colorGreyShadow
      },
    );
  }

  Widget EmptyList(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<PokemonBloc>(context).add(GetFavoritesEvent());
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextComponent("Não conseguimos encontrar os Pokémon :(\nTente novamente mais tarde",
              textColor: colorGreyShadow,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextComponent("Clique aqui para atualizar",
                textColor: colorBlue,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
