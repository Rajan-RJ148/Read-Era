import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/bookmarks_provider.dart';
import '../../widgets/book_card.dart';
import '../book_detail/book_detail_screen.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarksProvider = Provider.of<BookmarksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
      ),
      body: bookmarksProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookmarksProvider.bookmarkedBooks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bookmark_outline,
                        size: 64,
                        color: AppTheme.secondaryText,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No bookmarked books',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Start adding books to your collection',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.secondaryText,
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: bookmarksProvider.bookmarkedBooks.length,
                    itemBuilder: (context, index) {
                      final book = bookmarksProvider.bookmarkedBooks[index];
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
                  ),
                ),
    );
  }
}
