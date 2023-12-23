part of 'guest_list_cubit.dart';

@freezed
class GuestListState with _$GuestListState {
  const factory GuestListState.initial() = _Initial;
  const factory GuestListState.loading() = _Loading;
  const factory GuestListState.failure(String mesage) = _Failure;
  const factory GuestListState.success(List<GuestListModel> payload) = _Success;
}
