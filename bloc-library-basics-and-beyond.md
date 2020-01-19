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

# overview

![inline](./assets/bloc-overview.pdf)

> A bloc converts incoming events into outgoing states.

---

# real-world

![inline](./assets/bloc-counter-overview.png)

---

# real-world: increment

![inline](./assets/bloc-counter-increment.png)

---

# packages

- **package:bloc - Core (Dart)**
- package:bloc_test - Testing Helpers (Dart)
- package:flutter_bloc - Flutter Widgets
- package:angular_bloc - AngularDart Components

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
$ dart example/counter_bloc.dart
0
1
0
```

---

# bloc in action

[.code-highlight: 1]

```sh
$ dart example/counter_bloc.dart
0
1
0
```

---

# bloc in action

[.code-highlight: 2]

```sh
$ dart example/counter_bloc.dart
0 // initialState
1
0
```

---

# bloc in action

[.code-highlight: 3]

```sh
$ dart example/counter_bloc.dart
0
1 // CounterEvent.increment
0
```

---

# bloc in action

[.code-highlight: 4]

```sh
$ dart example/counter_bloc.dart
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

# onEvent in action

```sh
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
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

# onTransition in action

```sh
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
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
$ dart example/counter_bloc.dart
0
onTransition Transition { currentState: 0, event: CounterEvent.increment, nextState: 1 }
1
onTransition Transition { currentState: 1, event: CounterEvent.decrement, nextState: 0 }
0
```

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
