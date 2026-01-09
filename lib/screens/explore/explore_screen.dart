import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/books_provider.dart';
import '../../widgets/book_card.dart';
import '../book_detail/book_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    final booksProvider = Provider.of<BooksProvider>(context, listen: false);
    booksProvider.searchBooks(query);
  }

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Search books or authors...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            // Search results or empty state
            Expanded(
              child: booksProvider.isSearching
                  ? booksProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : booksProvider.searchResults.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: AppTheme.secondaryText,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No books found',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppTheme.secondaryText,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Try searching with different keywords',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: booksProvider.searchResults.length,
                              itemBuilder: (context, index) {
                                final book = booksProvider.searchResults[index];
                                return BookCard(
                                  book: book,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookDetailScreen(book: book),
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 64,
                            color: AppTheme.secondaryText,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Search for books',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppTheme.secondaryText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Enter a book name or author to start',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
