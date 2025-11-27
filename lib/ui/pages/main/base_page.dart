import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasePage<B extends BlocBase<S>, S> extends StatelessWidget {

  final B Function(BuildContext) onCreate;
  final void Function(BuildContext, S) listener;
  final Widget Function(BuildContext, S) builder;
  final Widget? Function(BuildContext, S)? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget Function(BuildContext, S)? bottomNavigationBar;

  const BasePage({
    super.key,
    required this.onCreate,
    required this.listener,
    required this.builder,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: onCreate,
      child: BlocListener<B, S>(
        listener: (ctx, state) => listener(ctx, state),
        child: BlocBuilder<B, S>(
          builder: (ctx, state) => Scaffold(
            floatingActionButton: floatingActionButton?.call(ctx, state),
            floatingActionButtonLocation: floatingActionButtonLocation,
            bottomNavigationBar: bottomNavigationBar?.call(ctx, state),
            body: SafeArea(
              child: builder(ctx, state),
            ),
          )
        ),
      ),
    );
  }
}