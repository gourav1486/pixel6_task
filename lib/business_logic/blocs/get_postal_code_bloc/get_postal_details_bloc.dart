import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pixel6_assignment_task/business_logic/api_repo/post_code_api.dart';
import 'package:pixel6_assignment_task/models/address_controller_model.dart';

part 'get_postal_details_event.dart';
part 'get_postal_details_state.dart';

class GetPostalDetailsBloc
    extends Bloc<GetPostalDetailsEvent, GetPostalDetailsState> {
  GetPostalDetailsBloc() : super(GetPostalDetailsInitial()) {
    final postCodeApi = PostCodeApi();
    on<GetPostalCode>((event, emit) async {
      // TODO: implement event handler
      try {
        var data = await postCodeApi.getAddressFromApi(event.code);
        if (data['status']) {
          event.address.city.text = data['data']['city'][0]['name'];
         event.address.state.text = data['data']['state'][0]['name'];
          emit(PostalDetailsFetched(data: data['data']));
        } else {
          emit(GetPostalDetailsError(data: data));
        }
      } catch (e) {
        emit(GetPostalDetailsError(data: {"status": false, "data": e}));
      }
    });
  }
}
