//
//  ViewController.m
//  ChatDemo
//
//  Created by jason on 16/3/30.
//  Copyright © 2016年 Test. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"
#import "EMSDK.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    UIButton *btn_nav_back = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_nav_back.backgroundColor = [UIColor redColor];
    btn_nav_back.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    [btn_nav_back addTarget:self action:@selector(barButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_nav_back];
    
    
    UIButton *btn_RemoveList = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_RemoveList.backgroundColor = [UIColor redColor];
    btn_RemoveList.frame = CGRectMake(100.0f, 200.0f, 100.0f, 100.0f);
    [btn_RemoveList addTarget:self action:@selector(barButtonItemClick1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_RemoveList];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshAndSortView];
}

#pragma mark - data

-(void)refreshAndSortView
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSArray* sorted = [conversations sortedArrayUsingComparator:
                       ^(EMConversation *obj1, EMConversation* obj2){
                           EMMessage *message1 = [obj1 latestMessage];
                           EMMessage *message2 = [obj2 latestMessage];
                           if(message1.timestamp > message2.timestamp) {
                               return(NSComparisonResult)NSOrderedAscending;
                           }else {
                               return(NSComparisonResult)NSOrderedDescending;
                           }}];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:sorted];
    
   for(EMConversation *model in self.dataArray)
   {
       EaseConversationModel *modelTeset = [[EaseConversationModel alloc] initWithConversation:model];
       id<IConversationModel> modelVaule = modelTeset;
       NSLog(@"%@",[self _latestMessageTitleForConversationModel:modelVaule]);
   }
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

#pragma mark - private
- (NSString *)_latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSEaseLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSEaseLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSEaseLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSEaseLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSEaseLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    return latestMessageTitle;
}

- (NSString *)_latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    return latestMessageTime;
}



- (void)barButtonItemClick
{
    ChatViewController *chatVC = [[ChatViewController alloc]initWithConversationChatter:@"4696185282" conversationType:EMConversationTypeChat];
    chatVC.title = @"469618528";
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (void)barButtonItemClick1
{
//    [[EMClient sharedClient].chatManager rem];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
