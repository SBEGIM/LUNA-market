import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/features/drawer/data/bloc/review_state.dart';
import 'package:haji_market/features/drawer/data/models/review_product_model.dart';

import '../repository/review_product_repo.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewProductRepository reviewProductRepository;

  ReviewCubit({required this.reviewProductRepository}) : super(InitState());

  Future<void> reviews(String product_id) async {
    try {
      emit(LoadingState());
      final List<ReviewProductModel> data =
          await reviewProductRepository.productReviews(product_id);

      emit(LoadedState(data));
    } catch (e) {
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
            await reviewProductRepository.productReviews(product_id);

        emit(LoadedState(data));
      } else {
        final List<ReviewProductModel> data =
            await reviewProductRepository.productReviews(product_id);

        emit(LoadedState(data));

        Get.snackbar('Ошибка', 'Вы не можете оставлять отзыв',
            backgroundColor: Colors.orangeAccent);
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
