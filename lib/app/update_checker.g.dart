// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_checker.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateChecker)
final updateCheckerProvider = UpdateCheckerProvider._();

final class UpdateCheckerProvider
    extends
        $FunctionalProvider<
          AsyncValue<UpdateCheckResult?>,
          UpdateCheckResult?,
          FutureOr<UpdateCheckResult?>
        >
    with
        $FutureModifier<UpdateCheckResult?>,
        $FutureProvider<UpdateCheckResult?> {
  UpdateCheckerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateCheckerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateCheckerHash();

  @$internal
  @override
  $FutureProviderElement<UpdateCheckResult?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UpdateCheckResult?> create(Ref ref) {
    return updateChecker(ref);
  }
}

String _$updateCheckerHash() => r'90f3165cb04aefe7fe24a1c256d63a7bca748d3c';
