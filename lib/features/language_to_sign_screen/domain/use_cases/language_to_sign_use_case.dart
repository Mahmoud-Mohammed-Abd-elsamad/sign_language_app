import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/sign_to_language_model.dart';
import '../entities/language_to_sign_body.dart';
import '../entities/language_to_sign_entity.dart';
import '../repositories/domain_repo.dart';

class LanguageToSignTranslateUseCase {
  LanguageToSignTranslateUseCase(this.languageToSignDomainRepository);

  LanguageToSignDomainRepository languageToSignDomainRepository;

  Future<Either<FailureError, LanguageToSignModel>> call(
      LanguageToSignBody languageToSignBody) {
    return languageToSignDomainRepository
        .languageToSignTranslate(languageToSignBody);
  }
}
