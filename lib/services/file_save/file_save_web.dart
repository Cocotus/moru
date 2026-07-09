import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Web implementation of "save a text file".
///
/// Builds a Blob from the content and triggers a regular browser download
/// via a temporary anchor element — no server round trip involved.
Future<bool> saveTextFilePlatform({
  required String fileName,
  required String content,
}) async {
  final web.BlobPropertyBag blobOptions =
      web.BlobPropertyBag(type: 'text/plain;charset=utf-8');
  final web.Blob blob = web.Blob(
    <web.BlobPart>[content.toJS].toJS,
    blobOptions,
  );

  final String objectUrl = web.URL.createObjectURL(blob);
  final web.HTMLAnchorElement anchor = web.HTMLAnchorElement();
  anchor.href = objectUrl;
  anchor.download = fileName;

  final web.HTMLElement body = web.document.body!;
  body.appendChild(anchor);
  anchor.click();
  anchor.remove();
  web.URL.revokeObjectURL(objectUrl);
  return true;
}
