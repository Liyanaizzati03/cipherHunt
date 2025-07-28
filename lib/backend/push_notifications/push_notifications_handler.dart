import 'dart:async';

import 'serialization_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: FlutterFlowTheme.of(context).tertiary,
          child: Image.asset(
            'assets/images/ChatGPT_Image_May_11,_2025,_08_39_30_AM.png',
            fit: BoxFit.contain,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'MainMenu': ParameterData.none(),
  'cclevel1': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<int>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'caesercipherlevel': ParameterData.none(),
  'CategoriesPages': ParameterData.none(),
  'info': ParameterData.none(),
  'AtbashCipherLevel': ParameterData.none(),
  'VIGENEREcipherlevel': ParameterData.none(),
  'ConfettiWinnerPagecc1': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'atbashlevel1': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<int>(data, 'currentLevel'),
        },
      ),
  'cclevel2': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageab1': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'cclevel3': ParameterData.none(),
  'cclevel4': ParameterData.none(),
  'cclevel5': ParameterData.none(),
  'atbashlevel2': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<int>(data, 'currentLevel'),
        },
      ),
  'atbashlevel3': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<int>(data, 'currentLevel'),
        },
      ),
  'atbashlevel4': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<int>(data, 'currentLevel'),
        },
      ),
  'atbashlevel5': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<int>(data, 'currentLevel'),
        },
      ),
  'vigenerelevel1': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<int>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'vigenerelevel2': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<String>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'vigenerelevel3': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<String>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'vigenerelevel4': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<String>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'vigenerelevel5': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<String>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'SETTINGS': ParameterData.none(),
  'ConfettiWinnerPageV1': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<int>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageCC5': ParameterData.none(),
  'ConfettiWinnerPageCC4': ParameterData.none(),
  'ConfettiWinnerPageCC3': ParameterData.none(),
  'ConfettiWinnerPageaCC2': ParameterData.none(),
  'ConfettiWinnerPageab5': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageab4': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageab3': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageab2': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageV3': ParameterData.none(),
  'ConfettiWinnerPageV5': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageV4': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageV2': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'morsecode4': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<String>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'morsecode5': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<String>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'morsecode3': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<String>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'morsecode2': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<int>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'morsecode1': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
          'currentLevel': getParameter<int>(data, 'currentLevel'),
          'currentQuestion': getParameter<bool>(data, 'currentQuestion'),
        },
      ),
  'ConfettiWinnerPageMC1': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageMC2': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageMC3': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageMC4': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'ConfettiWinnerPageMC5': (data) async => ParameterData(
        allParams: {
          'correctOption': getParameter<String>(data, 'correctOption'),
        },
      ),
  'msCipherlevel': ParameterData.none(),
  'CreateAccount3': ParameterData.none(),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
