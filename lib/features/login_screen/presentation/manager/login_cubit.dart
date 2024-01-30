import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/errors/failures.dart';
import '../../../register_screen/data/models/register_mode.dart';
import '../../data/data_sources/data_source.dart';
import '../../data/repositories/data_repo.dart';
import '../../domain/entities/login_body.dart';
import '../../domain/repositories/domain_repo.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginDataSource}) : super(LoginInitial());
  LoginDataSource loginDataSource;

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var obscureText = true;

  obscureTextFunction() {
    obscureText = !obscureText;
    emit(LoginInitial());
  }

  login() async {
    emit(LoginLoading());

    LoinDomainRepo domainRepo = LoginDataRepo(dataSource: loginDataSource) ;
    LoginUseCase useCae = LoginUseCase(domainRepo: domainRepo);

    var result = await useCae.call(
        LoginBody(email: emailController.text, password: passController.text));

    result.fold((l){
      return emit(LoginFailure(l));}, (r) => emit(LoginSuccess(r)));
  }
}
