import 'package:bloc/bloc.dart';
import 'package:teste_pokedex/helpers/clients/dio_client.dart';
import 'package:teste_pokedex/helpers/clients/favorites_client.dart';
import 'package:teste_pokedex/helpers/clients/pokemon_client.dart';
import 'package:teste_pokedex/models/pokemon.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {

  FavoritesClient favoritesClient = FavoritesClient();
  PokemonClient pokemonClient = PokemonClient();

  List<ResultsModel>? allPokemons = [];
  List<ResultsModel>? allFavorites = [];


  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonEvent>((event, emit) {});

    on<GetPokemonEvent>((event, emit) async {
      emit(LoadingState(true));

      allPokemons = await pokemonClient.getPokemonsResults(page: event.page);
      currentPage = event.page;

      emit(LoadingState(false));
      emit(AllPokemonsLoaded(allPokemons: allPokemons!));
    });

    on<GetFilteredEvent>((event, emit) async {
      emit(LoadingState(true));

      allPokemons = await pokemonClient.filterPokemons(page: event.page, filter: event.filter);
      currentPage = event.page;

      emit(LoadingState(false));
      emit(AllPokemonsLoaded(allPokemons: allPokemons!));
    });

    on<GetFavoritesEvent>((event, emit) async {
      emit(LoadingState(true));

      allFavorites = await favoritesClient.getAllFavorites();

      emit(LoadingState(false));
      emit(AllFavoritesLoaded(allFavorites: allFavorites!));
    });

    on<AddPokemonFavoriteEvent>((event, emit) async {
      int index = allPokemons!.indexOf(event.pokemon);
      allPokemons![index].favorited = true;
      emit(AllPokemonsLoaded(allPokemons: allPokemons!));
    });

    on<AddFromFavoriteEvent>((event, emit) async {
      event.pokemon.favorited = true;
      allFavorites!.add(event.pokemon);
      emit(AllFavoritesLoaded(allFavorites: allFavorites!));
    });

    on<RemovePokemonFavoriteEvent>((event, emit) async {
      int index = allPokemons!.indexOf(event.pokemon);
      allPokemons![index].favorited = false;
      emit(AllPokemonsLoaded(allPokemons: allPokemons!));
    });

    on<RemoveFromFavoriteEvent>((event, emit) async {
        int index = allFavorites!.indexOf(event.pokemon);
        allFavorites![index].favorited = false;
        allFavorites!.removeAt(index);
        emit(AllFavoritesLoaded(allFavorites: allFavorites!));
    });
  }
}