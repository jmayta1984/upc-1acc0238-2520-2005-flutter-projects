import 'package:easy_travel/core/ui/theme.dart';
import 'package:easy_travel/features/auth/data/login_service.dart';
import 'package:easy_travel/features/auth/presentation/blocs/login_bloc.dart';
import 'package:easy_travel/features/auth/presentation/pages/login_page.dart';
import 'package:easy_travel/features/home/data/destination_service.dart';
import 'package:easy_travel/features/home/domain/category.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_bloc.dart';
import 'package:easy_travel/features/home/presentation/blocs/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MaterialTheme theme = MaterialTheme(TextTheme());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomeBloc(service: DestinationService())
                ..add(GetDestinationsByCategory(category: CategoryType.all)),
        ),
        BlocProvider(create: (context) => LoginBloc(service: LoginService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme.light(),
        darkTheme: theme.dark(),
        home: LoginPage(),
      ),
    );
  }
}
