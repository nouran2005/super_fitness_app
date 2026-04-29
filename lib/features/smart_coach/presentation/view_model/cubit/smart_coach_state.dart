import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/app/config/base_state/base_state.dart';

class SmartCoachState extends Equatable {
  final Resource<List<Map<String, dynamic>>> chatsResource;
  final Resource<List<Map<String, dynamic>>> messagesResource;
  final int? currentChatId;
  final bool isSendingMessage;

  const SmartCoachState({
    required this.chatsResource,
    required this.messagesResource,
    this.currentChatId,
    this.isSendingMessage = false,
  });

  factory SmartCoachState.initial() => SmartCoachState(
    chatsResource: Resource.initial(),
    messagesResource: Resource.initial(),
  );

  SmartCoachState copyWith({
    Resource<List<Map<String, dynamic>>>? chatsResource,
    Resource<List<Map<String, dynamic>>>? messagesResource,
    int? currentChatId,
    bool? isSendingMessage,
  }) {
    return SmartCoachState(
      chatsResource: chatsResource ?? this.chatsResource,
      messagesResource: messagesResource ?? this.messagesResource,
      currentChatId: currentChatId ?? this.currentChatId,
      isSendingMessage: isSendingMessage ?? this.isSendingMessage,
    );
  }

  @override
  List<Object?> get props => [
    chatsResource,
    messagesResource,
    currentChatId,
    isSendingMessage,
  ];
}
