import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_pokedex/constants/colors.dart';
import 'package:teste_pokedex/helpers/clients/dio_client.dart';
import 'package:teste_pokedex/helpers/pokemon/pokemon_bloc.dart';
import 'package:teste_pokedex/screens/dialog/filter_dialog.dart';
import 'package:teste_pokedex/screens/favorites_screen.dart';
import 'package:teste_pokedex/screens/loading_screen.dart';
import 'package:teste_pokedex/widgets/pokemon/pokemon_card.dart';
import 'package:teste_pokedex/widgets/texts.dart';
import 'pokemon_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    initialData();
    super.initState();
  }

  void initialData() => BlocProvider.of<PokemonBloc>(context).add(GetPokemonEvent(0));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state){
        if(state is AllPokemonsLoaded) {
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
                  TextComponent("Pokédex", fontSize: 32, fontWeight: FontWeight.bold),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Image.asset("assets/pokeball_64.png", height: 32),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list_rounded, color: colorWhite),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const FilterDialog(),
                    );
                  },
                ),
              ],
              leading: IconButton(
                icon: const Icon(Icons.favorite_rounded, color: colorPrimary),
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const FavoritesScreen()),
                  );
                  BlocProvider.of<PokemonBloc>(context).add(GetPokemonEvent(currentPage));
                },
              ),
            ),
            body: state.pokemons.length == 0 ? EmptyList(context) :
            SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    itemCount: state.pokemons.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PokemonScreen(state.pokemons[index]),
                            ),
                          );
                        },
                        child: PokemonCard(state.pokemons[index], index),
                      );
                    },
                  ),
                  if(state.pokemons.length > 49) Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0, top: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PageButton(context, "Anterior", false),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: currentPage == 0 ? null : () => initialData(),
                            child: SizedBox(
                              height: 32,
                              width: 32,
                              child: Image.asset('assets/pokeball_64.png', fit: BoxFit.fill,
                                color: currentPage == 0 ? Colors.white.withOpacity(0.3) : Colors.white,
                                colorBlendMode: BlendMode.modulate,
                              ),
                            ),
                          ),
                        ),
                        PageButton(context, "Próxima", true),
                      ],
                    ),
                  )
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
        BlocProvider.of<PokemonBloc>(context).add(GetPokemonEvent(0));
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

  Widget PageButton(BuildContext context, String title, bool isNext) {
    bool enabled = (isNext && currentPage < lastPage) || (!isNext && currentPage > 0);
    return Expanded(
      child: GestureDetector(
        onTap: enabled ? () {
          if(isNext && currentPage < lastPage) {
            BlocProvider.of<PokemonBloc>(context).add(GetPokemonEvent(currentPage + 1));
          } else if(!isNext && currentPage > 0) {
            BlocProvider.of<PokemonBloc>(context).add(GetPokemonEvent(currentPage - 1));
          }
        } : null,
        child: Card(
          color: enabled ? colorPrimary : colorGreyLight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: TextComponent(title,
                fontWeight: enabled ? FontWeight.bold : FontWeight.w400,
                textColor: colorWhiteShadow,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
