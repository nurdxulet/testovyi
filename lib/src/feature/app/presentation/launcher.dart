// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testovyi/src/core/extension/src/build_context.dart';
import 'package:testovyi/src/feature/home/bloc/daily_bars_cubit.dart';
import 'package:testovyi/src/feature/home/presentation/view/home_page.dart';

// ignore: unused_element
const _tag = 'Launcher';

class Launcher extends StatefulWidget {
  const Launcher({super.key});

  @override
  State<Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyBarsCubit(context.repository.homeRepository),
      child: const HomePage(),
    );
  }
}
