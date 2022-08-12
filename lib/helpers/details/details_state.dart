part of 'details_bloc.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class PokemonFeaturesState extends DetailsState {
  PokemonModel pokemon;

  PokemonFeaturesState({
    required this.pokemon
  });
}

class LoadingState extends DetailsState {
  final bool isLoading;
  LoadingState(this.isLoading);
}