import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
part 'chopper_helper.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class ChopperHelper extends ChopperService {
  @Get()
  Future<Response> getAllPosts();
  @Get(path: '/{id}')
  Future<Response> getPostById(@Path() int id);
  @Post()
  Future<Response> sendPost(@Body() Map<String, dynamic> post);

  @Delete(path: '/{id}')
  Future<Response> deletePost(@Path() int id);

  @Put(path: '/{id}')
  Future<Response> updatePost(
      @Path() int id, @Body() Map<String, dynamic> data);

  static ChopperHelper create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [_$ChopperHelper()],
      converter: JsonConverter(),
      interceptors: [
        //HttpLoggingInterceptor(),
        //HeadersInterceptor({"Content-Type": "application/json"}),
        //CurlInterceptor(),

        // request interceptor anonymous function
        (Request request)async{
        print(request.method);
        return request ;
        },

        // response interceptor anonymous function
        (Response response) async{
        print(response.statusCode);
        return response;
        }
      ],
    );
    return _$ChopperHelper(client);
  }
}
