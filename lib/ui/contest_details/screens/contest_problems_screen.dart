import 'package:cflytics/models/contest_standings.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Problems",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        const Divider(
          color: Colors.black26,
        ),
        Flexible(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black26,
            ),
            itemCount: widget.contestStandings.result!.problems!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () async {
                  Utils.openProblem(widget.contestStandings.result!.problems![index]);
                },
                leading: Text(
                  "${widget.contestStandings.result!.problems![index].index!}.",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                title: Text(
                  widget.contestStandings.result!.problems![index].name!,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
