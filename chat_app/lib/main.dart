import 'package:flutter/material.dart';
import 'package:chat_app/config/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/logic/auth/auth_bloc.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
// import 'package:chat_app/presentation/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: AuthRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
         initialRoute: '/',
         onGenerateRoute: Routes.generateRoute,
       /// home: LoginScreen(),
      ),
    );
  }
}
