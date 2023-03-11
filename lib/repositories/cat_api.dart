import 'dart:convert';
import 'package:http/http.dart' as http;

import '../env/env.dart';
import '../models/cat_api_model.dart';
import '../models/custom_error.dart';

class CatApiRepository {
  Future<List<String>> getCatBreeds() async {
    try {
      var client = http.Client();
      var headers = {'x-api-key': Env.catApiKey};
      var url = Uri.parse('https://api.thecatapi.com/v1/breeds');
      var response = await client.get(url, headers: headers);
      // STATUS CODE 200 = REQUEST SUCCESSFULL FROM API
      if (response.statusCode == 200) {
        List<String> breeds = [];
        var data = jsonDecode(response.body);
        for (var u in data) {
          CatBreed breed = CatBreed(name: u['name']);
          breeds.add(breed.name);
        }

        return breeds;
      }
    } on Exception catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error ref.getCatBreeds',
      );
    }
    return [];
  }
}
