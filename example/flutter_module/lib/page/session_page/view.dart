import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/page/session_page/action.dart';

import 'state.dart';

const EMOJI_LIST = ['😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
  '☺️', '😊️', '😇️', '🙂️', '🙃️', '😉️', '😌️', '😍️',
  '🥰️', '😘', '😗️', '😙️', '😚️', '😋️', '😛️', '😝️',
  '😜', '🤪', '🤨️', '🧐️', '🤓️', '😎️', '🤩️', '🥳️',
  '😏', '😒', '😞️', '😔️', '😟️', '😕️', '🙁️', '☹️️',
  '😣', '😖', '😫️', '😩️', '🥺️', '😢️', '😭️', '😤️️',
  '😠', '😡', '🤬️', '🤯️', '😳️', '🥵️', '🥶️', '😱️️',
  '😨', '😰', '😥️', '😓️', '🤗️', '🤔️', '🤭️', '🤫️️',
  '🤥', '😶', '😐️', '😑️', '😬️', '🙄️', '😯️', '😦️️',
  '😧', '😮', '😲️', '🥱️', '😴️', '🤤️', '😪️', '😵️️',
  '🤐', '🥴', '🤢️', '🤮️', '🤧️', '😷️', '🤒️', '🤕️️',
  '🤑', '🤠', '😈️', '👿️', '👹️', '👺️', '🤡️', '💩️️',
  '👻', '💀', '☠️️', '👽️', '👾️', '🤖️', '🎃️', '😺️️',
  '😸', '😹', '😻️️', '😼️', '😽️', '🙀️', '😿️', '😾️️',];

const MORE_FUNCTION = [{
  "icon": Icons.photo_album,
  "text": '相册',
},{
  "icon": Icons.video_call,
  "text": '视频',
},{
  "icon": Icons.my_location,
  "text": '位置',
},{
  "icon": Icons.call,
  "text": '电话',
},{
  "icon": Icons.insert_drive_file,
  "text": '文件',
},{
  "icon": Icons.redeem,
  "text": '红包',
},{
  "icon": Icons.info,
  "text": '提示',
},];

double keyboardHeight = 0.0;

Widget buildView(
    SessionPageState state, Dispatch dispatch, ViewService viewService) {
  final ListAdapter adapter = viewService.buildAdapter();
  double currentKeyboardHeight = MediaQuery.of(viewService.context).viewInsets.bottom;
  if (currentKeyboardHeight > keyboardHeight) {
    keyboardHeight = currentKeyboardHeight;
  }
  print("keyboardHeight:$keyboardHeight");
  return Scaffold(
    appBar: AppBar(
//      backgroundColor: Colors.redAccent,
      brightness: Theme.of(viewService.context).brightness,
//      title: Title(title: state.nimUserInfo.name, color: Colors.redAccent,),
      title: Text(state.nimUserInfo?.name ?? '', style: Theme.of(viewService.context).primaryTextTheme.title,),
      leading: BackButton(onPressed: (){
        SystemNavigator.pop(animated: true);
      },),
      actions: <Widget>[
        PopupMenuButton<String>(itemBuilder: (BuildContext context){
          return state.popMenus.map((value) => PopupMenuItem(child: Text(value), value: value)).toList();
        }, onSelected: (String value) => dispatch(SessionPageActionCreator.onPopMenuSelectedAction(value)),),
      ],
    ),
    backgroundColor: Theme.of(viewService.context).cardColor.withOpacity(0.9),
      body: Column(
    children: <Widget>[
      Expanded(
          child: ListView.builder(
        itemBuilder: adapter.itemBuilder,
        itemCount: adapter.itemCount,
      )),
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            IconButton(icon: Icon(Icons.keyboard_voice), onPressed: () {}),
            Expanded(
              child: Container(
                child: TextField(
                  autofocus: true,
                  maxLines: 5,
                  minLines: 1,
                  onChanged: (value) => dispatch(SessionPageActionCreator.onSendTextChangeAction()),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(viewService.context).dividerColor.withOpacity(.9),
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(viewService.context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(viewService.context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  controller: state.sendTextEditingController,
                  onTap: () => dispatch(SessionPageActionCreator.onUpdateStateAction(state.clone()..showedPanel = ShowedPanel.NONE)),
                ),
              ),
            ),
            IconButton(icon: Icon(state.showedPanel == ShowedPanel.EMOJI
                ? Icons.keyboard : Icons.insert_emoticon), onPressed: () =>
              dispatch(SessionPageActionCreator.onTriggerEmojiPanelAction())
            , padding: EdgeInsets.all(0),),
            IconButton(icon: Icon((state?.sendTextEditingController?.text?.trim()?.length ?? 0) > 0
                ? Icons.send : Icons.add), onPressed: () =>
            (state?.sendTextEditingController?.text?.trim()?.length ?? 0) > 0
                ? dispatch(SessionPageActionCreator.onSendButtonClickAction(""))
                : dispatch(SessionPageActionCreator.onMoreButtonClickAction()),
                padding: EdgeInsets.all(0)),
          ],
        ),
      ),
      if (state.showedPanel == ShowedPanel.EMOJI)
        Container(
          height: (MediaQuery.of(viewService.context).size.width / 8) * 4,
          child: GridView.count(crossAxisCount: 8, children:
          EMOJI_LIST.map((emoji) => Center(
            child: InkWell(onTap: (){
              dispatch(SessionPageActionCreator.onChooseEmojiAction(emoji));
            }, child: Container(
              width: MediaQuery.of(viewService.context).size.width / 8,
              height: MediaQuery.of(viewService.context).size.width / 8,
              child: Center(child: Text(emoji),),),),
          )).toList(), ),
        ),
      if (state.showedPanel == ShowedPanel.MORE)
        Container(
          height: ((MediaQuery.of(viewService.context).size.width) / 2),
          child: GridView.count(crossAxisCount: 4, children:
          MORE_FUNCTION.map((function) => InkWell(onTap: (){
              dispatch(SessionPageActionCreator.onMoreItemClickAction(function));
            }, child: Container(
//              width: (MediaQuery.of(viewService.context).size.width - 5 * 40) / 4,
              height: (MediaQuery.of(viewService.context).size.width) / 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(function['icon']),
                  Text(function['text']),
                ],
              ),
            ),),
          )).toList(), ),
        ),
    ],
  ));
}
