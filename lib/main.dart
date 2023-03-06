import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider_shopping/provider/shopping_provider.dart';
import 'package:provider_shopping/view/shopping_view.dart';

void main() => runApp(ChangeNotifierProvider<ShoppingProvider>(
child: const MyApp(),
  create:(_) => ShoppingProvider() ,
));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 16)
        ),
      ),
      home: const ShoppingView(),
    );
  }
}
