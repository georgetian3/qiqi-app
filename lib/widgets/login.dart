import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:qiqi/logic/app_state.dart';
import 'package:qiqi/logic/auth.dart';
import 'package:qiqi/widgets/pages.dart';
import 'package:qiqi/widgets/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _errorMessage = '';
  bool _saveLogin = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // thudState.getSavedCredentials().then((Credentials? savedCredentials) {
      //   if (savedCredentials != null) {
      //     setState(() {
      //       _usernameController.text = savedCredentials.username;
      //       _passwordController.text = savedCredentials.password;
      //     });
      //     if (widget.autoLogin) {
      //       login();
      //     }
      //   }
      // });

    });
  }

  Future<void> login() async {


    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Pages()));

  }

  Future<void> loginClicked(context) async {

    final future = Future.delayed(const Duration(seconds: 5), () => true);
    return await showLoading(context, future, Text('Logging in'));

  }

  @override build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
      converter: (store) => store.state.authState,
      builder: (context, state) => state.token == null ? const Pages() : 
        Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('lib/assets/thud.png', width: 160, height: 160),
              // const SizedBox(height: 32),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(hintText: 'username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _saveLogin,
                    onChanged: (value) => {setState(() {_saveLogin = value!;})}
                  ),
                  Text('saveLogin'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async => await loginClicked(context),
                      child: Text('login'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => {}, //() async => await registerClicked(context),
                      child: Text('register'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ),
        ),
      )
    );
  }
}
