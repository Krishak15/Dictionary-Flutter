import 'dart:convert';

import 'package:get/get.dart';
import 'package:gym_api/models/model.dart';
import 'package:http/http.dart' as http;

// class RemoteService {
//   static var client = http.Client();

//   static Future<List<FootballVideos>?> fetchData() async {
//     var response = await client.get(
//         Uri.parse('https://free-football-soccer-videos.p.rapidapi.com/'),
//         headers: {
//           'X-RapidAPI-Key':
//               'bb46a8c432msh4c268bc76e16ab4p1027e3jsnffc06b8711bf',
//           'X-RapidAPI-Host': 'free-football-soccer-videos.p.rapidapi.com'
//         });
//     if (response.statusCode == 200) {
//       var jsonString = response.body;
//       print(response.body);
//       return footballVideosFromJson(jsonString);
//     } else {
//       print('API ERROR');
//       return [];
//     }
//   }
// }

// class ApiController {
//   static Future<List<FootballVideos>?> fetchData() async {
//     try {
//       var url =
//           Uri.parse("https://free-football-soccer-videos.p.rapidapi.com/");
//       final response = await http.get(
//         url,
//         headers: {
//           'X-RapidAPI-Key':
//               'bb46a8c432msh4c268bc76e16ab4p1027e3jsnffc06b8711bf',
//           'X-RapidAPI-Host': 'free-football-soccer-videos.p.rapidapi.com'
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = jsonDecode(response.body);
//         // responseData.value = json.decode(response.body);
//         return responseData
//             .map((dynamic item) => FootballVideos.fromJson(item))
//             .toList();
//       } else {
//         print(response.statusCode);
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }

// class ProductController extends GetxController {
//   var products = <DictionaryModel>[].obs;

//   Future<void> fetchProducts() async {
//     const url = 'https://api.dictionaryapi.dev/api/v2/entries/en/<word>';
//     final response = await http.get(Uri.parse(url), headers: {
//       'X-RapidAPI-Key': 'bb46a8c432msh4c268bc76e16ab4p1027e3jsnffc06b8711bf',
//       'X-RapidAPI-Host': 'free-football-soccer-videos.p.rapidapi.com'
//     });

//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body) as List;
//       products.value =
//           jsonData.map((e) => DictionaryModel.fromJson(e)).toList();
//       print(products.value);
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
// }

class DictionaryController extends GetxController {
  final definition = DictionaryModel(
    word: '',
    phonetic: '',
    phonetics: <dynamic>[],
    meanings: <dynamic>[],
  ).obs;

  var isLoading = true;
  var noSuchWord = false;
  // get data => definition.value.obs;

  Future<void> fetchDefinition(String word) async {
    final response = await http.get(
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("-------------------$word");
      print(definition.value.word);
      definition.value = DictionaryModel(
        word: data[0]['word'],
        phonetic: data[0]['phonetic'],
        phonetics: data[0]['phonetics'],
        meanings: data[0]['meanings'],
      );
      isLoading = false;
      noSuchWord = false;
    } else {
      print(response.statusCode);
      isLoading = true;
      if (response.statusCode == 404) {
        noSuchWord = true;
        isLoading = false;
      }
    }

    // print(definition.value.word);
  }
}
