import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_service.dart';

enum RealtimeEventType { insert, update, delete }

/// A row change pushed by Supabase Realtime.
class RealtimeRowChange {
  const RealtimeRowChange({
    required this.type,
    required this.table,
    required this.newRow,
    required this.oldRow,
  });

  final RealtimeEventType type;
  final String table;
  final Map<String, dynamic> newRow;
  final Map<String, dynamic> oldRow;
}

/// Thin wrapper over Supabase Realtime `postgres_changes`.
///
/// Repositories expose the stream so the presentation layer never talks
/// to the Realtime API directly.
abstract final class RealtimeService {
  static int _channelSeq = 0;

  /// Streams row changes of [table] limited to rows owned by [userId].
  /// Emits nothing when the backend is not configured.
  static Stream<RealtimeRowChange> watchTable({
    required String table,
    required String userColumn,
    required String userId,
  }) {
    final client = SupabaseService.clientOrNull;
    if (client == null) return const Stream<RealtimeRowChange>.empty();

    final channelName = 'nf_${table}_${_channelSeq++}';
    final channel = client.channel(channelName);
    late final StreamController<RealtimeRowChange> controller;

    channel.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: table,
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: userColumn,
        value: userId,
      ),
      callback: (payload) {
        controller.add(
          RealtimeRowChange(
            type: switch (payload.eventType) {
              PostgresChangeEvent.insert => RealtimeEventType.insert,
              PostgresChangeEvent.update => RealtimeEventType.update,
              PostgresChangeEvent.delete => RealtimeEventType.delete,
              _ => RealtimeEventType.update,
            },
            table: payload.table,
            newRow: payload.newRecord,
            oldRow: payload.oldRecord,
          ),
        );
      },
    );

    controller = StreamController<RealtimeRowChange>(
      onListen: () {
        channel.subscribe();
      },
      onCancel: () async {
        await client.removeChannel(channel);
        await controller.close();
      },
    );
    return controller.stream;
  }
}
