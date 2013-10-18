//
//  NewForgotViewController.m
//  Instanote
//
//  Created by Man Tung
//
//

#import "NewForgotViewController.h"
#import "UILabel+Extensions.h"

@interface NewForgotViewController ()

@end

@implementation NewForgotViewController

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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 15)];
    label.font = [UIFont fontWithName:FONT_NAME size:17];
    label.text = @"找回密码功能尚未开通，请发送邮件到greatmedia@126.com找回。";
    [label sizeToFitFixedWidth:300];
    [self.view addSubview:label];
    [label release];
    
}

- (void)backAction
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
