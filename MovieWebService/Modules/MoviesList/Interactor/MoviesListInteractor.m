//
//  MoviesListInteractor.m
//  MovieWebService
//
//  Created by testDev on 11/04/2017.
//  Copyright © 2017 Agoda Services Co. Ltd. All rights reserved.
//

#import "MoviesListInteractor.h"

#import "AppDelegate.h"
#import "MWSFilm.h"
#import "Masonry.h"
#import "MovieWebService-Swift.h"
#import "MoviesListInteractorOutput.h"

@interface MoviesListInteractor ()

@property(nonatomic) UITableView * tableView;
@property(nonatomic) NSArray * films;
@property(nonatomic) UIView * view;

@end

@implementation MoviesListInteractor
{
}

- (void)setViewForSetup:(UIView *)view1
{
  self.view = view1;
  self.tableView = [UITableView new];
  [self.view addSubview:self.tableView];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
}

#pragma mark - MoviesListInteractorInput

- (void)setData:(NSArray *)films1
{
  self.films = films1;
  [self.tableView mas_remakeConstraints:^(MASConstraintMaker * make) {
    make.left.mas_equalTo(self.view);
    make.right.mas_equalTo(self.view);
    make.top.mas_equalTo(self.view);
    make.bottom.mas_equalTo(self.view);
  }];

  [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.films.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString * CellIdentifier = @"CellTableViewCell";
  CellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil)
  {
    cell = [[[NSBundle mainBundle] loadNibNamed:@"CellTableViewCell" owner:self options:nil]
        firstObject];
    // cell = self.movieCell;
    // self.movieCell = nil;
  }
  MWSFilm * film = [self.films objectAtIndex:indexPath.row];
  cell.name.text = film.name;

  NSCalendar * cal = [NSCalendar new];
  NSString * dateText;
  NSDateFormatter * f = [[NSDateFormatter alloc] init];
  [f setCalendar:cal];
  dateText = [f stringFromDate:film.releaseDate];

  cell.date.text = dateText;

  NSString * filmRatingText;
  switch (film.mpaa)
  {
  case MWSMpaaG: filmRatingText = @"G"; break;
  case MWSMpaaPG: filmRatingText = @"PG"; break;
  case MWSMpaaPG13: filmRatingText = @"PG13"; break;
  case MWSMpaaR: filmRatingText = @"R"; break;
  case MWSMpaaNC17: filmRatingText = @"NC17"; break;
  default: break;
  }
  cell.filmRating.text = filmRatingText;
  cell.rating.text = [[NSNumber numberWithFloat:film.imdbRating] stringValue];

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  AppDelegate * appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  MWSFilm * film = [self.films objectAtIndex:indexPath.row];
  DetailsModuleBuilder * builder = [DetailsModuleBuilder new];
  [appDelegate.navigationController pushViewController:[builder buildWith:film] animated:YES];
}

@end
