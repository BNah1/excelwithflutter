import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

String? selectedFilePath;

Future<void> pickAndEditExcelFile(bool chooseAgain) async {

  await requestStoragePermissions();

  if (selectedFilePath == null) {
    await _pickFile();
  } else {
    chooseAgain ? await _pickFile() :
    print('Đã chọn: $selectedFilePath');
  }
}

_pickFile() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx'],
  );

  if (result != null && result.files.isNotEmpty) {
    selectedFilePath = result.files.single.path;
    print('File đã chọn: $selectedFilePath');

  } else {
    print('chưa chọn');
    return;
  }
}

Future<void> requestStoragePermissions() async {
  Permission.storage.request();
  if (await Permission.storage.request().isGranted) {
  } else {
    print('Lỗi từ chối quyền');
  }
}