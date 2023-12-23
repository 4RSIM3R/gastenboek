// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i8;

import 'application/auth/auth_cubit.dart' as _i23;
import 'application/bloc/pagination_bloc.dart' as _i24;
import 'common/network/network_info.dart' as _i9;
import 'common/permission/permission.dart' as _i10;
import 'common/permission/permission_impl.dart' as _i11;
import 'common/storage/shared_pref_storage.dart' as _i13;
import 'common/storage/storage.dart' as _i16;
import 'common/storage/storage_path.dart' as _i14;
import 'common/utils/image_resize.dart' as _i7;
import 'data/datasources/network/network_source.dart' as _i25;
import 'data/datasources/remote_datasources/auth_remote/auth_remote.dart'
    as _i17;
import 'data/datasources/remote_datasources/auth_remote/auth_remote_impl.dart'
    as _i18;
import 'data/datasources/remote_datasources/post_remote/post_remote.dart'
    as _i20;
import 'data/datasources/remote_datasources/post_remote/post_remote_impl.dart'
    as _i21;
import 'data/datasources/session/session_source.dart' as _i15;
import 'data/repositories/auth_repository.dart' as _i19;
import 'data/repositories/post_repository.dart' as _i22;
import 'presentation/pages/guest/list/cubit/guest_list_cubit.dart' as _i5;
import 'presentation/pages/scan/cubit/scan_cubit.dart' as _i12;
import 'presentation/routes/app_router.dart' as _i3;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final apiService = _$ApiService();
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  gh.lazySingleton<_i4.Dio>(() => apiService.dio());
  gh.factory<_i5.GuestListCubit>(() => _i5.GuestListCubit());
  gh.lazySingleton<_i6.ImagePicker>(() => apiService.imagePicker);
  gh.lazySingleton<_i7.ImageResizeUtils>(() => _i7.ImageResizeUtils());
  gh.lazySingleton<_i8.InternetConnection>(
      () => apiService.internetConnectionChecker());
  gh.lazySingleton<_i9.NetworkInfo>(
      () => _i9.NetworkInfoImpl(gh<_i8.InternetConnection>()));
  gh.lazySingleton<_i10.PermissionInterface>(
      () => const _i11.KendaliPermission());
  gh.factory<_i12.ScanCubit>(() => _i12.ScanCubit());
  gh.lazySingleton<_i13.SharedPrefStorageInterface>(
      () => _i13.SharedPreferenceStorage());
  await gh.factoryAsync<_i14.StoragePathInterface>(
    () => apiService.init(),
    preResolve: true,
  );
  gh.lazySingleton<_i15.SessionSource>(
      () => _i15.SessionSource(storage: gh<_i13.SharedPrefStorageInterface>()));
  gh.lazySingleton<_i16.StorageInterface>(() => _i16.Storage(
        permission: gh<_i10.PermissionInterface>(),
        storagePath: gh<_i14.StoragePathInterface>(),
      ));
  gh.lazySingleton<_i17.AuthRemote>(() => _i18.AuthRemoteImpl(
        gh<_i4.Dio>(),
        gh<_i15.SessionSource>(),
      ));
  gh.lazySingleton<_i19.AuthRepository>(() => _i19.AuthRepository(
        gh<_i9.NetworkInfo>(),
        gh<_i17.AuthRemote>(),
        gh<_i15.SessionSource>(),
      ));
  gh.lazySingleton<_i20.PostRemote>(() => _i21.PostRemoteImpl(
        gh<_i4.Dio>(),
        gh<_i15.SessionSource>(),
      ));
  gh.lazySingleton<_i22.PostRepository>(() => _i22.PostRepository(
        gh<_i9.NetworkInfo>(),
        gh<_i20.PostRemote>(),
      ));
  gh.factory<_i23.AuthCubit>(() => _i23.AuthCubit(gh<_i19.AuthRepository>()));
  gh.factory<_i24.PaginationBloc>(
      () => _i24.PaginationBloc(gh<_i22.PostRepository>()));
  return getIt;
}

class _$ApiService extends _i25.ApiService {}
