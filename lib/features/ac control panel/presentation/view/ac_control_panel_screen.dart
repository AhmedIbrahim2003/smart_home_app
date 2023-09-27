import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:smart_home_app/features/ac%20control%20panel/presentation/view/widgets/custom_slider.dart';

import '../../../../core/utils/slider_utils.dart';
import '../../data/enum/options_enum.dart';
import 'widgets/ac_modes.dart';
import 'widgets/ac_power.dart';
import 'widgets/ac_speed.dart';
import 'widgets/ac_temp.dart';

class ControlPanelPage extends StatefulWidget {
  final String tag;

  const ControlPanelPage({Key? key, required this.tag}) : super(key: key);
  @override
  _ControlPanelPageState createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage>
    with TickerProviderStateMixin {
  Options option = Options.cooling;
  bool isActive = false;
  int speed = 1;
  double temp = 22.85;
  double progressVal = 0.49;

  var activeColor = Rainbow(spectrum: [
    const Color(0xFF33C0BA),
    const Color(0xFF1086D4),
    const Color(0xFF6D04E2),
    const Color(0xFFC421A0),
    const Color(0xFFE4262F)
  ], rangeStart: 0.0, rangeEnd: 1.0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
            size: 25,
          ),
        ),
        title: const Text(
          'Smart AC',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.white,
                activeColor[progressVal].withOpacity(0.5),
                activeColor[progressVal]
              ]),
        ),
        child: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
            baseColor: const Color(0xFFFFFFFF),
            opacityChangeRate: 0.25,
            minOpacity: 0.1,
            maxOpacity: 0.3,
            spawnMinSpeed: speed * 60.0,
            spawnMaxSpeed: speed * 120,
            spawnMinRadius: 2.0,
            spawnMaxRadius: 5.0,
            particleCount: isActive ? speed * 150 : 0,
          )),
          vsync: this,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        acModes(),
                        acTemp(),
                        acControllers(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  acModes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ACModes(
          icon: 'assets/svg/clock.svg',
          isSelected: option == Options.timer,
          onTap: () => setState(() {
            option = Options.timer;
          }),
          size: 32,
        ),
        ACModes(
          icon: 'assets/svg/snow.svg',
          isSelected: option == Options.cooling,
          onTap: () => setState(() {
            option = Options.cooling;
          }),
          size: 25,
        ),
        ACModes(
          icon: 'assets/svg/bright.svg',
          isSelected: option == Options.heat,
          onTap: () => setState(() {
            option = Options.heat;
          }),
          size: 35,
        ),
        ACModes(
          icon: 'assets/svg/drop.svg',
          isSelected: option == Options.dry,
          onTap: () => setState(() {
            option = Options.dry;
          }),
          size: 28,
        ),
      ],
    );
  }

  acTemp() {
    return CustomSlider(
      progressVal: progressVal,
      color: activeColor[progressVal],
      onChange: (value) {
        setState(() {
          temp = value;
          progressVal = normalize(value, kMinDegree, kMaxDegree);
        });
      },
    );
  }

  acControllers() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ACSpeed(
                  speed: speed,
                  changeSpeed: (val) => setState(() {
                        speed = val;
                      })),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: ACPower(
                  isActive: isActive,
                  onChanged: (val) => setState(() {
                        isActive = val;
                      })),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        ACTemp(
            temp: temp,
            changeTemp: (val) => setState(() {
                  temp = val;
                  progressVal = normalize(val, kMinDegree, kMaxDegree);
                })),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
