//
//  HttpServiceDelegate.m
//  
//
//  Copyright (c) 2013 . All rights reserved.
//

#import "HttpServiceDelegate.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLResponseSerialization.h"
#import "MXMLReader.h"
#import "MApi.h"

@interface HttpServiceDelegate ()

@end

@implementation HttpServiceDelegate

AFHTTPRequestOperationManager *httpClient;

- (id)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        self.urlString = urlString;
        NSURL *url = [NSURL URLWithString: self.urlString];
        httpClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        // FOR XML
//        [httpClient setResponseSerializer:[AFXMLParserResponseSerializer new]];
        // FOR JSON
        [httpClient setResponseSerializer:[AFJSONResponseSerializer new]];
        httpClient.operationQueue.maxConcurrentOperationCount = 3;
//        
//        httpClient.requestSerializer = [AFHTTPRequestSerializer serializer];
//        httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelAllOperations:) name:@"NSNotification_CancelAllOperations" object:nil];
    }
    return self;
}

- (void)setMaxConcurrentOperationsCount:(int)count
{
    httpClient.operationQueue.maxConcurrentOperationCount = count;
}

- (void)cancelAllOperations:(NSNotification *)notification
{
    [httpClient.operationQueue cancelAllOperations];
}

- (void)getWithPath:(NSString *)path andQuery:(HttpQuery *)query andCallback:(NSObject<HttpServiceCallback> *)callback forSid:(NSString *)sid
{
    [httpClient GET:path parameters:query.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:sid callback:callback operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failure:error operation:operation sid:sid callback:callback];
    }];
}

- (void)postWithPath:(NSString *)path andQuery:(HttpQuery *)query andAttachments:(NSDictionary *)attachments andCallback:(NSObject<HttpServiceCallback>*) callback forSid:(NSString *) sid
{
    [httpClient POST:path parameters:query.parameters constructingBodyWithBlock:^(id formData) {
        if (attachments) {
            NSEnumerator *enumerator = [attachments keyEnumerator];
            id key = [enumerator nextObject];
            NSArray *attachmentObjs = attachments[key];
            for (int i = 0; i < attachmentObjs.count; i++) {
                 NSData *fileData = attachmentObjs[i];
                [formData appendPartWithFileData:fileData name:key fileName:[NSString stringWithFormat:@"file%d.jpg", i] mimeType:@"image/jpeg"];
            }
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:sid callback:callback operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failure:error operation:operation sid:sid callback:callback];
    }];
}

- (void)postWithPath:(NSString *)path andQuery:(HttpQuery *)query andAttachments:(NSDictionary *)attachments andVideoFile:(NSString *)videoFile andVideoImage:(NSString *)videoImage andCallback:(NSObject<HttpServiceCallback>*) callback forSid:(NSString *) sid
{
    [httpClient POST:path parameters:query.parameters constructingBodyWithBlock:^(id formData) {
        if (attachments) {
            NSEnumerator *enumerator = [attachments keyEnumerator];
            id key = [enumerator nextObject];
            NSArray *attachmentObjs = attachments[key];
            for (int i = 0; i < attachmentObjs.count; i++) {
                NSData *fileData = attachmentObjs[i];
                [formData appendPartWithFileData:fileData name:key fileName:[NSString stringWithFormat:@"file%d.jpg", i] mimeType:@"image/jpeg"];
            }
        }
        if(videoFile != nil) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoFile] name:@"videofile"  error:nil];
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoImage] name:@"videoimage"  error:nil];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:sid callback:callback operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failure:error operation:operation sid:sid callback:callback];
    }];
}


- (void)postWithPathForFiles:(NSString *)path andQuery:(HttpQuery *)query andFiles:(NSArray *)files andCallback:(NSObject<HttpServiceCallback>*) callback forSid:(NSString *) sid
{
    [httpClient POST:path parameters:query.parameters constructingBodyWithBlock:^(id formData) {
        for (int i = 0; i < files.count; i++) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:files[i]] name:@"f_file[]" fileName:[NSString stringWithFormat:@"file%d.jpg", 1]  mimeType:@"image/jpeg" error:nil];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:sid callback:callback operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failure:error operation:operation sid:sid callback:callback];
    }];
}

- (void)postWithPathForFile:(NSString *)path andQuery:(HttpQuery *)query andFile:(NSString *)file andMimeType:(NSString *)mimeType andCallback:(NSObject<HttpServiceCallback> *) callback forSid:(NSString *)sid
{
    [httpClient POST:path parameters:query.parameters constructingBodyWithBlock:^(id formData) {
        if (file) {
            if([mimeType isEqualToString:@"video/quicktime"])
            {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:file] name:@"userfile" fileName:[NSString stringWithFormat:@"file%d.mov", 1] mimeType:mimeType error:nil];
            }
            else
            {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:file] name:@"userfile" fileName:[NSString stringWithFormat:@"file%d.mp3", 1] mimeType:mimeType error:nil];
            }
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:sid callback:callback operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failure:error operation:operation sid:sid callback:callback];
    }];
}

- (void)postWithPathForFiles:(NSString *)path andQuery:(HttpQuery *)query andKey:(NSString *)key andFiles:(NSArray *)files andMimeTypes:(NSArray *)mimeTypes andCallback:(NSObject<HttpServiceCallback> *) callback forSid:(NSString *)sid
{
    [httpClient POST:path parameters:query.parameters constructingBodyWithBlock:^(id formData) {
        for (int i = 0; i < mimeTypes.count; i++) {
            NSString *mimeType = mimeTypes[i];
            if([mimeType isEqualToString:@"video/quicktime"])
            {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:files[i]] name:key fileName:[NSString stringWithFormat:@"file%d.mov", i] mimeType:mimeType error:nil];
            }
            else
            {
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:files[i]] name:key fileName:[NSString stringWithFormat:@"file%d.jpg", i] mimeType:mimeType error:nil];
            }
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:sid callback:callback operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failure:error operation:operation sid:sid callback:callback];
    }];
}

- (void)postWithPath:(NSString *)path andQuery:(HttpQuery *)query andCallback:(NSObject<HttpServiceCallback> *)callback forSid:(NSString *)sid
{
    [httpClient POST:path parameters:query.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:sid callback:callback operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failure:error operation:operation sid:sid callback:callback];
    }];
}

- (NSDictionary *)postWithPathSyn:(NSString *)path andQuery:(HttpQuery *)query
{
    NSMutableURLRequest *urlrequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"PATCH" URLString:[[NSURL URLWithString:path relativeToURL:[NSURL URLWithString: [MApi getBaseUrl]]] absoluteString] parameters:query.parameters error:nil];
    //NSMutableURLRequest *urlrequest = [[NSMutableURLRequest alloc]initWithURL:url];
    urlrequest.HTTPMethod = @"POST";
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlrequest];
    
    [requestOperation start];
    [requestOperation waitUntilFinished];
    
    NSDictionary *returnDict = [NSJSONSerialization JSONObjectWithData:[requestOperation.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    
    //return  returnDict[@"status"];
    return  returnDict;
}

- (void)postWithPath:(NSString *)path andQuery:(HttpQuery *)query completionHandler:(GetResultCompletionHandler)completionHandler
{
    [httpClient POST:path parameters:query.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try {
            
            NSDictionary *returnDict = [NSJSONSerialization JSONObjectWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            (completionHandler)(0,returnDict);
        } @catch (NSException *exception) {
            (completionHandler)(4,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (nil == operation.responseString) {
            (completionHandler)(1,nil);
        } else {
            (completionHandler)(2,nil);
        }
    }];
}



- (void)putWithPath:(NSString *)path andQuery:(HttpQuery *)query andCallback:(NSObject<HttpServiceCallback> *)callback forSid:(NSString *)sid forHttpHeader:(NSDictionary*)httpHeader
{
    [httpClient PUT:path parameters:query.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self success:sid callback:callback operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self failure:error operation:operation sid:sid callback:callback];
    }];
}

- (void)success:(NSString *)sid callback:(NSObject<HttpServiceCallback> *)callback operation:(AFHTTPRequestOperation *)operation
{
    HttpServiceResult *result = [[HttpServiceResult alloc] init];
    if (callback) {
        @try {
            if ([callback respondsToSelector:@selector(mapping:ofSid:)]) {
                result.data = [callback mapping: operation.responseString ofSid:sid];
            } else {
                //MLog(@"operation.responseString == %@", operation.responseString);
                // FOR XML
//                NSDictionary *returnDict = [MXMLReader dictionaryForXMLString:operation.responseString error:nil];
                // FOR JSON
                NSDictionary *returnDict = [NSJSONSerialization JSONObjectWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
                result.data = returnDict;
            }
        } @catch (NSException *exception) {
            result.resultCode = DATA_ERROR;
        }
        [callback responded: result ofSid:sid];
    }
}

- (void)failure:(NSError *)error operation:(AFHTTPRequestOperation *)operation sid:(NSString *)sid callback:(NSObject<HttpServiceCallback> *)callback
{
    NSLog(@"%@", error);
    NSLog(@"%@",operation.responseString);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_CANCEL_REQUEST" object:nil];
    HttpServiceResult *result = [[HttpServiceResult alloc] init];
    NSString *errorString = [error.userInfo objectForKey:@"NSLocalizedDescription"];
    if ([errorString isKindOfClass:[NSNull class]]) {
         result.message = [NSString stringWithFormat:@"%@", error];
    } else {
         result.message = errorString;
    }
    BOOL isNotFoundTimeout = ([result.message rangeOfString:@"time"].location == NSNotFound);
    BOOL isNotFoundTimeout2 = ([result.message rangeOfString:@"超时"].location == NSNotFound);
    if (isNotFoundTimeout && isNotFoundTimeout2) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"驴妈妈旅游" message:@"无法连接网络，请连接后重试" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        alert.alertViewStyle=UIAlertViewStyleDefault;
        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(performDismiss:) userInfo:alert repeats:NO];
        [alert show];
    } else {
        NSLog(@"mSquare:%@", @"time out");
    }

    if (nil == operation.responseString) {
        result.resultCode = CONNECTION_ERROR;
    } else {
        result.data = operation.responseString;
        result.resultCode = SERVER_ERROR;
    }
    if (callback) {
        [callback responded: result ofSid:sid];
    }
}

- (void)performDismiss:(id)timer
{
    NSTimer *myTimer = timer;
    UIAlertView *alert = myTimer.userInfo;
    [alert dismissWithClickedButtonIndex:0 animated:NO];
}

@end
