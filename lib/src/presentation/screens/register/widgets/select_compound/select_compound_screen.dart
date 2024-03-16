import 'package:city_eye/generated/l10n.dart';
import 'package:city_eye/src/config/theme/color_schemes.dart';
import 'package:city_eye/src/core/resources/image_paths.dart';
import 'package:city_eye/src/core/utils/show_massage_dialog_widget.dart';
import 'package:city_eye/src/domain/entities/register/compound.dart';
import 'package:city_eye/src/domain/entities/register/city_compound.dart';
import 'package:city_eye/src/presentation/blocs/compound/compound_bloc.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/select_compound/countries_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/select_compound/compounds_widget.dart';
import 'package:city_eye/src/presentation/screens/register/widgets/select_compound/select_compound_skeleton_screen.dart';
import 'package:city_eye/src/presentation/widgets/build_app_bar_widget.dart';
import 'package:city_eye/src/presentation/widgets/search_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCompoundScreen extends StatefulWidget {
  final Compound selectedCompound;

  const SelectCompoundScreen({
    Key? key,
    required this.selectedCompound,
  }) : super(key: key);

  @override
  State<SelectCompoundScreen> createState() => _SelectCompoundScreenState();
}

class _SelectCompoundScreenState extends State<SelectCompoundScreen> {
  CompoundBloc get _bloc => BlocProvider.of<CompoundBloc>(context);
  final TextEditingController _compoundSearchController =
      TextEditingController();
  List<CityCompound> _regions = [];
  List<CityCompound> _regionsFilter = [];
  CityCompound _selectedRegion = CityCompound(
    id: -1,
    name: S.current.all,
    parentId: -1,
    compounds: [],
  );
  late Compound _selectedCompound;

  @override
  void initState() {
    _selectedCompound = widget.selectedCompound;
    _bloc.add(GetCityCompoundEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompoundBloc, CompoundState>(
        listener: (context, state) {
      if (state is GetCityCompoundsSuccessState) {
        _regions = state.regions;
        _regionsFilter = state.regions;
        _bloc.add(SelectRegionEvent(
          region: _selectedRegion,
        ));
      } else if (state is GetCityCompoundsErrorState) {
        _showMessageDialog(
          message: state.errorMessage,
          icon: ImagePaths.error,
        );
      } else if (state is SelectRegionState) {
        _selectedRegion = state.region;
        _regions = state.regions;
        _regionsFilter = state.regionsFilter;
        _bloc.add(CompoundSearchEvent(
          value: _compoundSearchController.text,
          selectedRegion: _selectedRegion,
        ));
      } else if (state is SelectCompoundState) {
        _selectedCompound = state.compound;
        Navigator.pop(
          context,
          state.compound,
        );
      } else if (state is CompoundSearchState) {
        _regions = state.regions;
      } else if (state is CloseRegionState) {
        _selectedRegion = state.region;
        _regions = state.regions;
        _regionsFilter = state.regionsFilter;
        _bloc.add(CompoundSearchEvent(
          value: _compoundSearchController.text,
          selectedRegion: _selectedRegion,
        ));
      }
    }, builder: (context, state) {
      if (state is ShowSkeletonState) {
        return const SelectCompoundSkeletonScreen();
      }
      return Scaffold(
          appBar: buildAppBarWidget(
            context,
            title: S.of(context).selectCompound,
            isHaveBackButton: true,
            onBackButtonPressed: () {
              Navigator.pop(
                context,
                _selectedCompound,
              );
            },
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchTextFieldWidget(
                  controller: _compoundSearchController,
                  onChange: (value) {
                    _bloc.add(CompoundSearchEvent(
                      value: value,
                      selectedRegion: _selectedRegion,
                    ));
                  },
                  searchText: S.of(context).searchCompound,
                  onClear: () {
                    _bloc.add(CompoundSearchEvent(
                      value: '',
                      selectedRegion: _selectedRegion,
                    ));
                  },
                ),
              ),
              CountriesWidget(
                regions: _regionsFilter,
                selectedRegion: _selectedRegion,
                onSelectRegion: (CityCompound region) {
                  _bloc.add(SelectRegionEvent(
                    region: region,
                  ));
                },
                onCloseRegion: (CityCompound region) {
                  _bloc.add(CloseRegionEvent(
                    region: region,
                  ));
                },
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                color: ColorSchemes.lightGray,
                height: 1.7,
              ),
              CompoundsWidget(
                regions: _regions,
                selectedRegion: _selectedRegion,
                selectedCompound: _selectedCompound,
                onSelectCompound: (Compound compound) {
                  _bloc.add(SelectCompoundEvent(
                    compound: compound,
                  ));
                },
              )
            ],
          ));
    });
  }

  void _showMessageDialog({
    required String message,
    required String icon,
  }) {
    showMassageDialogWidget(
      context: context,
      text: message,
      icon: icon,
      buttonText: S.of(context).ok,
      onTap: () => Navigator.pop(context),
    );
  }
}
