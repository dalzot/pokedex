import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_pokedex/constants/colors.dart';
import 'package:teste_pokedex/constants/values.dart';
import 'package:teste_pokedex/extensions/string_extensions.dart';
import 'package:teste_pokedex/helpers/clients/dio_client.dart';
import 'package:teste_pokedex/helpers/details/details_bloc.dart';
import 'package:teste_pokedex/helpers/pokemon/pokemon_bloc.dart';
import 'package:teste_pokedex/models/pokemon.dart';
import 'package:teste_pokedex/screens/loading_screen.dart';
import 'package:teste_pokedex/widgets/favorite_icon.dart';
import 'package:teste_pokedex/widgets/pokeball_loading.dart';
import 'package:teste_pokedex/widgets/texts.dart';

class PokemonScreen extends StatefulWidget {
  final ResultsModel pokemon;
  final bool fromFavoriteScreen;
  const PokemonScreen(this.pokemon, {this.fromFavoriteScreen = false, Key? key}) : super(key: key);

  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {

  @override
  void initState() {
    BlocProvider.of<DetailsBloc>(context).add(GetDetailsEvent(widget.pokemon.url!));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state){
        if(state is PokemonFeaturesState) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: GetColorByType(state.pokemon.types![0].type!.name!).withOpacity(0.75),
              centerTitle: true,
              title: TextComponent("# ${widget.pokemon.id!.toString().padLeft(3, "0")}", fontWeight: FontWeight.bold),
              actions: [
                FavoriteIcon(widget.pokemon, fromFavoriteScreen: widget.fromFavoriteScreen),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 276,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 276,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: GetColorByType(state.pokemon.types![0].type!.name!).withOpacity(0.75),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(32),
                                bottomRight: Radius.circular(32),
                              )
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: 256,
                            child: state.pokemon.image != '' ? CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: state.pokemon.image.toString(),
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  ImageLoading(progress: downloadProgress.progress),
                              errorWidget: (context, url, error) => Image.asset('assets/pokeball_64.png',
                                color: Colors.white.withOpacity(0.25),
                              ),
                            ) : Image.asset('assets/pokeball_64.png',
                              color: Colors.white.withOpacity(0.25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextComponent(widget.pokemon.name!.firstUpperCase(),
                    textColor: colorGreyShadow,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-16,
                    height: 48,
                    child: Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.pokemon.types!.length,
                        itemBuilder: (context,index) {
                          var data = state.pokemon.types![index];
                          return ItemType(data);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: TextComponent("Altura", textColor: colorGreyLight, fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: TextComponent("Peso", textColor: colorGreyLight, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: TextComponent("${formatValue(state.pokemon.height!)} M",
                            textColor: colorGreyShadow,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: TextComponent("${formatValue(state.pokemon.weight!)} KG",
                            textColor: colorGreyShadow,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  TextComponent("Habilidades", textColor: colorGreyLight),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-16,
                    height: 48,
                    child: Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.pokemon.abilities!.length,
                        itemBuilder: (context,index) {
                          var data = state.pokemon.abilities![index];
                          return ItemAbility(data);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  TextComponent("Estatísticas", textColor: colorGreyLight),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-16,
                    child: Center(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.pokemon.stats!.length,
                        itemBuilder: (context,index) {
                          var data = state.pokemon.stats![index];
                          return ItemStats(data);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width-16,
                    child: ItemStats(StatsModel(
                      baseStat: state.pokemon.base_experience,
                      stat: AbilityModel(
                        name: "EXP"
                      )
                    )),
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          );
        }
        return const LoadingScreen();
      },
    );
  }

  Widget ItemAbility(AbilitiesModel item) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 128,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: colorGreyLight, width: 2)
        ),
        child: Center(
          child: TextComponent("${item.ability!.name!.firstUpperCase()}",
            textColor: colorGreyMid, textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget ItemType(TypesModel item) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 128,
        decoration: BoxDecoration(
          color: GetColorByType(item.type!.name!).withOpacity(0.75),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: colorGrey, width: 2),
        ),
        child: Center(
          child: TextComponent("${item.type!.name!.firstUpperCase()}",
          textColor: colorWhite,
            textAlign:
            TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget ItemStats(StatsModel item) {
    double percent = item.baseStat! / (item.stat!.name! == "EXP" ? maxEXP : maxHP);
    bool small = percent < 0.1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 96,
            child: TextComponent(item.stat!.name!.replaceAll("special-", "S. ").toUpperCase(),
              textColor: colorGreyShadow,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Stack(
            children: [
              Container(
                width: 256,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: colorGrey, width: 2),
                ),
              ),
              Padding(
                padding: small ? EdgeInsets.symmetric(vertical: 6, horizontal: 2) : EdgeInsets.all(2),
                child: Container(
                  width: percent * 256,
                  height: small ? 20 : 28,
                  decoration: BoxDecoration(
                    color: GetColorByStats(item.stat!.name!),
                    borderRadius: BorderRadius.circular(small ? 360 : 32),
                  ),
                ),
              ),
              SizedBox(
                width: 256,
                height: 32,
                child: Center(
                  child: TextComponent("${item.baseStat} / ${item.stat!.name! == "EXP" ? maxEXP : maxHP}",
                    textColor: colorWhite,
                    textAlign:
                    TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatValue(int d) {
    if(d.toString().length > 1) return "${d.toString().substring(0,d.toString().length-1)}."
        "${d.toString().substring(d.toString().length-1)}";
    return d.toString();
  }
}
