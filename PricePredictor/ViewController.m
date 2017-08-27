//
//  ViewController.m
//  PricePredictor
//
//  Created by iwar on 2017/6/7.
//  Copyright © 2017年 iwar. All rights reserved.
//

#import "ViewController.h"
#import <CoreML/CoreML.h>
#import "MarsHabitatPricer.h"
//#import "GoogLeNetPlaces.h"

@interface ViewController ()

@property(nonatomic, strong) MarsHabitatPricer  *model;


@property (weak, nonatomic) IBOutlet UITextField *solarTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *greenhouseTextField;
@property (weak, nonatomic) IBOutlet UITextField *acresTextField;
@property (weak, nonatomic) IBOutlet UILabel *predicationLbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self updatePredictedPrice];
    
    // 我是nb2 branch
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - fun
- (void)updatePredictedPrice{
    
    NSError *error;
    MarsHabitatPricerOutput *marsHabitatPricerOutput = [self.model predictionFromSolarPanels:1.0 greenhouses:1 size:1000 error:&error];
    
    if(error){
        
        NSLog(@"error : %@",error.description);
        
    }else{
        
        double price = marsHabitatPricerOutput.price;
        NSLog(@"price:%.2f",price);
    }
}

- (MarsHabitatPricer *)model{
    
    if(!_model){
        
        _model = [[MarsHabitatPricer alloc] init];
    }
    
    return _model;
    
}
- (IBAction)doPredicateAction:(id)sender {
    
    [self.greenhouseTextField resignFirstResponder];
    [self.acresTextField resignFirstResponder];
    [self.solarTextFiled resignFirstResponder];
    
    double solar = [self.solarTextFiled.text doubleValue];
    double green = [self.greenhouseTextField.text doubleValue];
    double acres = [self.acresTextField.text doubleValue];
    
    NSError *error;
    MarsHabitatPricerOutput *marsHabitatPricerOutput = [self.model predictionFromSolarPanels:solar greenhouses:green size:acres error:&error];
    
    if(error){
        
        NSLog(@"error : %@",error.description);
        
    }else{
        
        double price = marsHabitatPricerOutput.price;
        self.predicationLbl.text = [NSString stringWithFormat:@"预算价格(百万):%.2f",price];
        NSLog(@"price:%.2f",price);
    }
    
}


@end
