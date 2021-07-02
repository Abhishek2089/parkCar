import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetails{
  final String adname;
  final String mediaUrl;
  final String district;
  final String price;
  final String address;
  final String region;
  final String mobileno;
  final String postId;
  final String zipcode;

  PostDetails({
    this.adname,
    this.mediaUrl,
    this.district,
    this.price,
    this.address,
    this.region,
    this.mobileno,
    this.postId,
    this.zipcode
  });

  factory PostDetails.fromDocument(DocumentSnapshot doc) {
    return PostDetails(
      adname: doc['ad-name'],
      mediaUrl: doc['mediaUrl'],
      district: doc['district'],
      price: doc['price'],
      address: doc['address'],
      region: doc['region'],
      mobileno: doc['mobile no'],
      postId: doc['postId'],
      zipcode: doc['zip-code'],
    );
  }
}