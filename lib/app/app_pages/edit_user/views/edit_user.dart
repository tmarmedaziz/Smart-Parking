import 'package:flutter/material.dart';
import 'package:frontend/app/modles/utils/api_services.dart';
import 'package:frontend/app/app_theme/Text_Theme.dart';
import 'package:get_it/get_it.dart';


class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _size.width * 0.067),
      height: _size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _size.height * 0.08),
            Row(
              children: [
                Text(
                  'Edit your profile informations',
                  style: Text_Theme.style3
                      .copyWith(color: Color(0xff1a1111)),
                ),
                Spacer(),

              ],
            ),

            SizedBox(height: _size.height * 0.02),

            SizedBox(height: _size.height * 0.05),
            SizedBox(height: _size.height * 0.05),
            SizedBox(height: _size.height * 0.05),


            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Edit Username',
              ),
            ),
            SizedBox(height: _size.height * 0.02),
            OutlinedButton(
                child: Text('Edit'),
                onPressed: () {
                  String newUsername = _usernameController.text;
                  GetIt.I<APIServices>()
                      .updateProfile(data: {'username': newUsername});
                }),
            SizedBox(height: _size.height * 0.02),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Edit Password',
              ),
            ),
            SizedBox(height: _size.height * 0.05),
            TextField(
              controller: _confirmpasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Edited Password',
              ),
            ),
            SizedBox(height: _size.height * 0.02),
            OutlinedButton(
                child: Text('Edit'),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(width: 5, color: Colors.white)))),
                onPressed: () {
                  String newPassword = _passwordController.text;
                  String confirmPassword = _confirmpasswordController.text;
                  if (newPassword == confirmPassword) {
                    GetIt.I<APIServices>()
                        .updateProfile(data: {'password': newPassword});
                  }
                }),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
