import 'package:dartz/dartz.dart';
import 'package:sign_language_app/features/sign_to_language_screen/data/models/sign_to_language_model.dart';
import '../../../../core/errors/failures.dart';
import '../entities/sign_to_language_body.dart';
import '../repositories/domain_repo.dart';

class SignToLanguageVideoTranslateUseCase {
  SignToLanguageVideoTranslateUseCase(this.signToLanguageDomainRepository);

  SignToLanguageDomainRepository signToLanguageDomainRepository;

  Future<Either<FailureError, SignToLanguageModel>> call(
      SignToLanguageBody signToLanguageBody) {
    return signToLanguageDomainRepository
        .signToLanguageVideoTranslate(signToLanguageBody);
  }
}
