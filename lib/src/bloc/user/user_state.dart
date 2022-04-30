part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({required this.logged});
  final bool logged;
  UserState copyWith({
    bool? logged,
  }) =>
      UserState(
        logged: logged ?? this.logged,
      );
  @override
  List<Object> get props => [
        logged,
      ];
}
