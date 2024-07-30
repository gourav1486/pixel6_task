part of 'verify_pan_bloc.dart';

sealed class VerifyPanEvent extends Equatable {
  const VerifyPanEvent();

  @override
  List<Object> get props => [];
}

class VerifyPan extends VerifyPanEvent {
  final String panNumber;
  const VerifyPan({required this.panNumber});
   @override
  List<Object> get props => [panNumber];
}
