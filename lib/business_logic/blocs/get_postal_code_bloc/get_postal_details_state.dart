part of 'get_postal_details_bloc.dart';

sealed class GetPostalDetailsState extends Equatable {
  const GetPostalDetailsState();

  @override
  List<Object> get props => [];
}

final class GetPostalDetailsInitial extends GetPostalDetailsState {}

final class PostalDetailsFetched extends GetPostalDetailsState {
 final Map<String, dynamic> data;
 const PostalDetailsFetched({required this.data});
  @override
  List<Object> get props => [data];
}
final class GetPostalDetailsError extends GetPostalDetailsState {
   final Map<String, dynamic> data;
 const GetPostalDetailsError({required this.data});
  @override
  List<Object> get props => [data];
}