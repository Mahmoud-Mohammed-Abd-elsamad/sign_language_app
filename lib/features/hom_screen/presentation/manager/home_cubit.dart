import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  // var tabsList = [SignToLanguageScreen(),LanguageToSignScreen()];
  int bottomNavigationSelectedIcon = 0;

   selectedTab(int index){
     bottomNavigationSelectedIcon = index;
     emit(HomeInitial());
   }

   navigateToProfileScreen(){
     emit(ProfileState());
   }
}
