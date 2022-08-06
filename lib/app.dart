import 'package:flutter/material.dart';
import 'package:logique_techtest/routes/router.dart';
import 'package:logique_techtest/screen/home/home_provider.dart';
import 'package:logique_techtest/screen/home/home_screen.dart';
import 'package:logique_techtest/utils/size_config.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Social Media',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: MyRouter.generateRoute,
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);
          SizeConfig().init(context);
          return MediaQuery(
            data: data.copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: const MyHomePage(),
      ),
    );
  }
}
