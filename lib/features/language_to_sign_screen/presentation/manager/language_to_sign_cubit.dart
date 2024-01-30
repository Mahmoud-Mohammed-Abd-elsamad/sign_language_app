import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/flutter_tts.dart';
import '../../data/data_sources/data_source.dart';
import '../../data/models/sign_to_language_model.dart';
import '../../data/repositories/data_repo.dart';
import '../../domain/entities/language_to_sign_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../../domain/use_cases/language_to_sign_use_case.dart';

part 'language_to_sign_state.dart';

class LanguageToSignCubit extends Cubit<LanguageToSignState> {
  LanguageToSignCubit({required this.languageToSignDataSource})
      : super(LanguageToSignInitial());
  LanguageToSignDataSource languageToSignDataSource;

  final FlutterTtsMe flutterTts = FlutterTtsMe();
  TextEditingController textController = TextEditingController();

  void languageToSignTranslate() async {
    emit(LanguageToSignLoading());

    LanguageToSignDomainRepository languageToSignDomainRepository =
        LanguageToSignDataRepository(languageToSignDataSource);
    LanguageToSignTranslateUseCase useCase =
        LanguageToSignTranslateUseCase(languageToSignDomainRepository);

    var result =
        await useCase.call(LanguageToSignBody(text: textController.text));

    result.fold((l) {
      emit(LanguageToSignFailed(l));
    }, (r) {
      emit(LanguageToSignSuccess(r));
    });
  }
}
