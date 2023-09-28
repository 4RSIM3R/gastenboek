import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';
import 'package:next_starter/utils/constant.dart';
import 'package:nik_validator/nik_validator.dart';

part 'scan_cubit.freezed.dart';
part 'scan_state.dart';

@injectable
class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(const ScanState.initial());

  final textDetector = TextRecognizer();

  Future<void> parseData(String path) async {
    emit(const ScanState.loading());

    final inputImage = InputImage.fromFilePath(path);
    final text = await textDetector.processImage(inputImage);

    NIKModel? model;

    for (TextBlock block in text.blocks) {
      for (TextLine line in block.lines) {
        String text = line.text.trim().replaceAll(" ", "");
        if (nikRegex.hasMatch(text)) {
          /// Parsing raw text and find NIK Informations
          final result = await parse(nikRegex.stringMatch(text)!);

          if (result != null) {
            model = result;
          }
        }
      }
    }

    if (model != null) {
      emit(ScanState.success(model));
    } else {
      emit(const ScanState.failure('Cannot recognized NIK'));
    }
  }

  Future<NIKModel?>? parse(String text) async {
    NIKModel result = await NIKValidator.instance.parse(nik: text);
    if (result.valid == true) {
      return result;
    }
    return null;
  }
}
