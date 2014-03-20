//
//  SlideDirEsq.m
//  GestureTest
//
//  Created by LEONARDO DE SOUSA MENDES on 10/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import "SlideDirEsq.h"

@implementation SlideDirEsq

-(id)initWithTarget:(id)target action:(SEL)action{
    if(self =[super initWithTarget:target action:action]){
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //Inicio do reconhecimento do toque, irá reconhecer se o toque que o user fez é esse
    UITouch *toque=[touches anyObject];
    

    
    if ([toque locationInView:self.view].x < CGRectGetMaxX(self.view.bounds)-100){
        self.state=UIGestureRecognizerStateFailed;
    }else{
        self->ultimaPosicao=CGPointMake([toque locationInView:self.view].x, [toque locationInView:self.view].y);
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
    
    //impede que o usuario comece o movimento no sentido Dir > Esq e depois mude para Esq > Dir
    if ([toque locationInView:self.view].x >= self->ultimaPosicao.x){
        NSLog(@"Aumentou X erro");
        
        self.state=UIGestureRecognizerStateFailed;
    }else if([toque locationInView:self.view].y >= (self -> ultimaPosicao.y +50) || [toque locationInView:self.view].y <= (self -> ultimaPosicao.y -50)){
        NSLog(@"Aumentou Y erro");
        
        self.state=UIGestureRecognizerStateFailed;
    }else {
        self->ultimaPosicao.x =[toque locationInView:self.view].x;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *toque=[touches anyObject];
   
    if(toque.tapCount==0){
        if([toque locationInView:self.view].x < (CGRectGetMaxX(self.view.bounds)-50)){
            self.state=UIGestureRecognizerStateRecognized;
        }
    }

}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.state=UIGestureRecognizerStateCancelled;
}

@end
