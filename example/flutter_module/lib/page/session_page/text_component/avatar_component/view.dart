import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(AvatarState state, Dispatch dispatch, ViewService viewService) {
  return CircleAvatar(
    backgroundImage: CachedNetworkImageProvider(state.avatar),
  );
}
