import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text('Tema', style: Theme.of(context).textTheme.bodyLarge),
          ),

          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: SwitchListTile(
              title: Text('Mode Gelap'),
              subtitle: Text('Aktifkan Mode Gelap'),
              value: true,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
