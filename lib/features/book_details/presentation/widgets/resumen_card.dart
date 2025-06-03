import 'package:flutter/material.dart';

class ResumenCard extends StatelessWidget {
  final String label;
  final String title;
  final String description;
  final String iconAsset;

  const ResumenCard({
    Key? key,
    required this.label,
    required this.title,
    required this.description,
    required this.iconAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF8F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(description, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Image.asset(iconAsset, width: 56, height: 56, fit: BoxFit.contain),
        ],
      ),
    );
  }
} 