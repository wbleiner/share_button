import 'dart:typed_data';

import 'package:http/http.dart' as http;

const _url =
    'https://www2.pucgoias.edu.br/ArquivisWordpress/calendario-academico-2022/calendario-01-22.02.2022.pdf';

class RemotePdfRepository {
  static Future<Uint8List> getRemotePdf() async {
    final response = await http.get(
      Uri.parse(
        _url,
      ),
    );
    return response.bodyBytes;
  }
}
