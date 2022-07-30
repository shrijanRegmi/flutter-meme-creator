import 'package:flutter/material.dart';
import 'package:meme_creator/viewmodels/base_vm.dart';
import 'package:provider/provider.dart';

class VMProvider<T extends BaseVm> extends StatefulWidget {
  final T vm;
  final Widget Function(BuildContext, T) builder;
  final Function(T)? onInit;
  final Function(T)? onDispose;

  const VMProvider({
    required this.vm,
    required this.builder,
    this.onInit,
    this.onDispose,
    Key? key,
  }) : super(key: key);

  @override
  State<VMProvider<T>> createState() => _VMProviderState();
}

class _VMProviderState<T extends BaseVm> extends State<VMProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => widget.vm,
      builder: (context, child) {
        return Consumer<T>(
          builder: (context, value, child) {
            return widget.builder(context, value);
          },
        );
      },
    );
  }
}
