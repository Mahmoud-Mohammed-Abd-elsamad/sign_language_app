import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/cach_helper.dart';

part 'setting_screen_state.dart';

class SettingScreenCubit extends Cubit<SettingScreenState> {
  SettingScreenCubit() : super(SettingScreenInitial());

  double setSpeechRateSliderValue = CacheHelper.getSpeechRateSettings() ?? .6;
  double setVolumeSliderValue =CacheHelper.getVolumeSettings() ?? .8;
  double value = 50;
  int weightCounter = 40;
  int edgeCounter = 15;

  setStateSettingScreen(){
    emit(SettingScreenSetState());
  }
}
