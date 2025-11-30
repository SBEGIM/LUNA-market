import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/drawer/bloc/review_state.dart';
import 'package:haji_market/src/feature/drawer/data/models/review_product_model.dart';

import '../data/repository/review_product_repo.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewProductRepository reviewProductRepository;

  ReviewCubit({required this.reviewProductRepository}) : super(InitState());

  Future<void> reviews(String product_id) async {
    try {
      emit(LoadingState());
      final List<ReviewProductModel> data = await reviewProductRepository.productReviews(
        product_id,
      );

      emit(LoadedState(data));
    } catch (e) {
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }

  Future<void> reviewStore(
    BuildContext context,
    int orderId,
    String review,
    String rating,
    String productId,
    List<dynamic> images,
  ) async {
    try {
      emit(LoadingState());
      final statusCode = await reviewProductRepository.storeReview(
        orderId,
        review,
        rating,
        productId,
        images,
      );
      if (statusCode == 200) {
        final List<ReviewProductModel> data = await reviewProductRepository.productReviews(
          productId,
        );

        emit(LoadedState(data));
        AppSnackBar.show(context, 'Ваш  отзыв добавлен', type: AppSnackType.success);
      } else {
        final List<ReviewProductModel> data = await reviewProductRepository.productReviews(
          productId,
        );

        emit(LoadedState(data));

        AppSnackBar.show(context, 'Вы не можете оставлять отзыв', type: AppSnackType.error);
      }
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: 'Ошибка сервера'));
    }
  }
}
