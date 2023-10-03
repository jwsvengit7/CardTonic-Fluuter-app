import 'package:cardmonix/dto/response/UserDetails.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  UserData userData;
  Profile({required this.userData});
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Positioned(
              left: 10,
              top: 30,
              right: 10,
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  color: Colors.white30,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.white30,
                        child: Image.network(widget.userData.profile!,
                            height: 70, width: 70),
                      ),
                      Text(
                        widget.userData.user_name!,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        widget.userData.email!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'History',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Example list of history items
            const ListTile(
              leading: Icon(Icons.work),
              title: Text('Work History 1'),
              subtitle: Text('Position: Senior Developer\nCompany: ABC Inc.'),
            ),
            Divider(),
            const ListTile(
              leading: Icon(Icons.work),
              title: Text('Work History 2'),
              subtitle: Text('Position: Product Manager\nCompany: XYZ Corp.'),
            ),
          ],
        ),
      ),
    );
  }
}
