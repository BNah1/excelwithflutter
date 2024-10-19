import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:excel/excel.dart';
import '../bloc/excel_bloc.dart';
import '../bloc/excel_state.dart';

class ExcelDisplayPage extends StatelessWidget {
  const ExcelDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExcelBloc, ExcelState>(
        builder: (context, state) {
          if (state is ExcelLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExcelLoaded) {
            List<List<Data?>> data = [];
            for (var table in state.excel.tables.keys) {
              Sheet sheet = state.excel.tables[table]!;
              // Bắt đầu từ hàng thứ 9 (index 8)
              for (var rowIndex = 8; rowIndex < sheet.maxRows; rowIndex++) {
                var row = sheet.row(rowIndex);
                if (row.every((cell) => cell?.value == null)) {
                  continue;
                }
                data.add(row);
              }
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('STT')),
                    DataColumn(label: Text('Ngày')),
                    DataColumn(label: Text('Giờ')),
                    DataColumn(label: Text('Trạm')),
                    DataColumn(label: Text('Trụ bơm')),
                    DataColumn(label: Text('Mặt hàng')),
                    DataColumn(label: Text('Số lượng')),
                    DataColumn(label: Text('Đơn giá')),
                    DataColumn(label: Text('Thành tiền (VNĐ)')),
                    DataColumn(label: Text('Trạng thái thanh toán')),
                    DataColumn(label: Text('Mã khách hàng')),
                    DataColumn(label: Text('Tên khách hàng')),
                    DataColumn(label: Text('Loại khách hàng')),
                    DataColumn(label: Text('Ngày thanh toán')),
                    DataColumn(label: Text('Nhân viên')),
                    DataColumn(label: Text('Biển số xe')),
                    DataColumn(label: Text('Trạng thái hoá đơn')),
                  ],
                  rows: List.generate(data.length, (index) {
                    return DataRow(
                      cells: [
                        DataCell(Text(data[index][0]?.value.toString() ?? '')),
                        DataCell(Text(data[index][1]?.value.toString() ?? '')),
                        DataCell(Text(data[index][2]?.value.toString() ?? '')),
                        DataCell(Text(data[index][3]?.value.toString() ?? '')),
                        DataCell(Text(data[index][4]?.value.toString() ?? '')),
                        DataCell(Text(data[index][5]?.value.toString() ?? '')),
                        DataCell(Text(data[index][6]?.value.toString() ?? '')),
                        DataCell(Text(data[index][7]?.value.toString() ?? '')),
                        DataCell(Text(data[index][8]?.value.toString() ?? '')),
                        DataCell(Text(data[index][9]?.value.toString() ?? '')),
                        DataCell(Text(data[index][10]?.value.toString() ?? '')),
                        DataCell(Text(data[index][11]?.value.toString() ?? '')),
                        DataCell(Text(data[index][12]?.value.toString() ?? '')),
                        DataCell(Text(data[index][13]?.value.toString() ?? '')),
                        DataCell(Text(data[index][14]?.value.toString() ?? '')),
                        DataCell(Text(data[index][15]?.value.toString() ?? '')),
                        DataCell(Text(data[index][16]?.value.toString() ?? '')),
                      ],
                    );
                  }),
                ),
              ),
            );
          }
          return const Center(child: Text('Chưa có dữ liệu.'));
        },
      ),
    );
  }
}