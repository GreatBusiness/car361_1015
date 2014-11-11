//
//  CommentInputCell.h
//  car361
//
//  Created by lichaowei on 14/11/11.
//  Copyright (c) 2014年 lcw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentInputCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *nameLabel;
@property (strong, nonatomic) IBOutlet UITextView *commentTF;
@property (strong, nonatomic) IBOutlet UIButton *commitButton;

@end
