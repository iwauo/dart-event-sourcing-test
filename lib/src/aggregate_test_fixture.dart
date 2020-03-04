import 'dart:mirrors';
import 'package:dart_event_sourcing/commandhandling.dart';
import 'package:dart_event_sourcing/eventhandling.dart';
import 'package:dart_event_sourcing/modeling.dart';

class AggregateTestFixture<T extends Aggregate> {
  T Function() aggregateProvider;
  CommandBus commandBus;
  EventStore eventStore;
  T aggregate;

  AggregateTestFixture({
    CommandBus commandBus,
    EventStore eventStore,
  }) {
    this.aggregate = reflectClass(T).newInstance(Symbol(""), []).reflectee as T;
    this.commandBus = commandBus ?? SimpleCommandBus();
    this.eventStore = eventStore ?? InMemoryEventStore();
  }

  TestExecutor<T> givenNoPriorActivity() {
    return TestExecutor();
  }

  TestExecutor<T> given(List<dynamic> events) {
    return TestExecutor();
  }
}

class TestExecutor<T extends Aggregate> {
  ResultValidator<T> when(dynamic command) {
    return ResultValidator();
  }
}

class ResultValidator<T extends Aggregate> {
  ResultValidator<T> expectEvents(List<dynamic> events) {
    return this;
  }

  ResultValidator<T> expectState(void Function(T aggregate) stateValidator) {
    return this;
  }
}
