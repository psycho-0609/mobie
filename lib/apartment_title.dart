import 'package:coursework/apartment.dart';
import 'package:coursework/apartment_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class ApartmentTitle extends StatelessWidget {
  final Apartment apartment;
  final bool canVibrate;
  final VoidCallback voidCallback;
  const ApartmentTitle(
      {Key? key, required this.apartment, required this.canVibrate, required this.voidCallback})
      : super(key: key);

  Future<void> deleteOneApartment(int id) async {
    await ApartmentsDatabase.instance.deleteOneApartment(apartment.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {

    final Iterable<Duration> pauses = [
      const Duration(milliseconds: 1000),
    ];
    textInfo(String lable,String detail){
      return Row(
        children: [
          Text("$lable: ",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
          Text("$detail",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400),)

        ],
      );
    }
    return Container(
      height: 150,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textInfo("Property",apartment.property ?? ''),
          textInfo("Bedrooms",apartment.bedRooms ?? ''),
          textInfo("Price",apartment.monthlyRentPrice ?? ''),
          textInfo("Reporter",apartment.nameOfTheReporter ?? ''),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text('Ring'),
                onPressed: () =>    FlutterBeep.beep(),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text('Vibrate'),
                onPressed: () => Vibrate.vibrateWithPauses(pauses),
              ),
            ],
          )
        ],
      ),
    );
  }
}
