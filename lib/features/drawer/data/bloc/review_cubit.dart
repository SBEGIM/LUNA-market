import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:haji_market/features/drawer/data/bloc/review_state.dart';
import 'package:haji_market/features/drawer/data/models/review_product_model.dart';

import '../repository/review_product_repo.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewProductRepository reviewProductRepository;

  ReviewCubit({required this.reviewProductRepository}) : super(InitState());

  Future<void> reviews() async {
    try {
      emit(LoadingState());
      final List<ReviewProductModel> data =
          await reviewProductRepository.productReviews();

      emit(LoadedState(data));
    } catch (e) {
      log(e.toString() + 'reviewCUBIT');
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> reviewStore(
      String review, String rating, String product_id) async {
    try {
      emit(LoadingState());
      final statusCode =
          await reviewProductRepository.storeReview(review, rating, product_id);
      if (statusCode == 200) {
        final List<ReviewProductModel> data =
            await reviewProductRepository.productReviews();

        emit(LoadedState(data));
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
