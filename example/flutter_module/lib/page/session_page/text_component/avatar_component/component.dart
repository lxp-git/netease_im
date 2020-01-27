import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AvatarComponent extends Component<AvatarState> {
  AvatarComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AvatarState>(
                adapter: null,
                slots: <String, Dependent<AvatarState>>{
                }),);

}
