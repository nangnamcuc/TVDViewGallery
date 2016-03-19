//
//  TVDViewGallery.m
//  Wallpapers
//
//  Created by Tạ Đại on 17/03/2016.
//  Copyright © 2016 Tạ Đại. All rights reserved.
//

#import "TVDViewGallery.h"

@implementation TVDViewGallery{
    NSInteger numOfItem, maxOfColumn;
    CGFloat heightCell, spaceView, widthColumn;
    NSMutableArray *arrColumn, *arrWidth;
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
    self.datasourceTvd = (id)self.dataSource;
    self.delegate = self;
    self.dataSource = self;
}

-(void)reloadData{
    if(self.datasourceTvd){
        numOfItem = [self.datasourceTvd numberOfViewOnViewGallery:self];
        maxOfColumn = [self.datasourceTvd numberOfMaxColumnOnViewGallery:self];
        spaceView = [self.datasourceTvd spaceForViewGallery:self];
        heightCell = [self.datasourceTvd heghtForRowViewGallery:self];
        if(!arrColumn){
            arrColumn=[[NSMutableArray alloc] init];
        }
        int i=0;
        for(NSNumber *num in arrColumn){
            i+=[num intValue];
        }
        while (i>=numOfItem) {
            int s = [[arrColumn objectAtIndex:arrColumn.count-1] intValue];
            i-=s;
            [arrColumn removeObjectAtIndex:arrColumn.count-1];
        }
        while (i<numOfItem) {
            int s = arc4random()%maxOfColumn + 1;
            if(s==1){
                if(arc4random()%2!=0){
                    s+=s+(arc4random()%(maxOfColumn - s));
                }
            }
            if(s+i>numOfItem)s = (int)numOfItem-i;
            i+=s;
            [arrColumn addObject:[NSNumber numberWithInt:s]];
        }
        if(!arrWidth){
            arrWidth = [NSMutableArray new];
        }
        for(i=0;i<arrColumn.count;i++){
            if(arrWidth.count<i+1){
                [arrWidth addObject:[NSMutableArray new]];
            }
            NSMutableArray *a = [arrWidth objectAtIndex:i];
            int num = [[arrColumn objectAtIndex:i] intValue];
            for(int j=0;j<num;j++){
                if(a.count<j+1){
                    [a addObject:[NSNumber numberWithFloat:0]];
                }
            }
            while (a.count>num) [a removeObjectAtIndex:a.count-1];
        }
        while (arrWidth.count>arrColumn.count) [arrWidth removeObjectAtIndex:arrWidth.count-1];
    }
    [super reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrColumn.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightCell + spaceView;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int num = [[arrColumn objectAtIndex:indexPath.row] intValue];
    NSString *cellIden = [NSString stringWithFormat:@"cellCount%d",num];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIden];
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = v;
    }
    int si = 0;
    for(int i=0;i<indexPath.row;i++){
        si+=[[arrColumn objectAtIndex:i] intValue];
    }
    float w = (self.frame.size.width-spaceView*(num+1))/num;
    for(int i=0;i<num;i++){
        UIView *v = [cell.contentView viewWithTag:-i-1];
        if(v){
            v=[self.datasourceTvd viewGallery:self atIndex:i+si reUsingView:v];
            UIButton *btn=nil;
            for(UIView *vb in v.subviews){
                if(vb.tag<=-100){
                    btn = (UIButton*)vb;
                    break;
                }
            }
            if(btn){
                btn.tag = -i-si-100;
            }
            [cell.contentView addSubview:v];
        }else{
            v=[self.datasourceTvd viewGallery:self atIndex:i+si reUsingView:nil];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:@"" forState:UIControlStateNormal];
            btn.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
            btn.tag=-i-si-100;
            [v addSubview:btn];
            [btn setFrame:v.bounds];
            [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:v];
            v.frame = CGRectMake(spaceView + (spaceView+w)*i, spaceView, w, heightCell);
        }
        v.tag = -i-1;
    }
    return cell;
}

-(void)chinhSizeAtIndex:(NSNumber*)nunber{
    NSInteger index = [nunber integerValue];
    if(index>=arrColumn.count){
        return;
    }
    int num = [[arrColumn objectAtIndex:index] intValue];
    int dem = 0;
    float tong = 0;
    for(int i=0;i<num;i++){
        float gt = [[[arrWidth objectAtIndex:index] objectAtIndex:i] floatValue];
        if(gt>0){
            tong+=gt;
            dem++;
        }
    }
    float w=self.frame.size.width/num;
    float tl=1;
    if (dem > 0){
        w = tong/dem;
        tong = w*num;
        tl = tong/(self.frame.size.width-(num+1)*spaceView);
    }
    [UIView animateWithDuration:0.2f animations:^{
        UITableViewCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        float vtx = spaceView;
        for(int i=0;i<num;i++){
            UIView *v = [cell.contentView viewWithTag:-i-1];
            if(v){
                float gt = [[[arrWidth objectAtIndex:index] objectAtIndex:i] floatValue];
                if(gt>0){
                    v.frame = CGRectMake(vtx, spaceView, gt/tl, heightCell);
                    vtx = vtx + spaceView + gt/tl;
                }else{
                    v.frame = CGRectMake(vtx, spaceView, w/tl, heightCell);
                    vtx = vtx + spaceView + w/tl;
                }
                [self.delegateTvd viewGallery:self sizeDidchangedOnView:v];
            }
        }
    }];
}

-(void)buttonAction:(UIButton*)btn{
    [self.delegateTvd viewGallery:self selectedAtIndex:-1*btn.tag-100];
}

-(void)setSize:(CGSize)size forIndex:(NSInteger)index{
    float width = size.width/size.height;
    int x = 0;
    int vt = (int)arrColumn.count-1;
    for(int i=0;i<arrColumn.count;i++){
        x+=[[arrColumn objectAtIndex:i] intValue];
        if(index<x){
            vt=i;
            x-=[[arrColumn objectAtIndex:i] intValue];
            break;
        }
    }
    [[arrWidth objectAtIndex:vt] replaceObjectAtIndex:index-x withObject:[NSNumber numberWithDouble:width]];
    [self performSelector:@selector(chinhSizeAtIndex:) withObject:[NSNumber numberWithInt:vt] afterDelay:0.08 inModes:@[NSRunLoopCommonModes]];
}

@end
