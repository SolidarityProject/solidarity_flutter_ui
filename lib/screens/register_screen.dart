import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:solidarity_flutter_ui/mixins/validation_mixin/register_validation_mixin.dart';
import 'package:solidarity_flutter_ui/models/address_model.dart';
import 'package:solidarity_flutter_ui/models/country_model.dart';
import 'package:solidarity_flutter_ui/models/dtos/gender_dto.dart';
import 'package:solidarity_flutter_ui/models/dtos/register_dto.dart';
import 'package:solidarity_flutter_ui/services/address_service/country_service.dart';
import 'package:solidarity_flutter_ui/services/solidarity_service/auth_service.dart';
import 'package:solidarity_flutter_ui/utils/constants.dart';
import 'package:solidarity_flutter_ui/utils/styles.dart';
import 'package:solidarity_flutter_ui/utils/username_email_check.dart';
import 'package:solidarity_flutter_ui/widgets/alert_dialogs.dart';
import 'package:solidarity_flutter_ui/widgets/drop_down_field.dart';
import 'package:solidarity_flutter_ui/widgets/label_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

ThemeData _themeData;
Future<List<Country>> futureCountryListRegister;
TextEditingController addressController;
Address addressObj;

class _RegisterScreenState extends State<RegisterScreen>
    with RegisterValidationMixin {
  @override
  void initState() {
    futureCountryListRegister = getAllCountry();
    addressController = TextEditingController();
    super.initState();
  }

  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<GenderDTO> dropDownGenderItems = genderList;
  var _selectedGender;

  DateTime _selectedDate;

  var _formTFHeight = 50.0;
  var _formTFHeightPW = 50.0;
  var _autoValidateStatus = false;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            _buildColorContainer(),
            _buildMainContainer(),
          ],
        ),
      ),
    );
  }

  Container _buildColorContainer() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff9999e6),
            Color(0xff8484e1),
            Color(0xff6f6fdc),
            Color(0xff5b5bd7),
          ],
          stops: [0.1, 0.4, 0.7, 0.8],
        ),
      ),
    );
  }

  Container _buildMainContainer() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          top: 60.0,
          bottom: 20.0,
          left: 30.0,
          right: 30.0,
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
          _appIconSizedBox(),
          SizedBox(height: 15.0),
          _signUpText(),
          SizedBox(height: 20.0),
          _buildNameTextFormField(),
          SizedBox(height: 20.0),
          _buildLastNameTextFormField(),
          SizedBox(height: 20.0),
          _buildBirthdateTextFormField(),
          SizedBox(height: 20.0),
          _buildGenderDropDownField(),
          SizedBox(height: 20.0),
          _buildAddressTextFormField(),
          SizedBox(height: 20.0),
          _buildUsernameTextFormField(),
          SizedBox(height: 20.0),
          _buildEmailTextFormField(),
          SizedBox(height: 20.0),
          _buildPasswordTextFormField(),
          SizedBox(height: 20.0),
          _buildRegisterButton(),
          SizedBox(height: 40.0),
          _buildSignInButton(),
        ],
      ),
    );
  }

  SizedBox _appIconSizedBox() {
    return SizedBox(
      height: 90,
      width: 90,
      child: Image.asset(
        "assets/images/icon_github.png",
        fit: BoxFit.contain,
      ),
    );
  }

  Text _signUpText() {
    return Text(
      "Sign Up",
      style: Styles.LOGIN_TITLE,
    );
  }

  Widget _buildNameTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      autoValidateStatus: _autoValidateStatus,
      labelText: "Name",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _nameController,
      maxLength: 50,
      fieldDecoration: Styles.TF_BOXDEC,
      iconText: "N",
      hintText: "e.g. Mustafa",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: nameInputFormat(),
      validationMixin: (_) => validateName(_),
    );
  }

  Widget _buildLastNameTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      autoValidateStatus: _autoValidateStatus,
      labelText: "Last Name",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _lastNameController,
      maxLength: 50,
      fieldDecoration: Styles.TF_BOXDEC,
      iconText: "L",
      hintText: "e.g. ÇEVİK",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: nameInputFormat(),
      validationMixin: (_) => validateLastName(_),
    );
  }

  Widget _buildBirthdateTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      autoValidateStatus: _autoValidateStatus,
      readOnlyStatus: true,
      labelText: "Birthdate",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _birthdateController,
      maxLength: 10,
      fieldDecoration: Styles.TF_BOXDEC,
      iconText: "B",
      suffixIcon: Icons.date_range,
      hintText: "Select your birthdate",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      onTapFunc: () => _datePicker(),
      validationMixin: (_) => validateBirthdate(_),
    );
  }

  Widget _buildGenderDropDownField() {
    return DropDownField<GenderDTO>(
      labelText: "Gender",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldDecoration: Styles.TF_BOXDEC,
      hintText: "Select your gender",
      hintStyle: Styles.TF_HINT,
      icon: Icons.keyboard_arrow_down,
      items: dropDownGenderItems,
      selectedValue: _selectedGender,
      themeColor: _themeData.accentColor,
      onChangedFunc: (_) => _dropDownGenderOnChanged(_),
      dropDownMenuItem: (_) => _dropDownGenderMenuItems(_),
    );
  }

  Widget _buildAddressTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      autoValidateStatus: _autoValidateStatus,
      readOnlyStatus: true,
      labelText: "Address",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: addressController,
      maxLength: 50,
      fieldDecoration: Styles.TF_BOXDEC,
      icon: Icons.not_listed_location,
      suffixIcon: Icons.arrow_forward_ios,
      hintText: "Select your address",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      onTapFunc: () => _addressOnTapFunc(),
      validationMixin: (_) => validateBirthdate(_),
    );
  }

  Widget _buildUsernameTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      autoValidateStatus: _autoValidateStatus,
      labelText: "Username",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _usernameController,
      maxLength: 20,
      fieldDecoration: Styles.TF_BOXDEC,
      iconText: "U",
      hintText: "e.g. mcevik",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: usernameInputFormat(),
      validationMixin: (_) => validateUsername(_),
    );
  }

  Widget _buildEmailTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeight,
      autoValidateStatus: _autoValidateStatus,
      labelText: "Email",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _emailController,
      maxLength: 50,
      fieldDecoration: Styles.TF_BOXDEC,
      icon: Icons.email,
      hintText: "e.g. mcevik@xmail.com",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputType: TextInputType.emailAddress,
      inputFormatters: emailInputFormat(),
      validationMixin: (_) => validateEmail(_),
    );
  }

  Widget _buildPasswordTextFormField() {
    return LabelTextFormField(
      formHeight: _formTFHeightPW,
      autoValidateStatus: _autoValidateStatus,
      obscureStatus: true,
      labelText: "Password",
      labelTextStyle: Styles.TF_LABEL_WHITE,
      fieldTextStyle: Styles.BLACK_TEXT,
      controller: _passwordController,
      maxLength: 15,
      fieldDecoration: Styles.TF_BOXDEC,
      icon: Icons.lock,
      hintText: "e.g. pW123123*",
      hintStyle: Styles.TF_HINT,
      themeColor: _themeData.accentColor,
      inputFormatters: passwordInputFormat(),
      validationMixin: (_) => validateUsername(_),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            await _showAlertDiaolog();
          } else {
            setState(() {
              _autoValidateStatus = true;
              _formTFHeight = 70;
              _formTFHeightPW = 90;
            });
          }
        },
        padding: EdgeInsets.all(13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          "REGISTER",
          style: Styles.LOGIN_BTN_TEXT,
        ),
      ),
    );
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
      var registerResult = await _registerUser();

      if (registerResult) {
        alertDiaolog = AlertDialogOneButton(
          title: "Success",
          content: "Registered to Solidarity Platform.",
          okText: "OK",
          okOnPressed: () {
            Navigator.pop(context);
          },
        );

        _formKey.currentState.save();
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

  Future<bool> _registerUser() async {
    // TODO : address fields
    Address address = Address(
      country: "Türkiye",
      countryId: "5eef52787e2213196405352e",
      province: "İzmir",
      provinceId: "5eef530e7e22131964053531",
      district: "Ödemiş",
      districtId: "5eef567d7e2213196405353f",
    );
    var _registerUserDTO = RegisterDTO(
      //
      // define value from fields
      //
      name: _nameController.text,
      lastname: _lastNameController.text,
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      address: address,
      birthdate: DateTime.parse("1998-08-08"),
      gender: 0,
      pictureUrl:
          "https://raw.githubusercontent.com/SolidarityProject/solidarity_icons/master/test_user.png",
    );

    var result;

    await register(_registerUserDTO).then(
      (_) {
        result = true;
      },
    ).catchError((_) {
      result = false;
    });
    return result;
  }

  Widget _buildSignInButton() {
    return GestureDetector(
      onTap: () async => await Navigator.pushReplacementNamed(
        context,
        Constants.ROUTE_LOGIN,
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Already have an account? ",
              style: Styles.LOGIN_TEXTSPAN,
            ),
            TextSpan(
              text: "Sign In",
              style: Styles.LOGIN_SIGNUP_TEXT,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addressOnTapFunc() async {
    await Navigator.pushNamed(context, Constants.ROUTE_ADDRESSSELECT);
  }

  Future<void> _datePicker() async {
    DateTime _dateNow = DateTime.now();

    final DateTime _picked = await showDatePicker(
      helpText: "Select your birthdate",
      fieldLabelText: "Enter birthdate",
      context: context,
      initialDate:
          _selectedDate == null ? DateTime(_dateNow.year - 20) : _selectedDate,
      firstDate: DateTime(_dateNow.year - 100),
      lastDate: DateTime(_dateNow.year - 18),
    );
    if (_picked != null) {
      setState(() {
        _selectedDate = _picked;
      });
      String formattedDate = DateFormat('dd.MM.yyyy').format(_picked);
      _birthdateController.text = formattedDate;
    }
  }

  void _dropDownGenderOnChanged(GenderDTO value) async {
    setState(() {
      _selectedGender = value;
    });
  }

  DropdownMenuItem<GenderDTO> _dropDownGenderMenuItems(GenderDTO item) {
    return DropdownMenuItem<GenderDTO>(
      value: item,
      child: Text(item.description),
    );
  }
}
