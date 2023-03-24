// To parse this JSON data, do
//
//     final dictionaryModel = dictionaryModelFromJson(jsonString);

import 'dart:convert';

class DictionaryModel {
  DictionaryModel({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.meanings,
  });

  String word;
  String phonetic;
  List<dynamic> phonetics;
  List<dynamic> meanings;
}
