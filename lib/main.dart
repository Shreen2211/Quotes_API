import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/Quotes.dart';
import 'bloc/qoutes_cubit.dart';
import 'data/Network/DioHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dioHelper.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => QoutesCubit()..QuotesGet(),
      ),
    ],
    child: const MaterialApp(
      home: QuotesScreen(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
