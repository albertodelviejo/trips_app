import 'package:flutter/material.dart';

class Place {
  String id;
  String name;
  String description;
  String urlImage;
  String searchKey;
  int likes;
  bool liked;

  Place(
      {Key key,
      @required this.name,
      @required this.description,
      @required this.urlImage,
      @required this.likes,
      @required this.searchKey,
      this.liked,
      this.id});
}
