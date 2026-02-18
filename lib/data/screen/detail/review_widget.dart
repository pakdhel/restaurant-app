import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/customer_review.dart';

class ReviewWidget extends StatelessWidget {
  final CustomerReview customerReview;
  const ReviewWidget({super.key, required this.customerReview});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customerReview.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(customerReview.review),
            const SizedBox(height: 4),
            Text(
              customerReview.date,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
