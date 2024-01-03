import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../data/data_sources/data_source.dart';
import '../../data/models/sign_to_language_model.dart';
import '../../data/repositories/data_repo.dart';
import '../../domain/repositories/domain_repo.dart';
import '../../domain/use_cases/history_case.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({required this.remoteHistoryDataSource})
      : super(HistoryInitial());

  HistoryDataSource remoteHistoryDataSource;

  getUserHistory() async {
    emit(HistoryLoading());

    HistoryDomainRepository domainRepository =
        HistoryDataRepository(remoteHistoryDataSource);
    HistoryUseCase useCase = HistoryUseCase(domainRepository);

    var result = await useCase.call();

    result.fold((l) => {emit(HistoryFailure(model: l))},
        (r) => {emit(HistorySuccess(model: r))});
  }
}
