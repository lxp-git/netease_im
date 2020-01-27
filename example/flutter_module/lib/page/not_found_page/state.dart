import 'package:fish_redux/fish_redux.dart';

class NotFoundState implements Cloneable<NotFoundState> {

  @override
  NotFoundState clone() {
    return NotFoundState();
  }
}

NotFoundState initState(Map<String, dynamic> args) {
  return NotFoundState();
}
