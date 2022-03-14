import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/person.dart';

class ApiService {
  final _dio = Dio(BaseOptions(
      baseUrl:
          "https://gist.githubusercontent.com/russellbstephens/9e528b12fd1a45a7ff4e4691adcddf10/raw/5ec8ce76460e8f29c9b0f99f3bf3450b06696482/"));

  Future<List<Person>> getPersons() async {
    final response = await _dio.get("people.json");

    print(jsonDecode(response.data));
    final peopleList = jsonDecode(response.data)["people"] as List;

    return peopleList
        .map((personData) => Person.fromJson(personData))
        .toList(growable: false);
  }
}
