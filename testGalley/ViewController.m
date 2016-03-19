//
//  ViewController.m
//  testGalley
//
//  Created by Tạ Đại on 18/03/2016.
//  Copyright © 2016 Tạ Đại. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ViewThoiTiet.h"

@interface ViewController ()
{
    NSMutableArray *images;
    __weak IBOutlet TVDViewGallery *table;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    images = [NSMutableArray new];
    // Do any additional setup after loading the view, typically from a nib.
    [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
    [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
    [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
    [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
    [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
    [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
    [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
    [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
    [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
    [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
    [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
    [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
    [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
    [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
    [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
    [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
    [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
    [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
    [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
    [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
    [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
    [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
    [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
    [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
    [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
    [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
    [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
    [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
    [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
    [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
    [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
    [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
    [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
    [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
    [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
    [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)spaceForViewGallery:(TVDViewGallery*)viewTvd{
    return 8;
}
-(CGFloat)heghtForRowViewGallery:(TVDViewGallery*)viewTvd{
    return 200;
}
-(NSInteger)numberOfViewOnViewGallery:(TVDViewGallery*)viewTvd{
    return images.count;
}
-(NSInteger)numberOfMaxColumnOnViewGallery:(TVDViewGallery*)viewTvd{
    return 3;
}
-(UIView*)viewGallery:(TVDViewGallery*)viewTvd atIndex:(NSInteger)index reUsingView:(UIView*)view{
    ViewThoiTiet *img;
    if(!view){
        img = [[ViewThoiTiet alloc] init];
    }else{
        img = (ViewThoiTiet*)view;
    }
    [img.img setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[images objectAtIndex:index]]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        img.img.image = image;
        [table setSize:image.size forIndex:index];
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    if(index==images.count-1 && images.count<200){
        
        [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
        [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
        [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
        [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
        [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
        [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
        [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
        [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
        [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
        [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
        [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
        [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
        [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
        [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
        [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
        [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
        [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
        [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
        [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
        [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
        [images addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
        [images addObject:@"https://vietnamchange.files.wordpress.com/2014/05/image-884.jpg?w=321"];
        [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
        [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
        [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
        [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
        [images addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
        [images addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
        [images addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
        [images addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
        [table reloadData];
    }
    return img;
}

-(void)viewGallery:(TVDViewGallery*)viewTvd selectedAtIndex:(NSInteger)index{
    NSLog(@"%d",index);
}

-(void)viewGallery:(TVDViewGallery*)viewTvd sizeDidchangedOnView:(UIView*)view{
    if(view==nil)return;
    if(![view isKindOfClass:[ViewThoiTiet class]])return;
    ViewThoiTiet *v = (ViewThoiTiet*)view;
    if(v.frame.size.width<=0)return;
    if(v.frame.size.height<=0)return;
    float tlw = v.img.image.size.width/v.frame.size.width;
    float tlh = v.img.image.size.height/v.frame.size.height;
    if(tlw<=0)return;
    if(tlh<=0)return;
    float w = v.img.image.size.width/(tlw>tlh?tlh:tlw);
    float h = v.img.image.size.height/(tlw>tlh?tlh:tlw);
    if(w<=0)return;
    if(h<=0)return;
    v.img.frame = CGRectMake(0, 0, w, h);
    v.img.center = CGPointMake(v.frame.size.width/2, v.frame.size.height/2);
}

@end
