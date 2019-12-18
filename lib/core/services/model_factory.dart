import 'package:jom_malaysia/screens/tabs/overview/models/category_model.dart';

class ModelFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    }
    else if (T.toString() == "SearchEntity") {
       return CategoryModel.fromJson(json) as T;
     }
    //else if (T.toString() == "UserEntity") {
    //   return UserEntity.fromJson(json) as T;
    // } else {
    //   return null;
    // }
    // }
  }
}
