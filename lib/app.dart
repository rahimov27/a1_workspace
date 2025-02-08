import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/login/presentation/pages/login_page.dart';
import 'package:a1_workspace/features/service/presentation/bloc/client_bloc.dart';
import 'package:a1_workspace/main.dart';
import 'package:a1_workspace/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  final bool isLoggedIn;
  const App({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => GetIt.I<HomeBloc>()..add(GetRecordsEvent()),
        ),
        BlocProvider<CalendarBloc>(
          create: (context) =>
              GetIt.I<CalendarBloc>()..add(GetRecordsCalendarEvent()),
        ),
        BlocProvider<ClientBloc>(
          create: (context) => GetIt.I<ClientBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? const MainMenu() : const LoginPage(),
      ),
    );
  }
}
