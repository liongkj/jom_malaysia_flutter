import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';

import 'base_entity.dart';

class JsonParser {
  // If T is a List, K is the subtype of the list.

  static T fromJson<T, K>(dynamic json) {
    final dynamic data = BaseEntity.fromJson(json).data;
    if (data is Iterable) {
      return _fromJsonList<K>(data) as T;
    }
    if (T == CategoryModel) {
      return CategoryModel.fromJson(json) as T;
    }
    // if (T == Category) {
    //   return Category.fromJson(json) as T;
    // }
    // } else if (T == UserDetails) {
    //   //   return UserDetails.fromJson(json) as T;
    //   // } else if (T == Message) {
    //   //   return Message.fromJson(json) as T;
    // } else {
    throw Exception("Unknown class");
  }

  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    List<K> output = List();

    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }

    return output;
  }
}
