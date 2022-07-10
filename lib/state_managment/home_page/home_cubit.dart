import 'package:bloc/bloc.dart';
import 'package:honar_api_v18/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late CoreApi coreApi;

  HomeCubit() : super(HomeInitial()) {
    coreApi = CoreApi(interfaceOfUser);
  }

  Future fetchHome() async {
    try {

    } catch (e) {
      emit(HomeError());
    }
  }
}
