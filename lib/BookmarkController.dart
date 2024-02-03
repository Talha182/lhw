import 'package:get/get.dart';

class BookmarkController extends GetxController {
  var bookmarks = <Map<String, dynamic>>[].obs;

  void addBookmark(String id, int index) {
    bookmarks.add({'id': id, 'index': index});
  }

  void removeBookmark(String id) {
    bookmarks.removeWhere((bookmark) => bookmark['id'] == id);
  }

  bool isBookmarked(String id) {
    return bookmarks.any((bookmark) => bookmark['id'] == id);
  }

  List<Map<String, dynamic>> getBookmarkedItems() {
    return bookmarks;
  }
}
