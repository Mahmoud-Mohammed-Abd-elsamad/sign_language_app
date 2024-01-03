import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/sign_to_language_model.dart';
import '../repositories/domain_repo.dart';

class HistoryUseCase {
  HistoryUseCase(this.historyDomainRepository);

  HistoryDomainRepository historyDomainRepository;

  Future<Either<FailureError, HistoryModel>> call() {
    return historyDomainRepository
        .history();
  }
}
