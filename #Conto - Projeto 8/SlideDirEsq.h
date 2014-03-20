//
//  SlideDirEsq.h
//  GestureTest
//
//  Created by LEONARDO DE SOUSA MENDES on 10/03/14.
//  Copyright (c) 2014 LEONARDO DE SOUSA MENDES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface SlideDirEsq : UIGestureRecognizer
//Toque iniciado na borda direita seguindo sentido Dir > Esq no mesmo eixo Y.
{
    CGPoint ultimaPosicao;
}
@end
