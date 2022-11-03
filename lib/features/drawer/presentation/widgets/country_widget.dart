



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/common/constants.dart';

class CountryWidget extends StatefulWidget {
  const CountryWidget({Key? key}) : super(key: key);

  @override
  _CountryWidgetState createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {

  int index = 0;
  final _box = GetStorage();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Выберите страну',
            textAlign: TextAlign.center,
            style: TextStyle(
            color: Colors.black,
        ),
        ),
        backgroundColor: Colors.white ,
      ),
      body: Column(
          children: [

            GestureDetector(
              onTap: () {
                index = 1;
                _box.write('country_index', index);
                setState(() {
                  index;
                });
              }   ,
              child:   Container(
                padding: EdgeInsets.only(left: 13,right: 13,top: 20),
                width: 359,
                child:Row(
                  children: [
                    SvgPicture.asset('assets/temp/kaz.svg' , height: 30,width: 30,),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 280,
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Казахстан',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400

                              ),
                            ),
                            index == 1 ?
                            const Icon(
                              Icons.check,
                              size: 20,
                              color: AppColors.kPrimaryColor,
                            ) : Container()
                          ],
                        )
                    )


                  ],),
              ),
            ),

            GestureDetector(
              onTap: () {
                index = 2;
                _box.write('country_index', index);
                setState(() {
                  index;
                });
              }   ,
              child: Container(
                padding: EdgeInsets.only(left: 13,right: 13,top: 20),
                width: 359,
                child:Row(
                  children: [
                    SvgPicture.asset('assets/temp/rus.svg' , height: 30,width: 30,),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 280,
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Россия',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400

                              ),
                            ),
                            index == 2 ?
                            const Icon(
                              Icons.check,
                              size: 20,
                              color: AppColors.kPrimaryColor,
                            ) : Container()
                          ],
                        )
                    )


                  ],),
              ),
            ),
            GestureDetector(
              onTap: (){
                index = 3;
                _box.write('country_index', index);
                setState(() {
                  index;
                });
              }   ,
              child: Container(
                padding: EdgeInsets.only(left: 13,right: 13,top: 20),
                width: 359,
                child:Row(
                  children: [
                    SvgPicture.asset('assets/temp/ukr.svg' , height: 30,width: 30,),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 280,
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Украина',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400

                              ),
                            ),
                            index == 3 ?
                           const Icon(
                              Icons.check,
                              size: 20,
                              color: AppColors.kPrimaryColor,
                            ) : Container()
                          ],
                        )
                    )


                  ],),
              ),
            ),
            GestureDetector(
              onTap: () {
                index = 4;
                _box.write('country_index', index);
                setState(() {
                  index;
                });
              }   ,
              child: Container(
                padding: EdgeInsets.only(left: 13,right: 13,top: 20),
                width: 359,
                child:Row(
                  children: [
                    SvgPicture.asset('assets/temp/bel.svg' , height: 30,width: 30,),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                        width: 280,
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          const Text(
                              'Беларусь',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400

                              ),
                            ),
                            index == 4 ?
                            const Icon(
                              Icons.check,
                              size: 20,
                              color: AppColors.kPrimaryColor,
                            ) : Container()
                          ],
                        )
                    )
                  ],),
              ),
            ),
          ])
      ,);
  }
}
