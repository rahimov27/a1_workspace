import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:a1_workspace/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:a1_workspace/features/history/presentation/bloc/edit_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_bloc.dart';
import 'package:a1_workspace/features/home/presentation/bloc/home_event.dart';
import 'package:a1_workspace/features/login/presentation/bloc/bloc/auth_bloc.dart';
import 'package:a1_workspace/features/login/presentation/bloc/login_bloc.dart';
import 'package:a1_workspace/features/login/presentation/pages/login_page.dart';
import 'package:a1_workspace/features/register/presentation/bloc/register_bloc.dart';
import 'package:a1_workspace/features/service/presentation/bloc/client_bloc.dart';
import 'package:a1_workspace/main.dart';
import 'package:a1_workspace/shared/theme/theme.dart';
import 'package:a1_workspace/shared/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

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
        BlocProvider<AuthBloc>(
          create: (context) => GetIt.I<AuthBloc>(),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<EditBloc>(
          create: (context) => EditBloc(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(), // Используем ThemeProvider
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              theme: themeProvider.isDarkMode
                  ? darkTheme
                  : ligthTheme, // Переключаем темы
              debugShowCheckedModeBanner: false,
              home: isLoggedIn ? const MainMenu() : const LoginPage(),
            );
          },
        ),
      ),
    );
  }
}
