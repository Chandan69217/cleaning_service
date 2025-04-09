import 'package:flutter/material.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  String selectedTheme = 'System Default'; // Options: Light, Dark, System Default

  final List<String> themes = ['Light', 'Dark', 'System Default'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: themes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final theme = themes[index];
          final isSelected = theme == selectedTheme;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTheme = theme;
              });

              // TODO: Implement actual theme switching logic here
              // You can use Provider, GetX, or any state management tool
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? Colors.purple : Colors.transparent,
                  width: 1.2,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(theme,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.purple : Colors.black)),
                  if (isSelected)
                    const Icon(Icons.check_circle, color: Colors.purple)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
