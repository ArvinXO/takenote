import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Column(
            children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 20),
//                      child: SearchBarWidget(),
//                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          // Text(
                          //   currentUser.value.name,
                          //   textAlign: TextAlign.left,
                          //   style: Theme.of(context).textTheme.headline3,
                          // ),
                          // Text(
                          //   currentUser.value.email,
                          //   style: Theme.of(context).textTheme.caption,
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 55,
                      height: 55,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(300),
                        onTap: () {
                          Navigator.of(context).pushNamed('/Profile');
                        },
                        // child: CircleAvatar(
                        //   backgroundImage:
                        //       NetworkImage(currentUser.value.image.thumb),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: const Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.person),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: const Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: const <Widget>[
                    ListTile(
                      leading: Icon(Icons.credit_card),
                    ),
                    ListTile(
                      dense: true,
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: const Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(Icons.settings),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Languages');
                      },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.translate,
                            size: 22,
                            color: Theme.of(context).focusColor,
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/DeliveryAddresses');
                      },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.place,
                            size: 22,
                            color: Theme.of(context).focusColor,
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Help');
                      },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.help,
                            size: 22,
                            color: Theme.of(context).focusColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
