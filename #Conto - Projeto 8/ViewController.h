//
//  ViewController.h
//  #Conto - Projeto 8
//
//  Created by Leonardo de Sousa Mendes on 19/03/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideDirEsq.h"
#import "SlideDownUpMid.h"
#import "SlideUpDonwMid.h"
#import "MenuView.h"

@interface ViewController : UIViewController
{
    CGRect screenRect; //'bounds' da tela
    CGFloat screenWidth; //largura da tela inteira
    CGFloat screenHeight;   //altura da tela inteira
    
    UIView *menuLateral; //View do menuLateral
    UIView *menuSuperior; //View do menuSuperior
    CGFloat larguraMenuLateral; //largura do menuLateral
    CGFloat alturaMenuSuperior; //largura do menuSuperior
    
    bool menuLateralAparece;
    bool menuSuperiorAparece;
}

@property UIView *menuView;

@property (weak, nonatomic) IBOutlet UIButton *botaoTeste;

-(IBAction)testar:(id)sender;
-(IBAction)apagarArquivoConfig:(id)sender;
@end
