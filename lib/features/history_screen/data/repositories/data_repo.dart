import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/history_body.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/repositories/domain_repo.dart';
import '../data_sources/data_source.dart';
import '../models/sign_to_language_model.dart';

class HistoryDataRepository extends HistoryDomainRepository {
  HistoryDataRepository(this.historyDataSource);

  HistoryDataSource historyDataSource;

  @override
  Future<Either<FailureError, HistoryModel>>
      history() {
    return historyDataSource
        .history();
  }
}
