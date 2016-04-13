//
//  theTableViewCell.m
//  lvmamaTourist
//
//  Created by Earth on 15/12/18.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import "theTableViewCell.h"

@interface theTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *lable4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;


@end


@implementation theTableViewCell




- (void)awakeFromNib
{
    self.label1.text = @"12345678901";
    self.label2.text = @"正常";
    self.label3.text = @"123456789165478941534651667465032kggjkfdrtdsrxckfdrduihgfdsdkdtuuhugdtyksrtyujdtfjkjfduiuokkljcdtyijdrtynfdtyubdrtijdrty";
    self.label5.text = @"9165478941534651667465032kggjkfdrtdsrxckfdrduihgfdsdkdtuuhugdtyksrtyujdtfjkjfduiuokkljcdtyijdrty";
    self.label6.text = @"9165478941534651667465032kggjkfdrtdsrxckfdrduihgfdsdkdtuuhugdtyksrtyujdtfjkjfduiuokkljcdtyijdrty9165478941534651667465032kggjkfdrtdsrxckfdrduihgfdsdkdtuuhugdtyksrtyujdtfjkjfduiuokkljcdtyijdrty";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
