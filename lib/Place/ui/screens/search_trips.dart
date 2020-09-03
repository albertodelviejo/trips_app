import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:platzi_trips_app/Place/repository/search_service.dart';
import 'package:platzi_trips_app/Place/ui/screens/home_trips.dart';
import 'package:platzi_trips_app/widgets/gradient_back.dart';

class SearchTrips extends StatefulWidget {
  @override
  _SearchTripsState createState() => _SearchTripsState();
}

class _SearchTripsState extends State<SearchTrips> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GradientBack(height: 120.0),
            Padding(
                padding:
                    const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: TextField(
                    onChanged: (val) {
                      initiateSearch(val);
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFe5e5e5),
                        border: InputBorder.none,
                        hintText: "Search an amazing place...",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFe5e5e5)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0))))))
          ],
        ),
        SizedBox(height: 10.0),
        GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            primary: false,
            shrinkWrap: true,
            children: tempSearchStore.map((e) {
              return buildResultCard(e, context);
            }).toList())
      ],
    );
  }
}

Widget buildResultCard(data, context) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeTrips()),
          );
        },
        child: Container(
          child: Center(
              child: Text(
            data['name'],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          )),
        ),
      ));
}
