import 'package:flutter/material.dart';
import 'package:simsar/Theme/text_theme.dart';

import '../../models_temp/property_model.dart';

class AgentSection extends StatelessWidget {
  final Agent agent;

  const AgentSection({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(agent.avatarUrl),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(agent.name, style: STextTheme.lightTextTheme.bodyMedium),
              Text(agent.role, style: STextTheme.lightTextTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
