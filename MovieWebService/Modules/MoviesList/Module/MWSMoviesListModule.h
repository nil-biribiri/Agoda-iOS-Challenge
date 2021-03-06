//
//  MWSMoviesListModule.h
//  MovieWebService
//
//  Created by testDev on 11/04/2017.
//  Copyright © 2017 Agoda Services Co. Ltd. All rights reserved.
//

#import "MWSModule.h"

@protocol MWSMoviesProvider;

@interface MWSMoviesListModule : MWSModule

+ (MWSModule *)buildWithMoviesProvider:(id<MWSMoviesProvider>)moviesProvider;

@end
