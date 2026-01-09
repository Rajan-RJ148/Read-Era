import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String bookName;
  final String authorName;
  final String imageUrl;
  final String genre;
  final String storyBrief;
  final String detailedOverview;

  Book({
    required this.id,
    required this.bookName,
    required this.authorName,
    required this.imageUrl,
    required this.genre,
    required this.storyBrief,
    required this.detailedOverview,
  });

  // Create Book from Firestore document
  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      bookName: data['bookName'] ?? '',
      authorName: data['authorName'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      genre: data['genre'] ?? '',
      storyBrief: data['storyBrief'] ?? '',
      detailedOverview: data['detailedOverview'] ?? '',
    );
  }

  // Convert Book to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'bookName': bookName,
      'authorName': authorName,
      'imageUrl': imageUrl,
      'genre': genre,
      'storyBrief': storyBrief,
      'detailedOverview': detailedOverview,
    };
  }
}
