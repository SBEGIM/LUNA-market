import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/upload_video_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/data/model/tape_blogger_model.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/ui/tape_statistics_page.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/delete_video_dialog.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/edit_tape_vidoe.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showBlogerTapeOptions(
    BuildContext context, int id, TapeBloggerModel tape) {
  final List<String> categories = [
    "Редактировать",
    "Статистика",
    "Удалить",
  ];

  List<String> filteredCategories = [...categories];

  String selectedCategory = "Все категории";
  TextEditingController searchController = TextEditingController();

  showMaterialModalBottomSheet(
    context: context,

    // isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Заголовок и крестик
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Управление видео',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    Get.to(EditTapeVidoePage(
                      id: id,
                    ));
                  },
                  child: Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.kGray,
                          width: 1.5,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.edit,
                            color: AppColors.mainPurpleColor, size: 18),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Редактировать',
                          style: TextStyle(
                              color: AppColors.kLightBlackColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    Get.to(TapeStatisticsPage(tape: tape));
                  },
                  child: Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.kGray,
                          width: 1.5,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.line_axis,
                            color: AppColors.mainPurpleColor, size: 18),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Статистика',
                          style: TextStyle(
                              color: AppColors.kLightBlackColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (context) => DeleteVideoDialog(
                        onYesTap: () {
                          BlocProvider.of<UploadVideoBLoggerCubit>(context)
                              .delete(tapeId: id);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.kGray,
                          width: 1.5,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.delete_forever_outlined,
                            color: Colors.red, size: 18),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Удалить',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    },
  );
}
