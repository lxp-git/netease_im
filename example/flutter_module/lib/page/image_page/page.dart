import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ImagePage extends Page<ImageState, Map<String, dynamic>> {
  ImagePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ImageState>(
              adapter: null, slots: <String, Dependent<ImageState>>{}),
          middleware: <Middleware<ImageState>>[],
        );
}
