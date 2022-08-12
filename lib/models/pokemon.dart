import 'package:flutter/material.dart';
import 'package:teste_pokedex/helpers/clients/dio_client.dart';

class ResultsModel {
  int? id;
  String? name,
          url;
  bool? favorited;

  ResultsModel({this.id, this.name, this.url, this.favorited = false});

  ResultsModel.fromJson(Map<String, dynamic> json) {
    if(json.containsKey('favorited')) {
      favorited = json['favorited'];
    }
    id = int.parse(json['url'].toString().split("/pokemon/")[1].replaceAll("/", ""));
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'url': url,
  };
}
///======================================== POKEMON MODELS ==================================================================
class PokemonModel {
  int? height;
  int? weight;
  int? base_experience;
  String? image;
  List<AbilitiesModel>? abilities;
  AbilityModel? species;
  List<StatsModel>? stats;
  List<TypesModel>? types;

  PokemonModel({this.height, this.weight, this.base_experience, this.species, this.stats, this.abilities, this.types, this.image = ''});

  PokemonModel.fromJson(Map<String, dynamic> json) {

    height = json['height'];
    weight = json['weight'];
    base_experience = json['base_experience'];
    species = json['species'] != null ? AbilityModel.fromJson(json['species']) : null;

    if(json['sprites'] != null && json['sprites']['other']['official-artwork'] != null && json['sprites']['other']['official-artwork']['front_default'] != null) {
      image = json['sprites']['other']['official-artwork']['front_default'];
    } else if(json['sprites'] != null && json['sprites']['other']['home'] != null && json['sprites']['other']['home']['front_default'] != null) {
      image = json['sprites']['other']['home']['front_default'];
    }
    
    if (json['stats'] != null) {
      stats = <StatsModel>[];
      json['stats'].forEach((v) {
        stats!.add(StatsModel.fromJson(v));
      });
    }
    if (json['abilities'] != null) {
      abilities = <AbilitiesModel>[];
      json['abilities'].forEach((v) {
        abilities!.add(AbilitiesModel.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <TypesModel>[];
      json['types'].forEach((v) {
        types!.add(TypesModel.fromJson(v));
      });
    }
  }
}

class AbilitiesModel {
  AbilityModel? ability;
  bool? isHidden;
  int? slot;

  AbilitiesModel({this.ability, this.isHidden, this.slot});

  AbilitiesModel.fromJson(Map<String, dynamic> json) {
    ability = json['ability'] != null ? AbilityModel.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }
}

class AbilityModel {
  String? name;
  String? url;

  AbilityModel({this.name, this.url});

  AbilityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class StatsModel {
  int? baseStat;
  int? effort;
  AbilityModel? stat;

  StatsModel({this.baseStat, this.effort, this.stat});

  StatsModel.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? AbilityModel.fromJson(json['stat']) : null;
  }
}

class TypesModel {
  int? slot;
  AbilityModel? type;

  TypesModel({this.slot, this.type});

  TypesModel.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    type = json['type'] != null ? AbilityModel.fromJson(json['type']) : null;
  }
}