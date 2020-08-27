import 'package:flutter/material.dart';
import 'package:solidarity_flutter_ui/mixins/validation_mixin/profile_validation_mixin.dart';
import 'package:solidarity_flutter_ui/models/dtos/update_user_dto.dart';
import 'package:solidarity_flutter_ui/screens/tab_controller_screen.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/user_service.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/utils/username_email_check.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';
import 'package:solidarity_flutter_ui/widgets/label_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

ThemeData _themeData;

class _ProfileScreenState extends State<ProfileScreen>
    with ProfileValidationMixin {
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
          _buildNameTextFormField(),
          SizedBox(height: 20.0),
          _buildLastNameTextFormField(),
          SizedBox(height: 20.0),
          _buildUsernameTextFormField(),
          SizedBox(height: 20.0),
          _buildEmailTextFormField(),
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
          var changedStatus = _checkChangedFields();
          if (changedStatus) {
            await _showAlertDiaolog();
          } else {
            setState(() {
              _editStatus = false;
              _formTFHeight = 50.0;
            });
          }
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

  bool _checkChangedFields() {
    if (user.name != _nameController.text)
      return true;
    else if (user.lastname != _lastnameController.text)
      return true;
    else if (user.username != _usernameController.text)
      return true;
    else if (user.email != _emailController.text)
      return true;
    else
      return false;
  }

  Future<void> _showAlertDiaolog() async {
    var resultAlert = await usernameEmailCheckAlert(
      _usernameController.text,
      _emailController.text,
    );
    AlertDialogOneButton alertDiaolog;

    if (resultAlert != null) {
      alertDiaolog = resultAlert;
    }

    //* success
    else {
      var updatedResult = await _updateUser();

      if (updatedResult) {
        alertDiaolog = AlertDialogOneButton(
          title: "Success",
          content: "Updated your information.",
          okText: "OK",
          okOnPressed: () {},
        );

        _formKey.currentState.save();

        setState(() {
          _editStatus = false;
          _formTFHeight = 50.0;
        });
      }

      //! server error
      // TODO : log -> server error
      else {
        alertDiaolog = AlertDialogOneButton(
          title: "ERROR",
          content: "Please try again later.",
          okText: "OK",
          okOnPressed: () {},
        );
      }
    }

    // show alert diaolog
    await showDialog(
      context: context,
      builder: (context) => alertDiaolog,
    );
  }

  Future<bool> _updateUser() async {
    var _updateUserDTO = UpdateUserDTO(
      //
      // update value from fields
      //
      name: _nameController.text,
      lastname: _lastnameController.text,
      username: _usernameController.text,
      email: _emailController.text,

      //

      id: user.id,
      address: user.address,
      birthdate: user.birthdate,
      gender: user.gender,
      pictureUrl: user.pictureUrl,
    );

    var result;

    await updateUser(_updateUserDTO).then(
      (updatedUser) {
        user = updatedUser;
        result = true;
      },
    ).catchError((onError) {
      result = false;
    });
    return result;
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

  Widget _buildNameTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      editStatus: _editStatus,
      labelText: "Name",
      labelTextStyle: Styles.TF_LABEL,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _nameController,
      maxLength: 50,
      fieldDecoration: Styles.TF_BOXDEC,
      iconText: user.name,
      hintText: "e.g. Mustafa",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: nameInputFormat(),
      validationMixin: (_) => validateName(_),
      saveMixin: saveName,
    );
  }

  Widget _buildLastNameTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      editStatus: _editStatus,
      labelText: "Last Name",
      labelTextStyle: Styles.TF_LABEL,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _lastnameController,
      maxLength: 50,
      fieldDecoration: Styles.TF_BOXDEC,
      iconText: user.lastname,
      hintText: "e.g. ÇEVİK",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: nameInputFormat(),
      validationMixin: (_) => validateLastName(_),
      saveMixin: saveLastName,
    );
  }

  Widget _buildUsernameTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      editStatus: _editStatus,
      labelText: "Username",
      labelTextStyle: Styles.TF_LABEL,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _usernameController,
      maxLength: 20,
      fieldDecoration: Styles.TF_BOXDEC,
      iconText: user.username,
      hintText: "e.g. mcevik",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: usernameInputFormat(),
      validationMixin: (_) => validateUsername(_),
      saveMixin: saveUsername,
    );
  }

  Widget _buildEmailTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      editStatus: _editStatus,
      labelText: "Email",
      labelTextStyle: Styles.TF_LABEL,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _emailController,
      maxLength: 50,
      fieldDecoration: Styles.TF_BOXDEC,
      iconText: user.email,
      icon: Icons.email,
      hintText: "e.g. mcevik@xmail.com",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: emailInputFormat(),
      validationMixin: (_) => validateEmail(_),
      saveMixin: saveEmail,
    );
  }
}
