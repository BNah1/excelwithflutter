abstract class ExcelEvent {}

class LoadExcel extends ExcelEvent{
}

class SaveExcel extends ExcelEvent {
  final Map<String, dynamic> data;
  SaveExcel(this.data);
}

class FilterExcel extends ExcelEvent{
}

