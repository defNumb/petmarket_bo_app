import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env/env.dart';
import '../models/custom_error.dart';
import '../models/dog_api_model.dart';

// NAME THE CLASS DogApiRepository
class DogApiRepository {
  // THIS IS THE METHOD THAT WILL BE CALLED FROM THE UI
  Future<List<String>> getDogBreeds() async {
    // TRY/CATCH BLOCK TO HANDLE ERRORS
    try {
      // STEP 1: CREATE A CLIENT
      var client = http.Client();
      // STEP 2: CREATE A MAP OF HEADERS AND ADD API KEY
      // IN THIS CASE THE API KEY IS STORED IN A .ENV FILE
      var headers = {'x-api-key': Env.dogApiKey};
      // STEP 3: MAKE THE REQUEST
      var url = Uri.parse('https://api.thedogapi.com/v1/breeds');
      // IN THIS CASE WE ARE USING THE GET METHOD
      // IN OTHER CASES WE MIGHT USE POST, PUT, DELETE ETC
      var response = await client.get(url, headers: headers);
      // STATUS CODE 200 = REQUEST SUCCESSFULL FROM API
      if (response.statusCode == 200) {
        // this is what will be returned from the function
        List<String> breeds = [];
        // STEP 4: PARSE THE JSON RESPONSE
        var data = jsonDecode(response.body);
        for (var u in data) {
          DogBreed breed = DogBreed(name: u['name']);
          breeds.add(breed.name);
        }
        breeds.add('Chihuahua');
        breeds.sort();
        // STEP 5: RETURN THE DATA
        return breeds;
      }
    } on Exception catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error ref.getDogBreeds',
      );
    }
    return [];
  }
}
