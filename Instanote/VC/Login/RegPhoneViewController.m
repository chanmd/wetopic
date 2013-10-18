//
//  RegPhoneViewController.m
//  Instanote
//
//  Created by Man Tung
//
//

#import "RegPhoneViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "JSON.h"
#import "NSDictionaryAdditions.h"
#import "WeiboClient.h"
#import "NewRegisterViewController.h"

@interface RegPhoneViewController ()

@end

@implementation RegPhoneViewController
@synthesize tableview;
@synthesize usernameInputField;
@synthesize sendButton;
@synthesize finishAction,finishTarget;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"注册新用户";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    
    if (!tableview) {
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStyleGrouped];
        tableview.delegate = self;
        tableview.dataSource = self;
        UIView * bkview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        bkview.backgroundColor = [UIColor whiteColor];
        tableview.backgroundView = bkview;
        [self.view insertSubview:tableview atIndex:0];
    }
    
    if (!usernameInputField) {
        usernameInputField = [[UITextField alloc] init];
        [usernameInputField setFrame:CGRectMake(20, 15, 280, 20)];
        [usernameInputField setPlaceholder:@"输入手机号码"];
        [usernameInputField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [usernameInputField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [usernameInputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [usernameInputField setReturnKeyType:UIReturnKeyDone];
        [usernameInputField setKeyboardType:UIKeyboardTypeNumberPad];
        [usernameInputField setDelegate:self];
        [usernameInputField setFont:[UIFont fontWithName:FONT_NAME size:15]];
    }
    if (!sendButton) {
        sendButton = [[UIButton alloc] init];
        [sendButton setTitle:@"下一步" forState:UIControlStateNormal];
        [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [sendButton setFrame:CGRectMake(60, 7, 200, 30)];
        [sendButton.titleLabel setTextAlignment:UITextAlignmentCenter];
        [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sendButton addTarget:self action:(@selector(sendAction)) forControlEvents:UIControlEventTouchUpInside];
    }
    if (!msgview) {
        msgview = [[msgView alloc] initWithFrame:CGRectMake(10, 10, 300, 46)];
        [self.view addSubview:msgview];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (indexPath.row == 0 && indexPath.section == 0) {
        CellIdentifier = @"UserNameCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            //cell.userInteractionEnabled = NO;
            [cell addSubview:usernameInputField];
        }
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            [cell addSubview:sendButton];
        }
    } else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell ...
    return cell;
}

- (void)sendAction
{
    NSString * text = usernameInputField.text;
    if (!text || [text length] == 0) {
        [msgview setText:@"请输入手机号码"];
        [msgview show];
    } else if ([text length] != 11) {
        [msgview setText:@"号码输入有误"];
        [msgview show];
    } else {
        [self sendService];
    }
}

#pragma mark - convert json

- (void)convertdata:(NSObject *)data
{
    NSDictionary * dic = (NSDictionary *)data;
    int status;
    status = [dic getIntValueForKey:@"status" defaultValue:0];
    if ([self statusto:status]) {
        
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"forgot_message_checkmail", nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
//        [alert show];
//        
//        [alert release];
//        
//        [self backAction];
    }
}

//- (void)backAction
//{
////    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissModalViewControllerAnimated:YES];
//}

- (BOOL)statusto:(int)status
{
    BOOL flag = false;
    switch (status) {
        case 3:
            [msgview setText:@"短信发送失败，请检查号码是否有误"];
            [msgview show];
            break;
        case 1:
            flag = true;
            break;
        case 2:
            [msgview setText:@"手机号码已被注册"];
            [msgview show];
            break;
        case 4:
            break;
        default:
            break;
    }
    return flag;
    
}

- (void)sendService
{
    //here is soap methods
    NSString *phonenum = usernameInputField.text;
    
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    
    [client regWithPhone:phonenum];
    phoneN = phonenum;
    
}

- (void)loadDataFinished:(WeiboClient *)sender
                     obj:(NSObject*)obj
{
    
    if (sender.hasError) {
        [sender alerterror:NSLocalizedString(@"errormessage", nil)];
    }
    else {
        
        NSDictionary * dic = (NSDictionary *)obj;
        int status;
        status = [dic getIntValueForKey:@"status" defaultValue:0];
//        NSLog(@"%@", obj);
        if ([self statusto:status]) {
            
            [self goforward];
            
        }
        //        [self convertdata:obj];
    }
}

- (void)goforward
{
    NewRegisterViewController *newregvc = [[NewRegisterViewController alloc] init];
    newregvc.phoneNum = phoneN;
    newregvc.finishTarget = self;
    newregvc.finishAction = @selector(justBack);
    [self.navigationController pushViewController:newregvc animated:NO];
    [newregvc release];
}


//- (void)alerterror:(NSString *)title
//{
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"more_logout_yes", nil) otherButtonTitles:nil, nil];
//    [alert show];
//    [alert release];
//}


- (void)msgShow:(UIView *)view
{
    [view setHidden:NO];
    [self performSelector:@selector(hiddenView:) withObject:view afterDelay:2.f];
}


- (void)hiddenView:(UIView *)view;
{
    [view setHidden:YES];
}

- (void)justBack
{
    [self backAction];
    if ([finishTarget retainCount] > 0 && [finishTarget respondsToSelector:finishAction]) {
        [finishTarget performSelector:finishAction  withObject:nil];
    }
}

- (void)backAction
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark textfield delegate

//- (void)textViewDidChange:(UITextView *)textView
//{
//    NSInteger textlength = [[textfield text] length];
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString * text = textField.text;
    // need regex to pattern email?
    if (text) {
        if ([text length] > 0) {
            //validate the text as email address
            [self sendAction];
            
            return YES;
        } else {
            if ([text length] == 0) {
                [msgview setText:NSLocalizedString(@"forgot_username_input_empty", @"")];
                [msgview show];
            }
            return NO;
        }
    } else {
        return NO;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    //sendButton = nil;
    tableview = nil;
    usernameInputField = nil;
    sendButton = nil;
    
    //msg
    msgview = nil;
    //    activityindicator = nil;
}

- (void)dealloc
{
    [super dealloc];
    [sendButton release];
    [usernameInputField release];
    [tableview release];
    
    [msgview release];
    //    [activityindicator release];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [usernameInputField becomeFirstResponder];
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
