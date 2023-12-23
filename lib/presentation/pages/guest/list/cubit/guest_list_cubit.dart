import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mnc_identifier_ocr/mnc_identifier_ocr.dart';
import 'package:mnc_identifier_ocr/model/ocr_result_model.dart';
import 'package:next_starter/data/models/guest/guest_list_model.dart';
import 'package:next_starter/utils/constant.dart';

part 'guest_list_cubit.freezed.dart';
part 'guest_list_state.dart';

@injectable
class GuestListCubit extends Cubit<GuestListState> {
  GuestListCubit() : super(const GuestListState.initial());

  Future<void> fetch(int id) async {
    try {
      emit(const GuestListState.loading());

      final response = await supabase.from('guests').select().eq('agenda_id', id);

      final payload = response.map((e) => GuestListModel.fromJson(e)).toList();

      emit(GuestListState.success(payload));
    } catch (e) {
      emit(GuestListState.failure(e.toString()));
    }
  }

  Future<void> insert(int id) async {
    try {
      OcrResultModel res = await MncIdentifierOcr.startCaptureKtp(withFlash: false, cameraOnly: false);
      final user = supabase.auth.currentUser;

      final data = {
        'agenda_id': id,
        'user_id': user?.id,
        'address': '${res.ktp?.alamat}, ${res.ktp?.kabKot}',
        'nik': '${res.ktp?.nik}',
        'name': '${res.ktp?.nama}'
      };

      // final data = Map.of(payload);

      // data['user_id'] = user?.id;

      await supabase.from('guests').insert(data);

      fetch(id);
    } catch (e) {
      emit(GuestListState.failure(e.toString()));
    }
  }
}
