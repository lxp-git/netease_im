import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(NotFoundState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Container(
      child: Center(
        child: Text('page not found'),
      ),
    ),
  );
}
