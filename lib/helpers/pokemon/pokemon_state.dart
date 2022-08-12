part of 'pokemon_bloc.dart';

abstract class PokemonState {
  const PokemonState();
  List<ResultsModel> get pokemons => [];
  List<ResultsModel> get favorites => [];
}

class PokemonInitial extends PokemonState {}

class AllPokemonsLoaded extends PokemonState {
  List<ResultsModel> allPokemons = [];

  AllPokemonsLoaded({required this.allPokemons});

  @override
  List<ResultsModel> get pokemons => allPokemons;
}

class AllFavoritesLoaded extends PokemonState {
  List<ResultsModel> allFavorites = [];

  AllFavoritesLoaded({required this.allFavorites});

  @override
  List<ResultsModel> get favorites => allFavorites;
}

class LoadingState extends PokemonState {
  final bool isLoading;
  LoadingState(this.isLoading);
}