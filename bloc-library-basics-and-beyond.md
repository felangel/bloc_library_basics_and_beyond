footer: @felangelov - flutter europe 2020
slidenumbers: true

# Bloc Library: Basics and Beyond 🚀

### Felix Angelov @ Very Good Ventures

---

# about me

![inline](./assets/about-me.png)

---

# so you need to build an app?

---

## application state

![inline](./assets/ui-is-function-of-state.png)

#### "A system is described as stateful if it is designed to remember preceding events or user interactions; the remembered information is called the **state**"

[.footer: https://en.wikipedia.org/wiki/State_(computer_science)]

---

# why state management?

### "There is (almost) always state in our applications therefore we are (almost) always managing state whether we know it or not."

[.footer: https://egghead.io/articles/what-is-state-why-do-i-need-to-manage-it]

---

# goals

☐ separate presentation from logic
☐ logging/analytics
☐ test with ease
☐ develop efficiently (with many devs)
☐ maintainable/scalable

---

# packages

- package:bloc - Core (Dart)
- package:bloc_test - Testing Helpers (Dart)
- package:flutter_bloc - Flutter Widgets
- package:angular_bloc - AngularDart Components

---

# packages

- **package:bloc - Core (Dart)**
- package:bloc_test - Testing Helpers (Dart)
- package:flutter_bloc - Flutter Widgets
- package:angular_bloc - AngularDart Components

---

# packages

- package:bloc - Core (Dart)
- **package:bloc_test - Testing Helpers (Dart)**
- package:flutter_bloc - Flutter Widgets
- package:angular_bloc - AngularDart Components

---

# packages

- package:bloc - Core (Dart)
- package:bloc_test - Testing Helpers (Dart)
- **package:flutter_bloc - Flutter Widgets**
- package:angular_bloc - AngularDart Components

---

# packages

- package:bloc - Core (Dart)
- package:bloc_test - Testing Helpers (Dart)
- package:flutter_bloc - Flutter Widgets
- **package:angular_bloc - AngularDart Components**

---

# packages

- **package:bloc - Core (Dart)**
- package:bloc_test - Testing Helpers (Dart)
- package:flutter_bloc - Flutter Widgets
- package:angular_bloc - AngularDart Components

---

# overview

![inline](./assets/bloc-overview.pdf)

> A bloc converts incoming events into outgoing states.

---

# real-world

![inline](./assets/bloc-counter-overview.pdf)

---

# real-world: increment

![inline](./assets/bloc-counter-increment.pdf)

---

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

# bloc anatomy

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';
```

---

# bloc anatomy

[.code-highlight: 4]

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {}
```

---

# bloc anatomy

[.code-highlight: 4]

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {}
```

---

# bloc anatomy

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

# bloc anatomy

[.code-highlight: 10-13]

```dart
import 'dart:async';
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
    @override
    int get initialState => 0;

    @override
    Stream<int> mapEventToState(CounterEvent event) async* {

    }
}
```

---

# bloc anatomy

[.code-highlight: 12-14]

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

        }
    }
}
```

---

# bloc anatomy

[.code-highlight: 13-15]

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
        }
    }
}
```

---

# bloc anatomy

[.code-highlight: 16-18]

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

# bloc anatomy

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

# bloc in action

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

# bloc in action

[.code-highlight: 1]

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

# bloc in action

[.code-highlight: 4]

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

# bloc in action

[.code-highlight: 6]

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

# bloc in action

[.code-highlight: 8]

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

# bloc in action

[.code-highlight: 9]

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

# bloc in action

```sh
$ dart example/main.dart
0
1
0
```

---

# bloc in action

[.code-highlight: 1]

```sh
$ dart example/main.dart
0
1
0
```

---

# bloc in action

[.code-highlight: 2]

```sh
$ dart example/main.dart
0 // initialState
1
0
```

---

# bloc in action

[.code-highlight: 3]

```sh
$ dart example/main.dart
0
1 // CounterEvent.increment
0
```

---

# bloc in action

[.code-highlight: 4]

```sh
$ dart example/main.dart
0
1
0 // CounterEvent.decrement
```

---

# goals

**☑️ separate presentation from logic**
☐ logging/analytics
☐ test with ease
☐ develop efficiently (with many devs)
☐ maintainable/scalable

---

# goals

☑️ separate presentation from logic
**☐ logging/analytics**
☐ test with ease
☐ develop efficiently (with many devs)
☐ maintainable/scalable

---

# bloc hooks: onEvent

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

[.code-highlight: 5-9]

# bloc hooks: onEvent

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

[.code-highlight: 8]

# bloc hooks: onEvent

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

# onEvent in action

[.code-highlight: 1]

```sh
$ dart example/main.dart
onEvent CounterEvent.increment
onEvent CounterEvent.decrement
0
1
0
```

---

# onEvent in action

[.code-highlight: 2]

```sh
$ dart example/main.dart
onEvent CounterEvent.increment
onEvent CounterEvent.decrement
0
1
0
```

---

# onEvent in action

[.code-highlight: 3]

```sh
$ dart example/main.dart
onEvent CounterEvent.increment
onEvent CounterEvent.decrement
0
1
0
```

---

# onEvent in action

[.code-highlight: 4-6]

```sh
$ dart example/main.dart
onEvent CounterEvent.increment
onEvent CounterEvent.decrement
0
1
0
```

---

# bloc hooks: onTransition

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

[.code-highlight: 5-9]

# bloc hooks: onTransition

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

[.code-highlight: 8]

# bloc hooks: onTransition

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

[.code-highlight: 1]

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

[.code-highlight: 2]

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

[.code-highlight: 3]

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

[.code-highlight: 4]

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

[.code-highlight: 5]

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

# bloc hooks: onError

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

[.code-highlight: 5-9]

# bloc hooks: onError

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

[.code-highlight: 8]

# bloc hooks: onError

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

# bloc hooks: onError

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

# bloc hooks: onError

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

# bloc hooks: onError

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

[.code-highlight: 8]

# bloc hooks: onError

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

[.code-highlight: 1]

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

[.code-highlight: 5-17]

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

# seeing double: bloc delegate

> _handles hooks from all blocs_

```dart
import 'package:bloc/bloc.dart';

class MyBlocDelegate extends BlocDelegate {}
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

# seeing double: bloc delegate

> _handles hooks from all blocs_

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

[.code-highlight: 4-8]

# seeing double: bloc delegate

> _handles hooks from all blocs_

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

[.code-highlight: 10-14]

# seeing double: bloc delegate

> _handles hooks from all blocs_

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

[.code-highlight: 16-20]

# seeing double: bloc delegate

> _handles hooks from all blocs_

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

[.code-highlight: 1,4,7]

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

[.code-highlight: 1]

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

[.code-highlight: 2,3,4,6,8,10]

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

# goals

☑️ separate presentation from logic
**☑️ logging/analytics**
☐ test with ease
☐ develop efficiently (with many devs)
☐ maintainable/scalable

---

# goals

☑️ separate presentation from logic
☑️ logging/analytics
**☐ test with ease**
☐ develop efficiently (with many devs)
☐ maintainable/scalable

---

# package:bloc_test

---

# package:flutter_bloc

---

# package:hydrated_bloc

---

# package:sealed_flutter_bloc

---

# Tooling
