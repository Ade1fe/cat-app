
import 'package:flutter/material.dart';
import 'package:cat_shop/theme/styles.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, required this.fullName});

  final String fullName;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello $fullName',
              style: Styles.titleOne,
            ),
            const SizedBox(height: 16),
            const Text(
              'MEMORISE: “Behold, I will bring it health and cure, and I will cure them, and will reveal unto them the abundance of peace and truth.” – Jeremiah 33:6 (KJV)',
              style: Styles.subTitleOne,
            ),
          ],
        ),
      ),
    );
  }
}
