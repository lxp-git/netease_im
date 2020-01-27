import 'package:fish_redux/fish_redux.dart';

import '../state.dart';
import 'avatar_component/component.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TextComponent extends Component<IMMessageState> {
  TextComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<IMMessageState>(
                adapter: null,
                slots: <String, Dependent<IMMessageState>>{
                  'avatar': AvatarConnector() + AvatarComponent(),
                }),
  );

}
