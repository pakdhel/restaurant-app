import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onRetry;
  const ErrorScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, size: 60),
        const SizedBox(height: 16),
        Text("Periksa Koneksi Internet Anda"),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: onRetry, child: const Text("Coba Lagi")),
      ],
    );
  }
}
