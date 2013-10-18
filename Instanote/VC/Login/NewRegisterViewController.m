//
//  NewRegisterViewController.m
//  Instanote
//
//  Created by Man Tung
//
//

#import "NewRegisterViewController.h"
#import "UsersEntity.h"
#import "NSDictionaryAdditions.h"
#import "JSON.h"
#import "WeiboClient.h"

@interface NewRegisterViewController ()

@end

@implementation NewRegisterViewController
@synthesize tableview = tableview;
//@synthesize usernameInputField = usernameInputField;
@synthesize passwordInputField = passwordInputField;
@synthesize randomcodeInputField = randomcodeInputField;
@synthesize signInButton = signInButton;
@synthesize phoneNum = phoneNum;
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
    self.title = NSLocalizedString(@"register_title", @"");
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (!tableview) {
        tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 450) style:UITableViewStyleGrouped];
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.backgroundColor = [UIColor clearColor];
        UIView * bkview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        bkview.backgroundColor = [UIColor whiteColor];
        tableview.backgroundView = bkview;
        [self.view insertSubview:tableview atIndex:0];
    }
    
//    if (!usernameInputField) {
//        usernameInputField = [[UITextField alloc] init];
//        [usernameInputField setFrame:CGRectMake(20, 15, 280, 20)];
//        [usernameInputField setPlaceholder:NSLocalizedString(@"register_username_placehold", @"")];
//        [usernameInputField setClearButtonMode:UITextFieldViewModeWhileEditing];
//        [usernameInputField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
//        [usernameInputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
//        [usernameInputField setReturnKeyType:UIReturnKeyNext];
//        [usernameInputField setKeyboardType:UIKeyboardTypeEmailAddress];
//        [usernameInputField setDelegate:self];
//        [usernameInputField setFont:[UIFont fontWithName:FONT_NAME size:15]];
//    }
    if (!passwordInputField) {
        passwordInputField = [[UITextField alloc] init];
        [passwordInputField setFrame:CGRectMake(20, 15, 280, 20)];
        [passwordInputField setPlaceholder:@"请输入6位以上的密码"];
        [passwordInputField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [passwordInputField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [passwordInputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [passwordInputField setReturnKeyType:UIReturnKeyDone];
        [passwordInputField setSecureTextEntry:YES];
        [passwordInputField setDelegate:self];
        [passwordInputField setFont:[UIFont fontWithName:FONT_NAME size:15]];
    }
    if (!randomcodeInputField) {
        randomcodeInputField = [[UITextField alloc] init];
        [randomcodeInputField setFrame:CGRectMake(20, 15, 280, 20)];
        [randomcodeInputField setPlaceholder:@"请输入手机验证码"];
        [randomcodeInputField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [randomcodeInputField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [randomcodeInputField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [randomcodeInputField setReturnKeyType:UIReturnKeyNext];
        [randomcodeInputField setDelegate:self];
        [randomcodeInputField setFont:[UIFont fontWithName:FONT_NAME size:15]];
    }
    
    if (!signInButton) {
        signInButton = [[UIButton alloc] init];
        [signInButton setTitle:@"完成注册" forState:UIControlStateNormal];
        [signInButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [signInButton setFrame:CGRectMake(60, 7, 200, 30)];
        [signInButton.titleLabel setTextAlignment:UITextAlignmentCenter];
        //[signInButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
        [signInButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [signInButton addTarget:self action:(@selector(regAction)) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //    if (!_forgetPasswordButton) {
    //        _forgetPasswordButton = [[UIButton alloc] init];
    //        [_forgetPasswordButton setTitle:@"Back" forState:UIControlStateNormal];
    //        [_forgetPasswordButton setFrame:CGRectMake(0, 203, 60, 30)];
    //        [_forgetPasswordButton.titleLabel setFont:[UIFont fontWithName:@"Arial" size:16]];
    //        [_forgetPasswordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //        [_forgetPasswordButton addTarget:self action:(@selector(backAction)) forControlEvents:UIControlEventTouchUpInside];
    //        [self.view addSubview:_forgetPasswordButton];
    //    }
    if (!msgview) {
        msgview = [[msgView alloc] initWithFrame:CGRectMake(10, 20, 300, 46)];
        [self.view addSubview:msgview];
    }
    
    //    if (!activityindicator) {
    //        activityindicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //        [activityindicator setFrame:CGRectMake(185, 142, 20, 20)];
    //        [self.view insertSubview:activityindicator atIndex:1];
    //    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == randomcodeInputField) {
        [randomcodeInputField resignFirstResponder];
        [passwordInputField becomeFirstResponder];
    }
    if (textField == passwordInputField) {
        [self regAction];
        
    }
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section == 1) {
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
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            //cell.userInteractionEnabled = NO;
            [cell addSubview:randomcodeInputField];
        }
    } else if (indexPath.row == 1 && indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            //cell.userInteractionEnabled = NO;
            [cell addSubview:passwordInputField];
        }
        
    } else if (indexPath.row == 0 && indexPath.section == 1) {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            //            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            [cell addSubview:signInButton];
        }
    } else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    return cell;
}

- (void)regAction
{
//    NSString * textUsername = usernameInputField.text;
    NSString * textPassword = passwordInputField.text;
    NSString * textRandomcode = randomcodeInputField.text;
//    if (!textUsername || [textUsername length] == 0) {
//        [msgview setFrame:CGRectMake(10, 10, 300, 44)];
//        [msgview setText:NSLocalizedString(@"register_username_input_empty", @"")];
//        [msgview show];
//    } else if ([textUsername length] != 11) {
//        
//        [msgview setFrame:CGRectMake(10, 10, 300, 44)];
//        [msgview setText:@"请输入正确的号码"];
//        [msgview show];
//        
//        
//    }
    if (!textPassword || [textPassword length] == 0) {
        [msgview setFrame:CGRectMake(10, 54, 300, 46)];
        [msgview setText:NSLocalizedString(@"register_password_input_empty", @"")];
        [msgview show];
    } else if (textPassword && [textPassword length] < 6) {
        [msgview setFrame:CGRectMake(10, 54, 300, 46)];
        [msgview setText:NSLocalizedString(@"register_password_input_lessthan_six", @"")];
        [msgview show];
    } else if (!textRandomcode || [textRandomcode length] == 0) {
        [msgview setFrame:CGRectMake(10, 100, 300, 46)];
        [msgview setText:@"请输入验证码"];
        [msgview show];
    } else {
        
//        [self performSelector:@selector(justBack) withObject:nil afterDelay:2];
        
        [self regService];
    }
}

- (BOOL)statusto:(int)status
{
    BOOL flag = false;
    switch (status) {
        case 1:
            [msgview setFrame:CGRectMake(10, 100, 300, 44)];
            [msgview setText:@"注册成功"];
            [msgview show];
            flag = true;
            break;
        case 2:
            [msgview setFrame:CGRectMake(10, 100, 300, 46)];
            [msgview setText:@"请检查验证码是否错误"];
            [msgview show];
            break;
        default:
            break;
    }
    return flag;
    
}

- (void)regService
{
    //here is soap methods
//    NSString *email = usernameInputField.text;
    NSString *password = passwordInputField.text;
    NSString *randomcode = randomcodeInputField.text;
    
    WeiboClient *client = [[WeiboClient alloc] initWithTarget:self action:@selector(loadDataFinished:obj:)];
    
    [client regWithPhone:phoneNum randomCode:randomcode pwd:password];
    
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
        if ([self statusto:status]) {
            
            //NSLog(@"%@", data);
            
            //NSDictionary * data = [dic objectForKey:@"data"];
            //NSDictionary * user = [data objectForKey:@"user"];
            //UsersEntity * u = [UsersEntity entityWithJsonDictionary:user];
            //remember the user
            //[self saveUser:u];
            //dismiss this view
            
//            [sender alerterror:NSLocalizedString(@"register_success", nil)];
            [self performSelector:@selector(justBack) withObject:nil afterDelay:2];
            
            //        if ([[dic getStringValueForKey:@"data" defaultValue:@"null"] isEqualToString:@"null"]) {
            //
            //
            //        } else {
            //            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"注册失败，请稍后重试" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //            [alert show];
            //            [alert release];
            //
            //            [self.navigationController popViewControllerAnimated:NO];
            //        }
            
            
            
        }
        //        [self convertdata:obj];
    }
}

//- (void)backAction
//{
////    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissModalViewControllerAnimated:YES];
//}

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


- (void)backAction
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)justBack
{
    [self dismissViewControllerAnimated:NO completion:^
     {
         [self.navigationController popViewControllerAnimated:NO];
     }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    tableview = nil;
//    usernameInputField = nil;
    passwordInputField = nil;
    randomcodeInputField = nil;
    signInButton = nil;
    //    _forgetPasswordButton = nil;
    
    msgview = nil;
    //    activityindicator = nil;
}

- (void)dealloc
{
    [super dealloc];
    [tableview release];
//    [usernameInputField release];
    [passwordInputField release];
    [randomcodeInputField release];
    [signInButton release];
    //    [_forgetPasswordButton release];
    
    [msgview release];
    //    [activityindicator release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [randomcodeInputField becomeFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
