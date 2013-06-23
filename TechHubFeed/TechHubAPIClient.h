#import <Foundation/Foundation.h>
#import <AFHTTPClient.h>

@interface TechHubAPIClient : AFHTTPClient

+ (TechHubAPIClient *)sharedClient;

@end
