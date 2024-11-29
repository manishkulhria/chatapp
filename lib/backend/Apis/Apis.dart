import 'package:cloud_firestore/cloud_firestore.dart';

class Apis {
  static final _firestore = FirebaseFirestore.instance;

  // Collection References
  static CollectionReference userCollectionRef = _firestore.collection("User");

  // Document References
  static DocumentReference userDocumentRef(String id) =>
      userCollectionRef.doc(id);
}
