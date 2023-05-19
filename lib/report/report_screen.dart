import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Reports",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Tooltip(
              message: 'Old Reports',
              child: HeroIcon(
                HeroIcons.clock,
                size: 28,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: GestureDetector(
            onTap: () {},
            child: TextFormField(
              enabled: false,
              decoration: const InputDecoration(
                hintText: "From Date",
                filled: true,
                fillColor: Color.fromRGBO(234, 240, 247, 1),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(8),
                  child: HeroIcon(HeroIcons.calendar),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: GestureDetector(
            onTap: () {},
            child: TextFormField(
              enabled: false,
              decoration: const InputDecoration(
                hintText: "To Date",
                filled: true,
                fillColor: Color.fromRGBO(234, 240, 247, 1),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(8),
                  child: HeroIcon(HeroIcons.calendar),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 150,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const HeroIcon(HeroIcons.eye),
                label: const Text("View Data"),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const HeroIcon(HeroIcons.documentText),
                label: const Text("Generate CSV"),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 170,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const HeroIcon(HeroIcons.document),
                label: const Text("Generate PDF"),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          thickness: 1,
        ),
        const SizedBox(
          height: 50,
        ),
        // no report to view
        const HeroIcon(
          HeroIcons.documentText,
          size: 100,
          color: Color.fromRGBO(233, 233, 233, 1),
        ),
        const Center(
          child: Text(
            " No report to view",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(194, 194, 194, 1),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
