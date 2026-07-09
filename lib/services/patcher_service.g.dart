// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patcher_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides the app-wide [PatcherService] instance.

@ProviderFor(patcherService)
final patcherServiceProvider = PatcherServiceProvider._();

/// Provides the app-wide [PatcherService] instance.

final class PatcherServiceProvider
    extends $FunctionalProvider<PatcherService, PatcherService, PatcherService>
    with $Provider<PatcherService> {
  /// Provides the app-wide [PatcherService] instance.
  PatcherServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'patcherServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$patcherServiceHash();

  @$internal
  @override
  $ProviderElement<PatcherService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PatcherService create(Ref ref) {
    return patcherService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PatcherService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PatcherService>(value),
    );
  }
}

String _$patcherServiceHash() => r'190494969fb59ce34ed42568e9306d369b6ddda1';
