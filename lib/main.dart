import 'package:coursework/add_apartment_screen.dart';
import 'package:coursework/apartment.dart';
import 'package:coursework/apartment_detail.dart';
import 'package:coursework/apartment_title.dart';
import 'package:coursework/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

import 'apartment_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RentalZ.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => const LoginScreen(),
        "/home": (context) => const MyHomePage(
              title: 'RetailZ',
            ),
        "/add": (context) => const AddApartmentScreen(),
        "/detail": (context) => const ApartmentDetailScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Apartment> apmList = [];
  Future<List<Apartment>> getAllApartment() async {
    return await ApartmentsDatabase.instance.getAllApartments();
  }

  Future<void> searchApartment(String property) async {
    if (property == '') {
      getAllApartment().then((value) {
        apmList = [];
        apmList.addAll(value);
        setState(() {});
      });
    } else {
      ApartmentsDatabase.instance.searchApartmentsByProperty(property).then((value) {
        apmList = [];
        apmList.addAll(value);
        setState(() {});
      });
    }
  }

  TextEditingController searchController = TextEditingController();

  bool _canVibrate = true;

  @override
  void initState() {
    // TODO: implement initState
    getAllApartment().then((value) {
      apmList.addAll(value);
      setState(() {});
    });
    Vibrate.canVibrate.then((value) => _canVibrate = value);
    super.initState();
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
          decoration: InputDecoration(
            hintText: lableText,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    final searchWidget = Container(
      height: 80,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(child: textFieldRequirement('search', searchController)),
          IconButton(
              onPressed: () {
                searchApartment(searchController.text);
              },
              icon: const Icon(Icons.search))
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.red,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              searchWidget,
              apmList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: apmList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/detail",
                                      arguments: apmList[index])
                                  .then((value) =>
                                      getAllApartment().then((value) {
                                        apmList = [];
                                        apmList.addAll(value);
                                        setState(() {});
                                      }));
                            },
                            child: ApartmentTitle(
                              apartment: apmList[index],
                              canVibrate: _canVibrate, voidCallback: () {
                              getAllApartment().then((value) {
                                apmList = [];
                                apmList.addAll(value);
                                setState(() {});
                              });
                            },
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text('No'),
                    ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pushNamed(context, '/add').then((value) {
            getAllApartment().then((value) {
              apmList = [];
              apmList.addAll(value);
              setState(() {});
            });
          });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
