// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i7;

import 'application/auth/auth_cubit.dart' as _i22;
import 'application/bloc/pagination_bloc.dart' as _i23;
import 'common/network/network_info.dart' as _i8;
import 'common/permission/permission.dart' as _i9;
import 'common/permission/permission_impl.dart' as _i10;
import 'common/storage/shared_pref_storage.dart' as _i12;
import 'common/storage/storage.dart' as _i15;
import 'common/storage/storage_path.dart' as _i13;
import 'common/utils/image_resize.dart' as _i6;
import 'data/datasources/network/network_source.dart' as _i24;
import 'data/datasources/remote_datasources/auth_remote/auth_remote.dart'
    as _i16;
import 'data/datasources/remote_datasources/auth_remote/auth_remote_impl.dart'
    as _i17;
import 'data/datasources/remote_datasources/post_remote/post_remote.dart'
    as _i19;
import 'data/datasources/remote_datasources/post_remote/post_remote_impl.dart'
    as _i20;
import 'data/datasources/session/session_source.dart' as _i14;
import 'data/repositories/auth_repository.dart' as _i18;
import 'data/repositories/post_repository.dart' as _i21;
import 'presentation/pages/scan/cubit/scan_cubit.dart' as _i11;
import 'presentation/routes/app_router.dart' as _i3;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
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
  gh.lazySingleton<_i5.ImagePicker>(() => apiService.imagePicker);
  gh.lazySingleton<_i6.ImageResizeUtils>(() => _i6.ImageResizeUtils());
  gh.lazySingleton<_i7.InternetConnection>(
      () => apiService.internetConnectionChecker());
  gh.lazySingleton<_i8.NetworkInfo>(
      () => _i8.NetworkInfoImpl(gh<_i7.InternetConnection>()));
  gh.lazySingleton<_i9.PermissionInterface>(() => _i10.KendaliPermission());
  gh.factory<_i11.ScanCubit>(() => _i11.ScanCubit());
  gh.lazySingleton<_i12.SharedPrefStorageInterface>(
      () => _i12.SharedPreferenceStorage());
  await gh.factoryAsync<_i13.StoragePathInterface>(
    () => apiService.init(),
    preResolve: true,
  );
  gh.lazySingleton<_i14.SessionSource>(
      () => _i14.SessionSource(storage: gh<_i12.SharedPrefStorageInterface>()));
  gh.lazySingleton<_i15.StorageInterface>(() => _i15.Storage(
        permission: gh<_i9.PermissionInterface>(),
        storagePath: gh<_i13.StoragePathInterface>(),
      ));
  gh.lazySingleton<_i16.AuthRemote>(() => _i17.AuthRemoteImpl(
        gh<_i4.Dio>(),
        gh<_i14.SessionSource>(),
      ));
  gh.lazySingleton<_i18.AuthRepository>(() => _i18.AuthRepository(
        gh<_i8.NetworkInfo>(),
        gh<_i16.AuthRemote>(),
        gh<_i14.SessionSource>(),
      ));
  gh.lazySingleton<_i19.PostRemote>(() => _i20.PostRemoteImpl(
        gh<_i4.Dio>(),
        gh<_i14.SessionSource>(),
      ));
  gh.lazySingleton<_i21.PostRepository>(() => _i21.PostRepository(
        gh<_i8.NetworkInfo>(),
        gh<_i19.PostRemote>(),
      ));
  gh.factory<_i22.AuthCubit>(() => _i22.AuthCubit(gh<_i18.AuthRepository>()));
  gh.factory<_i23.PaginationBloc>(
      () => _i23.PaginationBloc(gh<_i21.PostRepository>()));
  return getIt;
}

class _$ApiService extends _i24.ApiService {}
