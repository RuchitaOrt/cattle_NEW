import 'package:cattle/Provider/sign_In_provider.dart';
import 'package:cattle/Screens/HomeScreen.dart';
import 'package:cattle/Utils/cattle_colors.dart';
import 'package:cattle/Utils/cattle_strings.dart';
import 'package:cattle/Utils/CattleStyles.dart';
import 'package:cattle/Utils/sizeConfig.dart';
import 'package:cattle/Widget/custom_text_field_widget.dart';
import 'package:cattle/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String route = "/login_screen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInProvider>(
      create: (_) => SignInProvider(),
      child: const _LoginScreenContent(),
    );
  }
}
class _LoginScreenContent extends StatelessWidget {
  const _LoginScreenContent();
@override
Widget build(BuildContext context) {
  final signInProvider = Provider.of<SignInProvider>(context);

  final BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8));
  final BorderSide focusedBorder = const BorderSide(width: 1.0,color: CattleColors.orange,);
  final BorderSide enableBorder = BorderSide(width: 1.0,
  color: CattleColors.hintGrey,);

  return Scaffold(
    backgroundColor: CattleColors.white,
    resizeToAvoidBottomInset: true,
    body: SafeArea(
      child: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical * 5),
                  Text(
                    CattleStrings.strLogin,
                    style: CattleStyles.tsblackHeading,
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 0.5),
                  Text(
                    CattleStrings.strLoginSubHeading,
                    style: CattleStyles.tsGreyHeading,
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  CustomTextFieldWidget(
                    title: CattleStrings.strUserID,
                    hintText: CattleStrings.strEnterUserID,
                    onChange: (val) {},
                    textEditingController: signInProvider.userIDController,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: signInProvider.validateUserIDField,
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 2),
                  Text(
                    CattleStrings.strPassword,
                    style: CattleStyles.textFieldHeading,
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                  TextFormField(
                    cursorColor: CattleColors.orange,
                    style: CattleStyles.textFieldHeading,
                    obscureText: signInProvider.isPasswordObscured,
                    controller: signInProvider.passwordController,
                    validator: signInProvider.validatePassword,
                    autovalidateMode: AutovalidateMode.disabled,
                    decoration: InputDecoration(
                      errorMaxLines: 3,
                      suffixIcon: IconButton(
                        onPressed: signInProvider.togglePasswordVisibility,
                        icon: Icon(
                          signInProvider.isPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: CattleColors.orange,
                        ),
                      ),
                      hintText: CattleStrings.strEnterPassword,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                      border: OutlineInputBorder(borderRadius: borderRadius, borderSide: enableBorder),
                      focusedBorder: OutlineInputBorder(borderRadius: borderRadius, borderSide: focusedBorder),
                      enabledBorder: OutlineInputBorder(borderRadius: borderRadius, borderSide: enableBorder),
                      filled: true,
                      fillColor: CattleColors.white,
                      hintStyle: CattleStyles.textFieldHint,
                      errorStyle: CattleStyles.textFieldHint,
                      counterText: "",
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                      
                        value: signInProvider.rememberMe,
                        onChanged: signInProvider.toggleRememberMe,
                          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        activeColor: CattleColors.orange,
                        side: BorderSide(color: CattleColors.hintGrey),
                        checkColor: CattleColors.white,
                        
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                       SizedBox(width: SizeConfig.blockSizeHorizontal * 1.5),
                      const Text(CattleStrings.strkeepSignedIn),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Login button pinned at bottom
         Padding(
  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12), // no insets here
  child: SafeArea(
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:  signInProvider.isFormValid
              ? CattleColors.orange:CattleColors.greyButton,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: signInProvider.isFormValid ?() {
          // Login logic
             Navigator.pushReplacement(routeGlobalKey.currentContext!,
                               MaterialPageRoute(builder: (context) => HomeScreen()));
        }:null,
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ),
  ),
)

        ],
      ),
    ),
  );
}

}


