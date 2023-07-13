import 'package:rxdart/rxdart.dart';

class NotAuthLogic {
  static final NotAuthLogic _singleton = NotAuthLogic._internal();

  factory NotAuthLogic() {
    return _singleton;
  }

  NotAuthLogic._internal();

  BehaviorSubject<int> statusSubject = BehaviorSubject<int>();
}
