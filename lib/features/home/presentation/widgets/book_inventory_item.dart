import 'package:flutter/material.dart';

class BookInventoryItem extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final int quantity;
  final String id;

  const BookInventoryItem({
    Key? key,
    required this.image,
    required this.title,
    required this.author,
    required this.quantity,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              width: 56,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF4E342E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Cantidad: $quantity',
                  style: const TextStyle(
                    color: Color(0xFF00897B),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Autor: $author',
                  style: const TextStyle(
                    color: Color(0xFF6D4C41),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 