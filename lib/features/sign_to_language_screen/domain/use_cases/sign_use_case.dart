import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/sign_to_language_body.dart';
import '../entities/sign_to_language_entity.dart';
import '../repositories/domain_repo.dart';

class SignToLanguageVideoTranslateUseCase {
  SignToLanguageVideoTranslateUseCase(this.signToLanguageDomainRepository);

  SignToLanguageDomainRepository signToLanguageDomainRepository;

  Future<Either<FailureError, SignToLanguageEntity>> call(
      SignToLanguageBody signToLanguageBody) {
    return signToLanguageDomainRepository
        .signToLanguageVideoTranslate(signToLanguageBody);
  }
}
