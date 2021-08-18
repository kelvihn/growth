import 'package:flutter/material.dart';
import 'package:growth/providers/uploadImageProvider.dart';
import 'package:growth/providers/user_provider.dart';
import 'package:growth/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (BuildContext context) => UserProvider(),
          ),
          ChangeNotifierProvider<ImageUploadProvider>(
            create: (BuildContext context) => ImageUploadProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Growth',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              primaryColor: Colors.purple,
              fontFamily: 'MontserratRegular'),
          routes: RouteNames.routes,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: RouteNames.generateRoute,
        ));
  }
}
