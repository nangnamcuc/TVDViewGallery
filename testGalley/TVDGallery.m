//
//  TVDGallery.m
//  testGalley
//
//  Created by Tạ Đại on 25/03/2016.
//  Copyright © 2016 Tạ Đại. All rights reserved.
//

#import "TVDGallery.h"

@implementation TVDGallery{
    NSInteger numOfItem, numOfColumn;
    CGFloat heightCell, spaceView, widthColumn;
    NSMutableArray *arrSize,*arrView;
    CGFloat oldy, defaultHeight;
    UITapGestureRecognizer *tap;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupProtocol];
}

-(instancetype)init{
    self = [super init];
    [self setupProtocol];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setupProtocol];
    return self;
}

-(void)setupProtocol{
    numOfItem=0;
    self.delegateTvd = (id)self.delegate;
    self.datasourceTvd = (id)self.delegate;
    self.delegate = (id)self;
    defaultHeight = self.frame.size.height;
}

-(void)setDefaultHeight:(CGFloat)height{
    defaultHeight = height;
}

-(void)tapAction:(UIGestureRecognizer *)recognizer {
    UIView* view = recognizer.view;
    CGPoint loc = [recognizer locationInView:view];
    UIView* subview = [view hitTest:loc withEvent:nil];
    if(subview==nil)return;
    if(subview == self)return;
    loc.x=loc.x-subview.frame.origin.x;
    loc.y=loc.y-subview.frame.origin.y;
    [self.delegateTvd viewGallery:self selectedView:subview atPoint:loc andIndex:subview.tag];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

-(void)reloadData{
    numOfColumn = [self.datasourceTvd numberOfColumnOnViewGallery:self];
    numOfItem = [self.datasourceTvd numberOfViewOnViewGallery:self];
    spaceView = [self.datasourceTvd spaceForViewGallery:self];
    if(!tap){
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        tap.delegate = (id)self;
        tap.numberOfTapsRequired = 1;
        
        [self addGestureRecognizer:tap];
    }
    if(!arrSize){
        arrSize = [NSMutableArray new];
    }
    if(!arrView){
        arrView = [NSMutableArray new];
    }
    for(UIView *v in arrView) v.hidden=YES;
    while (arrSize.count>numOfItem) {
        [arrSize removeObjectAtIndex:arrSize.count-1];
    }
    widthColumn = (self.frame.size.width-spaceView*(1+numOfColumn))/numOfColumn;
    [self reSize];
    [self loadView];
}

-(void)reSize{
    NSMutableArray *ar = [NSMutableArray new];
    for(int i=0;i<numOfColumn;i++){
        [ar addObject:[NSNumber numberWithFloat:spaceView]];
    }
    for(int i=0;i<numOfItem;i++){
        CGFloat min = CGFLOAT_MAX;
        int vtmin = 0;
        for(int j=0;j<ar.count;j++){
            if(min>[[ar objectAtIndex:j] floatValue]){
                min = [[ar objectAtIndex:j] floatValue];
                vtmin = j;
            }
        }
        if(arrSize.count==i){
            [arrSize addObject:[NSValue valueWithCGRect:CGRectMake((spaceView + widthColumn)*vtmin + spaceView, [[ar objectAtIndex:vtmin] floatValue], widthColumn, defaultHeight)]];
            [ar replaceObjectAtIndex:vtmin withObject:[NSNumber numberWithFloat:[[ar objectAtIndex:vtmin] floatValue]+defaultHeight+spaceView]];
        }else{
            CGRect frame = [[arrSize objectAtIndex:i] CGRectValue];
            frame.origin.x=(spaceView + widthColumn)*vtmin + spaceView;
            frame.origin.y=[[ar objectAtIndex:vtmin] floatValue];
            [arrSize replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:frame]];
            [ar replaceObjectAtIndex:vtmin withObject:[NSNumber numberWithFloat:[[ar objectAtIndex:vtmin] floatValue]+[[arrSize objectAtIndex:i] CGRectValue].size.height+spaceView]];
        }
    }
    float max = 0;
    for(int i=0;i<ar.count;i++){
        float vl = [[ar objectAtIndex:i] floatValue];
        if(vl>max){
            max = vl;
        }
    }
    self.contentSize = CGSizeMake(self.frame.size.width, max);
}

-(BOOL)soSanh:(CGFloat)a :(CGFloat)b{
    return floor(a)==floor(b);
}

-(void)loadView{
    NSArray *indes = [self getIndexs];
    for(int vtn = 0; vtn<indes.count;vtn++){
        if(vtn>=indes.count)break;
        NSNumber *num = [indes objectAtIndex:vtn];
        UIView *v = nil;
        CGRect frame = [[arrSize objectAtIndex:[num integerValue]] CGRectValue];
        if(arrView.count==vtn){
            v = [self.datasourceTvd viewGallery:self atIndex:[num integerValue] reUsingView:nil];
            [arrView addObject:v];
        }else{
            v = [arrView objectAtIndex:vtn];
            v.hidden=NO;
            if(v.tag!=[num integerValue]){
                v = [self.datasourceTvd viewGallery:self atIndex:[num integerValue] reUsingView:v];
            }
        }
        if(v){
            [v setFrame:frame];
            [self addSubview:v];
            v.tag = [num integerValue];
        }
    }
    oldy=self.contentOffset.y;
}

-(NSArray*)getIndexs{
    NSMutableArray *arr = [NSMutableArray new];
    CGRect inFrame = CGRectMake(0, self.contentOffset.y-self.frame.size.height/2, self.frame.size.width, self.frame.size.height*2);
    if(inFrame.origin.y<0){
        inFrame.origin.y = 0;
    }
    for(int i=0;i<arrSize.count;i++){
        CGRect frame = [[arrSize objectAtIndex:i] CGRectValue];
        if(inFrame.origin.y<frame.origin.y+frame.size.height && inFrame.origin.y+inFrame.size.height>frame.origin.y){
            [arr addObject:[NSNumber numberWithInt:i]];
        }
    }
    return arr;
}

-(void)setSize:(CGSize)size forIndex:(NSInteger)index{
    CGRect fr = [[arrSize objectAtIndex:index] CGRectValue];
    fr.size.height = size.height*widthColumn/size.width;
    CGRect frameOld = [[arrSize objectAtIndex:index] CGRectValue];
    if(round(fr.size.height)==round(frameOld.size.height))return;
    [arrSize replaceObjectAtIndex:index withObject:[NSValue valueWithCGRect:fr]];
    [self reSize];
    [self performSelector:@selector(loadView) withObject:nil afterDelay:0.1 inModes:@[NSRunLoopCommonModes]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(fabs(self.contentOffset.y-oldy)>=self.frame.size.height/5){
        [self loadView];
    }
}

@end
