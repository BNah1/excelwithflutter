import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import '../bloc/excel_bloc.dart';
import '../bloc/excel_event.dart';
import '../bloc/excel_state.dart';
import '../widget/custom_textbutton.dart';
import 'home_screen.dart';

class TransactionForm extends StatefulWidget {
  static String routeName = '/form';

  const TransactionForm({super.key});

  @override
  TransactionFormState createState() => TransactionFormState();
}

class TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  void saveExcel() async {
    if (_formKey.currentState?.saveAndValidate() ?? false){
      final formData = _formKey.currentState!.value;
      await BlocProvider.of<ExcelBloc>(context)..add(SaveExcel(formData));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã lưu...')),
      );

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Check lại input')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Nhập Giao Dịch'),
        actions: [
          BlocBuilder<ExcelBloc, ExcelState>(builder: (context, state){
            return CustomTextbutton(text: 'Cập nhập', onPressed: saveExcel
       );
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderDateTimePicker(
                name: 'datetime',
                decoration: const InputDecoration(labelText: 'Thời gian'),
                inputType: InputType.both,
                format: DateFormat('yyyy-MM-dd HH:mm'),
                validator: FormBuilderValidators.required(
                  errorText: 'Bạn chưa chọn thời gian...',
                ),
              ),
              FormBuilderTextField(
                name: 'quantity',
                decoration: const InputDecoration(labelText: 'Số lượng (lít)'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Bạn chưa nhập thời gian....',
                  ),
                  FormBuilderValidators.numeric(
                    errorText: 'Số lượng phải là số.',
                  ),
                ]),
              ),
              FormBuilderDropdown<String>(
                name: 'pump',
                decoration: const InputDecoration(labelText: 'Trụ'),
                items: List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'))
                    .map((pump) => DropdownMenuItem(
                  value: pump,
                  child: Text(pump),
                ))
                    .toList(),
                validator: FormBuilderValidators.required(
                  errorText: 'Bạn chưa chọn trụ.....',
                ),
              ),
              FormBuilderTextField(
                name: 'revenue',
                decoration: const InputDecoration(labelText: 'Doanh thu'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Bạn chưa nhập doanh thu....',
                  ),
                  FormBuilderValidators.numeric(
                    errorText: 'Doanh thu phải là số.',
                  ),
                ]),
              ),
              FormBuilderTextField(
                name: 'price',
                decoration: const InputDecoration(labelText: 'Đơn giá'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'Bạn chưa nhập đơn giá....',
                  ),
                  FormBuilderValidators.numeric(
                    errorText: 'Đơn giá phải là số.',
                  ),
                ]),
              ),
              SizedBox(height: 100,),
              CustomTextbutton(text: 'Load', onPressed: (){
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              })
            ],
          ),
        ),
      ),
    );
  }
}