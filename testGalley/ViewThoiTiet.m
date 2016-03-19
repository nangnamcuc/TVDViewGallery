//
//  ViewThoiTiet.m
//  ThoiTietVI
//
//  Created by Tạ Đại on 10/03/2016.
//  Copyright © 2016 Tạ Đại. All rights reserved.
//

#import "ViewThoiTiet.h"

@implementation ViewThoiTiet

-(id)init{
    self = [(NSArray *)[[NSBundle mainBundle] loadNibNamed:@"ViewThoiTiet" owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

-(id)initWithDevice:(NSString*)dv{
    self = [(NSArray *)[[NSBundle mainBundle] loadNibNamed:dv owner:self options:nil] objectAtIndex:0];
    if (self) {
        
    }
    return self;
}

- (IBAction)chonngayPress:(id)sender {
    if(self.delegate){
        [self.delegate selectThoiTiet:self];
    }
}

@end
