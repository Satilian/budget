import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryBtn extends StatefulWidget {
  const CategoryBtn({super.key, required this.label, required this.iconSrc});
  final String label;
  final String iconSrc;

  @override
  State<CategoryBtn> createState() => _CategoryBtnState();
}

class _CategoryBtnState extends State<CategoryBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF212832),
        boxShadow: [
          BoxShadow(
            color: Color(0x7F000000),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 0,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      width: 120,
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [SvgPicture.asset(widget.iconSrc), Text(widget.label)],
      ),
    );
  }
}
