import 'package:flutter/material.dart';

import 'package:ddd_resocoder/domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  const CriticalFailureDisplay({
    Key? key,
    required this.noteFailure,
  }) : super(key: key);

  final NoteFailure noteFailure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '😱',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
          Text(
            noteFailure.maybeMap(
              orElse: () => 'Unexpected failure. \nPlease contact support.',
              insufficientPremission: (_) => 'Insufficent permissions',
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
          TextButton(
            onPressed: () {
              print('Sending email...');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.mail),
                SizedBox(
                  width: 4,
                ),
                Text('I NEED HELP'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
