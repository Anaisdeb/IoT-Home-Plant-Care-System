import 'package:flutter/material.dart';
import 'package:HPCS_app/Pages/bluetooth.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _bleSettings() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: BluetoothSettings(),
            ),
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreen.shade300],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.5, 0.9],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white70,
                      minRadius: 60.0,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            'https://m.media-amazon.com/images/I/71pLSZUMrdL.jpg'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Hector the plant',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Dieffenbachia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: Column(
                children: <Widget>[
                  Text(
                      'CURRENT STATUS',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
                  Divider(),
                  ListTile(
                      title: Text(
                        'Temperature',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(1 < 3 ? Icons.star : Icons.star_border,
                          color: Colors.lightGreen, size: 30);
                    }),
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                        'Moisture',
                        style: TextStyle(
                          color: Colors.yellow.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                          index < 3 ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 30);
                    }),
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                        'pH',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(1 < 3 ? Icons.star : Icons.star_border,
                          color: Colors.lightGreen, size: 30);
                    }),
                  ),
                  Divider(),
                  ListTile(
                      title: Text(
                        'Lighting',
                        style: TextStyle(
                          color: Colors.red.shade700,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(4 < 3 ? Icons.star : Icons.star_border,
                          color: Colors.red.shade700, size: 30);
                    }),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Column(
                      children: [
                        CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.blueGrey,
                            child: IconButton(
                                icon: const Icon(
                                    Icons.build, color: Colors.white),
                                onPressed: null
                            )),
                        Text('modify sensor thresholds',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                fontSize: 12))
                      ]),
                  Divider(),
                  SizedBox(height: 10),
                  Wrap(spacing: 80, children: [
                    IconButton(
                        icon: const Icon(
                            Icons.settings_rounded, color: Colors.blueGrey),
                        onPressed: null,
                        padding: EdgeInsets.all(0.0),
                        iconSize: 40
                    ),
                    CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.lightBlue,
                        child: Icon(Icons.share, color: Colors.white)),
                    IconButton(
                        icon: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.lightBlue,
                            child: Icon(
                                Icons.settings_bluetooth, color: Colors.white)),
                        onPressed: _bleSettings,
                        padding: EdgeInsets.all(0.0),
                        iconSize: 40
                    )
                  ])
                ],
              ),
              padding: EdgeInsets.all(25.0))
        ],
      ),
    );
  }
}
