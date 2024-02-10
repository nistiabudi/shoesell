import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Text(
          'Nulla culpa anim tempor ullamco. Velit cillum quis cupidatat enim qui cillum incididunt. Ipsum dolor in proident ex id non tempor enim qui ut quis dolor irure. Lorem ad nulla do irure eiusmod amet quis. Officia ex irure cillum reprehenderit cupidatat cupidatat nisi dolore et. Culpa excepteur non amet voluptate fugiat est ipsum cupidatat cupidatat dolor adipisicing reprehenderit et fugiat. Sit anim irure duis sit nisi minim.',
        ),
      ),
    );
  }
}
