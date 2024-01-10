import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/sign_to_language_model.dart';


abstract class HistoryDomainRepository {
  Future<Either<FailureError, HistoryModel>>
  history();
}
