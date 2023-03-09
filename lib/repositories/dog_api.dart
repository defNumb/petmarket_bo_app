import 'dart:convert';
import 'package:http/http.dart' as http;

import '../env/env.dart';
import '../models/dog_api_model.dart';

class DogApiRepository {
  Future<List<String>?> getDogBreeds() async {
    var client = http.Client();
    var headers = {'x-api-key': Env.dogApiKey};
    var url = Uri.parse('https://api.thedogapi.com/v1/breeds');
    var response = await client.get(url, headers: headers);
    // STATUS CODE 200 = REQUEST SUCCESSFULL FROM API
    if (response.statusCode == 200) {
      List<String> breeds = [];
      var data = jsonDecode(response.body);
      for (var u in data) {
        DogBreed breed = DogBreed(name: u['name']);
        breeds.add(breed.name);
      }
      return breeds;
    }
    return null;
  }
}
