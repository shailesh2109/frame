import 'package:celebrare_assignment/bloc/image_bloc/image_bloc.dart';
import 'package:celebrare_assignment/screens/splash_screen.dart';
import 'package:celebrare_assignment/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ImageBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme(context),
        home: SplashScreen(),
      ),
    );
  }
}
