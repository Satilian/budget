import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  const Modal({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              offset: const Offset(0, -4),
              blurRadius: 6,
            )
          ],
        ),
        child: child,
      ),
    );
  }
}
