const String apartmentDB = 'apartments';

class Apartments {
  static final List<String> values = [
    /// Add all fields
    id, property, bedRooms, dateTime, monthlyRentPrice, furnitureTypes, notes,
    nameOfTheReporter
  ];

  static const String id = 'id';
  static const String property = 'property';
  static const String bedRooms = 'bedRooms';
  static const String dateTime = 'dateTime';
  static const String monthlyRentPrice = 'monthlyRentPrice';
  static const String furnitureTypes = 'furnitureTypes';
  static const String notes = 'notes';
  static const String nameOfTheReporter = 'nameOfTheReporter';
}

class Apartment {
  int? id;
  String? property;
  String? bedRooms;
  String? dateTime;
  String? monthlyRentPrice;
  String? furnitureTypes;
  String? notes;
  String? nameOfTheReporter;

  Apartment(
      {this.id,
      this.property,
      this.bedRooms,
      this.dateTime,
      this.monthlyRentPrice,
      this.furnitureTypes,
      this.notes,
      this.nameOfTheReporter});
  Apartment copy({
    int? id,
    String? property,
    String? bedRooms,
    String? dateTime,
    String? monthlyRentPrice,
    String? furnitureTypes,
    String? notes,
    String? nameOfTheReporter,
  }) =>
      Apartment(
        id: id ?? this.id,
        property: property ?? this.property,
        bedRooms: bedRooms ?? this.bedRooms,
        dateTime: dateTime ?? this.dateTime,
        monthlyRentPrice: monthlyRentPrice ?? this.monthlyRentPrice,
        furnitureTypes: furnitureTypes ?? this.furnitureTypes,
        notes: notes ?? this.notes,
        nameOfTheReporter: nameOfTheReporter ?? this.nameOfTheReporter,
      );
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "property": property,
      "bedRooms": bedRooms,
      "dateTime": dateTime,
      "monthlyRentPrice": monthlyRentPrice,
      "furnitureTypes": furnitureTypes,
      "notes": notes,
      "nameOfTheReporter": nameOfTheReporter,
    };
  }

  Apartment.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    property = map['property'];
    bedRooms = map['bedRooms'];
    dateTime = map['dateTime'];
    monthlyRentPrice = map['monthlyRentPrice'];
    furnitureTypes = map['furnitureTypes'];
    notes = map['notes'];
    nameOfTheReporter = map['nameOfTheReporter'];
  }
}
