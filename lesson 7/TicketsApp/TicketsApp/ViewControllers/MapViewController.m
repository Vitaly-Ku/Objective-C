//
//  MapViewController.m
//  TicketsApp
//
//  Created by Vit K on 22.11.2020.
//  Copyright © 2020 Vit K. All rights reserved.
//

#import "MapViewController.h"
#import "LocationService.h"
#import "APIManager.h"
#import "PlaceViewController.h"
#import "TicketsViewController.h"
#import "CoreDataHelper.h"


@interface MapViewController () <MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@property (nonatomic, strong) LocationService *locationService;
@property (nonatomic, strong) City *origin;
@property (nonatomic, strong) NSArray *prices;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Карта цен";
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    [[DataManager sharedInstance] loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dataLoadedSuccessfully {
    _locationService = [[LocationService alloc] init];
}

- (void)updateCurrentLocation:(NSNotification *)notification {
    CLLocation *currentLocation = notification.object;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000000, 1000000);
    [_mapView setRegion: region animated: YES];
    
    if (currentLocation) {
        _origin = [[DataManager sharedInstance] cityForLocation:currentLocation];
        if (_origin) {
            [[APIManager sharedInstance] mapPricesFor:_origin withCompletion:^(NSArray *prices) {
                self.prices = prices;
            }];
        }
    }
}

- (void)setPrices:(NSArray *)prices {
    _prices = prices;
    [_mapView removeAnnotations: _mapView.annotations];
    
    for (MapPrice *price in prices) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat:@"%@ (%@)", price.destination.name, price.destination.code];
            annotation.subtitle = [NSString stringWithFormat:@"%ld руб.", (long)price.value];
            annotation.coordinate = price.destination.coordinate;
            [self->_mapView addAnnotation: annotation];
        });
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    static NSString *identifier = @"MarkerIdentifier";
    MKMarkerAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(-5.0, 5.0);
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        }
    annotationView.annotation = annotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:view.annotation.coordinate.latitude longitude:view.annotation.coordinate.longitude];
    City *city = [[DataManager sharedInstance] cityForLocation:location];
    SearchRequest searchRequest;
    searchRequest.destination = city.code;
    searchRequest.origin = _origin.code;
    searchRequest.departDate = [NSDate date];
    searchRequest.returnDate = [NSDate date];
    [[APIManager sharedInstance] ticketsWithRequest:searchRequest withCompletion:^(NSArray *tickets) {
        if (tickets.count > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"destination.code == %@", city.code];
            NSArray *filteredArray = [self->_prices filteredArrayUsingPredicate:predicate];
            id firstFoundObject = nil;
            firstFoundObject =  filteredArray.count > 0 ? filteredArray.firstObject : nil;
            
            predicate = [NSPredicate predicateWithFormat:@"price == %d", ((MapPrice *)  firstFoundObject).value];
            filteredArray = [tickets filteredArrayUsingPredicate:predicate];
            firstFoundObject =  filteredArray.count > 0 ? filteredArray.firstObject : nil;
            
            if (firstFoundObject) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Хотите добавить в избранное?" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *favoriteAction;
                if ([[CoreDataHelper sharedInstance] isFavorite: (Ticket *)firstFoundObject]) {
                    favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        [[CoreDataHelper sharedInstance] removeFromFavorite:(Ticket *)firstFoundObject];
                    }];
                } else {
                    favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[CoreDataHelper sharedInstance] addToFavoriteFromMap:(Ticket *)firstFoundObject];
                    }];
                }
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
                [alertController addAction:favoriteAction];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ошибка!" message:@"Билеты не найдены" preferredStyle: UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}
@end
