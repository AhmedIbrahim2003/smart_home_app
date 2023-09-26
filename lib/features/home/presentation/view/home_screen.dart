import 'package:flutter/material.dart';

import '../../data/model/device_model.dart';
import 'widgets/devices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Device> homeDevices = [
    Device(
        name: 'Smart Spotlight',
        isActive: true,
        color: 0xFFff5f5f,
        icon: 'assets/svg/light.svg'),
    Device(
        name: 'Smart AC',
        isActive: true,
        color: 0xFF7739ff,
        icon: 'assets/svg/ac.svg'),
    Device(
        name: 'Smart TV',
        isActive: false,
        color: 0xFFc9c306,
        icon: 'assets/svg/tv.svg'),
    Device(
        name: 'Smart Sound',
        isActive: false,
        color: 0xFFc207db,
        icon: 'assets/svg/speaker.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFfce2e1), Colors.white]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SafeArea(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hello, Ahmed',
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                        minRadius: 25,
                        backgroundImage: NetworkImage('https://images.squarespace-cdn.com/content/v1/5446f93de4b0a3452dfaf5b0/1626904421257-T6I5V5IQ4GI2SJ8EU82M/Above+Avalon+Neil+Cybart'))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    width: size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'A total of 4 devices',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    'Living Room',
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.more_horiz,
                                color: Colors.grey[300],
                                size: 30,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 3 / 4,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemCount: homeDevices.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return DeviceCard(
                                    name: homeDevices[index].name,
                                    svg: homeDevices[index].icon,
                                    color: Color(homeDevices[index].color),
                                    isActive: homeDevices[index].isActive,
                                    onChanged: (val) {
                                      setState(() {
                                        homeDevices[index].isActive =
                                            !homeDevices[index].isActive;
                                      });
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
