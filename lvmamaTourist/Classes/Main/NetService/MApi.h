//
//  ZApi.h
//  iRadio
//
//  Copyright (c) 2013 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpServiceDelegate.h"
#import "HttpServiceResult.h"


@interface ServiceResult : NSObject

@property (nonatomic) BOOL hasError;
@property (strong, nonatomic) id data;
@property (strong, nonatomic) NSString *errorCode;
@property (strong, nonatomic) NSString *message;

@end

@protocol ServiceCallback<NSObject>

@required
- (void)callbackWithResult:(ServiceResult *)result forSid:(NSString *)sid;
- (void)callbackWhenError:(ServiceResult *)result forSid:(NSString *)sid;
@end

@interface MApi : NSObject<HttpServiceCallback>

- (id)initWithSid:(NSString *)sid andCallback:(NSObject<ServiceCallback> *)callback;
- (id)initWithSid:(NSString *)sid andBaseUrl:(NSString *)baseUrl andCallback:(NSObject<ServiceCallback> *)callback;
- (HttpQuery *) newQuery;
- (void)putWithPath: (NSString *)path andQuery: (HttpQuery *)query andHttpHeader:(NSDictionary*)httpHeader;
- (void)getWithPath:(NSString *)path andQuery:(HttpQuery *)query;
- (void)postWithPath:(NSString *)path andQuery:(HttpQuery *)query;
- (void)postWithPath:(NSString *)path andQuery:(HttpQuery *)query andAttachments:(NSDictionary *) attachments;
- (void)postWithPathForFiles: (NSString *)path andQuery: (HttpQuery *)query andFiles:(NSArray *)files;
- (void)postWithPathForFile: (NSString *)path andQuery: (HttpQuery *)query andFile:(NSString *)file andMimeType:(NSString *)mimeType;
- (void)postWithPathForFiles: (NSString *)path andQuery:(HttpQuery *)query andKey:key andFiles:(NSArray *)files andMimeTypes:(NSArray *)mimeTypes;
- (HttpServiceResult *)mapServiceResultData:(id)httpServiceResultData;
- (void)enableSingleRequestMode;

+ (NSString *)getBaseUrl;
+ (void)setBaseUrl:(NSString *)baseUrl;
+ (NSString *)getMediaBaseUrl;
+ (NSString *)getOSSBaseUrl;
+ (NSString *)getOSSImageBaseUrl;
+ (void)sethasShowedNetworkAlert:(BOOL)hasAlert;

- (NSDictionary *)postWithPathSyn:(NSString *)path andQuery:(HttpQuery *)query;
- (void)postWithPath:(NSString *)path andQuery:(HttpQuery *)query completionHandler:(GetResultCompletionHandler)completionHandler;
- (void)postWithPath: (NSString *)path andQuery: (HttpQuery *)query andAttachments:(NSDictionary *)attachments andVideoFile:(NSString *)videoFile andVideoImage:(NSString *)videoImage;
@end
