//
//  MenuView.m
//  #Conto - Projeto 8
//
//  Created by Leonardo de Sousa Mendes on 20/03/14.
//  Copyright (c) 2014 Leonardo de Sousa Mendes. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:[self criarBotao:@"Criar História..." :CGRectMake(20, 50, 50, 50) :self :@selector(criarHistoria)]];
    
        [self addSubview:[self criarBotao:@"Todas as Histórias ..." :CGRectMake(20, 100, 50, 50) :self :@selector(verHistorias)]];
        
        [self addSubview:[self criarBotao:@"Esqueci ..." :CGRectMake(20, 150, 50, 50) :self :@selector(esqueci)]];
        
        [self setBackgroundColor:[UIColor purpleColor]];
    }
    
    return self;
}

-(UIButton*)criarBotao:(NSString*)titulo :(CGRect)frame :(id)target :(SEL)seletor{
    
    UIButton *botao=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    //Configura botão
    [botao setTitle:titulo forState:UIControlStateNormal];
    [botao setFrame:frame];
    [botao setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [botao sizeToFit];
    
    if (target!=nil && seletor !=nil) {
        [botao addTarget:target action:seletor forControlEvents:UIControlEventTouchUpInside];
    }
    
    return botao;
}

-(void)criarHistoria{
    NSLog(@"Apertou no 1 botão");

}

-(void)verHistorias{
    NSLog(@"Apertou no 2 botão");
}

-(void)esqueci{
    NSLog(@"Apertou no 3 botão");
}
@end
