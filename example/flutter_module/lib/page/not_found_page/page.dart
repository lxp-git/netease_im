import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NotFoundPage extends Page<NotFoundState, Map<String, dynamic>> {
  NotFoundPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<NotFoundState>(
                adapter: null,
                slots: <String, Dependent<NotFoundState>>{
                }),
            middleware: <Middleware<NotFoundState>>[
            ],);

}
