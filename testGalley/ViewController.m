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
    NSMutableArray *links;
    __weak IBOutlet TVDGallery *table;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    links = [NSMutableArray new];
    // Do any additional setup after loading the view, typically from a nib.
//    [links addObject:@"http://7-themes.com/data_images/out/60/6976900-earth-landscape-art.jpg"];
    [links addObject:@"http://st.hzcdn.com/fimgs/d3e1af24028a9037_1205-w500-h666-b0-p0--contemporary-landscape.jpg"];
    [links addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
    [links addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
    [links addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
    [links addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
    [links addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
//    [links addObject:@"http://wallarthd.com/wp-content/uploads/2014/12/Landscape-Painting-Wallpaper-HD.jpg"];
//    [links addObject:@"http://7-themes.com/data_images/out/71/7013402-hills-landscape.jpg"];
    [links addObject:@"http://www.wallpaperhdf.com/wp-content/uploads/2016/02/landscape-wallpaper-widescreen.jpg"];
    [links addObject:@"http://largelandscapes.org/static/images/TBynumHomepage.jpg"];
    [links addObject:@"http://images.all-free-download.com/images/graphicthumb/summer_landscape_312434.jpg"];
    [links addObject:@"https://s-media-cache-ak0.pinimg.com/236x/e7/db/e7/e7dbe72acc1942c3275b1af7c30070d9.jpg"];
//    [links addObject:@"http://blog.spoongraphics.co.uk/wp-content/uploads/2015/vector-landscape/vector-landscape.jpg"];
//    [links addObject:@"http://digital-photography-school.com/wp-content/uploads/flickr/4164002933_e787dae9af_o.jpg"];
//    [links addObject:@"http://static.boredpanda.com/blog/wp-content/uuuploads/landscape-photography/landscape-photography-12.jpg"];
//    [links addObject:@"http://st.hzcdn.com/fimgs/9351dd1300226ca7_1944-w500-h666-b0-p0--traditional-landscape.jpg"];
    
    [table reloadData];
    
}

-(CGFloat)spaceForViewGallery:(TVDGallery*)viewTvd{
    return 8;
}

-(NSInteger)numberOfViewOnViewGallery:(TVDGallery*)viewTvd{
    return links.count;
}

-(NSInteger)numberOfColumnOnViewGallery:(TVDGallery*)viewTvd{
    return 2;
}

-(UIView*)viewGallery:(TVDGallery*)viewTvd atIndex:(NSInteger)index reUsingView:(UIView*)view{
    NSLog(@"1111111111111");
    ViewThoiTiet *img;
    if(!view){
        img = [[ViewThoiTiet alloc] init];
        NSLog(@"00000000000");
    }else{
        img = (ViewThoiTiet*)view;
    }
    [img.img setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[links objectAtIndex:index]]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        img.img.image = image;
        [table setSize:image.size forIndex:index];
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        
    }];
    if(index==links.count-1 && links.count<2000){
        [links addObject:@"http://st.hzcdn.com/fimgs/d3e1af24028a9037_1205-w500-h666-b0-p0--contemporary-landscape.jpg"];
        [links addObject:@"https://upload.wikimedia.org/wikipedia/commons/1/18/India_Vietnam_Locator.png"];
        [links addObject:@"http://data.sinhvienit.net/2013/T01/img/SinhVienIT.Net---anh-bia-toi-yeu-viet-nam-co-do-sao-vang-10.jpg"];
        [links addObject:@"https://farm8.staticflickr.com/7424/13950918227_443786981f_o.jpg"];
        [links addObject:@"https://i.ytimg.com/vi/Vs19oNPQQYQ/hqdefault.jpg"];
        [links addObject:@"http://vietnamtourism.gov.vn/english/images/109du-lich-Ha-long.jpg"];
        [links addObject:@"http://www.wallpaperhdf.com/wp-content/uploads/2016/02/landscape-wallpaper-widescreen.jpg"];
        [links addObject:@"http://largelandscapes.org/static/images/TBynumHomepage.jpg"];
        [links addObject:@"http://images.all-free-download.com/images/graphicthumb/summer_landscape_312434.jpg"];
        [links addObject:@"https://s-media-cache-ak0.pinimg.com/236x/e7/db/e7/e7dbe72acc1942c3275b1af7c30070d9.jpg"];
        [table reloadData];
    }
    return img;
}

-(void)viewGallery:(TVDGallery*)viewTvd selectedView:(UIView*)v atPoint:(CGPoint)point andIndex:(NSInteger)index{
    if(point.x>v.frame.size.width-35 && point.y<35){
        NSLog(@"delete at index: %d",index);
    }else{
        NSLog(@"select at index: %d",index);
    }
}

@end
