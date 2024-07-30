part of 'on_tap_listner_cubit.dart';

sealed class OnTapListnerState extends Equatable {
  const OnTapListnerState();

  @override
  List<Object> get props => [];
}

final class OnTapListnerInitial extends OnTapListnerState {}
final class OnTapListnerSet extends OnTapListnerState {
final  bool enable;
 const OnTapListnerSet({required this.enable});
  @override
  List<Object> get props => [
    enable
  ];
}