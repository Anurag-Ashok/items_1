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
  final TextEditingController _itemController = TextEditingController();

  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

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
                    "Add Item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _itemController,
                  decoration: const InputDecoration(
                      labelText: 'Item', hintText: 'eg.Book'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _qtyController,
                  decoration: const InputDecoration(
                      labelText: 'Quantity', hintText: 'eg.30'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  decoration: const InputDecoration(
                      labelText: 'Price', hintText: 'eg.60'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        final String item = _itemController.text;
                        final int? qty = int.tryParse(_qtyController.text);
                        final int? price = int.tryParse(_priceController.text);

                        // ignore: unnecessary_null_comparison
                        if (item != null && qty != null) {
                          await _items.add({
                            "item": item,
                            "qty": qty,
                            "price": price,
                          });
                          _itemController.text = '';
                          _qtyController.text = '';
                          _priceController.text = '';

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
          backgroundColor: const Color.fromARGB(255, 57, 175, 234),
          centerTitle: true,
          title: const Text("Items"),
        ),
        floatingActionButton: SizedBox(
          width: 150,
          child: FloatingActionButton(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.person_add_alt_1_outlined),
                Text('Add Item'),
              ],
            ),
            onPressed: () {
              _create();
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error${snapshot.error}"));
              }
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data;
                List<QueryDocumentSnapshot> document = querySnapshot.docs;
                List<Map> items = document.map((e) => e.data() as Map).toList();
                // List <MapEntry <String,int>> sortList =document.e
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map thisItems = items[index];

                    return Card(
                      color: const Color.fromARGB(255, 68, 230, 122),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(10),
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
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
