import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all books
  Stream<List<Book>> getAllBooks() {
    return _firestore
        .collection('books')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList());
  }

  // Get a single book by ID
  Future<Book?> getBookById(String bookId) async {
    try {
      final doc = await _firestore.collection('books').doc(bookId).get();
      if (doc.exists) {
        return Book.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      print('Error getting book: $e');
      return null;
    }
  }

  // Search books by name or author
  Future<List<Book>> searchBooks(String query) async {
    try {
      if (query.isEmpty) {
        return [];
      }

      // Get all books and filter locally
      // Note: Firestore doesn't support case-insensitive search natively
      final snapshot = await _firestore.collection('books').get();
      final allBooks = snapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();

      final queryLower = query.toLowerCase();
      return allBooks.where((book) {
        return book.bookName.toLowerCase().contains(queryLower) ||
               book.authorName.toLowerCase().contains(queryLower);
      }).toList();
    } catch (e) {
      print('Error searching books: $e');
      return [];
    }
  }

  // Get multiple books by IDs (for bookmarked books)
  Future<List<Book>> getBooksByIds(List<String> bookIds) async {
    try {
      if (bookIds.isEmpty) {
        return [];
      }

      final List<Book> books = [];
      for (String bookId in bookIds) {
        final book = await getBookById(bookId);
        if (book != null) {
          books.add(book);
        }
      }
      return books;
    } catch (e) {
      print('Error getting books by IDs: $e');
      return [];
    }
  }
}
