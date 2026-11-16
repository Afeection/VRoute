import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _email    = TextEditingController();
  final _password = TextEditingController();
  final _formKey  = GlobalKey<FormState>();
  bool _loading   = false;
  bool _obscure   = true;

  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl  = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );
      if (!mounted) return;
      if (cred.user != null) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage(e.code))),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _errorMessage(String code) => switch (code) {
    'user-not-found'  => 'No account found for this email.',
    'wrong-password'  => 'Incorrect password.',
    'invalid-email'   => 'Enter a valid email address.',
    'user-disabled'   => 'This account has been disabled.',
    _                 => 'Login failed. Please try again.',
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subColor  = isDark ? AppColors.darkSubtext : AppColors.lightSubtext;
    final accent    = isDark ? AppColors.teal : AppColors.tealDark;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(gradient: isDark ? AppColors.darkBg : AppColors.lightBg),
            child: const SizedBox.expand(),
          ),
          Positioned(
            top: -100, right: -80,
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.teal.withValues(alpha: isDark ? 0.07 : 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -120, left: -80,
            child: Container(
              width: 350, height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue.withValues(alpha: isDark ? 0.06 : 0.08),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: FadeTransition(
                  opacity: _fade,
                  child: SlideTransition(
                    position: _slide,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 76, height: 76,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              gradient: AppColors.tealGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.teal.withValues(alpha: 0.4),
                                  blurRadius: 28,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.explore_rounded, color: Colors.white, size: 40),
                          ),
                          const SizedBox(height: 18),
                          Text('VRoute', style: GoogleFonts.poppins(
                            fontSize: 36, fontWeight: FontWeight.w700, color: textColor,
                          )),
                          Text('Abdullah Gül University', style: GoogleFonts.inter(
                            fontSize: 13, color: subColor,
                          )),
                          const SizedBox(height: 36),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: isDark ? AppColors.darkGlass : AppColors.lightGlass,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: isDark ? AppColors.darkGlassBorder : AppColors.lightGlassBorder,
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Welcome back', style: Theme.of(context).textTheme.headlineSmall),
                                    const SizedBox(height: 4),
                                    Text('Sign in to continue', style: GoogleFonts.inter(fontSize: 13, color: subColor)),
                                    const SizedBox(height: 24),
                                    TextFormField(
                                      controller: _email,
                                      keyboardType: TextInputType.emailAddress,
                                      style: GoogleFonts.inter(color: textColor),
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        prefixIcon: Icon(Icons.email_outlined, size: 20),
                                      ),
                                      validator: (v) {
                                        if (v == null || v.isEmpty) return 'Enter your email';
                                        if (!v.contains('@')) return 'Enter a valid email';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 14),
                                    TextFormField(
                                      controller: _password,
                                      obscureText: _obscure,
                                      style: GoogleFonts.inter(color: textColor),
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        prefixIcon: const Icon(Icons.lock_outline, size: 20),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                            size: 20, color: subColor,
                                          ),
                                          onPressed: () => setState(() => _obscure = !_obscure),
                                        ),
                                      ),
                                      validator: (v) {
                                        if (v == null || v.isEmpty) return 'Enter your password';
                                        if (v.length < 6) return 'Min. 6 characters';
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 28),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 52,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          gradient: AppColors.tealGradient,
                                          borderRadius: BorderRadius.circular(14),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.teal.withValues(alpha: 0.35),
                                              blurRadius: 16,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                        child: ElevatedButton(
                                          onPressed: _loading ? null : _login,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                          ),
                                          child: _loading
                                              ? const SizedBox(
                                                  width: 22, height: 22,
                                                  child: CircularProgressIndicator(
                                                    color: Colors.white, strokeWidth: 2.5,
                                                  ),
                                                )
                                              : Text('Sign In', style: GoogleFonts.poppins(
                                                  fontSize: 15, fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ", style: GoogleFonts.inter(fontSize: 14, color: subColor)),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(context, '/register'),
                                child: Text('Register', style: GoogleFonts.inter(
                                  fontSize: 14, fontWeight: FontWeight.w600, color: accent,
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
