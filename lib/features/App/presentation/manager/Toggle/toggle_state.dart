part of 'toggle_cubit.dart';

sealed class ToggleState extends Equatable {
  final int index;
  const ToggleState({required this.index});

  @override
  List<Object> get props => [index];
}

final class ToggleInitial extends ToggleState {
  const ToggleInitial({required super.index});
}
