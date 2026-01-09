import 'package:flutter/material.dart';
import '../config/theme.dart';

class GenreTag extends StatelessWidget {
  final String genre;

  const GenreTag({
    super.key,
    required this.genre,
  });

  Color _getGenreColor() {
    switch (genre.toLowerCase()) {
      case 'fiction':
        return AppTheme.orangeGenre;
      case 'non-fiction':
        return AppTheme.yellowGenre;
      case 'mystery':
        return Colors.purple.shade400;
      case 'romance':
        return Colors.pink.shade400;
      case 'sci-fi':
      case 'science fiction':
        return Colors.blue.shade400;
      case 'fantasy':
        return Colors.indigo.shade400;
      case 'thriller':
        return Colors.red.shade400;
      case 'biography':
        return Colors.teal.shade400;
      default:
        return AppTheme.primaryGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getGenreColor(),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        genre,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
