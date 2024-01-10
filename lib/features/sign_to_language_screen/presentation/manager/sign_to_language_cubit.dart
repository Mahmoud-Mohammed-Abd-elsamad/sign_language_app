import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';


import '../../../../core/errors/failures.dart';
import '../../data/data_sources/data_source.dart';
import '../../data/models/sign_to_language_model.dart';
import '../../data/repositories/data_repo.dart';
import '../../domain/entities/sign_to_language_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../../domain/use_cases/sign_use_case.dart';
import '../pages/camera_page/camera_page.dart';

part 'sign_to_language_state.dart';

class SignToLanguageCubit extends Cubit<SignToLanguageState> {
  SignToLanguageCubit({required this.signToLanguageDataSource})
      : super(SignToLanguageInitial());

  final XFile videoPath =XFile(CameraPage.videos??"bnmbmb,,mnbnbv,m");



  var videoPicker;

  SignToLanguageDataSource signToLanguageDataSource;

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
      print("$l============================================================================================");
      emit(SignToLanguageTranslateFailed(l));
    }, (r) {
      emit(SignToLanguageTranslateSuccess(r));
    });
  }
}
