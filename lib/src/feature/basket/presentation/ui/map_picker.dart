import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/data/DTO/cdek_office_old_model.dart';
import 'package:haji_market/src/feature/basket/data/DTO/map_geo.dart';
import 'package:haji_market/src/feature/basket/data/bloc/cdek_office_cubit.dart';
import 'package:haji_market/src/feature/basket/data/bloc/cdek_office_state.dart';
import 'package:haji_market/src/feature/basket/presentation/ui/basket_order_page.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class MapPickerPage extends StatefulWidget {
  final MapGeo? mapGeo;
  final int? cc;
  final double? lat;
  final double? long;
  const MapPickerPage({Key? key, this.mapGeo, this.cc, this.lat, this.long})
      : super(key: key);

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  YandexMapController? controller;
  bool isNightModeEnabled = false;

  Point? _point;
  Uint8List? asd;
  String? place;
  List<MapObject> MapObjects = [];

  @override
  void initState() {
    super.initState();
    _point = Point(longitude: widget.long!, latitude: widget.lat!);

    BlocProvider.of<CdekOfficeCubit>(context).cdek(widget.cc ?? 0);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  _placeMarkAdd(List<CdekOfficeOldModel> data) {
    for (int i = 0; i < data.length; i++) {
      MapObjects.add(PlacemarkMapObject(
        mapId: MapObjectId('placeMark $i'),
        point: Point(
            latitude: double.tryParse(data[i].coordY!)!,
            longitude: double.tryParse(data[i].coordX!)!),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage('assets/icons/place.png'),
              scale: 2),
        ),
        onTap: ((mapObject, point) {
          Get.snackbar(data[i].name!, data[i].addressComment!,
              backgroundColor: Colors.blueAccent);
          //[i].name!;
          place = data[i].fullAddress;
        }),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        title: const Text(
          'Способ доставки',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<CdekOfficeCubit, CdekOfficeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is LoadedState) {
            _placeMarkAdd(state.cdekOffice);

            sleep(Duration(seconds: 2));
            return Stack(
              children: <Widget>[
                YandexMap(
                  onMapCreated:
                      (YandexMapController yandexMapController) async {
                    controller = yandexMapController;
                    controller!.moveCamera(
                      CameraUpdate.newCameraPosition(
                          CameraPosition(target: _point!, zoom: 14)),
                      animation: const MapAnimation(duration: 3.0),
                    );
                  },
                  mapObjects: MapObjects,
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
                            // await controller!.getMaxZoom();
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
                                )
                              ],
                              color: Color(0xe5fefefe),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/icon-tab-plus.svg',
                              color: Colors.black,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
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
                                )
                              ],
                              color: Color(0xe5fefefe),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(24),
                                bottomRight: Radius.circular(24),
                              ),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/icon-tab-minus.svg',
                              color: Colors.black,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 8,
                  right: 16,
                  child: GestureDetector(
                    onTap: () async {
                      try {
                        final loc = await Geolocator.getCurrentPosition();
                        final _myPoint = Point(
                            latitude: loc.latitude, longitude: loc.longitude);

                        controller!.moveCamera(
                          CameraUpdate.newCameraPosition(
                              CameraPosition(target: _myPoint, zoom: 6)),
                          animation: const MapAnimation(duration: 2.0),
                        );

                        //  controller!.move(point: _myPoint);
                      } catch (exception) {
                        Get.snackbar(
                            'Ошибка ', 'Не удалось найти местоположение',
                            backgroundColor: Colors.red);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(11),
                      decoration: const BoxDecoration(
                        color: Color(0xe5fefefe),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x33000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/icon-tab-navigation.svg',
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ),
            );
          }
        },
      ),
      bottomSheet: TextButton(
        onPressed: () async {
          // final mapgeo = MapGeo(
          //   address: place,
          //   lat: controller!.placemarks[0].point.latitude,
          //   long: controller!.placemarks[0].point.longitude,
          // );

          Get.to(BasketOrderPage(
            fbs: true,
            fulfillment: 'fbs',
          ));

          // context.router.push(BasketOrderRoute(fbs: true, address: place, fulfillment: 'fbs'));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Container(
          height: 48,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 40),
          decoration: BoxDecoration(
            color: AppColors.kPrimaryColor,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Center(
            child: Text(
              'Готово',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
