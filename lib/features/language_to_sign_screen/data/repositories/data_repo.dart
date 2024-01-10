import 'package:dartz/dartz.dart';


import '../../../../core/errors/failures.dart';
import '../../domain/entities/language_to_sign_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../data_sources/data_source.dart';
import '../models/sign_to_language_model.dart';

class LanguageToSignDataRepository extends LanguageToSignDomainRepository {
  LanguageToSignDataRepository(this.languageToSignDataSource);

  LanguageToSignDataSource languageToSignDataSource;

  @override
  Future<Either<FailureError, LanguageToSignModel>> languageToSignTranslate(
      LanguageToSignBody languageToSignBody) {
    return languageToSignDataSource.languageToSignTranslate(languageToSignBody);
  }
}
