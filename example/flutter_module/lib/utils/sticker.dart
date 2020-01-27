class StickerUtils {

  static const String CATEGORY_AJMD = "ajmd";
  static const String CATEGORY_XXY = "xxy";
  static const String CATEGORY_LT = "lt";

  static bool isSystemSticker(String category) {
    return CATEGORY_XXY == (category) ||
        CATEGORY_AJMD == (category) ||
        CATEGORY_LT == (category);
  }

  static String getStickerUri(String categoryName, String stickerName) {

    if (isSystemSticker(categoryName)) {
      if (!stickerName.contains(".png")) {
        stickerName += ".png";
      }

      String path = "sticker/" + categoryName + "/" + stickerName;
      return "assets/" + path;
    }

    return '';
  }

}