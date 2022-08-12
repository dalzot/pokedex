import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_pokedex/constants/colors.dart';
import 'package:teste_pokedex/helpers/pokemon/pokemon_bloc.dart';
import 'package:teste_pokedex/widgets/texts.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {

  var filterTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    filterTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 352,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32)
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextComponent("Buscar na Pokédex",
                          textColor: colorBlue, fontSize: 24, fontWeight: FontWeight.bold,
                          textAlign: TextAlign.start
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.clear, color: colorGreyShadow),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(color: colorBlue, height: 24, thickness: 2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextComponent("Nome ou ID do Pokémon", textColor: colorBlue, fontSize: 16, textAlign: TextAlign.start),
                      ],
                    ),
                  ),
                  TextField(
                    controller: filterTextController,
                    style: const TextStyle(color: colorBlue, fontSize: 18),
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: colorGreyLight, fontSize: 16),
                      hintText: "bulbasaur / 1",
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: colorBlue),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: colorGrey),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.backspace_rounded, color: colorGreyShadow),
                        onPressed: () {
                          BlocProvider.of<PokemonBloc>(context).add(GetFilteredEvent(0, filter: ''));
                        },
                      )
                    ),
                    cursorColor: colorBlue,
                  ),
                  const SizedBox(height: 16),
                  FilterButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget FilterButton(BuildContext context) {
    return SizedBox(
      height: 64,
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<PokemonBloc>(context).add(GetFilteredEvent(0, filter: filterTextController.text.trim()));
          Navigator.pop(context);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          color: colorPrimary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: TextComponent("Pesquisar",
                fontWeight: FontWeight.bold,
                textColor: colorWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
