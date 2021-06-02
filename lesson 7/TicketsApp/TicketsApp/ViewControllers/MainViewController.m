//
//  ViewController.m
//  TicketsApp
//
//  Created by Vit K on 11.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "MainViewController.h"
#import "DataManager.h"
#import "PlaceViewController.h"
#import "MapViewController.h"
#import "APIManager.h"
#import "TicketsViewController.h"



@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataManager sharedInstance] loadData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Поиск";
    
    _placeContainerView = [[UIView alloc] initWithFrame:CGRectMake(20.0, 140.0, [UIScreen mainScreen].bounds.size.width - 40.0, 170.0)];
    _placeContainerView.backgroundColor = [UIColor whiteColor];
    _placeContainerView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
    _placeContainerView.layer.shadowOffset = CGSizeZero;
    _placeContainerView.layer.shadowRadius = 20.0;
    _placeContainerView.layer.shadowOpacity = 1.0;
    _placeContainerView.layer.cornerRadius = 6.0;
    
    _departureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_departureButton setTitle:NSLocalizedString(@"main_from", @"") forState: UIControlStateNormal];
    _departureButton.tintColor = [UIColor blackColor];
    _departureButton.frame = CGRectMake(10.0, 20.0, _placeContainerView.frame.size.width - 20.0, 60.0);
    _departureButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    _departureButton.layer.cornerRadius = 4.0;
    [_departureButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.placeContainerView addSubview:_departureButton];
    
    _arrivalButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_arrivalButton setTitle:NSLocalizedString(@"main_to", @"") forState: UIControlStateNormal];
    _arrivalButton.tintColor = [UIColor blackColor];
    _arrivalButton.frame = CGRectMake(10.0, CGRectGetMaxY(_departureButton.frame) + 10.0, _placeContainerView.frame.size.width - 20.0, 60.0);
    _arrivalButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    _arrivalButton.layer.cornerRadius = 4.0;
    [_arrivalButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.placeContainerView addSubview:_arrivalButton];
    
    [self.view addSubview:_placeContainerView];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_searchButton setTitle:NSLocalizedString(@"main_search", @"") forState:UIControlStateNormal];
    _searchButton.tintColor = [UIColor whiteColor];
    _searchButton.frame = CGRectMake(30.0, CGRectGetMaxY(_placeContainerView.frame) + 30, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    _searchButton.backgroundColor = [UIColor blackColor];
    _searchButton.layer.cornerRadius = 8.0;
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
    [self.view addSubview:_searchButton];
    [_searchButton addTarget:self action:@selector(searchButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
}

-(void) placeButtonDidTap: (UIButton *) sender {
    PlaceType type;
    if ([sender isEqual:self.arrivalButton]){
        type = PlaceTypeArrival;
    } else {
        type = PlaceTypeDeparture;
    }
    PlaceViewController *controller = [[PlaceViewController alloc] initWithType:type];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)searchButtonDidTap:(UIButton *)sender {
    [[APIManager sharedInstance] ticketsWithRequest:_searchRequest withCompletion:^(NSArray *tickets) {
        if (tickets.count > 0) {
            TicketsViewController *ticketsViewController = [[TicketsViewController alloc] initWithTickets:tickets fromMap:NO];
            [self.navigationController showViewController:ticketsViewController sender:self];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"oh", @"") message:NSLocalizedString(@"oh_message", @"") preferredStyle: UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"close_message", @"") style:(UIAlertActionStyleDefault) handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}

- (void)dataLoadedSuccessfully {
    [[APIManager sharedInstance] cityForCurrentIP:^(City *city) {
        [self setPlace:city withDataType:DataSourceTypeCity andPlaceType:PlaceTypeDeparture forButton:self->_departureButton];
    }];
}

-(void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType {
    UIButton *button;
    switch (placeType) {
        case PlaceTypeArrival:
            button = self.arrivalButton;
            break;
        case PlaceTypeDeparture:
            button = self.departureButton;
            break;
        default:
            break;
    }
    [self setPlace:place withDataType:dataType andPlaceType:placeType forButton: button];
}

-(void)setPlace:(id)place withDataType:(DataSourceType)dataType andPlaceType:(PlaceType)placeType forButton:(UIButton *) button {
    NSString *title;
    NSString *iata;
    
    switch (dataType) {
        case DataSourceTypeCity:{
            City *city = (City *)place;
            title = city.name;
            iata = city.code;
            break;
        }
        case DataSourceTypeAirport: {
            Airport *airport = (Airport *)place;
            title = airport.name;
            iata = airport.cityCode;
            break;
        }
        default:
            break;
    }
    
    switch (placeType) {
        case PlaceTypeArrival:
            _searchRequest.destination = iata;
            break;
        case PlaceTypeDeparture:
            _searchRequest.origin = iata;
            break;
        default:
            break;
    }
    [button setTitle:title forState:UIControlStateNormal];
}

@end
