import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../data/data_sources/data_source.dart';
import '../../data/models/register_mode.dart';
import '../../data/repositories/data_repo.dart';
import '../../domain/entities/register_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../../domain/use_cases/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterDataSource registerDataSource;

  RegisterCubit(this.registerDataSource) : super(RegisterInitial());

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var obscureText = true;
  var confirmPassword = false;
  var flutterPwValidator = false;

  obscureTextFunction() {
    obscureText = !obscureText;
    emit(RegisterInitial());
  }

  register() async {
    emit(RegisterLoading());

    RegisterDomainRepository registerDomainRepo =
        RegisterDataRepository(registerDataSource);
    RegisterUseCase useCse = RegisterUseCase(registerDomainRepo);

    var result = await useCse.call(RegisterBody(
        name: nameController.text,
        email: emailController.text,
        password: passController.text,
        password_confirmation: confirmPasswordController.text));

    result.fold((l) {
      emit(RegisterFailure(l));
    }, (r) {
      emit(RegisterSuccess(r));
    });
  }

  void confirmPasswordFunction(String value) {
    if (value == passController.text) {
      emit(RegisterInitial());
      confirmPassword = true;
    } else {
      emit(RegisterInitial());
      confirmPassword = false;
    }
  }
//  {
//
//    // remain data source implementation
//    print("register method --------------------------------------------");
//
//    emit(RegisterLoading());
//    RegisterDomainRepository registerDomainRepository =  RegisterDataRepository(registerDataSource);
//   RegisterUseCase useCase = RegisterUseCase(registerDomainRepository);
//
//   var result  = await useCase.call(RegisterBody(name:nameController.text, email: emailController.text, password: passController.text, rePassword: repassController.text));
//
//   result.fold((l) => {
//
//   emit(RegisterFailure(l))
//
//   }, (r) => {
//
//     emit(RegisterSuccess(r))
//   });
//
//
//
// }
}
