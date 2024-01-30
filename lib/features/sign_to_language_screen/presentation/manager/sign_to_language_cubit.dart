import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/flutter_tts.dart';
import '../../data/data_sources/data_source.dart';
import '../../data/models/sign_to_language_model.dart';
import '../../data/repositories/data_repo.dart';
import '../../domain/entities/sign_to_language_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../../domain/use_cases/sign_use_case.dart';

part 'sign_to_language_state.dart';

class SignToLanguageCubit extends Cubit<SignToLanguageState> {
  SignToLanguageCubit({required this.signToLanguageDataSource})
      : super(SignToLanguageInitial());

  SignToLanguageDataSource signToLanguageDataSource;

  FlutterTtsMe flutterTts = FlutterTtsMe();
  XFile? pickedFileT;
  String newWord = "";
  late VideoPlayerController controller;

  signToLanguageTranslateVideo({required var video}) async {
    emit(SignToLanguageTranslateLoading());

    SignToLanguageDomainRepository signToLanguageDomainRepository =
        SignToLanguageDataRepository(signToLanguageDataSource);
    SignToLanguageVideoTranslateUseCase useCase =
        SignToLanguageVideoTranslateUseCase(signToLanguageDomainRepository);

    var result = await useCase.call(SignToLanguageBody(
      video: video,
    ));

    result.fold((l) {
      emit(SignToLanguageTranslateFailed(l));
    }, (r) {
      emit(SignToLanguageTranslateSuccess(r));
    });
  }
}
