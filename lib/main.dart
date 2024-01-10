import 'package:btprint_test/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 36, 26, 129),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() {
  runApp(const BtPrintTest());
}

class BtPrintTest extends StatelessWidget {
   const BtPrintTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BT print test',
      theme: theme,
      home: HomePage(),
    );
  }
}
