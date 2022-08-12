import 'package:dio/dio.dart';
import 'package:teste_pokedex/models/pokemon.dart';
import 'dio_client.dart';
import 'favorites_client.dart';

Map<int, List<ResultsModel>> filteredPokemons = {};
Map<int, List<ResultsModel>> pokemonsMemory = {};

List<ResultsModel> allPokemonsMemory = [];
List<AbilitiesModel> abilitiesMemory = [];
class PokemonClient extends DioClient {

  Future<List<ResultsModel>>? getPokemonsResults({int page = 0}) async {
    try {
      currentPage = page;
      if(pokemonsMemory.isNotEmpty && pokemonsMemory.containsKey(page)) {
        return pokemonsMemory[page]!;
      }

      pokemonsMemory = {};
      List<ResultsModel> pokemonsList = [];
      Map<int, List<ResultsModel>> paginatedPokemons = {};

      final Response response = await dio.get(apiUrl);

      List results = response.data['results'] as List;
      int p = 0, qtd = 0;
      for(var m in results) {
        ResultsModel r = ResultsModel.fromJson(m as Map<String, dynamic>);
        r.favorited = await FavoritesClient().isFavorite(r.id!);
        if(qtd == 50) {
          paginatedPokemons.addAll({p: pokemonsList});
          pokemonsList = [];
          qtd = 0;
          p++;
        }
        pokemonsList.add(r);
        qtd ++;
        // Armazenar todos os Pokemons para filtrar
        allPokemonsMemory.add(r);
      }
      if(pokemonsList.isNotEmpty) {
        lastPage = p;
        paginatedPokemons.addAll({p: pokemonsList});
      }

      if(paginatedPokemons.isNotEmpty) {
        pokemonsMemory = paginatedPokemons;
      }
      return paginatedPokemons[0]!;
    } catch(e,st) {
      print("getPokemonsResults.Exception: $e\n$st");
      return [];
    }
  }

  Future<List<ResultsModel>>? filterPokemons({int page = 0, String filter = ''}) async {
    try {
      filteredPokemons = pokemonsMemory;
      currentPage = page;

      List<ResultsModel> pokemonsList = [];
      Map<int, List<ResultsModel>> paginatedPokemons = {};

      List<ResultsModel> results = allPokemonsMemory.where((p) =>
      p.id.toString().contains(filter) ||
          p.name.toString().toLowerCase().contains(filter.toLowerCase())
      ).toList();

      int p = 0, qtd = 0;
      for(ResultsModel r in results) {
        if(qtd == 50) {
          paginatedPokemons.addAll({p: pokemonsList});
          pokemonsList = [];
          qtd = 0;
          p++;
        }
        pokemonsList.add(r);
        qtd ++;
      }

      if(pokemonsList.isNotEmpty) {
        lastPage = p;
        paginatedPokemons.addAll({p: pokemonsList});
      }

      if(paginatedPokemons.isNotEmpty) filteredPokemons = paginatedPokemons;
      return paginatedPokemons[page]!;
    } catch(e,st) {
      print("getPokemonsResults.Exception: $e\n$st");
      return [];
    }
  }

  Future<PokemonModel?>? getPokemonData(String url) async {
    try {
      final Response response = await dio.get(url);

      return PokemonModel.fromJson(response.data);
    } catch(e,st) {
      print("getPokemonData.Exception: $e\n$st");
      return null;
    }
  }
}