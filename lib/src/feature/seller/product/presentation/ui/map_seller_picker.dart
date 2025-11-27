import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:haji_market/src/core/common/constants.dart';

@RoutePage()
class MapSellerPickerPage extends StatefulWidget {
  final double lat;
  final double long;

  const MapSellerPickerPage({Key? key, required this.lat, required this.long}) : super(key: key);

  @override
  State<MapSellerPickerPage> createState() => _MapSellerPickerPageState();
}

class _MapSellerPickerPageState extends State<MapSellerPickerPage> {
  YandexMapController? controller;

  late Point _centerPoint;
  double _radius = 1000; // радиус в метрах по умолчанию (1 км)

  @override
  void initState() {
    super.initState();
    _centerPoint = Point(latitude: widget.lat, longitude: widget.long);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // создаём объект Circle
  CircleMapObject _createCircle() {
    return CircleMapObject(
      mapId: const MapObjectId('radius_circle'),
      strokeColor: AppColors.mainPurpleColor.withOpacity(0.5),
      fillColor: AppColors.mainPurpleColor.withOpacity(0.2),
      strokeWidth: 2,
      circle: Circle(center: _centerPoint, radius: _radius),
    );
  }

  PlacemarkMapObject _createCenterPlacemark() {
    return PlacemarkMapObject(
      mapId: const MapObjectId('center_point'),
      point: _centerPoint,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/icons/center_map.png'),
          scale: 1.5,
        ),
      ),
    );
  }

  double _calculateZoom(double radius) {
    // Эта формула эмпирическая — можно "подстроить" под свою карту
    // 20 — самый большой зум (приближение), 1 — самый маленький (вся планета)
    // Коэффициент подобран для Yandex MapKit
    const double maxZoom = 17;
    const double minZoom = 10;

    // Радиус в метрах => log-шкала
    double zoomLevel = maxZoom - (radius / 1000).toDouble() * 1.5;

    // Ограничим диапазон
    if (zoomLevel > maxZoom) zoomLevel = maxZoom;
    if (zoomLevel < minZoom) zoomLevel = minZoom;

    return zoomLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kLightBlackColor),
        title: const Text(
          'Радиус продажи продукта',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          YandexMap(
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
              controller!.moveCamera(
                CameraUpdate.newCameraPosition(CameraPosition(target: _centerPoint, zoom: 14)),
                animation: const MapAnimation(duration: 2.0),
              );
            },
            mapObjects: [_createCircle(), _createCenterPlacemark()],
          ),
          Positioned(
            bottom: 100,
            left: 16,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_radius.round()} метров',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
                Slider(
                  min: 100, // мин радиус
                  max: 5000, // макс радиус
                  divisions: 49, // шаг по 100м
                  value: _radius,
                  activeColor: AppColors.mainPurpleColor,
                  // inactiveColor: AppColors.mainPurpleColor.withOpacity(0.3),
                  label: '${_radius.round()} м',
                  onChanged: (value) {
                    setState(() {
                      _radius = value;
                    });

                    // Обновляем zoom в зависимости от радиуса
                    final newZoom = _calculateZoom(_radius);

                    controller?.moveCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: _centerPoint, zoom: newZoom),
                      ),
                      animation: const MapAnimation(duration: 0.5),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 16,
            right: 16,
            child: GestureDetector(
              onTap: () async {
                try {
                  final loc = await Geolocator.getCurrentPosition();
                  final myPoint = Point(latitude: loc.latitude, longitude: loc.longitude);

                  controller!.moveCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(target: myPoint, zoom: 14)),
                    animation: const MapAnimation(duration: 2.0),
                  );
                } catch (exception) {
                  Get.snackbar(
                    'Ошибка',
                    'Не удалось определить местоположение',
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xe5fefefe),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(color: Color(0x33000000), offset: Offset(0, 1), blurRadius: 4),
                  ],
                ),
                child: SvgPicture.asset(
                  'assets/icons/icon-tab-navigation.svg',
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: TextButton(
        onPressed: () {
          Get.back(
            result: {
              'lat': _centerPoint.latitude,
              'long': _centerPoint.longitude,
              'radius': _radius,
            },
          );
        },
        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
        child: Container(
          height: 48,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 40),
          decoration: BoxDecoration(
            color: AppColors.mainPurpleColor,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Center(
            child: Text(
              'Подтвердить',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
