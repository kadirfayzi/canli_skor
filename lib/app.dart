import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:canli_skor/di.dart';
import 'package:canli_skor/core/network/connectivity_service.dart';
import 'features/favorites/bloc/favorites_bloc.dart';
import 'features/matches/bloc/match_bloc.dart';
import 'features/matches/bloc/match_event.dart';
import 'core/network/network_cubit.dart';

import 'core/constants/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/no_internet_overlay_widget.dart';
import 'features/matches/presentation/screens/home_screen.dart';
import 'features/matches/presentation/screens/match_detail_screen.dart';
import 'features/favorites/presentation/screens/favorites_screen.dart';

class LiveScoreApp extends StatelessWidget {
  const LiveScoreApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<NetworkCubit>()),
          BlocProvider(create: (_) => getIt<MatchBloc>()),
          BlocProvider(create: (_) => getIt<FavoritesBloc>()),
        ],
        child: MaterialApp(
          title: 'Canlı Skor',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (_) => const MainScreen(),
            '/match_detail': (_) => const MatchDetailScreen(),
            '/favorites': (_) => const FavoritesScreen(),
          },
        ),
      );
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isOffline = false;
  late final MatchBloc _matchBloc;

  static const List<Widget> _screens = [HomeScreen(), FavoritesScreen()];

  @override
  void initState() {
    super.initState();
    _matchBloc = context.read<MatchBloc>();

    /// Check initial network status
    final initialNetworkState = context.read<NetworkCubit>().state;
    _isOffline = initialNetworkState.status == NetworkStatus.offline;

    /// Start fetching matches if we're online
    if (!_isOffline) {
      _matchBloc.add(const StartFetchingMatches());
    }
  }

  @override
  void dispose() {
    _matchBloc.add(const StopFetchingMatches());
    super.dispose();
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  void _handleStateChange(BuildContext context, NetworkState state) {
    final wasOffline = _isOffline;
    _isOffline = state.status == NetworkStatus.offline;

    setState(() {});

    if (_isOffline) {
      _matchBloc.add(const StopFetchingMatches());
    } else {
      /// Only restart fetching if we were previously offline
      if (wasOffline) {
        _matchBloc.add(const StartFetchingMatches());
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<NetworkCubit, NetworkState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: _handleStateChange,
          child: Stack(
            children: [
              IndexedStack(index: _selectedIndex, children: _screens),
              if (_isOffline) const NoInternetOverlayWidget(),
            ],
          ),
        ),
        bottomNavigationBar: IgnorePointer(
          ignoring: _isOffline,
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.scoreboard), label: 'Canlı Skor'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoriler'),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.primary,
            onTap: _onItemTapped,
          ),
        ),
      );
}
