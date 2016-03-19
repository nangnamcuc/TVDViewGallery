//
//  TVDViewGallery.h
//  Wallpapers
//
//  Created by Tạ Đại on 17/03/2016.
//  Copyright © 2016 Tạ Đại. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TVDViewGalleryDelegate;
@protocol TVDViewGalleryDatasource;

@interface TVDViewGallery : UITableView<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id<TVDViewGalleryDelegate> delegateTvd;
@property (nonatomic, assign) id<TVDViewGalleryDatasource> datasourceTvd;

-(void)setSize:(CGSize)size forIndex:(NSInteger)index;

@end

@protocol TVDViewGalleryDatasource <NSObject>

-(CGFloat)spaceForViewGallery:(TVDViewGallery*)viewTvd;
-(CGFloat)heghtForRowViewGallery:(TVDViewGallery*)viewTvd;
-(NSInteger)numberOfViewOnViewGallery:(TVDViewGallery*)viewTvd;
-(NSInteger)numberOfMaxColumnOnViewGallery:(TVDViewGallery*)viewTvd;
-(UIView*)viewGallery:(TVDViewGallery*)viewTvd atIndex:(NSInteger)index reUsingView:(UIView*)view;

@end

@protocol TVDViewGalleryDelegate <NSObject>

-(void)viewGallery:(TVDViewGallery*)viewTvd selectedAtIndex:(NSInteger)index;
-(void)viewGallery:(TVDViewGallery*)viewTvd sizeDidchangedOnView:(UIView*)view;

@end
