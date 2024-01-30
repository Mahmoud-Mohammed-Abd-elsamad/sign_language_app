import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/errors/failures.dart';
import '../../data/data_sources/data_source.dart';
import '../../data/models/register_mode.dart';
import '../../data/repositories/data_repo.dart';
import '../../domain/entities/reset_password_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../../domain/use_cases/reset_password_use_case.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordDataSource resetPasswordDataSource;

  ResetPasswordCubit({required this.resetPasswordDataSource})
      : super(ResetPasswordInitial());

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  resetPassword() async {
    emit(ResetPasswordLoading());

    ResetPasswordDomainRepository resetPasswordDomainRepository =
        ResetPasswordDataRepository(resetPasswordDataSource);
    ResetPasswordUseCase useCse =
        ResetPasswordUseCase(resetPasswordDomainRepository);

    var result = await useCse.call(ResetPasswordBody(
      name: nameController.text,
      email: emailController.text,
    ));

    result.fold((l) {
      emit(ResetPasswordFailure(l));
    }, (r) {
      emit(ResetPasswordSuccess(r));
    });
  }
}
