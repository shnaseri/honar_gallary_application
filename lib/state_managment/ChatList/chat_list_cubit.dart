import 'package:bloc/bloc.dart';
import 'package:honar_api_v19/api.dart';
import 'package:honar_gallary/logic/consts.dart';
import 'package:meta/meta.dart';

part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  late ChatApi chatApi;

  ChatListCubit() : super(ChatListInitial()) {
    chatApi = ChatApi(interfaceOfUser);
  }

  Future<void> fetchChatList() async {
    try {
      List<ChatGetAllChatsList200ResponseInner> chats =
          (await chatApi.chatGetAllChatsList())!;
      print(chats);
      emit(ChatListLoaded(chats));
    } catch (e) {
      emit(ChatListError());
    }
  }
}
