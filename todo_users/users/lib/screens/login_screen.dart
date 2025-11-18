import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  String _completePhoneNumber = '';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Verificar que el campo de teléfono tenga contenido
      if (_phoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor ingresa tu número de teléfono'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      // Simular envío de SMS
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Navegar a la pantalla principal
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      // Mostrar mensaje si la validación falla
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresa un número de teléfono válido para continuar'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _loginWithGoogle() {
    // Implementar login con Google
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login con Google - Próximamente'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _loginWithEmail() {
    // Implementar login con email
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login con Email - Próximamente'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _loginWithFacebook() {
    // Implementar login con Facebook
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login con Facebook - Próximamente'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFF4F2F2),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo/Title
                    Column(
                      children: [
                        Text(
                          'To',
                          style: TextStyle(
                            fontFamily: 'TitanOne',
                            fontSize: 90,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78BF32),
                            height: 0.8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Do',
                          style: TextStyle(
                            fontFamily: 'TitanOne',
                            fontSize: 90,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF78BF32),
                            height: 0.8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),

                    // Phone Number Field
                    IntlPhoneField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Ingresa tu número móvil',
                        labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                      initialCountryCode: 'CO',
                      onChanged: (phone) {
                        setState(() {
                          _completePhoneNumber = '${phone.countryCode} ${phone.number}';
                        });
                        print('${phone.countryCode} ${phone.number}');
                      },
                      validator: (value) {
                        if (value == null || value.number.isEmpty) {
                          return null; // Dejar que el SnackBar maneje este caso
                        }
                        if (value.number.length < 7) {
                          return null; // Dejar que el SnackBar maneje este caso
                        }
                        if (value.number.length > 15) {
                          return null; // Dejar que el SnackBar maneje este caso
                        }
                        // Validación básica de formato
                        if (!RegExp(r'^[0-9+\-\s]+$').hasMatch(value.number)) {
                          return null; // Dejar que el SnackBar maneje este caso
                        }
                        return null;
                      },
                      invalidNumberMessage: '',
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-\s]')),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF78BF32),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Continuar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(height: 24),

                    // Separator
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.black.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'ó',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.black.withOpacity(0.3),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Social Login Buttons
                    ElevatedButton.icon(
                      onPressed: _loginWithGoogle,
                      icon: Image.asset(
                        'assets/images/logos/google_logo.png',
                        height: 24,
                        width: 24,
                      ),
                      label: const Text('Continuar con Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF595959),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: _loginWithEmail,
                      icon: Image.asset(
                        'assets/images/logos/email_logo.png',
                        height: 24,
                        width: 24,
                      ),
                      label: const Text('Continuar con email'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF595959),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      onPressed: _loginWithFacebook,
                      icon: Image.asset(
                        'assets/images/logos/facebook_logo.png',
                        height: 24,
                        width: 24,
                      ),
                      label: const Text('Continuar con Facebook'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF595959),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
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