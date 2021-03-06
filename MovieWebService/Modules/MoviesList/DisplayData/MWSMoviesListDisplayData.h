//
//  MWSMoviesListDisplayData.h
//  MovieWebService
//
//  Created by Ilya Grechuhin on 30.10.2017.
//  Copyright © 2017 TestCompany. All rights reserved.
//

#import "MWSDisplayData.h"
#import "MWSMoviesListApi.h"

@interface MWSMoviesListDisplayData : MWSDisplayData<MWSMoviesListDisplayDataApi>

@property(copy, nonatomic, readonly) NSString * title;
@property(nonatomic, readonly) UIColor * backgroundColor;

@end
