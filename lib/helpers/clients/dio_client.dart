import 'package:dio/dio.dart';

int currentPage = 0, lastPage = 0;
class DioClient {
  Dio dio = Dio();

  final String apiUrl = 'https://pokeapi.co/api/v2/pokemon?limit=1154';//'https://pokeapi.co/api/v2/pokemon?offset=0&limit=50';
  String getPokemon(String name) => 'https://pokeapi.co/api/v2/pokemon/$name';

  static String getImageUrl(int id) => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$id.png';
  static String getOriginalImageUrl(int id) => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}