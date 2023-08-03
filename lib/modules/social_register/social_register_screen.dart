import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app1/cubits/social_register_cubit/social_register_cubit.dart';
import 'package:social_app1/layout/social_layout/social_layout.dart';
import 'package:social_app1/shared/components/default_button.dart';
import 'package:social_app1/shared/components/default_form_field.dart';
import 'package:social_app1/shared/components/navigator_method.dart';

import '../../constants.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  static String id = socialRegisterScreenId;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
      listener: (context, state) {
        if (state is SocialCreateUserSuccess) {
          NavigateTo.navigateAndReplacement(context, const SocialLayout());
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
                        'REGISTER',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Register now to communicate with friends',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(height: 30),
                      DefaultTextFormFields(
                        textEditingController: nameController,
                        type: TextInputType.name,
                        prefix: const Icon(Icons.person),
                        label: 'User Name',
                      ),
                      const SizedBox(height: 15),
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
                            SocialRegisterCubit.get(context).userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                              name: nameController.text,
                            );
                          }
                        },
                        isPassword: SocialRegisterCubit.get(context).isPassword,
                        suffixIcon: SocialRegisterCubit.get(context).suffix,
                        suffixPressed: () {
                          SocialRegisterCubit.get(context)
                              .changePasswordVisibility();
                        },
                        textEditingController: passwordController,
                        type: TextInputType.visiblePassword,
                        prefix: const Icon(Icons.lock_outlined),
                        label: 'Password',
                      ),
                      const SizedBox(height: 15),
                      DefaultTextFormFields(
                        onSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            SocialRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);
                          }
                        },
                        textEditingController: phoneController,
                        type: TextInputType.phone,
                        prefix: const Icon(Icons.phone),
                        label: 'Phone Number',
                      ),
                      const SizedBox(height: 30),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState,
                        builder: (BuildContext context) {
                          return defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text);
                              }
                            },
                            text: 'Register',
                          );
                        },
                        fallback: (BuildContext context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
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
