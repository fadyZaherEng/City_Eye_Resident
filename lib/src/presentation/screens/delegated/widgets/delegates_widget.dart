import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/domain/entities/delegated/delegated.dart';
import 'package:city_eye/src/presentation/screens/delegated/widgets/delegated_card_widget.dart';
import 'package:city_eye/src/presentation/widgets/custom_empty_list_widget.dart';
import 'package:flutter/material.dart';

class DelegatesWidget extends StatefulWidget {
  final List<Delegated> delegates;
  final void Function(Delegated delegated) deactivateAction;
  final void Function(Delegated delegated) phoneNumberAction;
  final void Function(Delegated delegated) editAction;
  final void Function(Delegated delegated) onScanQRDelegation;
  final Function() onPullToRefresh;

  const DelegatesWidget({
    Key? key,
    required this.delegates,
    required this.deactivateAction,
    required this.phoneNumberAction,
    required this.editAction,
    required this.onScanQRDelegation,
    required this.onPullToRefresh,
  }) : super(key: key);

  @override
  State<DelegatesWidget> createState() => _DelegatesWidgetState();
}

class _DelegatesWidgetState extends State<DelegatesWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: widget.delegates.isEmpty
          ? CustomEmptyListWidget(
              imagePath: ImagePaths.delegationEmptyIcon,
              text: S.of(context).noDelegatedList,
              onRefresh: () => widget.onPullToRefresh(),
            )
          : RefreshIndicator(
              onRefresh: () => widget.onPullToRefresh(),
              child: ListView.builder(
                  itemCount: widget.delegates.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return DelegatedCardWidget(
                      delegated: widget.delegates[index],
                      deactivateAction: (Delegated delegated) {
                        widget.deactivateAction(delegated);
                      },
                      phoneNumberAction: (Delegated delegated) {
                        widget.phoneNumberAction(delegated);
                      },
                      editAction: (Delegated delegated) {
                        widget.editAction(delegated);
                      },
                      onScanQRDelegation: (Delegated delegated) {
                        widget.onScanQRDelegation(delegated);
                      },
                    );
                  }),
            ),
    );
  }
}
