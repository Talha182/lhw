import 'package:get/get.dart';
import '../FlashCard/flash_cards_screen.dart';

class BookmarkController extends GetxController {
  var bookmarks = <Bookmark>[].obs;

  void addBookmark(Bookmark bookmark) {
    bookmarks.add(bookmark);
  }

  void removeBookmark(Bookmark bookmark) {
    bookmarks.remove(bookmark);
  }
}
