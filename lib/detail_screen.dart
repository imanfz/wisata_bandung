import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'model/tourism_place.dart';

var informationTextStyle = TextStyle(fontFamily: 'Oswald');

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  DetailScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 800) {
          return DetailWebPage(place: place);
        } else {
          return DetailMobilePage(place: place);
        }
      },
    );
  }
}

class DetailMobilePage extends StatelessWidget {
  final TourismPlace place;

  DetailMobilePage({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.asset(place.imageAsset),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        FavoriteButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(Icons.calendar_today),
                      SizedBox(height: 8.0),
                      Text(
                        place.openDays,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.access_time),
                      SizedBox(height: 8.0),
                      Text(
                        place.openTime,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Icon(Icons.monetization_on),
                      SizedBox(height: 8.0),
                      Text(
                        place.ticketPrice,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                place.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Oxygen',
                ),
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: place.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;

  DetailWebPage({required this.place});

  @override
  _DetailWebPageState createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: kIsWeb ? null : AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 64,
        ),
        child: Center(
          child: Container(
            width: screenWidth <= 1200 ? 800 : 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Wisata Bandung',
                  style: TextStyle(
                    fontFamily: 'Staatliches',
                    fontSize: 32,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            child: Image.asset(widget.place.imageAsset),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          SizedBox(height: 16),
                          Scrollbar(
                            isAlwaysShown: true,
                            controller: _scrollController,
                            child: Container(
                              height: 150,
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ListView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                children: widget.place.imageUrls.map((url) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(url),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  widget.place.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'Staatliches',
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.calendar_today),
                                      SizedBox(width: 8.0),
                                      Text(
                                        widget.place.openDays,
                                        style: informationTextStyle,
                                      ),
                                    ],
                                  ),
                                  FavoriteButton(),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.access_time),
                                  SizedBox(width: 8.0),
                                  Text(
                                    widget.place.openTime,
                                    style: informationTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.monetization_on),
                                  SizedBox(width: 8.0),
                                  Text(
                                    widget.place.ticketPrice,
                                    style: informationTextStyle,
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  widget.place.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontFamily: 'Oxygen',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
    );
  }
}

// Container(
//   padding: EdgeInsets.symmetric(horizontal: 16.0),
//   child: Row(
//     children: <Widget>[
//       ComboBoxState(),
//     ],
//   ),
// ),
// TextBox(),
// TextWithController(),
// SwitchButton(),
// RadioButton(),
// CheckBoxS(),
// Row(
//   children: <Widget>[
//     Center(
//       child: Image.network(
//         'https://picsum.photos/200/300',
//         width: 200,
//         height: 200,
//       ),
//     ),
//     Center(
//       child: Image.asset(
//           'images/foto.jpg',
//           width: 200,
//           height: 200
//       ),
//     )
//   ],
// )
//
// class ComboBoxState extends StatefulWidget {
//   const ComboBoxState({Key? key}) : super(key: key);
//
//   @override
//   State<ComboBoxState> createState() => _ComboBoxState();
// }
//
// class _ComboBoxState extends State<ComboBoxState> {
//   String language = 'Select Language';
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: language,
//       onChanged: (String? value) {
//         setState(() {
//           language = value!;
//         });
//       },
//       items: <String>['Select Language', 'Dart', 'Kotlin', 'Swift', 'Python']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
//
// // TextField with onChange
// class TextBox extends StatefulWidget {
//   @override
//   _TextBoxState createState() => _TextBoxState();
// }
//
// class _TextBoxState extends State<TextBox> {
//   String _name = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Write your name here...',
//               labelText: 'Your Name',
//             ),
//             onChanged: (String value) {
//               setState(() {
//                 _name = value;
//               });
//             },
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       content: Text('Hello, $_name'),
//                     );
//                   });
//             },
//             child: Text('Submit'),
//           )
//         ],
//       ),
//     );
//   }
// }
//
//
// class TextWithController extends StatefulWidget {
//   @override
//   _TextWithControllerState createState() => _TextWithControllerState();
// }
//
// class _TextWithControllerState extends State<TextWithController> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:  const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           TextField(
//             controller: _controller,
//             decoration: InputDecoration(
//               hintText: 'Write your name here...',
//               labelText: 'Your Name',
//             ),
//           ),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       content: Text('Hello, ${_controller.text}'),
//                     );
//                   });
//             },
//             child: Text('Submit'),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
//
// class SwitchButton extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _SwitchButtonState();
// }
//
// class _SwitchButtonState extends State<SwitchButton> {
//   bool lightOn = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Switch(
//         value: lightOn,
//         onChanged: (bool value) {
//           setState(() {
//             lightOn = value;
//           });
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(lightOn ? 'Light On' : 'Light Off'),
//               duration: Duration(seconds: 1),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class RadioButton extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _RadioButtonState();
//
// }
//
// class _RadioButtonState extends State<RadioButton> {
//   String language = 'Dart';
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           ListTile(
//             leading: Radio<String>(
//               value: 'Dart',
//               groupValue: language,
//               onChanged: (String? value) {
//                 setState(() {
//                   language = value!;
//                   showSnackbar();
//                 });
//               },
//             ),
//             title: Text('Dart'),
//           ),
//           ListTile(
//             leading: Radio<String>(
//               value: 'Kotlin',
//               groupValue: language,
//               onChanged: (String? value) {
//                 setState(() {
//                   language = value!;
//                   showSnackbar();
//                 });
//               },
//             ),
//             title: Text('Kotlin'),
//           ),
//           ListTile(
//             leading: Radio<String>(
//               value: 'Swift',
//               groupValue: language,
//               onChanged: (String? value) {
//                 setState(() {
//                   language = value!;
//                   showSnackbar();
//                 });
//               },
//             ),
//             title: Text('Swift'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void showSnackbar() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('$language selected'),
//         duration: Duration(seconds: 1),
//       ),
//     );
//   }
// }
//
// class CheckBoxS extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _CheckBoxSState();
//
// }
// class _CheckBoxSState extends State<CheckBoxS> {
//   bool agree = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(16.0),
//       child: ListTile(
//         leading: Checkbox(
//           value: agree,
//           onChanged: (bool? value) {
//             setState(() {
//               agree = value!;
//             });
//           },
//         ),
//         title: Text('Agree / Disagree'),
//       ),
//     );
//   }
// }