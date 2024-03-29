import 'package:flutter/material.dart';
import 'package:jom_malaysia/widgets/state_layout.dart';

class BaseChangeNotifier extends ChangeNotifier {
  StateType _stateType = StateType.empty;
  StateType get stateType => _stateType;
  void setStateTypeWithoutNotify(StateType value) {
    _stateType = value;
  }

  void setStateType(StateType value) {
    _stateType = value;
    notifyListeners();
  }
}
