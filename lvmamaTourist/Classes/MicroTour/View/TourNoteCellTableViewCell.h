//
//  TourNoteCellTableViewCell.h
//  lvmamaTourist
//
//  Created by Earth on 15/12/10.
//  Copyright © 2015年 Earth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model_TourNote.h"

@interface TourNoteCellTableViewCell : UITableViewCell

//- (void) setTourData:(Model_TourNote *)modelData;

- (void) setTourData:(Model_TourNote *)modelData controller:(id)controller;


@end
