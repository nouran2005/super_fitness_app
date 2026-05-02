import 'package:equatable/equatable.dart';

abstract class SmartCoachEvent extends Equatable {
  const SmartCoachEvent();

  @override
  List<Object?> get props => [];
}

class GetAllChats extends SmartCoachEvent {}

class GetMessagesByChat extends SmartCoachEvent {
  final int chatId;
  const GetMessagesByChat(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class StartNewChat extends SmartCoachEvent {}

class SendMessage extends SmartCoachEvent {
  final String content;
  const SendMessage(this.content);

  @override
  List<Object?> get props => [content];
}
