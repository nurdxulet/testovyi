import 'package:testovyi/src/feature/app/logic/main_runner.dart';

import 'src/feature/app/model/async_app_dependencies.dart';
import 'src/feature/app/presentation/my_app.dart';

Future<void> main() => MainRunner.run<AsyncAppDependencies>(
      asyncDependencies: AsyncAppDependencies.obtain,
      appBuilder: (dependencies) => MyApp(
        sharedPreferences: dependencies.sharedPreferences,
        packageInfo: dependencies.packageInfo,
      ),
    );


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:testovyi/src/core/extension/extensions.dart';
// import 'package:testovyi/src/core/resources/resources.dart';
// import 'package:testovyi/src/feature/home/bloc/daily_bars_cubit.dart';
// import 'package:testovyi/src/feature/home/presentation/view/home_page.dart';

// void main() {
//   runApp(BlocProvider(
//     create: (context) => DailyBarsCubit(context.repository.homeRepository),
//     child: const MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: AppColors.kWhite),
//         useMaterial3: true,
//       ),
//       home: const HomePage(),
//     );
//   }
// }
