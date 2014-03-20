//
//  ViewController.m
//  #Conto - Projeto 8
//
//  Created by Leonardo de Sousa Mendes on 19/03/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //medidas da tela
        screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
        screenHeight = screenRect.size.height;
        
        //controle de menus
        menuLateralAparece = NO;
        menuSuperiorAparece = NO;
        
        [self iniciaMenuDireita];
        [self iniciaMenuSuperior];
    }
    return self;
}
*/

-(void)viewDidLoad{
    
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(displayGestureForTap2:)];
    
    [[self view]addGestureRecognizer:tap2];
    
    //Cria gesto custom
    SlideDirEsq *slideDirEsq=[[SlideDirEsq alloc]initWithTarget:self action:@selector(displagestureforSlideDirEsq:)];
    
    [[self view]addGestureRecognizer:slideDirEsq];
    
    SlideUpDonwMid *slideUp=[[SlideUpDonwMid alloc]initWithTarget:self action:@selector(displayGestureForSlideDownMid:)];
    
    [[self view]addGestureRecognizer:slideUp];
    
    //medidas da tela
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    //controle de menus
    menuLateralAparece = NO;
    menuSuperiorAparece = NO;
    
    [self iniciaMenuDireita];
    [self iniciaMenuSuperior];
}



-(void)iniciaMenuDireita
{
    /* Alterado para view final
    menuLateral = [[UIView alloc]init];
    [menuLateral setFrame:CGRectMake(screenWidth, 0, screenWidth/2, screenHeight)];
    [menuLateral setBackgroundColor:[UIColor blueColor]];
    
    larguraMenuLateral = menuLateral.frame.size.width;
    
    [menuLateral setAlpha:0.5f];
    [[self view] addSubview:menuLateral];
    */
    self.menuView =[[MenuView alloc]initWithFrame:CGRectMake(screenWidth, 0, screenWidth/2, screenHeight)];
    [self.menuView setBackgroundColor:[UIColor purpleColor]];
    larguraMenuLateral=self.menuView.frame.size.width;
    
    [self.menuView setAlpha:0.5f];
    [self.view addSubview:self.menuView];

}

-(void)iniciaMenuSuperior
{
    alturaMenuSuperior = screenHeight/4;
    
    menuSuperior = [[UIView alloc]init];
    [menuSuperior setFrame:CGRectMake(0, -alturaMenuSuperior, screenWidth, alturaMenuSuperior)];
    [menuSuperior setBackgroundColor:[UIColor blueColor]];
    
    [menuSuperior setAlpha:0.5f];
    [[self view] addSubview:menuSuperior];
}

-(void)mostraMenuDireita:(CALayer *)layer
{
    CGPoint inicio = {screenWidth + screenWidth/2, screenHeight/2};
    CGPoint fim = {screenWidth - larguraMenuLateral/2, screenHeight/2};
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anima.duration = 0.5f;
    anima.removedOnCompletion = YES;
    
    anima.fromValue = @(inicio.x);
    anima.toValue = @(fim.x);
    
    layer.position = fim;
    [layer addAnimation:anima forKey:@"position.x"];
    
    //menu está visivel
    menuLateralAparece = YES;
}

-(void)mostraMenuSuperior:(CALayer *)layer
{
    CGPoint inicio = {0, -alturaMenuSuperior};
    CGPoint fim = {screenWidth/2, alturaMenuSuperior/2};
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    anima.duration = 1;
    anima.removedOnCompletion = YES;
    
    anima.fromValue = @(inicio.y);
    anima.toValue = @(fim.y);
    
    layer.position = fim;
    [layer addAnimation:anima forKey:@"position.y"];
    
    //menu está visivel
    menuSuperiorAparece = YES;
}

-(void)escondeMenuDireita:(CALayer*)layer
{
    CGPoint inicio = {screenWidth + screenWidth/2, screenHeight/2};
    CGPoint fim = {screenWidth - larguraMenuLateral/2, screenHeight/2};
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position.x"];
    anima.duration = 1;
    anima.removedOnCompletion = YES;
    
    anima.fromValue = @(fim.x);
    anima.toValue = @(inicio.x);
    
    layer.position = inicio;
    [layer addAnimation:anima forKey:@"position.x"];
    
    //menu NAO visível
    menuLateralAparece = NO;
}

-(void)escondeMenuSuperior:(CALayer*)layer
{
    CGPoint inicio = {screenWidth/2, -alturaMenuSuperior};
    CGPoint fim = {screenWidth/2, alturaMenuSuperior/2};
    
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    anima.duration = 1;
    anima.removedOnCompletion = YES;
    
    anima.fromValue = @(fim.y);
    anima.toValue = @(inicio.y);
    
    layer.position = inicio;
    [layer addAnimation:anima forKey:@"position.y"];
    
    //menu NAO visível
    menuSuperiorAparece = NO;
}

-(void)displayGestureForTap2:(id*)sender{
    NSLog(@"Tocou ViewController");
    
    if(menuLateralAparece == YES){
        [self escondeMenuDireita:self.menuView.layer];
    }
    if(menuSuperiorAparece == YES){
        [self escondeMenuSuperior:menuSuperior.layer];
    }
}

-(void)displagestureforSlideDirEsq:(id*)sender{
    NSLog(@"esquerda");
    
    if(menuLateralAparece == NO){
        [self mostraMenuDireita:self.menuView.layer];
    }
    
}

-(void)displayGestureForSlideDownMid:(id*)sender{
    NSLog(@"abaixa");
    
    if(menuSuperiorAparece == NO){
        [self mostraMenuSuperior:menuSuperior.layer];
    }
    
}
@end
