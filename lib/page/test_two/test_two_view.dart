import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/counts.dart';

class TestTwoPage extends StatelessWidget {
  const TestTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.watch<Counts>().count.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<Counts>().add();
                      context.read<Counts>().Circle();
                    },
                    child: Icon(Icons.add)),
                SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<Counts>().remove();
                      context.read<Counts>().Circle();
                    },
                    child: Icon(Icons.remove))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
