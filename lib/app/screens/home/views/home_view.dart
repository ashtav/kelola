import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: Maa.center,
          children: [
            Textr('Home View', style: Gfont.fs18.bold, margin: Ei.only(b: 10)),
            Text(Faker.words(15), style: Gfont.muted, textAlign: Ta.center)
          ],
        ),
      ).padding(all: 35),
    );
  }
}
