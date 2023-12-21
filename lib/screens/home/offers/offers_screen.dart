import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esquare_batteries/screens/widgets/universal_widgets.dart';
import 'package:flutter/material.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});
  static const routeName = '/home/offers';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const TopImage(),
          const H2(text: 'OFFERS'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            margin: const EdgeInsets.all(25),
            height: 400,
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('offers').get(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      final imageLink =
                          snapshot.data!.docs[index].data()['link'];
                      final text =
                          snapshot.data!.docs[index].data()['info'].toString();
                        return Card(
                          child: Column(
                            children: [
                              Image.network(imageLink),
                              Text(text),
                            ],
                          ),
                        );
                    }),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
