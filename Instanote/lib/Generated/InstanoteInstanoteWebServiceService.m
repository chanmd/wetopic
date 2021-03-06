/*
	InstanoteInstanoteWebServiceService.m
	The implementation classes and methods for the InstanoteWebServiceService web service.
	Generated by SudzC.com
*/

#import "InstanoteInstanoteWebServiceService.h"
				
#import "Soap.h"
	
//#define SERVICE_URL @"http://124.207.169.2:8080/Instanote/services/InstanoteWebService"
//#define NAME_SPACE @"http://124.207.169.2:8080/Instanote/services/InstanoteWebService"

#define SERVICE_URL @"http://instanote-service.elasticbeanstalk.com/services/InstanoteWebService"
#define NAME_SPACE @"http://instanote-service.elasticbeanstalk.com/services/InstanoteWebService"

/* Implementation of the service */
				
@implementation InstanoteInstanoteWebServiceService

	- (id) init
	{
		if(self = [super init])
		{
			self.serviceUrl = SERVICE_URL;
			self.namespace = NAME_SPACE;
			self.headers = nil;
			self.logging = NO;
            
            //init the date
//            object = 0;
//            type = 0;
//            userid = 0;
//            email = @"";
//            pwd = @"";
//            userSource = @"";
//            newPassword = @"";
//            noteid = 0;
//            noteInfo = @"";
//            notedate = 0;
//            lastdate = 0;
//            notesource = 0;
//            pagenum = 0;
//            pagesize = 0;
//            active = @"";
            
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (InstanoteInstanoteWebServiceService*) service {
		return [InstanoteInstanoteWebServiceService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (InstanoteInstanoteWebServiceService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[[InstanoteInstanoteWebServiceService alloc] initWithUsername:username andPassword:password] autorelease];
	}

		
	/* Returns NSString*.  */
	- (SoapRequest*) instanoteService: (id <SoapDelegate>) handler intobject: (int) intobject inttype: (int) inttype intuserid: (int) intuserid stremail: (NSString*) stremail strpass: (NSString*) strpass strusersource: (NSString*) strusersource strnewpass: (NSString*) strnewpass noteid: (int) noteid noteinfo: (NSString*) noteinfo notedate: (long) notedate notelastdate: (long) notelastdate notesource: (short) notesource intpagenum: (int) intpagenum intpagesize: (int) intpagesize stractive: (NSString*) stractive
	{
		return [self instanoteService: handler action: nil intobject: intobject inttype: inttype intuserid: intuserid stremail: stremail strpass: strpass strusersource: strusersource strnewpass: strnewpass noteid: noteid noteinfo: noteinfo notedate: notedate notelastdate: notelastdate notesource: notesource intpagenum: intpagenum intpagesize: intpagesize stractive: stractive];
	}

	- (SoapRequest*) instanoteService: (id) _target action: (SEL) _action intobject: (int) intobject inttype: (int) inttype intuserid: (int) intuserid stremail: (NSString*) stremail strpass: (NSString*) strpass strusersource: (NSString*) strusersource strnewpass: (NSString*) strnewpass noteid: (int) noteid noteinfo: (NSString*) noteinfo notedate: (long) notedate notelastdate: (long) notelastdate notesource: (short) notesource intpagenum: (int) intpagenum intpagesize: (int) intpagesize stractive: (NSString*) stractive
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: intobject] forName: @"intobject"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: inttype] forName: @"inttype"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: intuserid] forName: @"intuserid"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: stremail forName: @"stremail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: strpass forName: @"strpass"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: strusersource forName: @"strusersource"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: strnewpass forName: @"strnewpass"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: noteid] forName: @"noteid"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: noteinfo forName: @"noteinfo"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithLong: notedate] forName: @"notedate"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithLong: notelastdate] forName: @"notelastdate"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithShort:notesource] forName: @"notesource"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: intpagenum] forName: @"intpagenum"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: intpagesize] forName: @"intpagesize"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: stractive forName: @"stractive"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"instanoteService" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


//- (SoapRequest *)loginService:(id <SoapDelegate>) handler email:(NSString *)email password:(NSString *) password
//{
//    return nil;
//}
//- (SoapRequest *)loginService:(id)target action:(SEL) action email:(NSString *)email password:(NSString *)password
//{
//    return nil;
//}
//
//- (SoapRequest *)registerService:(id <SoapDelegate>) handler email:(NSString *)email password:(NSString *) password
//{
//    return nil;
//}
//- (SoapRequest *)registerService:(id)target action:(SEL) action email:(NSString *)email password:(NSString *)password
//{
//    return nil;
//}

@end
	