import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:canli_skor/features/matches/bloc/match_state.dart';

import 'package:canli_skor/core/constants/app_colors.dart';
import '../../bloc/match_bloc.dart';
import '../widgets/empty_state.dart';
import '../widgets/match_card.dart';
import '../widgets/filter_dropdown.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleStateChange(BuildContext context, MatchState state) {
    if (state is MatchError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(
        content: Text(state.message),
        backgroundColor: AppColors.error,
      ));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Canlı Skor'), centerTitle: true),
        body: Column(
          children: [
            const FilterDropdown(),
            Expanded(
              child: BlocConsumer<MatchBloc, MatchState>(
                listenWhen: (prev, curr) => curr is MatchError,
                listener: _handleStateChange,
                buildWhen: (prev, curr) => curr is MatchLoading || curr is MatchLoaded || curr is MatchError,
                builder: (context, state) => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: switch (state) {
                    MatchLoading() => const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16,
                          children: [
                            CircularProgressIndicator.adaptive(),
                            Text('Maçlar yükleniyor...'),
                          ],
                        ),
                      ),
                    MatchLoaded(:final matches) => matches.isEmpty
                        ? const EmptyState(message: 'Şu anda hiçbir maç bulunmuyor!')
                        : Scrollbar(
                            controller: _scrollController,
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.all(8),
                              itemCount: matches.length,
                              itemBuilder: (context, index) => MatchCard(match: matches[index]),
                            ),
                          ),
                    MatchError(:final message) => EmptyState(message: message),
                    _ => const EmptyState(message: 'Maçlar yüklenemedi!'),
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
