import 'package:dart_event_sourcing/commandhandling.dart';
import 'package:dart_event_sourcing/eventhandling.dart';

class AggregateTestFixture<T> {
  CommandBus commandBus;
  EventStore eventStore;
  T Function() aggregateProvider;

  AggregateTestFixture(
    T Function() aggregateProvider, {
    CommandBus commandBus,
    EventStore eventStore,
  }) {
    this.aggregateProvider = aggregateProvider;
    this.commandBus = commandBus ?? SimpleCommandBus();
    this.eventStore = eventStore ?? InMemoryEventStore();
  }

  TestExecutor<T> givenNoPriorActivity() {
    return TestExecutor(aggregateProvider());
  }

  TestExecutor<T> given(List<dynamic> events) {
    return TestExecutor(aggregateProvider());
  }
}

class TestExecutor<T> {
  T aggregate;
  TestExecutor(this.aggregate);
  ResultValidator<T> when(dynamic command) {
    return ResultValidator(aggregate);
  }
}

class ResultValidator<T> {
  T aggregate;
  ResultValidator(this.aggregate);
  ResultValidator<T> expectEvents(List<dynamic> events) {
    return this;
  }

  ResultValidator<T> expectState(void Function(T aggregate) stateValidator) {
    stateValidator(aggregate);
    return this;
  }
}
