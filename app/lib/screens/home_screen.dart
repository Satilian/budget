import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          alignment: Alignment.bottomCenter,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(),
              Row(),
              Row(),
              Row(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryBtn(
                    label: 'Сбережения',
                    iconSrc: 'assets/aim.svg',
                  ),
                  CategoryBtn(
                    label: 'Доходы',
                    iconSrc: 'assets/aim.svg',
                  ),
                  CategoryBtn(
                    label: 'Расходы',
                    iconSrc: 'assets/aim.svg',
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
