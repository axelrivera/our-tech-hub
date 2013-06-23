#import "TechHubAPIClient.h"

#import <AFJSONRequestOperation.h>

static NSString * const kTechHubAPIBaseURLString = @"https://ourtechhub.herokuapp.com/";

@implementation TechHubAPIClient

+ (TechHubAPIClient *)sharedClient {
    static TechHubAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TechHubAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kTechHubAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end
