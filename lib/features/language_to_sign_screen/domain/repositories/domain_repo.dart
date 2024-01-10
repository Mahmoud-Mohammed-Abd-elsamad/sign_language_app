import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/sign_to_language_model.dart';
import '../entities/language_to_sign_body.dart';

abstract class LanguageToSignDomainRepository {
  Future<Either<FailureError, LanguageToSignModel>> languageToSignTranslate(
      LanguageToSignBody languageToSignBody);
}
