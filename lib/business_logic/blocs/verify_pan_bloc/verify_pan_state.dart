part of 'verify_pan_bloc.dart';

sealed class VerifyPanState extends Equatable {
  const VerifyPanState();
  
  @override
  List<Object> get props => [];
}

final class VerifyPanInitial extends VerifyPanState {}
final class PanVerifiedSuccess extends VerifyPanState {}
final class VerifyPanFail extends VerifyPanState {}


