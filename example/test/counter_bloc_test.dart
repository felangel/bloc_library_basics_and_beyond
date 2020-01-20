import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../counter_bloc.dart';

void main() {
  group('CounterBloc', () {
    blocTest(
      'emits [0] when no events are added',
      build: () => CounterBloc(),
      expect: [0],
    );

    blocTest(
      'emits [0, 1] when CounterEvent.increment is added',
      build: () => CounterBloc(),
      act: (counterBloc) => counterBloc.add(CounterEvent.increment),
      expect: [0, 1],
    );

    blocTest(
      'emits [0, -1] when CounterEvent.decrement is added',
      build: () => CounterBloc(),
      act: (counterBloc) => counterBloc.add(CounterEvent.decrement),
      expect: [0, -1],
    );
  });
}
