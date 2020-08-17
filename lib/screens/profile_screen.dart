import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  var _editStatus = false;

  @override
  void initState() {
    _nameController.text = user.name;
    _lastnameController.text = user.lastname;
    _usernameController.text = user.username;
    _emailController.text = user.email;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastnameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "Profile Screen",
          style: kLabelStyle,
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.pictureUrl),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _buildInfoLabel(),
                      SizedBox(height: 20.0),
                      _buildTextField(
                        "Name",
                        _nameController,
                        TextInputType.text,
                        user.name,
                        "Enter your name",
                      ),
                      SizedBox(height: 20.0),
                      _buildTextField(
                        "Lastname",
                        _lastnameController,
                        TextInputType.text,
                        user.lastname,
                        "Enter your lastname",
                      ),
                      SizedBox(height: 20.0),
                      _buildTextField(
                        "Username",
                        _usernameController,
                        TextInputType.text,
                        user.username,
                        "Enter your username",
                      ),
                      SizedBox(height: 20.0),
                      _buildTextField(
                        "Email",
                        _emailController,
                        TextInputType.emailAddress,
                        user.email,
                        "Enter your email",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Personal Information",
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildTextField(
    String labelText,
    TextEditingController controller,
    TextInputType inputType,
    String iconText,
    String hintText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 50.0,
          child: TextField(
            //textAlign: TextAlign.center,
            //textAlignVertical: TextAlignVertical.center,
            enabled: _editStatus ? true : false,
            controller: controller,
            keyboardType: inputType,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              prefixIcon:  CircleAvatar(
                  child: Text(iconText[0].toUpperCase()),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.blue,
                ),
              hintText: hintText,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  final kHintTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'OpenSans',
  );

  final kLabelStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  final kBoxDecorationStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6.0,
        offset: Offset(0, 2),
      ),
    ],
  );
}
