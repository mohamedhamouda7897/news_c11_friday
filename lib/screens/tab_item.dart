import 'package:flutter/material.dart';
import 'package:news_c11_friday/models/SourceResponse.dart';

class TabItem extends StatelessWidget {
  Sources source;
  bool isSelected;

  TabItem({required this.source, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.green)),
      child: Text(
        source.name ?? "",
        style: TextStyle(color: isSelected ? Colors.white : Colors.green),
      ),
    );
  }
}
