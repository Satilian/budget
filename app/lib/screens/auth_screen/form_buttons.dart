import 'package:flutter/material.dart';

class FormButtons extends StatelessWidget {
  const FormButtons(
      {super.key, this.onSubmit, this.onReset, required this.submitLabel});
  final VoidCallback? onSubmit;
  final VoidCallback? onReset;
  final String submitLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            onPressed: onSubmit,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primary),
              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return const Color(0xFF76A777);
                  }
                  return null;
                },
              ),
            ),
            child: Text(
              submitLabel,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: OutlinedButton(
            onPressed: onReset,
            child: Text(
              'Сброс',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
