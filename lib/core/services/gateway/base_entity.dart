import 'package:jom_malaysia/core/constants/common.dart';

import '../../services/model_factory.dart';

class BaseEntity<T> {
  int code;
  String message;
  T data;
  List<T> listData = [];

  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code];
    message = json[Constant.message];
    if (json.containsKey(Constant.data)) {
      if (json[Constant.data] is List) {
        (json[Constant.data] as List).forEach((item) {
          listData.add(ModelFactory.generateOBJ<T>(item));
        });
      } else {
        if (T.toString() == "String") {
          data = json[Constant.data].toString() as T;
        } else if (T.toString() == "Map<dynamic, dynamic>") {
          data = json[Constant.data] as T;
        } else {
          data = ModelFactory.generateOBJ(json[Constant.data]);
        }
      }
    }
  }
}
