import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final Function(Locale) onLanguageSelected;

  const LanguageSelector({super.key, required this.onLanguageSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language),
      onSelected: onLanguageSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        const PopupMenuItem<Locale>(
          value: Locale('en', ''),
          child: Text('English'),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('ar', ''),
          child: Text('العربية'),
        ),
      ],
    );
  }
}
