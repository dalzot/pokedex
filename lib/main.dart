import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_pokedex/helpers/details/details_bloc.dart';
import 'package:teste_pokedex/helpers/pokemon/pokemon_bloc.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => PokemonBloc()),
        BlocProvider(
            create: (context) => DetailsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokédex',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

/*
    Projeto desenvolvido por Matheus Dal Zot Nora para o teste de desenvolvedor Flutter Pleno.
    E-mail: matheusnora.unoesc@gmail.com
    Linkedin: https://www.linkedin.com/in/matheus-dal-zot-nora-408523177/
    Instagram: https://www.instagram.com/_dalzot
    Github: https://github.com/dalzot/pokedex

    Projeto foi desenvolvido em cima do Emulador Nexus 5X API 30
*/