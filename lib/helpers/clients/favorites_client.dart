import 'package:bloc/bloc.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:teste_pokedex/models/pokemon.dart';

const String tableFavorites = 'favorites';
const String columnId = '_id';
const String columnName = 'name';
const String columnIdPokemon = 'id';
const String columnUrl = 'url';

class FavoritesClient extends BlocBase {
  FavoritesClient() : super(null);

  late Database database;
  Future<Database> get db async => open();

  Future<Database> open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pokedex.db');

    database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $tableFavorites ( 
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
            $columnName TEXT NOT NULL,
            $columnIdPokemon INTEGER NOT NULL,
            $columnUrl TEXT NOT NULL)
          '''
        );
      },
    );
    return database;
  }

  Future<ResultsModel> addFavorite(ResultsModel favorite) async {
    Database _db = await db;
    favorite.id = await _db.insert(tableFavorites, favorite.toJson());
    return favorite;
  }

  Future<bool> isFavorite(int id) async {
    Database _db = await db;
    final List<Map<String, dynamic>> maps = await _db.query(tableFavorites,
      columns: [columnId, columnIdPokemon, columnName, columnUrl],
      where: '$columnIdPokemon = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) return true;
    return false;
  }

  Future<List<ResultsModel>> getAllFavorites() async {
    Database _db = await db;
    final List<Map<String, dynamic>> maps = await _db.query(tableFavorites,
      columns: [columnId, columnIdPokemon, columnName, columnUrl],
    );
    if (maps.isNotEmpty) {
      return maps.map<ResultsModel>((e) => ResultsModel.fromJson({
        'favorited': true,
        'url': e['url'],
        'name': e['name'],
        'id': e['id']
      })).toList();
    }
    return [];
  }

  Future<int> removeFavorite(int id) async {
    Database _db = await db;
    return await _db.delete(tableFavorites, where: '$columnIdPokemon = ?', whereArgs: [id]);
  }

  Future close() async => database.close();
}