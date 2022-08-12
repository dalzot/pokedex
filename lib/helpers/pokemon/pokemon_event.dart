part of 'pokemon_bloc.dart';

abstract class PokemonEvent {
  const PokemonEvent();
}

class GetPokemonEvent extends PokemonEvent {
  final int page;
  GetPokemonEvent(this.page);
}

class GetFilteredEvent extends PokemonEvent {
  final int page;
  final String filter;
  GetFilteredEvent(this.page, {this.filter = ''});
}

class GetFavoritesEvent extends PokemonEvent {
  GetFavoritesEvent();
}

class GetPokemonDataEvent extends PokemonEvent {
  final String url;
  GetPokemonDataEvent(this.url);
}

class AddPokemonFavoriteEvent extends PokemonEvent {
  final ResultsModel pokemon;
  AddPokemonFavoriteEvent(this.pokemon);
}

class AddFromFavoriteEvent extends PokemonEvent {
  final ResultsModel pokemon;
  AddFromFavoriteEvent(this.pokemon);
}

class RemovePokemonFavoriteEvent extends PokemonEvent {
  final ResultsModel pokemon;
  RemovePokemonFavoriteEvent(this.pokemon);
}

class RemoveFromFavoriteEvent extends PokemonEvent {
  final ResultsModel pokemon;
  RemoveFromFavoriteEvent(this.pokemon);
}