import 'package:fish_redux/fish_redux.dart';
import 'package:netease_im/models/NimUserInfo.dart';

class AvatarState extends NimUserInfo implements Cloneable<AvatarState> {

  @override
  AvatarState clone() {
    return AvatarState();
  }
}

AvatarState initState(Map<String, dynamic> args) {
  return AvatarState();
}
