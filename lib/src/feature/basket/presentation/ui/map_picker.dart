import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/basket/data/models/cdek_office_old_model.dart';
import 'package:haji_market/src/feature/basket/data/DTO/map_geo_dto.dart';
import 'package:haji_market/src/feature/basket/bloc/cdek_office_cubit.dart';
import 'package:haji_market/src/feature/basket/bloc/cdek_office_state.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@RoutePage()
class MapPickerPage extends StatefulWidget {
  final MapGeoDTO? mapGeo;
  final int? cc;
  final double? lat;
  final double? long;

  const MapPickerPage({super.key, this.mapGeo, this.cc, this.lat, this.long});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  YandexMapController? controller;
  bool isNightModeEnabled = false;

  Point? _point;
  Uint8List? asd;
  String? place;
  final List<MapObject> mapObjects = [];

  bool _mapObjectsInitialized = false;

  @override
  void initState() {
    super.initState();
    _point = Point(longitude: widget.long!, latitude: widget.lat!);

    BlocProvider.of<CdekOfficeCubit>(context).cdek(widget.cc ?? 0);
  }

  @override
  void dispose() {
    // НЕ диспоузим controller здесь — YandexMap сделает это сам
    super.dispose();
  }

  void _placeMarkAdd(List<CdekOfficeOldModel> data) {
    if (_mapObjectsInitialized) return;
    _mapObjectsInitialized = true;

    for (int i = 0; i < data.length; i++) {
      mapObjects.add(
        PlacemarkMapObject(
          mapId: MapObjectId('placeMark $i'),
          opacity: 1.0,
          point: Point(
            latitude: double.tryParse(data[i].coordY!)!,
            longitude: double.tryParse(data[i].coordX!)!,
          ),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(Assets.icons.mapLocation.path),
              scale: 1,
            ),
          ),
          onTap: (mapObject, point) {
            AppSnackBar.show(context, data[i].addressComment!, type: AppSnackType.success);
            place = data[i].fullAddress;
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Способ доставки', style: AppTextStyles.size18Weight600),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<CdekOfficeCubit, CdekOfficeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ErrorState) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Colors.red)),
            );
          }

          if (state is LoadedState) {
            _placeMarkAdd(state.cdekOffice);

            return Stack(
              children: <Widget>[
                YandexMap(
                  onMapCreated: (YandexMapController yandexMapController) async {
                    controller = yandexMapController;
                    controller!.moveCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(target: _point!, zoom: 14)),
                      animation: const MapAnimation(duration: 3.0),
                    );
                  },
                  mapObjects: mapObjects,
                ),
                Positioned.fill(
                  right: 15,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (controller == null) return;
                            controller!.moveCamera(
                              CameraUpdate.zoomIn(),
                              animation: const MapAnimation(duration: 2.0),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(11),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  offset: Offset(0, 1),
                                  blurRadius: 4,
                                ),
                              ],
                              color: Color(0xe5fefefe),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: Icon(Icons.add, color: AppColors.mainPurpleColor),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (controller == null) return;
                            controller!.moveCamera(
                              CameraUpdate.zoomOut(),
                              animation: const MapAnimation(duration: 2.0),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(11),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  offset: Offset(0, 1),
                                  blurRadius: 4,
                                ),
                              ],
                              color: Color(0xe5fefefe),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                            ),
                            child: Icon(Icons.remove, color: AppColors.mainPurpleColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 120,
                  right: -15,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          final loc = await Geolocator.getCurrentPosition();

                          if (!mounted || controller == null) return;

                          final myPoint = Point(latitude: loc.latitude, longitude: loc.longitude);

                          controller!.moveCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(target: myPoint, zoom: 6),
                            ),
                            animation: const MapAnimation(duration: 2.0),
                          );
                        } catch (exception) {
                          Get.snackbar(
                            'Ошибка ',
                            'Не удалось найти местоположение',
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      child: SizedBox(
                        height: 104,
                        width: 104,
                        child: Center(child: Image.asset(Assets.icons.userLocation.path)),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: AppColors.mainPurpleColor));
          }
        },
      ),
      bottomSheet: TextButton(
        onPressed: () async {
          if (place == null) return;

          // возвращаем значение наверх
          context.router.pop<String>(place!);
        },
        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
        child: Container(
          height: 52,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 40),
          decoration: BoxDecoration(
            color: AppColors.mainPurpleColor,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Center(
            child: Text(
              'Заберу отсюда',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
