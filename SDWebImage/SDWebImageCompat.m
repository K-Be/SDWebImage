//
//  SDWebImageCompat.m
//  SDWebImage
//
//  Created by Olivier Poitrey on 11/12/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "SDWebImageCompat.h"

#if !__has_feature(objc_arc)
#error SDWebImage is ARC only. Either turn on ARC for the project or use -fobjc-arc flag
#endif

inline UIImage *SDScaledImageForKey(NSString *key, UIImage *image)
{
    if ([image.images count] > 0)
    {
        NSMutableArray *scaledImages = [NSMutableArray array];

        for (UIImage *tempImage in image.images) {
            [scaledImages addObject:SDScaledImageForKey(key, tempImage)];
        }

        return [UIImage animatedImageWithImages:scaledImages duration:image.duration];
    }
    else
    {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        {
            CGFloat scale = [UIScreen mainScreen].scale;
           if (scale != image.scale)
           {
              UIImage *scaledImage = [[UIImage alloc] initWithCGImage:image.CGImage scale:scale orientation:image.imageOrientation];
              image = scaledImage;
           }
        }
        return image;
    }
}
