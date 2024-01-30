import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sign_language_app/core/errors/failures.dart';
import 'package:sign_language_app/features/hom_screen/data/data_sources/data_source.dart';
import 'package:sign_language_app/features/hom_screen/data/models/profile_model.dart';
import 'package:sign_language_app/features/hom_screen/data/repositories/data_repo.dart';
import 'package:sign_language_app/features/hom_screen/domain/repositories/domain_repo.dart';
import 'package:sign_language_app/features/hom_screen/domain/use_cases/history_case.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.profileDataSource}) : super(HomeInitial());

  ProfileDataSource profileDataSource;

  // var tabsList = [SignToLanguageScreen(),LanguageToSignScreen()];
  int bottomNavigationSelectedIcon = 0;

   selectedTab(int index){
     bottomNavigationSelectedIcon = index;
     emit(HomeInitial());
   }

    String name = "";
    String email = "";




   getProfileData() async{

     ProfileDomainRepository domainRepository = ProfileDataRepository(profileDataSource);
     ProfileUseCase useCase = ProfileUseCase(domainRepository);

     var result =await useCase.call();

     result.fold((l){
       emit(HomeStateFailure(l));
     }, (r){
       emit(HomeStateSuccess(r));
     });


   }




   navigateToProfileScreen(){
     emit(NavigateToProfileScreenSuccess());
   }
}
