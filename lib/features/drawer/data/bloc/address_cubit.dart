import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/models/address_model.dart';

import '../repository/address_repo.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressRepository addressRepository;

  AddressCubit({required this.addressRepository}) : super(InitState());

  Future<void> address() async {
    try {
      emit(LoadingState());
      final List<AddressModel> data = await addressRepository.address();

      emit(LoadedState(data));
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
