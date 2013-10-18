//
//  NewRegisterViewController.h
//  Instanote
//
//  Created by Man Tung
//
//

#import <UIKit/UIKit.h>
#import "msgView.h"

@interface NewRegisterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
    UITableView * tableview;
//    UITextField * usernameInputField;
    UITextField * passwordInputField;
    UITextField * randomcodeInputField;
    NSString * phoneNum;
    UIButton * signInButton;
    
    //    UIButton * _forgetPasswordButton;
    
    //UIButton * _registerButton;
    
    msgView * msgview;
    //    UIActivityIndicatorView * activityindicator;
    
}

@property (nonatomic, retain) UITableView * tableview;
//@property (nonatomic, retain) UITextField * usernameInputField;
@property (nonatomic, retain) UITextField * passwordInputField;
@property (nonatomic, retain) UITextField * randomcodeInputField;
@property (nonatomic, retain) NSString * phoneNum;
@property (nonatomic, retain) UIButton * signInButton;
//@property (nonatomic, retain) UIButton * _forgetPasswordButton;
//@property (nonatomic, retain) UIButton * _registerButton;
@property (nonatomic,assign) id finishTarget;
@property (nonatomic,assign) SEL finishAction;

- (void)regAction;
- (void)backAction;


@end
