import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      controller: pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        // Home,
        Container(color: Colors.green),
        Container(color: Colors.yellow),
        Container(color: Colors.purple),
        Container(color: Colors.brown),
      ],
    ));
  }
}
