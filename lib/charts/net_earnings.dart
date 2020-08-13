import 'package:bossi_pos/charts/net_model.dart';
/// Example of a bar chart with domain selection A11y behavior.
///
/// The OS screen reader (TalkBack / VoiceOver) setting must be turned on, or
/// the behavior does not do anything.
///
/// Note that the screenshot does not show any visual differences but when the
/// OS screen reader is enabled, the node that is being read out loud will be
/// surrounded by a rectangle.
///
/// When [DomainA11yExploreBehavior] is added to the chart, the chart will
/// listen for the gesture that triggers "explore mode".
/// "Explore mode" creates semantic nodes for each domain value in the chart
/// with a description (customizable, defaults to domain value) and a bounding
/// box that surrounds the domain.
///
/// These semantic node descriptions are read out loud by the OS screen reader
/// when the user taps within the bounding box, or when the user cycles through
/// the screen's elements (such as swiping left and right).
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class NetEarnings extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  NetEarnings(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory NetEarnings.withSampleData() {
    return new NetEarnings(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  /// An example of how to generate a customized vocalization for
  /// [DomainA11yExploreBehavior] from a list of [SeriesDatum]s.
  ///
  /// The list of series datums is for one domain.
  ///
  /// This example vocalizes the domain, then for each series that has that
  /// domain, it vocalizes the series display name and the measure and a
  /// description of that measure.
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
    return new Semantics(
        // Describe your chart
        label: 'Yearly sales bar chart',
        // Optionally provide a hint for the user to know how to trigger
        // explore mode.
        hint: 'Press and hold to enable explore',
        child: new charts.BarChart(
          seriesList,
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
        ));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<NetModel, String>> _createSampleData() {
    final mobileData = [
      new NetModel(year: 'Jan 2020', sales: "25"),
      new NetModel(year: 'Feb 2020', sales: "100"),
      new NetModel(year: 'Mar 2020', sales: "75"),
      new NetModel(year: 'Apr 2020', sales: "10"),
      new NetModel(year: 'May 2020', sales: "50"),
    ];

    final tabletData = [
      // Purposely missing data to show that only measures that are available
      // are vocalized.
      new NetModel(year: 'Jan 2020', sales: "75"),
      new NetModel(year: 'Feb 2020', sales: "10"),
      new NetModel(year: 'Mar 2020', sales: "50"),
      new NetModel(year: 'Apr 2020', sales: "100"),
      new NetModel(year: 'May 2020', sales: "90"),
    ];

    return [
      new charts.Series<NetModel, String>(
        id: 'Tablet Sales',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (NetModel sales, _) => sales.year,
        measureFn: (NetModel sales, _) => double.parse(sales.sales),
        data: tabletData,
      ),
      new charts.Series<NetModel, String>(
        id: 'Mobile Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (NetModel sales, _) => sales.year,
        measureFn: (NetModel sales, _) => double.parse(sales.sales),
        data: mobileData,
      )
    ];
  }
}