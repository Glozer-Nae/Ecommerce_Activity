import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  

  const CategoryButton({
    super.key,
    required this.title, 
    required this.isSelected,
    required this.onTap,
    
    });
    
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap, 
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.red : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      child: Text(title),
    );
  }
}