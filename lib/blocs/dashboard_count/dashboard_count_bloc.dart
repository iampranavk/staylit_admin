import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'dashboard_count_event.dart';
part 'dashboard_count_state.dart';

class DashboardCountBloc
    extends Bloc<DashboardCountEvent, DashboardCountState> {
  DashboardCountBloc() : super(DashboardCountInitialState()) {
    on<DashboardCountEvent>((event, emit) async {
      emit(DashboardCountLoadingState());

      final SupabaseClient supabaseClient = Supabase.instance.client;

      PostgrestResponse requestCount = await supabaseClient
          .from('service_requests')
          .select('*', const FetchOptions(count: CountOption.exact));

      PostgrestResponse staffCount = (await supabaseClient
          .from('staffs')
          .select('*', const FetchOptions(count: CountOption.exact)));

      PostgrestResponse tenantsCount = await supabaseClient
          .from('profiles')
          .select('*', const FetchOptions(count: CountOption.exact));

      PostgrestResponse servicessCount = await supabaseClient
          .from('services')
          .select('*', const FetchOptions(count: CountOption.exact));

      try {
        Map<String, dynamic> dashbordCount = {
          'requests': requestCount.count.toString(),
          'staffs': staffCount.count.toString(),
          'tenants': tenantsCount.count.toString(),
          'services': servicessCount.count.toString(),
        };

        Logger().w(dashbordCount);

        emit(DashboardCountSuccessState(dashbordCount: dashbordCount));
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(DashboardCountFailureState());
      }
    });
  }
}
