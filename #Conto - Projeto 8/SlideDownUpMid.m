//
//  SlideDounUpMid.m
//  GestureTest
//
//  Created by LEONARDO DE SOUSA MENDES on 10/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "SlideDownUpMid.h"


@implementation SlideDounUpMid
//Inicia o gesto na parte de baixo da tela no sentido Donw > Up até o meio da tela

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    
    if ([toque locationInView:self.view].y < CGRectGetMaxY(self.view.bounds)-100) {
        //Iniciar na base da tela com margem de 100px
        
        self.state=UIGestureRecognizerStateFailed;
    }else{
        self -> ultimaPosicaoY = [toque locationInView:self.view].y;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    
    
    if ([toque locationInView:self.view].y >= self->ultimaPosicaoY) {
        self.state=UIGestureRecognizerStateFailed;
    }else{
        self->ultimaPosicaoY=[toque locationInView:self.view].y;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    
    if(toque.tapCount==0){
        if ([toque locationInView:self.view].y < CGRectGetMidY(self.view.bounds)-50) {
            self.state=UIGestureRecognizerStateFailed;
        }else if([toque locationInView:self.view].y < (CGRectGetMaxY(self.view.bounds)-50)){
            self.state=UIGestureRecognizerStateRecognized;
        }
    }
}
@end
