import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add bookmark
  Future<void> addBookmark(String userId, String bookId) async {
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      
      // Use arrayUnion to prevent duplicates
      await userDoc.update({
        'bookmarks': FieldValue.arrayUnion([bookId]),
      });
    } catch (e) {
      print('Error adding bookmark: $e');
      rethrow;
    }
  }

  // Remove bookmark
  Future<void> removeBookmark(String userId, String bookId) async {
    try {
      final userDoc = _firestore.collection('users').doc(userId);
      
      await userDoc.update({
        'bookmarks': FieldValue.arrayRemove([bookId]),
      });
    } catch (e) {
      print('Error removing bookmark: $e');
      rethrow;
    }
  }

  // Check if book is bookmarked
  Future<bool> isBookmarked(String userId, String bookId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        final bookmarks = List<String>.from(userDoc.data()?['bookmarks'] ?? []);
        return bookmarks.contains(bookId);
      }
      return false;
    } catch (e) {
      print('Error checking bookmark: $e');
      return false;
    }
  }

  // Get user's bookmarked book IDs
  Stream<List<String>> getBookmarkIds(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
          if (snapshot.exists) {
            return List<String>.from(snapshot.data()?['bookmarks'] ?? []);
          }
          return [];
        });
  }

  // Toggle bookmark (add if not bookmarked, remove if bookmarked)
  Future<void> toggleBookmark(String userId, String bookId) async {
    try {
      final isBookmarked = await this.isBookmarked(userId, bookId);
      if (isBookmarked) {
        await removeBookmark(userId, bookId);
      } else {
        await addBookmark(userId, bookId);
      }
    } catch (e) {
      print('Error toggling bookmark: $e');
      rethrow;
    }
  }
}
