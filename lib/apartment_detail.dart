import 'package:coursework/apartment_database.dart';
import 'package:flutter/material.dart';
import 'apartment.dart';

class ApartmentDetailScreen extends StatefulWidget {
  const ApartmentDetailScreen({Key? key}) : super(key: key);

  @override
  _ApartmentDetailScreenState createState() => _ApartmentDetailScreenState();
}

class _ApartmentDetailScreenState extends State<ApartmentDetailScreen> {
  final _form = GlobalKey<FormState>(); //for storing form state.
  TextEditingController nameController = TextEditingController();
  TextEditingController propertyController = TextEditingController();
  TextEditingController bedRoomsController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController monthlyRentPriceController = TextEditingController();
  TextEditingController furnitureTypesController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController nameOfTheReporterController = TextEditingController();

  void _save(int id) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      Apartment apartment = Apartment(
        id: id,
        property: propertyController.text,
        bedRooms: bedRoomsController.text,
        dateTime: dateTimeController.text,
        monthlyRentPrice: monthlyRentPriceController.text,
        furnitureTypes: furnitureTypesController.text,
        notes: notesController.text,
        nameOfTheReporter: nameOfTheReporterController.text,
      );
      updatedOneApartment(apartment).then((value) => Navigator.pop(context));
    }
  }

  Future<void> updatedOneApartment(Apartment apartment) async {
    await ApartmentsDatabase.instance.updateOneApartment(apartment);
  }

  Future<void> deleteOneApartment(int id) async {
    await ApartmentsDatabase.instance.deleteOneApartment(id);
  }

  Future<void> _confirmDelete(
      BuildContext context, VoidCallback voidCallback) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure to delete ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                /// call function to delete
                voidCallback();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Apartment apartment =
        ModalRoute.of(context)!.settings.arguments as Apartment;

    propertyController.value = TextEditingValue(text: apartment.property ?? '');
    bedRoomsController.value = TextEditingValue(text: apartment.bedRooms ?? '');
    dateTimeController.value = TextEditingValue(text: apartment.dateTime ?? '');
    monthlyRentPriceController.value =
        TextEditingValue(text: apartment.monthlyRentPrice ?? '');
    furnitureTypesController.value =
        TextEditingValue(text: apartment.furnitureTypes ?? '');
    notesController.value = TextEditingValue(text: apartment.notes ?? '');
    nameOfTheReporterController.value =
        TextEditingValue(text: apartment.nameOfTheReporter ?? '');

    textFieldRequirement(
      String lableText,
      TextEditingController controller,
    ) {
      return Container(
        height: 80,
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.start,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return 'Please input this field !';
            }
            return null;
          },
        ),
      );
    }

    textFieldNotRequirement(
      String lableText,
      TextEditingController controller,
    ) {
      return Container(
        height: 80,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: lableText,
          ),
          textAlign: TextAlign.start,
        ),
      );
    }
    textRequirement(String text) {
      return Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              const TextSpan(
                  text: "*", style: TextStyle(fontSize: 16, color: Colors.red))
            ])),
      );
    }
    textNotRequirement(String text) {
      return Align(
        alignment: Alignment.topLeft,
        child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: text,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ])),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update apartment"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                textRequirement("Property"),
                textFieldRequirement(
                    apartment.property ?? '', propertyController),
                textRequirement("Bedrooms"),
                textFieldRequirement(
                    apartment.bedRooms ?? '', bedRoomsController),
                textRequirement("Date Time"),
                textFieldRequirement(
                    apartment.dateTime ?? '', dateTimeController),
                textRequirement("Price"),
                textFieldRequirement(
                    apartment.monthlyRentPrice ?? '', monthlyRentPriceController),
                textNotRequirement("Furniture Types"),
                textFieldNotRequirement(apartment.furnitureTypes ?? 'Furniture Types',
                    furnitureTypesController),
                textNotRequirement("Notes"),
                textFieldNotRequirement(
                    apartment.notes ?? 'Notes', notesController),
                textRequirement("Reporter"),
                textFieldRequirement(
                    apartment.nameOfTheReporter ?? '', nameOfTheReporterController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: const Text('Update'),
                          onPressed: () => _save(apartment.id ?? -1),
                        ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: const Text('Delete'),
                      onPressed: () => _confirmDelete(context, () {
                        deleteOneApartment(apartment.id ?? 0);
                      }).then((value) => Navigator.pop(context)),
                    ),

                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
