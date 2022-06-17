part of 'chat_list_cubit.dart';

@immutable
abstract class ChatListState {}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<InlineResponse2006> chats;

  ChatListLoaded(this.chats);
}

class ChatListError extends ChatListState {}
