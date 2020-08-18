import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';

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

  final _formKey = GlobalKey<FormState>();

  var _editStatus = false;
  var _formTFHeight = 50.0;

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
      key: _formKey,
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
            (String value) => _nameFieldFunc(value),
            user.name,
            "Enter your name",
          ),
          SizedBox(height: 20.0),
          _buildTextFormField(
            "Last Name",
            _lastnameController,
            TextInputType.text,
            (String value) => _lastNameFieldFunc(value),
            user.lastname,
            "Enter your last name",
          ),
          SizedBox(height: 20.0),
          _buildTextFormField(
            "Username",
            _usernameController,
            TextInputType.text,
            (String value) => _usernameFieldFunc(value),
            user.username,
            "Enter your username",
          ),
          SizedBox(height: 20.0),
          _buildTextFormField(
            "Email",
            _emailController,
            TextInputType.emailAddress,
            (String value) => _emailFieldFunc(value),
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
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          var alertDiaolog = AlertDialogOneButton(
            title: "Success",
            content: "Updated your information.",
            okText: "OK",
            okOnPressed: () {},
          );
          await showDialog(
            context: context,
            builder: (context) => alertDiaolog,
          );
          setState(() {
            _editStatus = false;
            _formTFHeight = 50.0;
            user.name = _nameController.text;
          });
        }
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
          _formTFHeight = 70.0;
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
    String validationFunc(String value),
    String iconText,
    String hintText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //* label text
        Text(labelText, style: Styles.TF_LABEL),

        SizedBox(height: 10.0),

        Container(
          alignment: Alignment.centerLeft,
          decoration: Styles.TF_BOXDEC,
          height: _formTFHeight,

          //* text form field
          child: TextFormField(
            enabled: _editStatus ? true : false,
            controller: controller,
            keyboardType: inputType,
            autovalidate: true,
            validator: (value) {
              return validationFunc(value);
            },
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

String _nameFieldFunc(String value) {
  String result;

  if (value.isEmpty) {
    result = "Please enter your name";
  } else if (value.length < 2) {
    result = "Name must be at least 2 characters";
  }

  return result;
}

String _lastNameFieldFunc(String value) {
  String result;

  if (value.isEmpty) {
    result = "Please enter your last name";
  }

  return result;
}

String _usernameFieldFunc(String value) {
  String result;

  if (value.isEmpty) {
    result = "Please enter your username";
  }

  return result;
}

String _emailFieldFunc(String value) {
  String result;

  if (value.isEmpty) {
    result = "Please enter your email";
  }

  return result;
}
