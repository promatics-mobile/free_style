import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:free_style/utils/common_widgets/app_bars/common_app_bar.dart';

import '../../routes/route.dart';
import '../../utils/common_constants.dart';
import '../../utils/common_widgets.dart';
import '../../utils/common_widgets/common_text/common_text.dart';
import 'cms_cubit.dart';
import 'cms_state.dart';

class CmsScreen extends StatelessWidget {
  final String type;

  CmsScreen({super.key, required this.type});

  late CmsCubit cubitData;
  late CmsState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: type,
      ),
      body: BlocProvider(
        create: (context) => CmsCubit(type),
        child: BlocBuilder<CmsCubit, CmsState>(
          builder: (context, state) {
            cubitData = context.read<CmsCubit>();
            return SingleChildScrollView(
              padding: EdgeInsets.all(size(context).width * numD04),
              child: Html(
                data: cubitData.cmsData,
                style: {
                  "body": Style(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
