import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xFFE8534F);
const Color colorPrimaryDark = Color(0xFFCF3935);
const Color colorWhite = Color(0xFFF3F3F3);
const Color colorWhiteShadow = Color(0xFFE6E6E6);
const Color colorGreyLight = Color(0xFFA3A6AD);
const Color colorGrey = Color(0xFF536670);
const Color colorGreyMid = Color(0xFF4D585D);
const Color colorGreyShadow = Color(0xFF313D43);
const Color colorYellow = Color(0xFFFECA1B);
const Color colorBlue = Color(0xFF3761A8);
const Color colorBlueLight = Color(0xFFC5CDE0);
const Color colorGreen = Color(0xFF228C4D);
const Color colorGreenLight = Color(0xFFC5EDC6);
const Color colorYellow2 = Color(0xFFF7EA35);
const Color colorYellow2Light = Color(0xFFFDFD8E);
const Color colorRed = Color(0xFFE02528);
const Color colorRedLight = Color(0xFFFFB6B3);

const Color colorBarHP = Color(0xFFd23b47);
const Color colorBarATK = Color(0xFFfda827);
const Color colorBarSATK = Color(0xFFdda857);
const Color colorBarDEF = Color(0xFF0091eb);
const Color colorBarSDEF = Color(0xFF0591ab);
const Color colorBarSPEED = Color(0xFF8eb0c4);
const Color colorBarEXP = Color(0xFF378d42);

const Color typeBug = Color(0xFF729f3f);
const Color typeDragonA = Color(0xFF53a4cf);
const Color typeDragonB = Color(0xFFf16e57);
const Color typeFairy = Color(0xFFfdb9e9);
const Color typeFire = Color(0xFFfd7d24);
const Color typeGhost = Color(0xFF7b61a2);
const Color typeGroundA = Color(0xFFf7de3f);
const Color typeGroundB = Color(0xFFab9842);
const Color typeNormal = Color(0xFFa4acaf);
const Color typePsychic = Color(0xFFf366b9);
const Color typeSteel = Color(0xFF9eb7b8);
const Color typeDark = Color(0xFF616161);
const Color typeElectric = Color(0xFFeed535);
const Color typeFighting = Color(0xFFd46722);
const Color typeFlyingA = Color(0xFF3dc7ef);
const Color typeFlyingB = Color(0xFFbdb9b8);
const Color typeGrass = Color(0xFF9bcc50);
const Color typeIce = Color(0xFF51c4e7);
const Color typePoison = Color(0xFFb97fc9);
const Color typeRock = Color(0xFFa38c21);
const Color typeWater = Color(0xFF4592c4);

Color GetColorByType(String ability) {
  switch(ability) {
    case "bug": return typeBug;
    case "dragonA": return typeDragonA;
    case "dragonB": return typeDragonB;
    case "fairy": return typeFairy;
    case "fire": return typeFire;
    case "ghost": return typeGhost;
//    case "ground": return typeGroundA;
    case "ground": return typeGroundB;
    case "normal": return typeNormal;
    case "psychic": return typePsychic;
    case "steel": return typeSteel;
    case "dark": return typeDark;
    case "electric": return typeElectric;
    case "fighting": return typeFighting;
    case "flying": return typeFlyingA;
//    case "flying": return typeFlyingB;
    case "grass": return typeGrass;
    case "ice": return typeIce;
    case "poison": return typePoison;
    case "rock": return typeRock;
    case "water": return typeWater;
  }
  return colorGreyShadow;
}

Color GetColorByStats(String stats) {
  switch(stats) {
    case "hp": return colorBarHP;
    case "attack": return colorBarATK;
    case "special-attack": return colorBarSATK;
    case "defense": return colorBarDEF;
    case "special-defense": return colorBarSDEF;
    case "speed": return colorBarSPEED;
    case "EXP": return colorBarEXP;
  }
  return colorGreyShadow;
}