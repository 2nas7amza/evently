import 'package:flutter/material.dart';
import 'package:untitled/uitels/AppColors.dart';



class DefualtControler extends StatelessWidget {
  const DefualtControler({
    Key? key,
    required this.isSelected,
    required this.text,
  }) : super(key: key);

  final bool isSelected;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).focusColor,
          width: 1,
        ),
        color: isSelected
            ? Theme.of(context).focusColor
            : Colors.transparent,
      ),
      child: Text(
        text,
        style: isSelected
            ? Theme.of(context).textTheme.headlineMedium
            : Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
