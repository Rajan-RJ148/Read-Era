import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/firestore_service.dart';

class BooksProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Book> _allBooks = [];
  List<Book> _searchResults = [];
  bool _isSearching = false;
  bool _isLoading = false;

  List<Book> get allBooks => _allBooks;
  List<Book> get searchResults => _searchResults;
  bool get isSearching => _isSearching;
  bool get isLoading => _isLoading;

  BooksProvider() {
    _loadBooks();
  }

  void _loadBooks() {
    _firestoreService.getAllBooks().listen((books) {
      _allBooks = books;
      notifyListeners();
    });
  }

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    _isLoading = true;
    notifyListeners();

    try {
      _searchResults = await _firestoreService.searchBooks(query);
    } catch (e) {
      print('Error searching books: $e');
      _searchResults = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    _searchResults = [];
    _isSearching = false;
    notifyListeners();
  }

  Future<Book?> getBookById(String bookId) async {
    return await _firestoreService.getBookById(bookId);
  }
}
