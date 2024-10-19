import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shubtest/bloc/excel_event.dart';
import 'package:shubtest/bloc/excel_state.dart';

import '../core/utils.dart';

class ExcelBloc extends Bloc<ExcelEvent, ExcelState> {
  ExcelBloc() : super(ExcelInitial()) {
    on<LoadExcel>((event, emit) async {
      emit(ExcelLoading());
      try{
        final Excel? excel = await readExcel();
        if (excel != null) {
          emit(ExcelLoaded(excel,selectedFilePath!));
        } else {
          emit(ExcelError('Khong load duoc file.'));
        }
      } catch (e) {
        emit(ExcelError('Failed to load: ${e.toString()}'));
      }
    });

    on<SaveExcel>((event, emit) async {
      emit(ExcelLoading());
      try {
        final data = await saveExcel(event.data);
        if (data != null) {
          emit(ExcelLoaded(data, selectedFilePath!));
        } else {
          emit(ExcelError('Failed to save'));
        }
      } catch (e) {
        emit(ExcelError('Failed to save: ${e.toString()}'));
      }
    });
  }

  Future<Excel?> readExcel() async {
      try {
        var file = File(selectedFilePath!);
        if (!await file.exists()) {
          print('File không tồn tại!');
          return null;
        }
        var bytes = await file.readAsBytes();
        var excel = Excel.decodeBytes(bytes);
        return excel;
      } catch (e) {
        print('Failed to load: $e');
        return null;
      }
    }


  Future<Excel?> saveExcel(Map<String, dynamic> data) async {
    try {
      if (selectedFilePath == null) {
        print('Đường dẫn tệp không hợp lệ!');
        return null;
      }

      var file = File(selectedFilePath!);
      if (!await file.exists()) {
        print('File không tồn tại!');
        return null;
      }

      var bytes = await file.readAsBytes();
      var excel = Excel.decodeBytes(bytes);
      Sheet sheet = excel.tables[excel.tables.keys.first]!;

      int newSTT = sheet.rows.length + 1;

      String formattedDate = '${data['datetime'].day.toString().padLeft(2, '0')}/'
          '${data['datetime'].month.toString().padLeft(2, '0')}/'
          '${data['datetime'].year}';

      sheet.appendRow([
        IntCellValue(newSTT), // STT
        TextCellValue(formattedDate), //  dd/mm/yyyy
        TimeCellValue(hour: data['datetime'].hour, minute: data['datetime'].minute, second: data['datetime'].second), // giờ
        TextCellValue(data['station'] ?? 'Cửa hàng xăng dầu số 27'),
        TextCellValue(data['pump'] ?? ''), // trụ
        TextCellValue( 'Xăng Ron A95-III'), // mặt hàng
        IntCellValue(int.tryParse(data['quantity']?.toString() ?? '0') ?? 0), // số lượng
        DoubleCellValue(double.tryParse(data['price']?.toString().replaceAll(',', '') ?? '0.0') ?? 0.0),
        DoubleCellValue(double.tryParse(data['revenue']?.toString().replaceAll(',', '') ?? '0.0') ?? 0.0),
        TextCellValue( 'Tiền mặt'), // trạng thái thanh toán
        TextCellValue( 'Khách lẻ'), // Mã khách hàng
        TextCellValue( ''),
        TextCellValue( ''),
        TextCellValue( ''),
        TextCellValue( ''),
        TextCellValue( ''),
        TextCellValue( 'Đã ký'),
      ]);

      List<int>? fileBytes = excel.save();

      if (fileBytes != null) {
        file..createSync(recursive: true)..writeAsBytesSync(fileBytes);
        print('File đã được ghi thành công tại: $selectedFilePath');
        return excel;
      } else {
        return null;
      }
    } catch (e) {
      print('Lỗi khi lưu file: $e');
      return null;
    }
  }
}