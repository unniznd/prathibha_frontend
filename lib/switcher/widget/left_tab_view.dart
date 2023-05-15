import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

import '../bloc/left_tab_view/left_tab_view_bloc.dart';
import '../bloc/left_tab_view/left_tab_view_event.dart';
import '../bloc/left_tab_view/left_tab_view_state.dart';

class LeftTabView extends StatelessWidget {
  LeftTabView({
    super.key,
    required this.tabViewBloc,
    required this.ratioWidth,
  });

  final List<String> _tabs = [
    'Dashboard',
    'Attedance',
    'Finance',
  ];

  final LeftTabViewBloc tabViewBloc;
  final double ratioWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
      bloc: tabViewBloc,
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is DashBoardState) {
          selectedIndex = 0;
        } else if (state is AttendanceState) {
          selectedIndex = 1;
        } else if (state is FinanceState) {
          selectedIndex = 2;
        }
        return Container(
          width: 250 / ratioWidth,
          color: const Color.fromRGBO(245, 247, 249, 1),
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  tabViewBloc.add(LeftTabViewSwitch(0));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? const Color.fromRGBO(68, 97, 242, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      HeroIcon(
                        HeroIcons.squares2x2,
                        color: selectedIndex == 0 ? Colors.white : Colors.black,
                      ),
                      SizedBox(
                        width: 10 / ratioWidth,
                      ),
                      Text(
                        _tabs[0],
                        style: TextStyle(
                          color:
                              selectedIndex == 0 ? Colors.white : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  tabViewBloc.add(LeftTabViewSwitch(1));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex == 1
                        ? const Color.fromRGBO(68, 97, 242, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      HeroIcon(
                        HeroIcons.userPlus,
                        color: selectedIndex == 1 ? Colors.white : Colors.black,
                      ),
                      SizedBox(
                        width: 10 / ratioWidth,
                      ),
                      Text(
                        _tabs[1],
                        style: TextStyle(
                          color:
                              selectedIndex == 1 ? Colors.white : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  tabViewBloc.add(LeftTabViewSwitch(2));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedIndex == 2
                        ? const Color.fromRGBO(68, 97, 242, 1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      HeroIcon(
                        HeroIcons.currencyDollar,
                        color: selectedIndex == 2 ? Colors.white : Colors.black,
                      ),
                      SizedBox(
                        width: 10 / ratioWidth,
                      ),
                      Text(
                        _tabs[2],
                        style: TextStyle(
                          color:
                              selectedIndex == 2 ? Colors.white : Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
