import 'package:bloc/bloc.dart';
import 'package:teste_pokedex/helpers/clients/favorites_client.dart';
import 'package:teste_pokedex/helpers/clients/pokemon_client.dart';
import 'package:teste_pokedex/models/pokemon.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {

  FavoritesClient favoritesClient = FavoritesClient();

  PokemonClient pokemonClient = PokemonClient();

  PokemonModel? pokemon = PokemonModel();

  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsEvent>((event, emit) {});

    on<GetDetailsEvent>((event, emit) async {
      emit(LoadingState(true));

      pokemon = await pokemonClient.getPokemonData(event.url);

      emit(LoadingState(false));

      emit(PokemonFeaturesState(
        pokemon: pokemon!,
      ));
    });
  }
}