import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
//creat items

  // text field controller
  final TextEditingController _colorController = TextEditingController();

  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Stray Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _colorController,
                  decoration: const InputDecoration(
                    labelText: 'Dog colour',
                  ),
                ),
                TextField(
                  controller: _breedController,
                  decoration: const InputDecoration(
                    labelText: 'Breed',
                  ),
                ),
                TextField(
                  controller: _placeController,
                  decoration: const InputDecoration(
                    labelText: 'Place',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        final String color = _colorController.text;
                        final int? breed = int.tryParse(_breedController.text);
                        final int? place = int.tryParse(_placeController.text);

                        // ignore: unnecessary_null_comparison
                        if (color != null && breed != null) {
                          await _items.add({
                            "dogColor": color,
                            "breed": breed,
                            "place": place,
                          });
                          _colorController.text = '';
                          _breedController.text = '';
                          _placeController.text = '';

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Create")),
                )
              ],
            ),
          );
        });
  }

  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('items').snapshots();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text(
            " Nearby Strays",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: SizedBox(
          width: 150,
          child: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 40,
                  child: Image.network(
                      'https://www.clipartbest.com/cliparts/eTM/EGX/eTMEGXk8c.png'),
                ),
                Text('Spot A Stray'),
              ],
            ),
            onPressed: () {
              _create();
            },
          ),
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error${snapshot.error}"));
                }
                if (snapshot.hasData) {
                  QuerySnapshot querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> document = querySnapshot.docs;
                  List<Map> items =
                      document.map((e) => e.data() as Map).toList();
                  // List <MapEntry <String,int>> sortList =document.e
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map thisItems = items[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 224, 135, 242),
                                Color.fromARGB(255, 50, 183, 254)
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          child: ListTile(
                            leading: thisItems.containsKey('image')
                                ? const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor:
                                            Color.fromARGB(255, 129, 226, 243),
                                        child: ClipOval(
                                            child: Icon(Icons
                                                .dashboard_customize_outlined))),
                                  )
                                : const SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircleAvatar(
                                        radius: 17,
                                        backgroundColor:
                                            Color.fromARGB(255, 122, 247, 238),
                                        child: Icon(Icons.person)),
                                  ),
                            title: Text(
                              "${thisItems['item']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quantity :${thisItems['qty']}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "Price :${thisItems['price']}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ));
  }
}
