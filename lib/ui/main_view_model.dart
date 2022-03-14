import 'package:bitrise_demo_1/models/person.dart';
import 'package:bitrise_demo_1/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../main.dart';

class MainViewModel extends ChangeNotifier {
  var _person = <Person>[];
  var loading = false;

  List<Person> get persons {
    return UnmodifiableListView(_person);
  }

  void getPersons() {
    loading = true;
    getIt<ApiService>().getPersons().then((value) {
      print(value);
      _person = value;
      loading = false;
      notifyListeners();
    });
  }
}
