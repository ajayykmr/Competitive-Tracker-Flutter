import 'package:cflytics/models/contest_standings.dart';
import 'package:cflytics/models/return_objects/problem.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:cflytics/utils/utils.dart';
import 'package:flutter/material.dart';

class ContestProblemsScreen extends StatefulWidget {
  final ContestStandings contestStandings;

  const ContestProblemsScreen(this.contestStandings, {super.key});

  @override
  State<ContestProblemsScreen> createState() => _ContestProblemsScreenState();
}

class _ContestProblemsScreenState extends State<ContestProblemsScreen> with AutomaticKeepAliveClientMixin<ContestProblemsScreen>{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Problems",
          style: textStyle.bodyLarge,
        ),
        Flexible(
          child: ListView.builder(
            itemCount: widget.contestStandings.result!.problems!.length,
            itemBuilder: (context, index) {
              return ProblemCard(widget.contestStandings.result!.problems![index]);
            },
          ),
        )
      ],
    );
  }
}

class ProblemCard extends StatelessWidget {
  final Problem problem;
  const ProblemCard(this.problem, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Utils.openProblem(problem);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColor.primary,
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text("${problem.index!}. ", style: Theme.of(context).textTheme.labelSmall),
                  Text(problem.name!, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            Icon(Icons.arrow_right_rounded, color: AppColor.primaryTextColor,)
          ],
        ),
      ),
    );
  }
}
