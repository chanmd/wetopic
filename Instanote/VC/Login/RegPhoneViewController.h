//
//  RegPhoneViewController.h
//  Instanote
//
//  Created by Man Tung
//
//

#import <UIKit/UIKit.h>
#import "msgView.h"

@interface RegPhoneViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    UITableView * tableview;
    UITextField * usernameInputField;
    UIButton * sendButton;
    NSString * phoneN;
    
    //msg
    msgView * msgview;
//    UIActivityIndicatorView * activityindicator;
}

@property (nonatomic, retain) UITableView * tableview;
@property (nonatomic, retain) UITextField * usernameInputField;
@property (nonatomic, retain) UIButton * sendButton;

@property (nonatomic,assign) id finishTarget;
@property (nonatomic,assign) SEL finishAction;

- (void)sendAction;
- (void)backAction;

@end
