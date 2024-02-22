import 'package:habo/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      skipStyle: ButtonStyle(
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 17)),
        foregroundColor: MaterialStateProperty.all(Colors.redAccent),
      ),
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/anclacom.jpg',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.4),
              const SizedBox(height: 20),
              Text(
                'Bienvenido a Ancla!',
                style: GoogleFonts.mochiyPopOne(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset('assets/pensar.jpg',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.4),
              const SizedBox(height: 20),
              Text(
                'Un grupo dispuesto a ayudarte cuando tengas un mal rato',
                textAlign: TextAlign.left,
                style: GoogleFonts.mochiyPopOne(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/emociones.jpg',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.4),
              const SizedBox(height: 20),
              Text(
                'Aunque a veces no sepas ni tú lo que tienes',
                style: GoogleFonts.mochiyPopOne(
                  fontSize: 33,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset('assets/triste.jpg',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.4),
              const SizedBox(height: 20),
              Text(
                'Recuerda que estamos para apoyarte',
                style: GoogleFonts.mochiyPopOne(
                  fontSize: 33,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/contacto.jpg',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.4),
              const SizedBox(height: 20),
              Text(
                'Estamos abiertos a que nos des tus opiniones!',
                style: GoogleFonts.mochiyPopOne(
                  fontSize: 33,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset('assets/apoya.jpg',
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.4),
              const SizedBox(height: 20),
              Text(
                'Recuerda apoyarnos si quieres respaldar nuestra causa',
                style: GoogleFonts.mochiyPopOne(
                  fontSize: 33,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Aquí encontrarás material útil",
                style: GoogleFonts.mochiyPopOne(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 40, 183, 125),
                ),
              ),
              const SizedBox(height: 25),
              Image(
                image: const AssetImage('assets/hobbies.png'),
                height: MediaQuery.of(context).size.height / 2,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              Text(
                "Además de contactos profesionales",
                style: GoogleFonts.mochiyPopOne(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 37, 119, 128),
                ),
              ),
            ],
          ),
        ),
      ],
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 175, 56, 56))),
      onDone: () => _onIntroEnd(context),
      nextStyle: ButtonStyle(
        foregroundColor:
            MaterialStateProperty.all(Color.fromARGB(255, 248, 64, 64)),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size.square(10),
        activeColor: Colors.redAccent,
        activeSize: Size.square(17),
      ),
    );
  }
}
