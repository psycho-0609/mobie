import 'package:coursework/apartment.dart';
import 'package:coursework/apartment_database.dart';
import 'package:flutter/material.dart';

class AddApartmentScreen extends StatefulWidget {
  const AddApartmentScreen({Key? key}) : super(key: key);

  @override
  _AddApartmentScreenState createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  final _form = GlobalKey<FormState>(); //for storing form state.

  TextEditingController propertyController = TextEditingController();
  TextEditingController bedRoomsController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController monthlyRentPriceController = TextEditingController();
  TextEditingController furnitureTypesController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController nameOfTheReporterController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void _save() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      Apartment apartment = Apartment(
          property: propertyController.text,
          bedRooms: bedRoomsController.text,
          dateTime: dateTimeController.text,
          monthlyRentPrice: monthlyRentPriceController.text,
          furnitureTypes: furnitureTypesController.text,
          notes: notesController.text,
          nameOfTheReporter: nameOfTheReporterController.text);
      insertApartment(apartment).then((value) => Navigator.pop(context));
    }
  }

  Future<void> insertApartment(Apartment apartment) async {
    await ApartmentsDatabase.instance.createOne(apartment);
  }

  @override
  Widget build(BuildContext context) {
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
              return 'Please input ${lableText}';
            }
            return null;
          },
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
    textFieldNotRequirement(
      String lableText,
      TextEditingController controller,
    ) {
      return Container(
        height: 80,
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.start,
        ),
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
        title: const Text("Add apartment"),
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
                textFieldRequirement('Property', propertyController),
                textRequirement("Bedrooms"),
                textFieldRequirement('Bedrooms', bedRoomsController),
                textRequirement("Date"),
                textFieldRequirement('Date', dateTimeController),
                textRequirement("Monthly Rent Price"),
                textFieldRequirement(
                    'Monthly Rent Price', monthlyRentPriceController),
                textNotRequirement("Furniture Types"),
                textFieldNotRequirement(
                    'Furniture Types', furnitureTypesController),
                textNotRequirement("Notes"),
                textFieldNotRequirement('Notes', notesController),
                textRequirement("Reporter"),
                textFieldRequirement('Reporter', nameOfTheReporterController),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text('Submit'),
                  onPressed: () => _save(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
