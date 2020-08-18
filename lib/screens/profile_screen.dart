import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

ThemeData _themeData;

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
    _themeData = Theme.of(context);

    return Scaffold(
      appBar: _buildAppBar(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: _buildScaffoldContainer(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 2,
      centerTitle: true,
      title: Text(
        "My Profile",
        style: Styles.BLACK_TEXT,
      ),
    );
  }

  Widget _buildScaffoldContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildProfilePicture(),
          SizedBox(height: 30.0),
          _buildInfoRow(),
          SizedBox(height: 5.0),
          _buildTextFormField(
            "Name",
            _nameController,
            TextInputType.text,
            user.name,
            "Enter your name",
          ),
          SizedBox(height: 20.0),
          _buildTextFormField(
            "Last Name",
            _lastnameController,
            TextInputType.text,
            user.lastname,
            "Enter your last name",
          ),
          SizedBox(height: 20.0),
          _buildTextFormField(
            "Username",
            _usernameController,
            TextInputType.text,
            user.username,
            "Enter your username",
          ),
          SizedBox(height: 20.0),
          _buildTextFormField(
            "Email",
            _emailController,
            TextInputType.emailAddress,
            user.email,
            "Enter your email",
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      height: 150,
      width: 150,
      child: CircleAvatar(
        backgroundImage: NetworkImage(user.pictureUrl),
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "Personal Information",
          style: Styles.TF_LABEL,
        ),
        _editStatus ? _buildSaveButton() : _buildEditButton(),
      ],
    );
  }

  Widget _buildSaveButton() {
    return FlatButton(
      color: _themeData.accentColor,
      onPressed: () {
        setState(() {
          _editStatus = false;
        });
      },
      child: Text(
        "Save",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return FlatButton(
      onPressed: () {
        setState(() {
          _editStatus = true;
        });
      },
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 3,
        children: <Widget>[
          Text(
            "Edit your information",
            style: Styles.BLACK_TEXT.copyWith(
              fontStyle: FontStyle.italic,
              fontSize: 12,
            ),
          ),
          Icon(
            Icons.edit,
            color: _themeData.accentColor,
            size: 22,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
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
          style: Styles.TF_LABEL,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: Styles.TF_BOXDEC,
          height: 50.0,
          child: TextFormField(
            enabled: _editStatus ? true : false,
            controller: controller,
            keyboardType: inputType,
            style: Styles.BLACK_TEXT,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(15.0),
              prefixIcon: CircleAvatar(
                child: Text(
                  iconText[0].toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.transparent,
                foregroundColor: _themeData.accentColor,
              ),
              hintText: hintText,
              hintStyle: Styles.TF_HINT,
            ),
          ),
        ),
      ],
    );
  }
}
