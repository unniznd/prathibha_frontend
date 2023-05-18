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
    required this.screenWidth,
  });

  final List<String> _tabs = [
    'Dashboard',
    'Students',
    'Attedance',
    'Fees',
    'Reports',
  ];

  final List<HeroIcons> _tabIcons = [
    HeroIcons.squares2x2,
    HeroIcons.userGroup,
    HeroIcons.userPlus,
    HeroIcons.currencyDollar,
    HeroIcons.newspaper,
  ];

  final LeftTabViewBloc tabViewBloc;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
      bloc: tabViewBloc,
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is DashBoardState) {
          selectedIndex = 0;
        } else if (state is StudentsState) {
          selectedIndex = 1;
        } else if (state is AttendanceState) {
          selectedIndex = 2;
        } else if (state is FeeState) {
          selectedIndex = 3;
        } else if (state is ReportsState) {
          selectedIndex = 4;
        } else {
          selectedIndex = 0;
        }

        return Container(
          width: screenWidth / 5.5,
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: _tabs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      tabViewBloc.add(LeftTabViewSwitch(index));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? const Color.fromRGBO(68, 97, 242, 1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          HeroIcon(
                            _tabIcons[index],
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            _tabs[index],
                            style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
