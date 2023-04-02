import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(),
              Row(),
              Row(),
              Row(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset('assets/aim.svg'),
                      const Text("Сбережения")
                    ],
                  ),
                  Column(
                    children: [
                      SvgPicture.asset('assets/aim.svg'),
                      const Text("Доходы")
                    ],
                  ),
                  Container(
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
                      children: [
                        SvgPicture.asset('assets/aim.svg'),
                        const Text("Расходы")
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
