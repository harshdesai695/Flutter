// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Categort_data extends ChangeNotifier {
  String category = 'general';
  String updatecategory() => category;

  UpdateCategory(data) {
    category = data;
    notifyListeners();
  }
}
