import 'dart:io';

import 'package:file_picker/file_picker.dart';

/// Desktop (Windows/Linux) implementation of "save a text file".
///
/// Opens the native "Save as" dialog via `file_picker` and writes the
/// content to the chosen path. Returns `false` when the user cancels.
Future<bool> saveTextFilePlatform({
  required String fileName,
  required String content,
}) async {
  // Offer the file's own extension as filter, e.g. "html" or "json".
  final int dotIndex = fileName.lastIndexOf('.');
  final List<String> allowedExtensions;
  if (dotIndex >= 0 && dotIndex < fileName.length - 1) {
    allowedExtensions = <String>[fileName.substring(dotIndex + 1)];
  } else {
    allowedExtensions = <String>[];
  }

  final String? savePath = await FilePicker.saveFile(
    fileName: fileName,
    type: allowedExtensions.isEmpty ? FileType.any : FileType.custom,
    allowedExtensions: allowedExtensions.isEmpty ? null : allowedExtensions,
  );
  if (savePath == null) {
    return false;
  }

  final File file = File(savePath);
  await file.writeAsString(content);
  return true;
}
