import 'package:fish_redux/fish_redux.dart';
import 'package:netease_im/models/IMMessage.dart';
import 'package:netease_im/models/NimUserInfo.dart';

import 'avatar_component/state.dart';

const headUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1579785684499&di=73f56903c6858a1199ef6f7b28ed4d40&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F1e2e62e6f57458ca32394a10211a9616498d25bd5459-K2uzdk_fw658";

class IMMessageState extends IMMessage implements Cloneable<IMMessageState> {

  NimUserInfo nimUserInfo;

  IMMessageState() : super.fromJson({});

  IMMessageState.fromJson(Map json) : super.fromJson(json);

  @override
  IMMessageState clone() {
    return IMMessageState();
  }
}

IMMessageState initState(Map<String, dynamic> args) {
  return IMMessageState();
}

class AvatarConnector extends ConnOp<IMMessageState, AvatarState>
    with ReselectMixin<IMMessageState, AvatarState> {
  @override
  AvatarState computed(IMMessageState state) {
    return AvatarState()
      ..avatar = state.nimUserInfo?.avatar ?? headUrl;
  }

  @override
  List<dynamic> factors(IMMessageState state) {
    return <String>[
      state.nimUserInfo?.avatar ?? headUrl,
    ];
  }

  @override
  void set(IMMessageState state, AvatarState subState) {
    throw Exception('Unexcepted to set PageState from ReportState');
  }
}