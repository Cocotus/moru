// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_transfer_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the app-wide [FileTransferService] instance.

@ProviderFor(fileTransferService)
final fileTransferServiceProvider = FileTransferServiceProvider._();

/// Provides the app-wide [FileTransferService] instance.

final class FileTransferServiceProvider
    extends
        $FunctionalProvider<
          FileTransferService,
          FileTransferService,
          FileTransferService
        >
    with $Provider<FileTransferService> {
  /// Provides the app-wide [FileTransferService] instance.
  FileTransferServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileTransferServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileTransferServiceHash();

  @$internal
  @override
  $ProviderElement<FileTransferService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FileTransferService create(Ref ref) {
    return fileTransferService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileTransferService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileTransferService>(value),
    );
  }
}

String _$fileTransferServiceHash() =>
    r'b24f589c0a8cb5f9979f97656d7c3176e01c598d';
