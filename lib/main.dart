import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shubtest/bloc/excel_bloc.dart';
import 'package:shubtest/core/route.dart';
import 'package:shubtest/screen/pick_file_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ExcelBloc(),
        child:  MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.generateRoute,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,),
         home: const PickFileScreen(),
    ));
  }
}