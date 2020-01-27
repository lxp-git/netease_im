import 'package:fish_redux/fish_redux.dart';

class ImageState implements Cloneable<ImageState> {

  @override
  ImageState clone() {
    return ImageState();
  }
}

ImageState initState(Map<String, dynamic> args) {
  return ImageState();
}
