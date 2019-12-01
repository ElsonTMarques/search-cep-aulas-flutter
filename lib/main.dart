import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:via_cep/blocs/theme.dart';
import 'package:via_cep/views/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData.light()),
        child: new MaterialAppWithTheme(),
    )
  );
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      home: HomePage(),
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
      );
  }
}