import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Platform-specific "save file": browser download on web, native
// "Save as" dialog plus dart:io write on desktop.
import 'package:flutter_template_appwrite/services/file_save/file_save_io.dart'
    if (dart.library.js_interop) 'package:flutter_template_appwrite/services/file_save/file_save_web.dart'
    as file_save;

part 'file_transfer_service.g.dart';

/// A text file the user picked, already decoded to a string.
class PickedTextFile {
  /// Creates a [PickedTextFile].
  const PickedTextFile({required this.name, required this.content});

  /// The file name including extension, e.g. `start_game.html`.
  final String name;

  /// The decoded UTF-8 content of the file.
  final String content;
}

/// Moves text files between the user's machine and the app.
///
/// This is the only place that talks to `file_picker` and the platform
/// download/save mechanisms, so controllers stay free of platform checks
/// and can be tested with a fake of this service. The whole patcher works
/// file-based on purpose — no database involved.
class FileTransferService {
  /// Creates a [FileTransferService].
  const FileTransferService();

  /// Lets the user pick a single text file filtered to [allowedExtensions]
  /// (without leading dots, e.g. `['html']`).
  ///
  /// Returns `null` when the user cancels the dialog. Throws a
  /// [FormatException] when the file is not valid UTF-8.
  Future<PickedTextFile?> pickTextFile({
    required List<String> allowedExtensions,
  }) async {
    final FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      // Ask for the bytes directly; works identically on web and desktop.
      withData: true,
    );
    if (result == null || result.files.isEmpty) {
      return null;
    }

    final PlatformFile pickedFile = result.files.first;
    final Uint8List? bytes = pickedFile.bytes;
    if (bytes == null) {
      return null;
    }

    final String content = utf8.decode(bytes);
    return PickedTextFile(name: pickedFile.name, content: content);
  }

  /// Saves [content] under the suggested [fileName].
  ///
  /// On web this triggers a browser download; on desktop it opens a
  /// "Save as" dialog. Returns `false` when the user cancels.
  Future<bool> saveTextFile({
    required String fileName,
    required String content,
  }) {
    return file_save.saveTextFilePlatform(
      fileName: fileName,
      content: content,
    );
  }
}

/// Provides the app-wide [FileTransferService] instance.
@Riverpod(keepAlive: true)
FileTransferService fileTransferService(Ref ref) {
  return const FileTransferService();
}
