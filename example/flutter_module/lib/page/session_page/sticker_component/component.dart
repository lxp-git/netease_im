import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_module/page/session_page/text_component/state.dart';

import '../text_component/reducer.dart';
import '../text_component/effect.dart';
import 'view.dart';

class StickerComponent extends Component<IMMessageState> {
  StickerComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<IMMessageState>(
                adapter: null,
                slots: <String, Dependent<IMMessageState>>{
                }),);

}
