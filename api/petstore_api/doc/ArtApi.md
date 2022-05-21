# petstore_api.api.ArtApi

## Load the API package

```dart
import 'package:petstore_api/api.dart';
```

All URIs are relative to *http://188.121.110.151:8000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**artArtPieceContentUpdate**](ArtApi.md#artartpiececontentupdate) | **
PUT** /art/art-piece/{id}/content/ |
[**artArtPieceCoverCreate**](ArtApi.md#artartpiececovercreate) | **POST** /art/art-piece/cover/ |
[**artArtPieceLikeUpdate**](ArtApi.md#artartpiecelikeupdate) | **PUT** /art/art-piece/{id}/like/ |
[**artArtPieceRead**](ArtApi.md#artartpieceread) | **GET** /art/art-piece/{id}/ |
[**artArtPieceUpdate**](ArtApi.md#artartpieceupdate) | **PUT** /art/art-piece/{id}/ |

# **artArtPieceContentUpdate**

> InlineResponse2001 artArtPieceContentUpdate(id, file)

### Example

```dart
import 'package:petstore_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = ArtApi();
final id = id_example; // String | 
final file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.artArtPieceContentUpdate(id, file);
    print(result);
} catch (e) {
    print('Exception when calling ArtApi->artArtPieceContentUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**id** | **String**|  |
**file** | **MultipartFile**|  |

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: multipart/form-data
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **artArtPieceCoverCreate**

> InlineResponse200 artArtPieceCoverCreate(data)

### Example

```dart
import 'package:petstore_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = ArtApi();
final data = ArtPieceCover(); // ArtPieceCover | 

try {
    final result = api_instance.artArtPieceCoverCreate(data);
    print(result);
} catch (e) {
    print('Exception when calling ArtApi->artArtPieceCoverCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**data** | [**ArtPieceCover**](ArtPieceCover.md)|  |

### Return type

[**InlineResponse200**](InlineResponse200.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **artArtPieceLikeUpdate**

> InlineResponse2002 artArtPieceLikeUpdate(id)

### Example

```dart
import 'package:petstore_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = ArtApi();
final id = id_example; // String | 

try {
    final result = api_instance.artArtPieceLikeUpdate(id);
    print(result);
} catch (e) {
    print('Exception when calling ArtApi->artArtPieceLikeUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**id** | **String**|  |

### Return type

[**InlineResponse2002**](InlineResponse2002.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **artArtPieceRead**

> ArtPiece artArtPieceRead(id)

### Example

```dart
import 'package:petstore_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = ArtApi();
final id = id_example; // String | 

try {
    final result = api_instance.artArtPieceRead(id);
    print(result);
} catch (e) {
    print('Exception when calling ArtApi->artArtPieceRead: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**id** | **String**|  |

### Return type

[**ArtPiece**](ArtPiece.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **artArtPieceUpdate**

> InlineResponse2001 artArtPieceUpdate(id, data)

### Example

```dart
import 'package:petstore_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = ArtApi();
final id = id_example; // String | 
final data = ArtPieceDetail(); // ArtPieceDetail | 

try {
    final result = api_instance.artArtPieceUpdate(id, data);
    print(result);
} catch (e) {
    print('Exception when calling ArtApi->artArtPieceUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
**id** | **String**|  |
**data** | [**ArtPieceDetail**](ArtPieceDetail.md)|  |

### Return type

[**InlineResponse2001**](InlineResponse2001.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

