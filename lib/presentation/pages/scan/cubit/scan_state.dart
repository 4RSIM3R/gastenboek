part of 'scan_cubit.dart';

@freezed
class ScanState with _$ScanState {
  const factory ScanState.initial() = _Initial;
  const factory ScanState.loading() = _Loading;
  const factory ScanState.failure(String message) = _Failure;
  const factory ScanState.success(NIKModel model) = _Success;
}
