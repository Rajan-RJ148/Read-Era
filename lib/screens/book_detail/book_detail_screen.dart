import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../config/theme.dart';
import '../../models/book.dart';
import '../../widgets/genre_tag.dart';
import '../../widgets/bookmark_button.dart';

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          BookmarkButton(bookId: book.id),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover image with genre tag
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 400,
                  color: AppTheme.lightGrey,
                  child: CachedNetworkImage(
                    imageUrl: book.imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.book,
                        size: 100,
                        color: AppTheme.secondaryText,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: GenreTag(genre: book.genre),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Book information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book name
                  Text(
                    book.bookName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Author name
                  Text(
                    book.authorName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppTheme.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Story brief
                  if (book.storyBrief.isNotEmpty) ...[
                    const Text(
                      'Story Brief',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.storyBrief,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.secondaryText,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  // Detailed overview
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.detailedOverview,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.secondaryText,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
