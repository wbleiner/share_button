import 'package:flutter/material.dart';
import 'package:share_button/components/share_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const ShareButton(),
      appBar: AppBar(
        title: const Text('Share Button'),
      ),
    );
  }
}
