import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/sign_to_language_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../data_sources/data_source.dart';
import '../models/sign_to_language_model.dart';

class SignToLanguageDataRepository extends SignToLanguageDomainRepository {
  SignToLanguageDataRepository(this.signToLanguageDataSource);

  SignToLanguageDataSource signToLanguageDataSource;

  @override
  Future<Either<FailureError, SignToLanguageModel>>
      signToLanguageVideoTranslate(SignToLanguageBody signToLanguageBody) {
    return signToLanguageDataSource
        .signToLanguageVideoTranslate(signToLanguageBody);
  }
}
