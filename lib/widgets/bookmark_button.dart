import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../providers/auth_provider.dart';
import '../providers/bookmarks_provider.dart';

class BookmarkButton extends StatelessWidget {
  final String bookId;
  final double size;

  const BookmarkButton({
    super.key,
    required this.bookId,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final bookmarksProvider = Provider.of<BookmarksProvider>(context);
    
    final isBookmarked = bookmarksProvider.isBookmarked(bookId);
    final userId = authProvider.user?.uid;

    if (userId == null) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: isBookmarked ? AppTheme.primaryGreen : AppTheme.secondaryText,
        size: size,
      ),
      onPressed: () async {
        try {
          await bookmarksProvider.toggleBookmark(userId, bookId);
          
          // Show feedback
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isBookmarked ? 'Removed from collection' : 'Added to collection',
                ),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error updating bookmark'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        }
      },
    );
  }
}
