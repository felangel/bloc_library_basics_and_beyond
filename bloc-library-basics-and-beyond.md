footer: @felangelov - flutter europe 2020
slidenumbers: true

# Bloc Library: Basics & Beyond 🚀

### Felix Angelov @ Very Good Ventures

---

# Very Good Ventures, Chicago 🕶️🦄

![inline](./assets/vgv-chicago.jpg)

^ opened an office with my friend/teammate, Jorge. if interested in learning more about VGV reach out.

---

# about me

![inline left](./assets/bmw-logo.png) ![inline right](./assets/vgv-logo.png)

^ started at BMW about 4 years ago. using flutter for last 2 years. rebuild BMW mobile app in Flutter. joined VGV in Jan.

---

# In the beginning...

![inline](./assets/bloc-pattern.png)

[.footer: https://www.didierboelens.com/2018/08/reactive-programming---streams---bloc/]

---

# After a while...

![inline](./assets/rx-meme.jpeg)

[.footer: https://medium.com/@drm/unsubscribe-from-angular-observables-2102dad5b732]

---

# Goals

☐ decouple UI & business logic

☐ easy to test

☐ predictable/maintainable

---

![inline 70%](./assets/bloc-logo.png)

![inline](./assets/bloc-package.png)

---

# Overview

![inline](./assets/bloc-overview.pdf)

> A bloc converts incoming events into outgoing states.

---

# Counter Overview

![inline](./assets/bloc-counter-increment.pdf)

---
[.code-highlight: all]
[.code-highlight: 8-9]

# package:bloc

```yaml
name: counter_bloc
description: A counter bloc example
version: 1.0.0

environment:
  sdk: ">=2.0.0 <3.0.0"

dependencies:
  bloc: ^3.0.0
```

---

# Bloc Anatomy

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';
```

---

# Bloc Anatomy

[.code-highlight: 4]

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }
```

---

# Bloc Anatomy

[.code-highlight: 6]

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {}
```

---

# Bloc Anatomy

[.code-highlight: 7-8]

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
    @override
    int get initialState => 0;
}
```

---

# Bloc Anatomy

[.code-highlight: 6-9]

```dart
...

class CounterBloc extends Bloc<CounterEvent, int> {
    ...

    @override
    Stream<int> mapEventToState(CounterEvent event) async* {

    }
}
```

---

# Bloc Anatomy

[.code-highlight: 8-10]

```dart
...

class CounterBloc extends Bloc<CounterEvent, int> {
    ...

    @override
    Stream<int> mapEventToState(CounterEvent event) async* {
        switch (event) {

        }
    }
}
```

---

# Bloc Anatomy

[.code-highlight: 9-11]

```dart
...

class CounterBloc extends Bloc<CounterEvent, int> {
    ...

    @override
    Stream<int> mapEventToState(CounterEvent event) async* {
        switch (event) {
            case CounterEvent.increment:
                yield state + 1;
                break;
        }
    }
}
```

---

# Bloc Anatomy

[.code-highlight: 12-14]

```dart
...

class CounterBloc extends Bloc<CounterEvent, int> {
    ...

    @override
    Stream<int> mapEventToState(CounterEvent event) async* {
        switch (event) {
            case CounterEvent.increment:
                yield state + 1;
                break;
            case CounterEvent.decrement:
                yield state - 1;
                break;
        }
    }
}
```

---

# Bloc Anatomy

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
    @override
    int get initialState => 0;

    @override
    Stream<int> mapEventToState(CounterEvent event) async* {
        switch (event) {
            case CounterEvent.increment:
                yield state + 1;
                break;
            case CounterEvent.decrement:
                yield state - 1;
                break;
        }
    }
}
```

---

# Bloc in Action

[.code-highlight: 1]
[.code-highlight: 4]
[.code-highlight: 6]
[.code-highlight: 8]
[.code-highlight: 9]

```dart
import 'package:counter_bloc/counter_bloc.dart';

void main() {
    final counterBloc = CounterBloc();

    counterBloc.listen(print);

    counterBloc.add(CounterEvent.increment);
    counterBloc.add(CounterEvent.decrement);
}
```

---


# Bloc in Action

[.code-highlight: 1]

```sh
$ dart example/main.dart
0
1
0
```

---

# Bloc in Action

[.code-highlight: 2]

```sh
$ dart example/main.dart
0 // initialState
1
0
```

---

# Bloc in Action

[.code-highlight: 3]

```sh
$ dart example/main.dart
0
1 // CounterEvent.increment
0
```

---

# Bloc in Action

[.code-highlight: 4]

```sh
$ dart example/main.dart
0
1
0 // CounterEvent.decrement
```

---

# Separation of Concerns

![inline](./assets/bloc-separation-of-concerns.pdf)

---

![left fit](./assets/angular-counter.gif)
![right fit](./assets/flutter-counter.gif)

---

# Async?

---

[.code-highlight: 1]
[.code-highlight: 3]
[.code-highlight: 5-9]
[.code-highlight: 11]

# Async Bloc

```dart
abstract class CounterState {}

class CounterLoadInProgress extends CounterState {}

class CounterLoadSuccess extends CounterState {
  CounterLoadSuccess(this.count);

  final int count;
}

class CounterLoadFailure extends CounterState {}
```

---

# Async Bloc

[.code-highlight: 3]

```dart
...

class CounterBloc extends Bloc<CounterEvent, CounterState> {...}
```

---

# Async Bloc

[.code-highlight: 4-6]

```dart
...

class CounterBloc extends Bloc<CounterEvent, CounterState> {
    CounterBloc(this._counterService);

    final CounterService _counterService;

    ...
}
```

---

# Async Bloc

[.code-highlight: 3,4]
[.code-highlight: 10,13]

```dart
...

@override
int get initialState => CounterLoadInProgress();

@override
Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
        case CounterEvent.increment:
            yield* _mapIncrementToState();
            break;
        case CounterEvent.decrement:
            yield* _mapDecrementToState();
            break;
    }
}
```

---

# Async Bloc

```dart
...

Stream<CounterState> _mapIncrementToState() async* {
  yield CounterLoadInProgress();
  try {
    final asyncCount = await _counterService.increment();
    yield CounterLoadSuccess(asyncCount);
  } catch (_) {
    yield CounterLoadFailure();
  }
}

```

---

[.code-highlight: 4,11]
[.code-highlight: 6-7]
[.code-highlight: 8-10]

# Async Bloc

```dart
...

Stream<CounterState> _mapIncrementToState() async* {
  yield CounterLoadInProgress();
  try {
    final asyncCount = await _counterService.increment();
    yield CounterLoadSuccess(asyncCount);
  } catch (_) {
    yield CounterLoadFailure();
  }
}

```

---

[.code-highlight: all]
[.code-highlight: 6]

# Async Bloc

```dart
...

Stream<CounterState> _mapDecrementToState() async* {
  yield CounterLoadInProgress();
  try {
    final asyncCount = await _counterService.decrement();
    yield CounterLoadSuccess(asyncCount);
  } catch (_) {
    yield CounterLoadFailure();
  }
}

```

---

# Goals

**☑️ decouple UI & business logic**

☐ easy to test

☐ predictable/maintainable

---

# Goals

☑️ decouple UI & business logic

**☐ easy to test**

☐ predictable/maintainable

---

![inline 70%](./assets/bloc-test-logo.png)
![inline](./assets/bloc-test-package.png)

---

[.code-highlight: all]
[.code-highlight: 11-13]

# package:bloc_test

```yaml
name: counter_bloc
description: A counter bloc example
version: 1.0.0

environment:
  sdk: ">=2.0.0 <3.0.0"

dependencies:
  bloc: ^3.0.0

dev_dependencies:
  test: ^1.11.1
  bloc_test: ^3.0.0
```

---

[.code-highlight: all]
[.code-highlight: 6,14]
[.code-highlight: 1, 7, 13]
[.code-highlight: 2, 4, 8-12]
[.code-highlight: 9]
[.code-highlight: 10]
[.code-highlight: 11]

# bloc_test Anatomy

```dart
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
  });
}
```

---

[.code-highlight: 1]
[.code-highlight: 2-3]

# bloc_test in Action

```sh
$ pub run test
✓ CounterBloc emits [0] when no events are added
00:01 +1: All tests passed!
```

---

[.code-highlight: 10-15]
[.code-highlight: 11]
[.code-highlight: 12]
[.code-highlight: 13]
[.code-highlight: 14]

# One More Time

```dart
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../counter_bloc.dart';

void main() {
  group('CounterBloc', () {
    ...

    blocTest(
      'emits [0, 1] when CounterEvent.increment is added',
      build: () => CounterBloc(),
      act: (counterBloc) => counterBloc.add(CounterEvent.increment),
      expect: [0, 1],
    );
  });
}
```

---

[.code-highlight: 10-15]
[.code-highlight: 13]
[.code-highlight: 14]

# One More Time

```dart
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

import '../counter_bloc.dart';

void main() {
  group('CounterBloc', () {
    ...

    blocTest(
      'emits [0, -1] when CounterEvent.decrement is added',
      build: () => CounterBloc(),
      act: (counterBloc) => counterBloc.add(CounterEvent.decrement),
      expect: [0, -1],
    );
  });
}
```

---

[.code-highlight: 1]
[.code-highlight: 2-5]

# All Tests in Action

```sh
$ pub run test
✓ CounterBloc emits [0] when no events are added
✓ CounterBloc emits [0, 1] when CounterEvent.increment is added
✓ CounterBloc emits [0, -1] when CounterEvent.decrement is added
00:01 +3: All tests passed!
```

---

# Async Tests?

---

[.code-highlight: 14]

# package:bloc_test

```yaml
name: counter_bloc
description: A counter bloc example
version: 1.0.0

environment:
  sdk: ">=2.0.0 <3.0.0"

dependencies:
  bloc: ^3.0.0

dev_dependencies:
  test: ^1.11.1
  bloc_test: ^3.0.0
  mockito: ^4.0.0
```

---

# Async Bloc Tests

```dart
import 'package:mockito/mockito.dart';

class MockCounterService extends Mock implements CounterService {}

...

```

---
[.code-highlight: 3-4, 12]
[.code-highlight: 5-9]
[.code-highlight: 10]
[.code-highlight: 11]

# Async Bloc Tests

```dart
...

blocTest(
  'emits [CounterLoadInProgress(), CounterLoadSuccess(1)] when CounterEvent.increment is added',
  build: () {
    final counterService = MockCounterService();
    when(counterService.increment).thenAnswer((_) => Future.value(1));
    return CounterBloc(counterService);
  },
  act: (counterBloc) => counterBloc.add(CounterEvent.increment),
  expect: [CounterLoadInProgress(), CounterLoadSuccess(1)],
);
```

---

# Not You

![inline](./assets/tests-meme.png)

---

# Goals

☑️ decouple UI & business logic

**☑️ easy to test**

☐ predictable/maintainable

---

# Goals

☑️ decouple **UI** & business logic

☑️ easy to test

☐ predictable/maintainable

---

![inline 70%](./assets/flutter-bloc-logo.png)
![inline](./assets/flutter-bloc-package.png)

---

# package:flutter_bloc

[.code-highlight: all]
[.code-highlight: 9-10]
[.code-highlight: 11]
[.code-highlight: 12-13]

```yaml
name: counter_app
description: A counter app example
version: 1.0.0

environment:
  sdk: ">=2.0.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^3.0.0
  counter_bloc:
    path: ../counter_bloc

flutter:
  uses-material-design: true
```

---

[.code-highlight: all]
[.code-highlight: 5]

# flutter_bloc in Action

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_bloc/counter_bloc.dart';

void main() => runApp(CounterApp());
```

---

[.code-highlight: all]
[.code-highlight: 3, 13]
[.code-highlight: 4-5, 12]
[.code-highlight: 6, 11]
[.code-highlight: 7-10]

# flutter_bloc in Action

```dart
...

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}
```

---

# Bloc**Provider** 🤔

---

# Bloc**Provider** 🧐

![inline](./assets/flutter-bloc-dependencies.png)

---

# Bloc**Provider** 😊

![inline left](./assets/flutter-bloc-dependencies-zoom.png)![inline right](./assets/surprised-yoda.jpg)

[.footer: https://imgflip.com/memetemplate/213059118/Surprised-Baby-Yoda]

---

[.code-highlight: all]
[.code-highlight: 2-4]
[.code-highlight: 5]

# BlocProvider Anatomy

> _makes a bloc available to a sub-tree_

```dart
BlocProvider(
  create: (BuildContext context) {
    return MyBloc();
  },
  child: TheChild(),
)
```

---

![inline](./assets/baby-yoda-crib.jpg)

[.footer: https://www.indiewire.com/2019/12/the-mandalorian-merchandise-questions-1202195206/]

---

[.code-highlight: all]
[.code-highlight: 4]

# BlocProvider Anatomy

```dart
class TheChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myBloc = BlocProvider.of<MyBloc>(context);

    ...
  }
}
```

---

[.code-highlight: all]
[.code-highlight: 3, 20]
[.code-highlight: 4, 6-10, 15-19]

# dispose?

```dart
...

class _CounterAppState extends State<CounterApp> {
  CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  Widget build(BuildContext context) {...}

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }
}
```

---

[.code-highlight: 9]

# BlocProvider Anatomy

> _by default BlocProvider automatically closes the provided bloc_

```dart
BlocProvider({
    Key key,
    @required Create<T> create,
    Widget child,
    bool lazy,
  }) : this._(
          key: key,
          create: create,
          dispose: (_, bloc) => bloc?.close(),
          child: child,
          lazy: lazy,
        );
```

---

# Multiple Blocs?

[.code-highlight: 1-2, 9-11]
[.code-highlight: 3-5]
[.code-highlight: 6-8]

```dart
MultiBlocProvider(
  providers: [
    BlocProvider<BlocA>(
      create: (_) => BlocA(),
    ),
    BlocProvider<BlocB>(
      create: (_) => BlocB(),
    ),
  ],
  child: MyChild(),
)
```

---

[.code-highlight: 9]

# Back to flutter_bloc in Action

```dart
...

class CounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: CounterPage(),
      ),
    );
  }
}
```

---

[.code-highlight: all]
[.code-highlight: 3, 17]
[.code-highlight: 4-5, 16]
[.code-highlight: 6-8, 15]
[.code-highlight: 9-13]

# flutter_bloc in Action

```dart
...

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Text('You have pushed the button $state times.');
          },
        ),
      ),
    );
  }
}
```

---

[.code-highlight: all]
[.code-highlight: 1, 5]
[.code-highlight: 2-4]

# BlocBuilder Anatomy

> _handles building a widget in response to bloc states_

```dart
BlocBuilder<MyBloc, MyState>(
  builder: (BuildContext context, MyState state) {
    // return widget based on MyState
  }
)
```

---

[.code-highlight: 2]

# Where is the Bloc?

```dart
BlocBuilder<MyBloc, MyState>(
  bloc: BlocProvider.of<MyBloc>(context),
  builder: (BuildContext context, MyState state) {
    // return widget based on MyState
  }
)
```

---

# Where is the Bloc?

[.code-highlight: 8]

```dart
class _BlocBuilderBaseState<B extends Bloc<dynamic, S>, S>
    extends State<BlocBuilderBase<B, S>> {
  ...

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? BlocProvider.of<B>(context);

    ...
  }
```

---

[.code-highlight: all]
[.code-highlight: 11]

# Back to flutter_bloc in Action

```dart
...

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, state) {
            return Text('You have pushed the button $state times.');
          },
        ),
      ),
    );
  }
}
```

---

[.code-highlight: all]
[.code-highlight: 5-7]
[.code-highlight: 8-10]
[.code-highlight: 11]

# flutter_bloc in Action (Async)

```dart
...

BlocBuilder<CounterBloc, int>(
  builder: (context, state) {
    if (state is CounterLoadInProgress) {
      return MyLoadingIndicator();
    }
    if (state is CounterLoadSuccess) {
      return Text('You have pushed the button ${state.count} times.');
    }
    return MyError();
  },
),
```

---

[.code-highlight: all]
[.code-highlight: 4]
[.code-highlight: 7-8, 17-18]
[.code-highlight: 9-12]
[.code-highlight: 11]
[.code-highlight: 13-16]
[.code-highlight: 15]

# flutter_bloc in Action

```dart
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      ...
      floatingActionButton: Column(
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => counterBloc.add(CounterEvent.increment),
          ),
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () => counterBloc.add(CounterEvent.decrement),
          ),
        ],
      ),
    );
  }
}
```

---

![inline left](./assets/flutter-counter.gif)![inline right](./assets/counter-app-tree.pdf)

---

# Side Effects: Snack Bars

---

[.code-highlight: all]
[.code-highlight: 1, 6]
[.code-highlight: 2-4]
[.code-highlight: 5]

# BlocListener Anatomy

> _handles doing "stuff" in response to state changes_

```dart
BlocListener<MyBloc, MyState>(
  listener: (BuildContext context, MyState state) {
    // do stuff in response to state changes
  },
  child: TheChild(),
)
```

---

![inline](./assets/baby-yoda-crib.jpg)

[.footer: https://www.indiewire.com/2019/12/the-mandalorian-merchandise-questions-1202195206/]

---

[.code-highlight: 9-20]
[.code-highlight: 10-14]

# Back to Side Effects: Snack Bars

```dart
...
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocListener<CounterBloc, int>(
          listener: (context, state) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('counter: $state')));
          },
          child: BlocBuilder<CounterBloc, int>(
            builder: (context, state) {
              return Text('You have pushed the button $state times.');
            },
          ),
        ),
      ),
      ...
```

---

![fit](./assets/counter-snack-bar.gif)

---

![inline](./assets/refactor-meme.jpg)

[.footer: https://makeameme.org/meme/brace-yourself-refactoring]

---

[.code-highlight: all]
[.code-highlight: 1,8]
[.code-highlight: 2-4]
[.code-highlight: 5-7]

# BlocConsumer Anatomy

> _combined BlocBuilder and BlocListener_

```dart
BlocConsumer<MyBloc, MyState>(
  listener: (BuildContext context, MyState state) {
    // do stuff in response to new states
  },
  builder: (BuildContext context, MyState state) {
    // return widgets in response to new states
  },
)
```

---

[.code-highlight: 9-20]

# The Refactor

```dart
...
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocListener<CounterBloc, int>(
          listener: (context, state) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('counter: $state')));
          },
          child: BlocBuilder<CounterBloc, int>(
            builder: (context, state) {
              return Text('You have pushed the button $state times.');
            },
          ),
        ),
      ),
      ...
```

---

[.code-highlight: 10-19]
[.code-highlight: 11-15]
[.code-highlight: 16-18]

# The Refactor

```dart
...

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocConsumer<CounterBloc, int>(
          listener: (context, state) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('counter: $state')));
          },
          builder: (context, state) {
            return Text('You have pushed the button $state times.');
          },
        ),
      ),
      ...
```

---

# Goals

☑️ decouple UI & business logic

☑️ easy to test

**☐ predictable/maintainable**

---

[.code-highlight: 5-9]
[.code-highlight: 8]

# bloc: onEvent

> _invoked when an event is added to the bloc_

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    print('onEvent $event');
  }

  ...
}
```

---

# the good old days

```dart
import 'counter_bloc.dart';

void main() {
    final counterBloc = CounterBloc();

    counterBloc.listen(print);

    counterBloc.add(CounterEvent.increment);
    counterBloc.add(CounterEvent.decrement);
}
```

---

[.code-highlight: 1]
[.code-highlight: 2]
[.code-highlight: 3]
[.code-highlight: 4-6]

# onEvent in action

```sh
$ dart example/main.dart
onEvent CounterEvent.increment
onEvent CounterEvent.decrement
0
1
0
```

---

[.code-highlight: 5-9]
[.code-highlight: 8]

# bloc: onTransition

> _invoked when a new state is emitted_

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print('onTransition $transition');
  }

  ...
}
```

---

[.code-highlight: 1]
[.code-highlight: 2]
[.code-highlight: 3]
[.code-highlight: 4]
[.code-highlight: 5]
[.code-highlight: 6]

# onTransition in action

```sh
$ dart example/main.dart
0
onTransition Transition { currentState: 0, event: CounterEvent.increment, nextState: 1 }
1
onTransition Transition { currentState: 1, event: CounterEvent.decrement, nextState: 0 }
0
```

---

[.code-highlight: 5-9]
[.code-highlight: 8]

# bloc: onError

> _invoked when an uncaught error is thrown within a bloc_

```dart
class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print('onError $error, $stacktrace');
  }

  ...
}
```

---

# bloc: onError

[.code-highlight: 14-15]

```dart
class CounterBloc extends Bloc<CounterEvent, int> {

  ...

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.decrement:
        yield state - 1;
        break;
      default:
        throw Exception('unsupported event!');
    }
  }
}
```

---

[.code-highlight: 8]

# bloc: onError

```dart
void main() {
  final counterBloc = CounterBloc();

  counterBloc.listen(print);

  counterBloc.add(CounterEvent.increment);
  counterBloc.add(CounterEvent.decrement);
  counterBloc.add(null);
}
```

---

[.code-highlight: 1]
[.code-highlight: 2-4]
[.code-highlight: 5-17]
[.code-highlight: 6]

# onError in action

```sh
$ dart example/main.dart
0
1
0
onError Exception: unsupported event!,
#0      CounterBloc.mapEventToState (file:///example/counter_bloc.dart:27:9) <asynchronous suspension>
#1      Bloc._bindStateSubject.<anonymous closure> (package:bloc/src/bloc.dart:155:14)
#2      Stream.asyncExpand.onListen.<anonymous closure> (dart:async/stream.dart:576:30)
#3      _RootZone.runUnaryGuarded (dart:async/zone.dart:1316:10)
#4      _BufferingStreamSubscription._sendData (dart:async/stream_impl.dart:338:11)
#5      _DelayedData.perform (dart:async/stream_impl.dart:593:14)
#6      _StreamImplEvents.handleNext (dart:async/stream_impl.dart:709:11)
#7      _PendingEvents.schedule.<anonymous closure> (dart:async/stream_impl.dart:669:7)
#8      _microtaskLoop (dart:async/schedule_microtask.dart:43:21)
#9      _startMicrotaskLoop (dart:async/schedule_microtask.dart:52:5)
#10     _runPendingImmediateCallback (dart:isolate-patch/isolate_patch.dart:118:13)
#11     _RawReceivePortImpl._handleMessage (dart:isolate-patch/isolate_patch.dart:175:5)
```

---

[.code-highlight: 3]

# seeing double: bloc delegate

> _handles hooks from all blocs_

```dart
import 'package:bloc/bloc.dart';

class MyBlocDelegate extends BlocDelegate {}
```

---

[.code-highlight: 4-8]
[.code-highlight: 10-14]
[.code-highlight: 16-20]

# seeing double: bloc delegate

```dart
import 'package:bloc/bloc.dart';

class MyBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('onEvent ${bloc.runtimeType}, $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('onError ${bloc.runtimeType}, $error, $stacktrace');
  }
}
```

---

[.code-highlight: 4,7]

# initialize bloc delegate

```dart
import 'package:bloc/bloc.dart';

import 'counter_bloc.dart';
import 'my_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();
  final counterBloc = CounterBloc();

  counterBloc.listen(print);

  counterBloc.add(CounterEvent.increment);
  counterBloc.add(CounterEvent.decrement);
  counterBloc.add(null);
}
```

---

[.code-highlight: 1]
[.code-highlight: 2-4]
[.code-highlight: 6,8]
[.code-highlight: 10-11]

# bloc delegate in action

```sh
$ dart example/main.dart
onEvent CounterBloc, CounterEvent.increment
onEvent CounterBloc, CounterEvent.decrement
onEvent CounterBloc, null
0
onTransition CounterBloc, Transition { currentState: 0, event: CounterEvent.increment, nextState: 1 }
1
onTransition CounterBloc, Transition { currentState: 1, event: CounterEvent.decrement, nextState: 0 }
0
onError CounterBloc, Exception: unhandled event!,
#0      CounterBloc.mapEventToState (file:///example/counter_bloc.dart:21:9)<asynchronous suspension>
#1      Bloc._bindStateSubject.<anonymous closure> (package:bloc/src/bloc.dart:155:14)
#2      Stream.asyncExpand.onListen.<anonymous closure> (dart:async/stream.dart:576:30)
#3      _RootZone.runUnaryGuarded (dart:async/zone.dart:1316:10)
#4      _BufferingStreamSubscription._sendData (dart:async/stream_impl.dart:338:11)
#5      _DelayedData.perform (dart:async/stream_impl.dart:593:14)
#6      _StreamImplEvents.handleNext (dart:async/stream_impl.dart:709:11)
#7      _PendingEvents.schedule.<anonymous closure> (dart:async/stream_impl.dart:669:7)
#8      _microtaskLoop (dart:async/schedule_microtask.dart:43:21)
#9      _startMicrotaskLoop (dart:async/schedule_microtask.dart:52:5)
#10     _runPendingImmediateCallback (dart:isolate-patch/isolate_patch.dart:118:13)
#11     _RawReceivePortImpl._handleMessage (dart:isolate-patch/isolate_patch.dart:175:5)
```

---

# Goals

☑️ decouple UI & business logic

☑️ easy to test

☐ **predictable**/maintainable

---

# Goals

☑️ decouple UI & business logic

☑️ easy to test

☐ predictable/**maintainable**

---

# Tooling

![inline](./assets/new-bloc.gif)![inline right 100%](./assets/new-bloc-intellij.png)

---

# Documentation

![inline](./assets/bloc-library-site.png)

> https://bloclibrary.dev

---

# Examples Apps & Tutorials

![inline](./assets/flutter-firebase-login.gif)![inline](./assets/flutter-github-search.gif)![inline](./assets/flutter-infinite-list.gif)![inline](./assets/flutter-timer.gif)![inline](./assets/flutter-todos.gif)![inline](./assets/flutter-weather.gif)

---

# Speaking of Examples...

---

![inline left](./assets/flutter-europe-android.png)![inline right](./assets/flutter-europe-ios.png)

---

# Goals

☑️ decouple UI & business logic

☑️ easy to test

☑️ **predictable/maintainable**

---

# Bonus: package:hydrated_bloc

![inline](./assets/hydrated-bloc-logo.png)
![inline](./assets/hydrated-bloc-package.png)

---

![inline](./assets/regular-bloc-restart.gif)

---

[.code-highlight: 12]

# package:hydrated_bloc

```yaml
name: counter_app
description: A counter app example
version: 1.0.0

environment:
  sdk: ">=2.0.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^3.0.0
  hydrated_bloc: ^3.0.0
  counter_bloc:
    path: ../counter_bloc

flutter:
  uses-material-design: true
```

---

# Hydrated Bloc in Action

```dart
...

import 'package:hydrated_bloc/hydrated_bloc.dart';

class CounterBloc extends HydratedBloc<CounterEvent, int> {...}
```

---

[.code-highlight: 6-7]

# Hydrated Bloc in Action

```dart
...

import 'package:hydrated_bloc/hydrated_bloc.dart';

class CounterBloc extends HydratedBloc<CounterEvent, int> {
  @override
  int get initialState => super.initialState ?? 0;
}
```

---

[.code-highlight: 11-14]
[.code-highlight: 16-19]

# Hydrated Bloc in Action

```dart
...

import 'package:hydrated_bloc/hydrated_bloc.dart';

class CounterBloc extends HydratedBloc<CounterEvent, int> {
  @override
  int get initialState => super.initialState ?? 0;

  ...

  @override
  Map<String, int> toJson(int state) {
    return {'count': state};
  }

  @override
  int fromJson(Map<String, dynamic> source) {
    return source['count'] as int;
  }
}
```

---

[.code-highlight: 1,6]
[.code-highlight: 2]
[.code-highlight: 3]
[.code-highlight: 4]

# Hydrated Bloc in Action

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = await HydratedBlocDelegate.build();
  runApp(App());
}
```

---

![inline left](./assets/regular-bloc-restart.gif)![inline right](./assets/hydrated-bloc-restart.gif)

---

# Thanks for coming 👋

![inline](./assets/baby-yoda-drinking.jpg)

> Twitter - @felangelov
> Bloc Library Docs - https://bloclibrary.dev
> Bloc Library Discord - https://discord.gg/Hc5KD3g

[.footer: https://www.syfy.com/syfywire/baby-yoda-soup]
