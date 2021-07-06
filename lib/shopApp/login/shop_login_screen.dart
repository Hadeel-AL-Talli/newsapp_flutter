import 'package:flutter/material.dart';
import 'package:news_app/components/component.dart';
import 'package:news_app/components/defaultformfield.dart';
import 'package:news_app/shopApp/register/shop_register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'LOGIN ',
                    style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),
                  ),
                  Text(
                    'login now to browse our hot offers ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Please Enter your email address';
                        }
                      },
                      label: 'Email Address',
                      prefix: Icons.email),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      suffix: Icons.visibility_outlined,
                      suffixPressed: () {},
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Password is too short ';
                        }
                      },
                      label: 'Password',
                      prefix: Icons.lock_outline),
                      SizedBox(height: 30.0,),
                 defaultButton(width: double.infinity,  function: (){}, text: 'Login'),
                 SizedBox(height: 15.0,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                   Text('Don\'t have an account?'),
                   defaultTextButton(function:() {
                      navigateTo(context, ShopRegisterScreen());
                    } ,
                 text: 'register'),
                 ],)
                ],
              ),
            ),
          ),
        ));
  }
}
