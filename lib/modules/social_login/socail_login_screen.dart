import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/constants.dart';
import 'package:social_app1/cubits/social_login_cubit/social_login_cubit.dart';
import 'package:social_app1/layout/social_layout/social_layout.dart';
import 'package:social_app1/modules/social_register/social_register_screen.dart';
import 'package:social_app1/shared/components/default_button.dart';
import 'package:social_app1/shared/components/default_form_field.dart';
import 'package:social_app1/shared/components/flutter_toast.dart';
import 'package:social_app1/shared/components/navigator_method.dart';
import 'package:social_app1/shared/network/local/shared_preferances.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({super.key});

  static String id = socialLoginScreenId;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLoginCubit, SocialLoginState>(
      listener: (context, state) {
        if (state is SocialLoginFailureState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
        if (state is SocialLoginSuccessState) {
          CacheHelper.saveData(
            key: 'uId',
            value: state.uId,
          ).then((value) {
            NavigateTo.navigateAndReplacement(context, const SocialLayout());
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Login now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(height: 30),
                      DefaultTextFormFields(
                        textEditingController: emailController,
                        type: TextInputType.emailAddress,
                        prefix: const Icon(Icons.email_outlined),
                        label: 'Email Address',
                      ),
                      const SizedBox(height: 15),
                      DefaultTextFormFields(
                        onSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        isPassword: SocialLoginCubit.get(context).isPassword,
                        suffixIcon: SocialLoginCubit.get(context).suffix,
                        suffixPressed: () {
                          SocialLoginCubit.get(context)
                              .changePasswordVisibility();
                        },
                        textEditingController: passwordController,
                        type: TextInputType.visiblePassword,
                        prefix: const Icon(Icons.lock_outlined),
                        label: 'Password',
                      ),
                      const SizedBox(height: 30),
                      ConditionalBuilder(
                        condition: true,
                        builder: (BuildContext context) {
                          return defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: 'login',
                          );
                        },
                        fallback: (BuildContext context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('dot\'t have an account ?'),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SocialRegisterScreen.id);
                              },
                              child: const Text('Register')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
