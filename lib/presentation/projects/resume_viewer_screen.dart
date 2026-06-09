import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class ResumeViewerScreen extends StatefulWidget {
  const ResumeViewerScreen({super.key});

  @override
  State<ResumeViewerScreen> createState() => _ResumeViewerScreenState();
}

class _ResumeViewerScreenState extends State<ResumeViewerScreen> {
  PdfControllerPinch? _pdfController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadPDF();
  }

  Future<void> _loadPDF() async {
    try {
      // Load PDF from assets and copy to temporary directory
      try {
        final ByteData data = await rootBundle.load('assets/pdf/resumeanuj.pdf');
        final List<int> bytes = data.buffer.asUint8List();
        
        final tempDir = await getTemporaryDirectory();
        final File file = File('${tempDir.path}/resumeanuj.pdf');
        await file.writeAsBytes(bytes);
        
        if (mounted) {
          _pdfController = PdfControllerPinch(
            document: PdfDocument.openFile(file.path),
          );
          setState(() => _isLoading = false);
        }
      } catch (e) {
        debugPrint('PDF load error: $e');
        if (mounted) {
          setState(() {
            _errorMessage =
                'Failed to load resume. Please ensure resumeanuj.pdf is in assets/pdf/ folder.';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      debugPrint('Resume load error: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'Failed to load resume: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resume')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });
                      _loadPDF();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            )
          : _pdfController != null
          ? PdfViewPinch(controller: _pdfController!)
          : const Center(child: Text('Unable to load PDF')),
    );
  }
}
