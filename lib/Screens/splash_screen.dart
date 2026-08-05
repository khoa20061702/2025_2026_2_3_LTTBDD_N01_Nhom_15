import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _glowController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation: logo phóng to từ nhỏ
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scaleAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _scaleController,
            curve: Curves.elasticOut,
          ),
        );

    // Fade animation: logo mờ dần xuất hiện
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _fadeController,
            curve: Curves.easeIn,
          ),
        );

    // Slide animation: text trượt lên
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _slideController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Glow pulse animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    )..repeat(reverse: true);
    _glowAnimation =
        Tween<double>(
          begin: 0.3,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _glowController,
            curve: Curves.easeInOut,
          ),
        );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(
      const Duration(milliseconds: 200),
    );
    _fadeController.forward();
    _scaleController.forward();

    await Future.delayed(
      const Duration(milliseconds: 600),
    );
    _slideController.forward();

    // Chờ xong rồi chuyển sang LoginScreen
    await Future.delayed(
      const Duration(milliseconds: 2200),
    );
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              const LoginScreen(),
          transitionsBuilder:
              (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
          transitionDuration: const Duration(
            milliseconds: 600,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D0D2B),
              Color(0xFF1A1A4E),
              Color(0xFF0D1B3E),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Các vòng tròn trang trí nền
            Positioned(
              top: -80,
              right: -60,
              child: AnimatedBuilder(
                animation: _glowAnimation,
                builder: (_, __) => Opacity(
                  opacity:
                      _glowAnimation.value * 0.15,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration:
                        const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(
                            0xFF2575FC,
                          ),
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -80,
              child: AnimatedBuilder(
                animation: _glowAnimation,
                builder: (_, __) => Opacity(
                  opacity:
                      (1 - _glowAnimation.value) *
                      0.15,
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration:
                        const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(
                            0xFFE8631A,
                          ),
                        ),
                  ),
                ),
              ),
            ),

            // Nội dung chính giữa
            Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  // Logo với hiệu ứng scale + fade + glow
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: AnimatedBuilder(
                        animation: _glowAnimation,
                        builder: (_, child) => Container(
                          decoration: BoxDecoration(
                            shape:
                                BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(
                                      0xFFE8631A,
                                    ).withValues(
                                      alpha:
                                          _glowAnimation
                                              .value *
                                          0.5,
                                    ),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                              BoxShadow(
                                color:
                                    const Color(
                                      0xFF2575FC,
                                    ).withValues(
                                      alpha:
                                          _glowAnimation
                                              .value *
                                          0.4,
                                    ),
                                blurRadius: 60,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: child,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Tên app trượt lên
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _slideController,
                      child: Column(
                        children: [
                          const Text(
                            'Phenikaa',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight:
                                  FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Học từ vựng thông minh',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white
                                  .withValues(
                                    alpha: 0.7,
                                  ),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),

                  // Loading dots
                  FadeTransition(
                    opacity: _slideController,
                    child: AnimatedBuilder(
                      animation: _glowController,
                      builder: (_, __) => Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: List.generate(3, (
                          i,
                        ) {
                          final delay = i * 0.33;
                          final value =
                              (_glowController
                                          .value -
                                      delay)
                                  .clamp(
                                    0.0,
                                    1.0,
                                  );
                          final pulse =
                              (value < 0.5
                              ? value * 2
                              : (1 - value) * 2);
                          return Container(
                            margin:
                                const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                            width: 8 + pulse * 4,
                            height: 8 + pulse * 4,
                            decoration: BoxDecoration(
                              shape:
                                  BoxShape.circle,
                              color: i == 1
                                  ? const Color(
                                      0xFFE8631A,
                                    ).withValues(
                                      alpha:
                                          0.6 +
                                          pulse *
                                              0.4,
                                    )
                                  : Colors.white.withValues(
                                      alpha:
                                          0.4 +
                                          pulse *
                                              0.4,
                                    ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
