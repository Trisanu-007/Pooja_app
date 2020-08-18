import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String fullName;
  final String flatnum;
  final int flatnumber;
  final int mobile_num;
  final String email_id;
  final String type;
  UserProfile(
      {this.fullName,
      this.email_id,
      this.flatnum,
      this.flatnumber,
      this.mobile_num,
      this.type});
}

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference userDataCollection =
      Firestore.instance.collection("users");

  Future createUserProfile(String fullName, String flatNum, int flatNumber,
      int mobileNum, String emailId, String type) async {
    return await userDataCollection.document(uid).setData({
      "fullname": fullName,
      "flatnum": flatNum,
      "flatnumber": flatNumber,
      "mobile_num": mobileNum,
      "email_id": emailId,
      "type": type, //TODO: Find the option and change here
    });
  }

  Future updateUserName(String name) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "fullname": name,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  Future updateUserFlatNum(String flatnum) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "flatnum": flatnum,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  Future updateFlatNumber(int flatNumber) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "flatnumber": flatNumber,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  Future updateUserMobileNumber(int mobileNum) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "mobile_num": mobileNum,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  Future updateUserType(String type) async {
    try {
      return await userDataCollection.document(uid).updateData({
        "type": type,
      });
    } catch (e) {
      print("error");
      return e;
    }
  }

  UserProfile convertToUserProfile(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserProfile(
            fullName: snapshot.data["fullname"],
            flatnum: snapshot.data["flatnum"],
            flatnumber: snapshot.data["flatnumber"],
            mobile_num: snapshot.data["mobile_num"],
            email_id: snapshot.data["email_id"],
            type: snapshot.data["type"],
          )
        : null;
  }

  Stream<UserProfile> get getUserProfile {
    return userDataCollection
        .document(uid)
        .snapshots()
        .map(convertToUserProfile);
  }
}