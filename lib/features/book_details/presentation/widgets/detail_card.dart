import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String label;
  final String value;
  final String iconAsset;

  const DetailCard({
    Key? key,
    required this.label,
    required this.value,
    required this.iconAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF8F3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black26, width: 1),
      ),
      child: Row(
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
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(iconAsset, width: 48, height: 48, fit: BoxFit.contain),
        ],
      ),
    );
  }
} 