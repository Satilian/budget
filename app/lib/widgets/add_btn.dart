import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddBtn extends StatefulWidget {
  const AddBtn(
      {super.key, required this.label, required this.iconSrc, this.onTap});
  final String label;
  final String iconSrc;
  final VoidCallback? onTap;

  @override
  State<AddBtn> createState() => _AddBtnState();
}

class _AddBtnState extends State<AddBtn> {
  double a = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap!();
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: const Color(0xFF212832),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              offset: Offset(0, 2 * a),
              blurRadius: 6 * a,
              spreadRadius: 0,
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [SvgPicture.asset(widget.iconSrc), Text(widget.label)],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      a = 0;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      a = 1;
    });
  }

  void _onTapCancel() {
    setState(() {
      a = 1;
    });
  }
}
