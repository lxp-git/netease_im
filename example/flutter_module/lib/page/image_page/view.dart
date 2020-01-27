import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(ImageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Container(
      child: Text('image'),
    ),
  );
}
