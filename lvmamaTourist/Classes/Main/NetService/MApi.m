//
//  ZApi.m
//  iRadio
//
//  Copyright (c) 2013 . All rights reserved.
//

#import "MApi.h"
#import "HttpServiceDelegate.h"

//static NSString *CurrentAPIBaseURLString = @"http://www.jadelibrary.com"; // 旧测试
static NSString *CurrentAPIBaseURLString = @"http://123.56.43.69"; // 现测试
//static NSString *CurrentAPIBaseURLString = @"http://182.92.27.167"; // 正式旧
//static NSString *CurrentAPIBaseURLString = @"http://182.92.235.172"; // 正式


static NSString *OSSBaseURLString = @"";
static NSString *MediaBaseURLString = @"http://jadebox.oss-cn-beijing.aliyuncs.com";

@interface MApi()

@property (strong, nonatomic) NSObject<ServiceCallback> *callback;
@property (strong, nonatomic) NSString *sid;
@property (strong, nonatomic) HttpServiceDelegate *httpDelegate;

@end

@implementation MApi

- (id)init
{
    self = [super init];
    if (self) {
        self.httpDelegate = [[HttpServiceDelegate alloc]initWithUrlString:[MApi getBaseUrl]];
    }
    return self;
}

- (id)initWithSid:(NSString *)sid andCallback:(NSObject<ServiceCallback> *)callback;
{
    self = [super init];
    if (self) {
        self.sid = sid;
        self.callback = callback;
        self.httpDelegate = [[HttpServiceDelegate alloc]initWithUrlString:[MApi getBaseUrl]];
    }
    return self;
}

- (id)initWithSid:(NSString *)sid andBaseUrl:(NSString *)baseUrl andCallback:(NSObject<ServiceCallback> *)callback
{
    self = [super init];
    if (self) {
        self.sid = sid;
        self.callback = callback;
        self.httpDelegate = [[HttpServiceDelegate alloc]initWithUrlString:baseUrl];
    }
    return self;
}

- (HttpQuery *)newQuery
{
    HttpQuery *query = [[HttpQuery alloc] init];
    return query;
}

- (void)getWithPath: (NSString *)path andQuery: (HttpQuery *)query
{
    [_httpDelegate getWithPath:path andQuery:query andCallback:self forSid:_sid];
}

- (void)postWithPath: (NSString *)path andQuery: (HttpQuery *)query
{
    [_httpDelegate postWithPath:path andQuery:query andCallback:self forSid:_sid];
}

- (void)putWithPath: (NSString *)path andQuery: (HttpQuery *)query andHttpHeader:(NSDictionary*)httpHeader
{
    [_httpDelegate putWithPath:path andQuery:query andCallback:self forSid:_sid forHttpHeader:httpHeader];
}

- (void)postWithPath: (NSString *)path andQuery: (HttpQuery *)query andAttachments:(NSDictionary *)attachments
{
    [_httpDelegate postWithPath:path andQuery:query andAttachments:attachments andCallback:self forSid:_sid];
}

- (void)postWithPath: (NSString *)path andQuery: (HttpQuery *)query andAttachments:(NSDictionary *)attachments andVideoFile:(NSString *)videoFile andVideoImage:(NSString *)videoImage
{
    [_httpDelegate postWithPath:path andQuery:query andAttachments:attachments andVideoFile:videoFile andVideoImage:videoImage andCallback:self forSid:_sid];
}

- (void)postWithPathForFiles: (NSString *)path andQuery: (HttpQuery *)query andFiles:(NSArray *)files
{
    [_httpDelegate postWithPathForFiles:path andQuery:query andFiles:files andCallback:self forSid:_sid];
}

- (void)postWithPathForFile: (NSString *)path andQuery: (HttpQuery *)query andFile:(NSString *)file andMimeType:(NSString *)mimeType
{
    [_httpDelegate postWithPathForFile:path andQuery:query andFile:file andMimeType:mimeType andCallback:self forSid:_sid];
}

- (void)postWithPathForFiles: (NSString *)path andQuery:(HttpQuery *)query andKey:key andFiles:(NSArray *)files andMimeTypes:(NSArray *)mimeTypes {
    [_httpDelegate postWithPathForFiles:path andQuery:query andKey:key andFiles:files andMimeTypes:mimeTypes andCallback:self forSid:_sid];
}

- (NSDictionary *)postWithPathSyn:(NSString *)path andQuery:(HttpQuery *)query
{
    return [_httpDelegate postWithPathSyn:path andQuery:query];
}

- (void)postWithPath:(NSString *)path andQuery:(HttpQuery *)query completionHandler:(GetResultCompletionHandler)completionHandler
{
    return [_httpDelegate postWithPath:path andQuery:query completionHandler:completionHandler];
}

static BOOL hasShowedNetworkAlert = NO;
+ (void)sethasShowedNetworkAlert:(BOOL)hasAlert
{
    hasShowedNetworkAlert = hasAlert;
}
- (void)responded:(HttpServiceResult *)result ofSid:(NSString *)sid
{
    ServiceResult *serviceResult = [[ServiceResult alloc]init];
    serviceResult.hasError = YES;
    if (0 == result.resultCode) {
        @try {
            serviceResult.data = [self mapServiceResultData:result.data];
            serviceResult.hasError = NO;
        } @catch (NSException *exception) {
            serviceResult.message = @"Reading data fail!";
        }
        
        [_callback callbackWithResult:serviceResult forSid:sid];
    }
    else
    {
        if ([_callback respondsToSelector:@selector(callbackWhenError:forSid:)]) {
            [_callback callbackWhenError:serviceResult forSid:sid];
        }
        
    }
}



- (HttpServiceResult *)mapServiceResultData: (id)httpServiceResultData;
{
    LMMLog(@"Default ServiceResult.");
    return httpServiceResultData;
}

- (void)enableSingleRequestMode
{
    [_httpDelegate setMaxConcurrentOperationsCount:1];
}


+ (NSString *)getBaseUrl
{
    return CurrentAPIBaseURLString;
}

+ (void)setBaseUrl:(NSString *)baseUrl
{
    CurrentAPIBaseURLString = baseUrl;
}

+ (NSString *)getOSSBaseUrl
{
    return OSSBaseURLString;
}

+ (NSString *)getMediaBaseUrl
{
    return MediaBaseURLString;
}

+ (NSString *)getOSSImageBaseUrl
{
    return @"http://img.jadelibrary.com/";
}

@end

@implementation ServiceResult

@synthesize hasError = _hasError;
@synthesize errorCode, message, data;

@end
