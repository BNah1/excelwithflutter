import 'package:excel/excel.dart';

abstract class ExcelState {
}

class ExcelInitial extends ExcelState{}
class ExcelLoading extends ExcelState{}

class ExcelLoaded extends ExcelState{
  String selectedFilePath;
  Excel excel;
  ExcelLoaded(this.excel, this.selectedFilePath);
}

class ExcelError extends ExcelState {
  final String message;

  ExcelError(this.message);
}