import 'package:eshoes_clean_arch/core/constant/images.dart';
import 'package:eshoes_clean_arch/core/error/failures.dart';
import 'package:eshoes_clean_arch/core/router/app_router.dart';
import 'package:eshoes_clean_arch/domain/usecases/user/sign_up_usecase.dart';
import 'package:eshoes_clean_arch/presentation/blocs/cart/cart_bloc.dart';
import 'package:eshoes_clean_arch/presentation/blocs/user/user_bloc.dart';
import 'package:eshoes_clean_arch/presentation/widgets/input_form_button.dart';
import 'package:eshoes_clean_arch/presentation/widgets/input_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignupView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is UserLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is UserLogged) {
          context.read<CartBloc>().add(const GetCart());
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            ModalRoute.withName(''),
          );
        } else if (state is UserLoggedFail) {
          if (state.failure is CredentialFailure) {
            EasyLoading.showError("Username / Password Wrong !");
          } else {
            EasyLoading.showError("Error");
          }
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 80,
                      child: Image.asset(
                        kAppLogo,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Please use your e-mail address to create a new account",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InputTextFormField(
                      textEditingController: firstNameController,
                      hint: 'First Name',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This fielc can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InputTextFormField(
                      textEditingController: lastNameController,
                      hint: 'Last Name',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InputTextFormField(
                      textEditingController: emailController,
                      hint: 'Email',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This Field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InputTextFormField(
                      textEditingController: passwordController,
                      hint: 'Passwod',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InputTextFormField(
                      textEditingController: confirmPasswordController,
                      hint: 'Confirm Password',
                      textInputAction: TextInputAction.next,
                      validation: (String? val) {
                        if (val == null || val.isEmpty) {
                          return 'This field can\'t be empty';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                          } else {
                            context.read<UserBloc>().add(
                                  SignUpUser(
                                    SignUpParams(
                                      email: emailController.text,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      password: passwordController.text,
                                    ),
                                  ),
                                );
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InputFormButton(
                      color: Colors.black87,
                      onClick: () {
                        if (_formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                          } else {
                            context.read<UserBloc>().add(
                                  SignUpUser(
                                    SignUpParams(
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  ),
                                );
                          }
                        }
                      },
                      titleText: 'Sign Up',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputFormButton(
                      color: Colors.black87,
                      onClick: () {
                        Navigator.of(context).pop();
                      },
                      titleText: 'Back',
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
