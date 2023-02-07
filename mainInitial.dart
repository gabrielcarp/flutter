import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:test_flutter/network/Repository.dart';
import 'package:test_flutter/models/User.dart';

void mainInitial() => runApp(MyApp());
const double spacing = 20;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var users = List<User>.empty();

  /**
      api response hard mapping to our expected model. error prone
      //better to have sorted data
   **/
  _getUsers() {
    Repository.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
        users.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
      });
    });
  }

// _getUser(String id) {
//   Repository.getUser(id).then((response) {
//     setState(() {
//       user = User.fromJson(response.body);
//     });
//   });
// }

initState() {
  super.initState();
  _getUsers();
}

/**
    requirement was to show 5 random users from the list
    the api might change and fewer than 5 users should still be shown

    //weird that i couldn't get collection.sample to work
    //https://api.flutter.dev/flutter/package-collection_collection/IterableExtension/sample.html
 **/
_getRandomUsers() {
  int maxUsers = min(5, users.length);
  var randomUsers = List<int?>.empty(growable: true);
  while (randomUsers.length < maxUsers) {
    int randomPosition = Random().nextInt(users.length);
    if (!randomUsers.contains(users[randomPosition].id)) {
      randomUsers.add(users[randomPosition].id);
    }
  }
  return users.where((element) => randomUsers.contains(element.id)).toList();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Flutter Challenge',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          )),
    ),
    body: UserList(userList: _getRandomUsers()),
  );
}}

class UserList extends StatelessWidget {
  const UserList({Key? key, required this.userList}) : super(key: key);
  final List<User> userList;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return Card(
          color: theme.colorScheme.primary,
          shadowColor: theme.colorScheme.background,
          elevation: spacing,
          margin: const EdgeInsets.all(spacing),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(userList[index])));
            },
            child: ListTile(
              title: Text(
                userList[index].name.toString(),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                userList[index].email.toString() +
                    '\n' +
                    userList[index].company.name.toString(),
                textAlign: TextAlign.center,
              ),
              selectedColor: theme.colorScheme.secondary,
            ),
          ),
        );
      },
    );
  }
}

class DetailPage extends StatefulWidget {
  User selectedUser;

  DetailPage(this.selectedUser, {Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.selectedUser.name.toString()),
            ),
            body: Center(
              child: ListView(
                padding: const EdgeInsets.all(spacing),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Name"),
                      Text(widget.selectedUser.name.toString()),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Username"),
                      Text(widget.selectedUser.username.toString()),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Email"),
                      Text(widget.selectedUser.email.toString()),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Text(
                    widget.selectedUser.address.toString(),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: spacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Phone"),
                      Text(widget.selectedUser.phone.toString()),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Website"),
                      Text(widget.selectedUser.website.toString()),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Text(
                    'Company name ${widget.selectedUser.company.name
                        .toString()} '
                        'with the catch phrase ${widget.selectedUser.company
                        .catchPhrase.toString()},'
                        ' and their bs of: ${widget.selectedUser.company.bs
                        .toString()}',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            )));
  }
}
