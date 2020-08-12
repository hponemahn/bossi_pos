import 'package:bossi_pos/charts/net_model.dart';
import 'package:bossi_pos/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class NetEarn extends StatelessWidget {

  String vocalizeDomainAndMeasures(List<charts.SeriesDatum> seriesDatums) {
    final buffer = new StringBuffer();

    // The datum's type in this case is [NetModel].
    // So we can access year and sales information here.
    buffer.write(seriesDatums.first.datum.year);

    for (charts.SeriesDatum seriesDatum in seriesDatums) {
      final series = seriesDatum.series;
      final datum = seriesDatum.datum;

      buffer.write(' ${series.displayName} '
          '${datum.sales / 1000} thousand dollars');
    }

    return buffer.toString();
  }
  
  @override
  Widget build(BuildContext context) {
    final List<NetModel> _netData = Provider.of<Cart>(context, listen: false).getNetData;

    print("daily summ build");

    List<charts.Series<NetModel, String>> series = [

      new charts.Series<NetModel, String>(
        id: 'Tablet Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (NetModel sales, _) => sales.year,
        measureFn: (NetModel sales, _) => double.parse(sales.sales),
        data: _netData,
      ),
      new charts.Series<NetModel, String>(
        id: 'Mobile Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (NetModel sales, _) => sales.year,
        measureFn: (NetModel sales, _) => double.parse(sales.sales),
        data: _netData,
      )
    ];

    return charts.BarChart(
          series,
          animate: false,
          animationDuration: Duration(seconds: 5),
          // To prevent conflict with the select nearest behavior that uses the
          // tap gesture, turn off default interactions when the user is using
          // an accessibility service like TalkBack or VoiceOver to interact
          // with the application.
          defaultInteractions: !MediaQuery.of(context).accessibleNavigation,
          behaviors: [
            new charts.DomainA11yExploreBehavior(
              vocalizationCallback: vocalizeDomainAndMeasures,
              exploreModeTrigger: charts.ExploreModeTrigger.pressHold,
              exploreModeEnabledAnnouncement: 'Explore mode enabled',
              exploreModeDisabledAnnouncement: 'Explore mode disabled',
              minimumWidth: 1.0,
            ),
            new charts.DomainHighlighter(charts.SelectionModelType.info),
          ],
        );
  }
}
