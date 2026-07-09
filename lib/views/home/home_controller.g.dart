// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for the MoRPatcher home view.
///
/// Owns the imported configuration, the imported game HTML file and the
/// result of the last patch run. `keepAlive` so the (potentially large)
/// loaded files survive tab switches. Progress and errors are exposed as
/// `AsyncValue<HomeState>`; the view surfaces errors via `ref.listen`.

@ProviderFor(HomeController)
final homeControllerProvider = HomeControllerProvider._();

/// Controller for the MoRPatcher home view.
///
/// Owns the imported configuration, the imported game HTML file and the
/// result of the last patch run. `keepAlive` so the (potentially large)
/// loaded files survive tab switches. Progress and errors are exposed as
/// `AsyncValue<HomeState>`; the view surfaces errors via `ref.listen`.
final class HomeControllerProvider
    extends $AsyncNotifierProvider<HomeController, HomeState> {
  /// Controller for the MoRPatcher home view.
  ///
  /// Owns the imported configuration, the imported game HTML file and the
  /// result of the last patch run. `keepAlive` so the (potentially large)
  /// loaded files survive tab switches. Progress and errors are exposed as
  /// `AsyncValue<HomeState>`; the view surfaces errors via `ref.listen`.
  HomeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeControllerHash();

  @$internal
  @override
  HomeController create() => HomeController();
}

String _$homeControllerHash() => r'01fb6bae2d8dfae7655b76b8d369c65b15420200';

/// Controller for the MoRPatcher home view.
///
/// Owns the imported configuration, the imported game HTML file and the
/// result of the last patch run. `keepAlive` so the (potentially large)
/// loaded files survive tab switches. Progress and errors are exposed as
/// `AsyncValue<HomeState>`; the view surfaces errors via `ref.listen`.

abstract class _$HomeController extends $AsyncNotifier<HomeState> {
  FutureOr<HomeState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HomeState>, HomeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomeState>, HomeState>,
              AsyncValue<HomeState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
