import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/cart_bloc.dart';
import 'bloc/products_bloc.dart';
import 'ui/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ProductsBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => CartBloc(),
          )
        ],
        child: MaterialApp(
          title: 'E-Commerce',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            textTheme: GoogleFonts.rubikTextTheme(),
            useMaterial3: true,
          ),
          home: const Login(),
        ),
      ),
    );
  }
}
