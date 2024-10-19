import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shubtest/screen/home_screen.dart';
import 'package:shubtest/widget/custom_textbutton.dart';
import '../bloc/excel_bloc.dart';
import '../bloc/excel_event.dart';
import '../core/utils.dart';

class PickFileScreen extends StatefulWidget {
  const PickFileScreen({super.key});
  static String routeName = '/home';

  @override
  State<PickFileScreen> createState() => _PickFileScreenState();
}

class _PickFileScreenState extends State<PickFileScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Pick and Upload xlsx file'),),
      body: Column(
        children: [
          CustomTextbutton(
            text: 'Chọn file',
            onPressed: () async {
              await pickAndEditExcelFile(false);
              if (selectedFilePath != null) {
                context.read<ExcelBloc>().add(LoadExcel());
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              }
            },
          ),

          CustomTextbutton(
            text: 'Chọn lại',
            onPressed: () async {
              await pickAndEditExcelFile(true);
              if (selectedFilePath != null) {
                context.read<ExcelBloc>().add(LoadExcel());
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}