import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../pages/pages.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              child: SimpleDialog(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Aguarde...', textAlign: TextAlign.center),
                    ],
                  ),
                ],
              ),
            );
          } else {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          }
        });

        widget.presenter.mainErrorStream.listen((error) {
          if (error != null) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red[900],
                content: Text(error, textAlign: TextAlign.center),
              ),
            );
          }
        });

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginHeader(),
              HeadLine1(text: 'Login'),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  child: Column(
                    children: [
                      StreamBuilder<String>(
                          stream: widget.presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                              ),
                              onChanged: widget.presenter.validateEmail,
                            );
                          }),
                      const SizedBox(height: 8),
                      StreamBuilder<String>(
                          stream: widget.presenter.passwordErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                icon: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                              ),
                              onChanged: widget.presenter.validatePassword,
                            );
                          }),
                      const SizedBox(height: 32.0),
                      StreamBuilder<bool>(
                          stream: widget.presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return RaisedButton(
                              child: Text('Entrar'),
                              onPressed: snapshot.data == true
                                  ? widget.presenter.auth
                                  : null,
                            );
                          }),
                      const SizedBox(height: 8.0),
                      FlatButton.icon(
                        icon: Icon(Icons.person),
                        label: Text('Criar Conta'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
