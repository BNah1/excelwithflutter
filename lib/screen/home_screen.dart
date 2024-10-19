import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shubtest/bloc/excel_bloc.dart';
import 'package:shubtest/bloc/excel_event.dart';
import 'package:shubtest/screen/input_screen.dart';
import 'package:shubtest/widget/custom_textbutton.dart';
import 'excel_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextbutton(
                        text: 'Thêm',
                        onPressed: () {
                          Navigator.of(context).pushNamed(TransactionForm.routeName);
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              name: 'start_time',
                              decoration: InputDecoration(labelText: 'Từ'),
                              inputType: InputType.both,
                            ),
                          ),
                          Icon(Icons.arrow_forward_rounded,size: 20,),
                          SizedBox(width: 10,),
                          Expanded(
                            child: FormBuilderDateTimePicker(
                              name: 'end_time',
                              decoration: InputDecoration(labelText: 'Đến'),
                              inputType: InputType.both,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      InkWell(
                          onTap: (){},
                          child: Text('Lọc',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),))
                    ]
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                color: Colors.cyan,
                child: const ExcelDisplayPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
