import 'package:get/get.dart';
import 'Mobile_Lesson & Flashcards/Lesson_Option20.dart';

class BookmarkController extends GetxController {
  var bookmarks = <Bookmark>[].obs;

  void addBookmark(Bookmark bookmark) {
    bookmarks.add(bookmark);
  }

  void removeBookmark(Bookmark bookmark) {
    bookmarks.remove(bookmark);
  }
}
