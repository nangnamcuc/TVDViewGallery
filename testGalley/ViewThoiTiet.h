//
//  ViewThoiTiet.h
//  ThoiTietVI
//
//  Created by Tạ Đại on 10/03/2016.
//  Copyright © 2016 Tạ Đại. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewThoiTietDelegate;

@interface ViewThoiTiet : UIView

-(id)initWithDevice:(NSString*)dv;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblngay;
@property (weak, nonatomic) IBOutlet UILabel *lblnhiet;

@property (nonatomic, assign) id<ViewThoiTietDelegate> delegate;

@end

@protocol ViewThoiTietDelegate <NSObject>

@optional

- (void)selectThoiTiet:(ViewThoiTiet*)viewtt;

@end
