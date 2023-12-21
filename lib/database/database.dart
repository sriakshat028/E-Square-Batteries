import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esquare_batteries/models/feedback.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/claim.dart';
import '../models/sale.dart';

class Database {
  final db = FirebaseFirestore.instance;

  Database();

  Future addUser(String uid) async {
    try {
      db.collection('users').doc(uid).get().then((value) {
        if (value.exists) {
        } else {
          db.collection('users').doc(uid).set({
            'uid': uid,
          });
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addSale(Sale sale) async {
    String result = 'Something went wrong check your connection';
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final doc =
        db.collection('users').doc(uid).collection('sales').doc(sale.serial);
    try {
      await doc.get().then((value) async {
        if (value.exists) {
          result = 'Sale already exists';
        } else {
          await doc.set(Sale.toMap(sale)).then((_) {
            result = 'Added';
          });
        }
      });
    } catch (e) {
      rethrow;
    }

    return result;
  }

  Future<String> addClaim(Claim claim) async {
    String result = 'Something went wrong check your connection';
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final doc =
        db.collection('users').doc(uid).collection('claims').doc(claim.serial);
    try {
      await doc.get().then((value) async {
        if (value.exists) {
          result = 'Claim already exists';
        } else {
          await doc.set(Claim.toMap(claim)).then((_) {
            result = 'Claim added';
          });
        }
      });
    } catch (e) {
      rethrow;
    }

    return result;
  }

  Future<String> addFeedback(Feedback feedback) async {
    String result = 'Something went wrong please check your connection';
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = db
        .collection('users')
        .doc(uid)
        .collection('feedback')
        .doc(feedback.serial);
    try {
      await doc.get().then((value) async {
        if (value.exists) {
          result = 'Feedback already exists';
        } else {
          await doc
              .set(Feedback.toMap(feedback))
              .then((_) => result = 'Feedback added');
        }
      });
    } catch (e) {
      rethrow;
    }
    return result;
  }
}
