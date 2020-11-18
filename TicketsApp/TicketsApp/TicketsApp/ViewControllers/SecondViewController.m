//
//  SecondViewController.m
//  AviaTickets
//
//  Created by Владислав Лихачев on 12.10.2020.
//  Copyright © 2020 Vladislav Likhachev. All rights reserved.
//

#import "SecondViewController.h"
#import "NewsArray.h"

@interface SecondViewController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_news count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NewsArticle *currentNews = ((NewsArticle *)_news[indexPath.row]);
    //вместо текста может быть NSNull
    if (currentNews.theDescription != [NSNull null]) {
        cell.titleLabel.text = currentNews.title;
        cell.articleLabel.text = currentNews.theDescription;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

@end

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 80.0)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
        [self.contentView addSubview:_titleLabel];
        
        _articleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0.0, 80.0, [UIScreen mainScreen].bounds.size.width, 150.00)];
        _articleLabel.numberOfLines = 0;
        _articleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_articleLabel];
        
    }
    return self;
}
@end
