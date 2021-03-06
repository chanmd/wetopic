/*
	InoteSyncInstanoteSynchronyServiceService.m
	The implementation classes and methods for the InstanoteSynchronyServiceService web service.
	Generated by SudzC.com
*/

#import "InoteSyncInstanoteSynchronyServiceService.h"
				
#import "Soap.h"
	
//#define SERVICE_URL @"http://223.4.86.101:8080/Instanote/services/InstanoteSynchronyService"
//#define NAMESPACE @"http://223.4.86.101:8080/Instanote/services/InstanoteSynchronyService"

//#define SERVICE_URL @"http://124.207.169.2:8080/Instanote/services/InstanoteSynchronyService"
//#define NAME_SPACE @"http://124.207.169.2:8080/Instanote/services/InstanoteSynchronyService"

#define SERVICE_URL @"http://instanote-service.elasticbeanstalk.com/services/InstanoteSynchronyService"
#define NAME_SPACE @"http://instanote-service.elasticbeanstalk.com/InstanoteSynchronyService"


/* Implementation of the service */
				
@implementation InoteSyncInstanoteSynchronyServiceService

	- (id) init
	{
		if(self = [super init])
		{
			self.serviceUrl = SERVICE_URL;
			self.namespace = NAME_SPACE;
			self.headers = nil;
			self.logging = NO;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (InoteSyncInstanoteSynchronyServiceService*) service {
		return [InoteSyncInstanoteSynchronyServiceService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (InoteSyncInstanoteSynchronyServiceService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[[InoteSyncInstanoteSynchronyServiceService alloc] initWithUsername:username andPassword:password] autorelease];
	}

		
	/* Returns NSString*.  */
	- (SoapRequest*) instanoteSynchronyService: (id <SoapDelegate>) handler inttype: (int) inttype intuserid: (int) intuserid strdata: (NSString*) strdata intpagenum: (int) intpagenum intpagesize: (int) intpagesize
	{
		return [self instanoteSynchronyService: handler action: nil inttype: inttype intuserid: intuserid strdata: strdata intpagenum: intpagenum intpagesize: intpagesize];
	}

	- (SoapRequest*) instanoteSynchronyService: (id) _target action: (SEL) _action inttype: (int) inttype intuserid: (int) intuserid strdata: (NSString*) strdata intpagenum: (int) intpagenum intpagesize: (int) intpagesize
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: inttype] forName: @"inttype"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: intuserid] forName: @"intuserid"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: strdata forName: @"strdata"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: intpagenum] forName: @"intpagenum"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: intpagesize] forName: @"intpagesize"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"instanoteSynchronyService" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


@end
	