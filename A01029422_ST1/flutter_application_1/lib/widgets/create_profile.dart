import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/services/service.dart';
import 'package:flutter_application_1/widgets/update_user_profile_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
  const CreateProfile({
    Key? key,
    required this.curUser,
  }) : super(key: key);

  final MUser curUser;

  @override
  Widget build(BuildContext context) {
    final _avatarUrlTextController =
        TextEditingController(text: curUser.avatarUrl);
    final _displayNameTextController =
        TextEditingController(text: curUser.displayName);
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(curUser.avatarUrl!),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateUserProfileDialog(
                            curUser: curUser,
                            avatarUrlTextController: _avatarUrlTextController,
                            displayNameTextController:
                                _displayNameTextController);
                      },
                    );
                  },
                ),
              ),
              Text(
                curUser.displayName!,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                });
              },
              icon: Icon(
                Icons.logout_outlined,
                size: 19,
                color: Colors.redAccent,
              ))
        ],
      ),
    );
  }
}