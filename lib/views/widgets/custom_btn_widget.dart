import 'package:flutter/material.dart';

class CustomBtnWidget extends StatelessWidget {
final VoidCallback onTap;
final String btnName;
  const CustomBtnWidget({super.key, required this.onTap, required this.btnName,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          border: Border.all(
            width: 0.8,
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Center(
          child: Text(
            btnName,
            style: TextStyle(
              fontFamily: 'Raleway',
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
