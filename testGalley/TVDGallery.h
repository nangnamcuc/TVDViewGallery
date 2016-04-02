//
//  TVDGallery.h
//  testGalley
//
//  Created by Tạ Đại on 25/03/2016.
//  Copyright © 2016 Tạ Đại. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TVDGalleryDelegate;
@protocol TVDGalleryDatasource;

@interface TVDGallery : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, assign) id<TVDGalleryDelegate> delegateTvd;
@property (nonatomic, assign) id<TVDGalleryDatasource> datasourceTvd;

-(void)setSize:(CGSize)size forIndex:(NSInteger)index;
-(void)setDefaultHeight:(CGFloat)height;
-(void)reloadData;

@end

@protocol TVDGalleryDatasource <NSObject>

-(CGFloat)spaceForViewGallery:(TVDGallery*)viewTvd;
-(NSInteger)numberOfViewOnViewGallery:(TVDGallery*)viewTvd;
-(NSInteger)numberOfColumnOnViewGallery:(TVDGallery*)viewTvd;
-(UIView*)viewGallery:(TVDGallery*)viewTvd atIndex:(NSInteger)index reUsingView:(UIView*)view;

@end

@protocol TVDGalleryDelegate <NSObject>

-(void)viewGallery:(TVDGallery*)viewTvd selectedView:(UIView*)v atPoint:(CGPoint)point andIndex:(NSInteger)index;

@end
