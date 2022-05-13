import 'package:flutter/material.dart';
import 'package:share_button/services/pdf_service.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({Key? key}) : super(key: key);

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  final _pdfService = PdfService();

  void _onPressedDownload() async {
    try {
      _showProgressDownload();
      await _pdfService
          .savePdfLocalStorage('calendario.pdf')
          .then((downloaded) {
        Navigator.of(context).pop();
        if (downloaded) {
          _showFile();
        } else {
          _errorDownloadFile();
        }
      });
    } catch (e) {
      Navigator.of(context).pop();
      _errorDownloadFile();
    }
  }

  void _showProgressDownload() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => const AlertDialog(
        title: Text('Baixando arquivo.'),
        content: LinearProgressIndicator(),
      ),
    );
  }

  void _showFile() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'O download foi concluído.',
        ),
        content: const Text('Deseja abrir o arquivo?'),
        actions: [
          TextButton(
            onPressed: () {
              _pdfService.openFile();

              Navigator.of(context).pop();
            },
            child: const Text('Sim'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Não'),
          ),
        ],
      ),
    );
  }

  void _errorDownloadFile() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Falha no download',
        ),
        content: const Text(
            'Não foi possivel concluir o download. Por favor tente mais tarde.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xFF0e47a1),
      child: const Icon(Icons.share),
      onPressed: () {
        _onPressedDownload();
      },
    );
  }
}
