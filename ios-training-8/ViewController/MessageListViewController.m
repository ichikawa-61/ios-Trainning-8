//
//  MassageListViewController.m
//  ios-training-8
//
//  Created by Manami Ichikawa on 7/21/17.
//  Copyright © 2017 Manami Ichikawa. All rights reserved.
//

#import "MessageListViewController.h"
#import "MessageCell.h"
#import "MessageDataProvider.h"
#import "DaoMessages.h"
#import "Message.h"


@interface MessageListViewController ()<UITableViewDelegate,UITextViewDelegate,DaoMessageDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (nonatomic) MessageDataProvider *provider;
@property BOOL isEditing;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) DaoMessages *db;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)tapSendButton:(id)sender;


//- (IBAction)tapSendButton:(id)sender;
@end

@implementation MessageListViewController
static NSInteger const TEXTVIEW_MAX_HEIGHT = 100.0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.provider = [[MessageDataProvider alloc]init];
    self.tableView.dataSource = self.provider;
    self.tableView.delegate = self;
    self.textView.delegate= self;
    
    UINib *nib = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MessageCell"];
   
//    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
//    gestureRecognizer.cancelsTouchesInView = NO;
//    [self.view addGestureRecognizer:gestureRecognizer];
//    
    
    self.tableView.estimatedRowHeight = 30;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if([self.textView.text length] == 0){
        self.sendButton.enabled = NO;
    }
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.db = [[DaoMessages alloc]init];
    self.db.delegate = self;
    
    [self accessMessageManager];
    
    if (!self.isEditing) {
        NSNotificationCenter *noticication = [NSNotificationCenter defaultCenter];
        [noticication addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [noticication addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        self.isEditing = YES;        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.isEditing) {
        NSNotificationCenter *noticication = [NSNotificationCenter defaultCenter];
        [noticication removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [noticication removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        
        self.isEditing = NO;
    }
}


-(void) keyboardWillShow:(NSNotification *) notification{

    CGRect rect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];

    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    [UIView animateWithDuration:duration animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -rect.size.height);
        self.view.transform = transform;
    } completion:NULL];
}

-(void) keyboardWillHide:(NSNotification *)notification{
    
    NSTimeInterval duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    } completion:NULL];
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if([self.textView.text length] == 0){
        self.sendButton.enabled = NO;
    }else{
        self.sendButton.enabled = YES;
    }
    
    float maxHeight = TEXTVIEW_MAX_HEIGHT;
    if(self.textView.frame.size.height < maxHeight){
        
        CGSize size = [self.textView sizeThatFits:self.textView.frame.size];
        self.textViewHeight.constant = size.height;
    }
}

# pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    [self.textView scrollRangeToVisible:self.textView.selectedRange];
    
    return YES;
}

-(void)accessMessageManager{
    
    if([self.db showMessageList] != nil){
        NSMutableArray *list = [[NSMutableArray alloc]init];
        list = [self.db showMessageList];
        
//        for( Message* message in list )
//        {
//            //配列にアペンド
//            NSArray *array = [[NSArray alloc]init];
//            [array addObject:message.sentDate];
//            message.sentDate;
//            
//        }
    
        
//        NSArray* dateList = [list objectForKey:[self.authors objectAtIndex:section]];
        self.provider.items = list;
        
        
    }
    
    [self.tableView reloadData];
    
}

#pragma mark - DaoMessageDelegate

-(void)finishedAddingNewMessage{
    
    [self accessMessageManager];
}

    

- (IBAction)tapSendButton:(id)sender {
    
    self.db = [[DaoMessages alloc]init];
    
    Message *newMessage = [[Message alloc]init];
    newMessage.title = self.textView.text;
    
    [self.db addNewMessage:newMessage];
    self.textView.text = nil;
    CGSize size = [self.textView sizeThatFits:self.textView.frame.size];
    self.textViewHeight.constant = size.height;
    
    self.sendButton.enabled = NO;
    [self.textView resignFirstResponder];

}
    



@end
