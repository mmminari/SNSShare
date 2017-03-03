//
//  HTTPClient.m
//  NavigationController
//
//  Created by 김민아 on 2016. 6. 14..
//  Copyright © 2016년 김민아. All rights reserved.
//

#import "HTTPClient.h"

@interface HTTPClient ()

@property(strong, nonatomic) NSMutableArray *requests;

@end

@implementation HTTPClient

-(instancetype)initWithBaseURL
{
    if(self = [super initWithBaseURL:[NSURL URLWithString:@"https://apidev.fanbook.me"]])
    {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requests = [NSMutableArray array];
    }
    
    return self;
    
}

-(void)GETWithUrlString:(NSString *)urlString parameters:(id)parameters
                success:(void (^)(id results))success
                failure:(void (^)(NSError *error))failure
{
    [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if(failure)
        {
            failure(error);
        }
    }];
}

- (void)SearchWithUrlString:(NSString *)urlString
                                   parameters:(id)parameters success:(void (^)(id results))success
                                      failure:(void (^)(NSError *error))failure
{
    
    // 현재 진행되고 있는 dataTask들을 가지고와 다른 request가 끝나기 전
    // 다른 request가 들어왔을 때 전에 실행중이던 task들을  cancel시켜주어
    // 사용자가 빠른 속도로 타이핑시에는 request가 실행되지 않게 함.
    NSArray *dataTasks = self.dataTasks;
    
    for (NSURLSessionDataTask *task in dataTasks) {
        [task cancel];
    }
    
    // AFHTTPSessionManager의 POST API는 NSURLSessionDataTask를 리턴한다.
    // 이 AFHTTPSessionManager로 현재 진행되고 있는 task를 cancel할 수 있다.
    [self POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(success)
            success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if(failure)
            failure(error);
    }];
}

-(void)POSTWithUrlString:(NSString *)urlString parameters:(id)parameters
                 success:(void (^)(id results))success
                 failure:(void (^)(NSError *error))failure
{
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if(failure)
        {
            failure(error);
           // LogRed(@"error : %@", error);
        }
    }];
}

-(void)UPLOADWithUrlString:(NSString *)URLString
                      data:(NSData *)data
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure
{

//    self.responseSerializer = [AFJSONResponseSerializer serializer];
//    
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    
    [self POST:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        [formData appendPartWithFileData:data name:@"image" fileName:@"image.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success)
            success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
            failure(error);
    }];
    
    
    
//    [self.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
//    
//    
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"https://apidev.fanbook.me/aws/image" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//                                    {
//                                              [formData appendPartWithFileData:data name:@"image" fileName:@"image.png" mimeType:@"image/png"];
//
//                                        
//                                    } error:nil];
//    
//    NSURLSessionUploadTask *uploadTask = [self uploadTaskWithStreamedRequest:request
//                                                                    progress:^(NSProgress * _Nonnull uploadProgress) {
//                      
//                                                                    }
//                                                              completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                      if (error)
//                      {
//                          NSLog(@"error :%@", error.description);
//                          
//                      }
//                      else
//                      {
//                          NSLog(@"success :%@", responseObject);
//                      }
//                  }];
//    
//    [uploadTask resume];
}

-(void)PUTWithUrlString:(NSString *)urlString parameters:(id)parameters
                success:(void (^)(id results))success
                failure:(void (^)(NSError *error))failure
{
    
    [self PUT:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
        {
            failure(error);
        }
    }];
    
}

-(void)PATCHWithUrlString:(NSString *)urlString parameters:(id)parameters
                  success:(void (^)(id results))success
                  failure:(void (^)(NSError *error))failure
{
    
    [self PATCH:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success)
        {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
        {
            failure(error);
        }
    }];
    
}


@end
