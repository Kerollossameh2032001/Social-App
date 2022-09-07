import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:social_app1/layout/cubit/cubit.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ReadDocumentScreen extends StatefulWidget {
  final PlatformFile? details;
  final File? document;

  const ReadDocumentScreen({Key? key, this.details, required this.document, }) : super(key: key);

  @override
  State<ReadDocumentScreen> createState() => _ReadDocumentScreenState();
}

class _ReadDocumentScreenState extends State<ReadDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.details!.name,
          style: Theme.of(context).textTheme.headline6,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(
        child: SfPdfViewer.file(widget.document!),
      ),
    );
  }
}
