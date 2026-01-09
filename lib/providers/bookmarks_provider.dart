import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/bookmark_service.dart';
import '../services/firestore_service.dart';

class BookmarksProvider with ChangeNotifier {
  final BookmarkService _bookmarkService = BookmarkService();
  final FirestoreService _firestoreService = FirestoreService();
  
  List<String> _bookmarkIds = [];
  List<Book> _bookmarkedBooks = [];
  bool _isLoading = false;

  List<String> get bookmarkIds => _bookmarkIds;
  List<Book> get bookmarkedBooks => _bookmarkedBooks;
  bool get isLoading => _isLoading;

  void initializeBookmarks(String userId) {
    _bookmarkService.getBookmarkIds(userId).listen((ids) async {
      _bookmarkIds = ids;
      await _loadBookmarkedBooks();
      notifyListeners();
    });
  }

  Future<void> _loadBookmarkedBooks() async {
    if (_bookmarkIds.isEmpty) {
      _bookmarkedBooks = [];
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _bookmarkedBooks = await _firestoreService.getBooksByIds(_bookmarkIds);
    } catch (e) {
      print('Error loading bookmarked books: $e');
      _bookmarkedBooks = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  bool isBookmarked(String bookId) {
    return _bookmarkIds.contains(bookId);
  }

  Future<void> toggleBookmark(String userId, String bookId) async {
    try {
      await _bookmarkService.toggleBookmark(userId, bookId);
      // The stream listener will update _bookmarkIds automatically
    } catch (e) {
      print('Error toggling bookmark: $e');
      rethrow;
    }
  }

  Future<void> addBookmark(String userId, String bookId) async {
    try {
      await _bookmarkService.addBookmark(userId, bookId);
    } catch (e) {
      print('Error adding bookmark: $e');
      rethrow;
    }
  }

  Future<void> removeBookmark(String userId, String bookId) async {
    try {
      await _bookmarkService.removeBookmark(userId, bookId);
    } catch (e) {
      print('Error removing bookmark: $e');
      rethrow;
    }
  }
}
