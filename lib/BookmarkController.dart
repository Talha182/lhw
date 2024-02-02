import 'package:get/get.dart';

class BookmarkController extends GetxController {
  var bookmarks = <String>[].obs;

  void addBookmark(String id) {
    if (!bookmarks.contains(id)) {
      bookmarks.add(id);
    }
  }

  void removeBookmark(String id) {
    bookmarks.remove(id);
  }

  bool isBookmarked(String id) {
    return bookmarks.contains(id);
  }
}
