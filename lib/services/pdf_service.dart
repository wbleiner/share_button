import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_button/repositories/remote_pdf_repository.dart';

class PdfService {
  File? _pathFile;

  Future<bool> savePdfLocalStorage(String fileName) async {
    final permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      final fileBytes = await RemotePdfRepository.getRemotePdf();
      if (fileBytes.isEmpty) return false;

      _pathFile = await _getDirectoryPath(fileName);
      if (_pathFile == null) return false;

      await _pathFile!.writeAsBytes(fileBytes);
      return true;
    }
    return false;
  }

  Future<File> _getDirectoryPath(String fileName) async {
    final appDir = await getExternalStorageDirectory();

    final pathFile = File('${appDir?.path}/$fileName');
    return pathFile;
  }

  void openFile() {
    OpenFile.open(_pathFile!.path);
  }
}
