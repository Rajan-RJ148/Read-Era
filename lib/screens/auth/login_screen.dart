import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // App logo/title
              const Text(
                'Read Era',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Discover your next favorite book',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              // Login title
              const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Welcome back! Please login to continue',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.secondaryText,
                ),
              ),
              const SizedBox(height: 32),
              // Email field (disabled as per requirements)
              TextField(
                enabled: false,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              // Password field (disabled as per requirements)
              TextField(
                enabled: false,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 24),
              // Login button (disabled)
              ElevatedButton(
                onPressed: null,
                child: const Text('Log in'),
              ),
              const SizedBox(height: 16),
              // Divider
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: TextStyle(
                        color: AppTheme.secondaryText,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),
              // Google Sign-In button
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return OutlinedButton.icon(
                    onPressed: authProvider.isLoading
                        ? null
                        : () async {
                            final success = await authProvider.signInWithGoogle();
                            if (!success && context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to sign in with Google'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                    icon: authProvider.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Image.network(
                            'https://www.google.com/favicon.ico',
                            width: 20,
                            height: 20,
                          ),
                    label: Text(
                      authProvider.isLoading ? 'Signing in...' : 'Login with Google',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppTheme.secondaryText),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
