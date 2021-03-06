//
//  CommentGoodListCellTableViewCell.h
//  Ash_AWord
//
//  Created by xmfish on 15/6/1.
//  Copyright (c) 2015年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShowPraiseList)(void);
@interface CommentGoodListCellTableViewCell : UITableViewCell

@property (strong, nonatomic)ShowPraiseList showPraiseList;
@property (weak, nonatomic) IBOutlet UIImageView *barBtImageView;

- (IBAction)showMoreBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *showMoreBtn;
-(void)setUserInfoArr:(NSArray*)userInfoArr;
@end
