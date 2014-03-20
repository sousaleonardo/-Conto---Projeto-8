//
//  Conto.h
//  ProjetoContinuando
//
//  Created by LEONARDO DE SOUSA MENDES on 19/03/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Twitter.h"
@interface Conto : NSObject
{
    NSArray *paths;
    NSString *dirArquivo;
    NSString *nomeArquivo;
}
@property Twitter *twitter;
@property UIAlertView *erro;

-(void)criarConto:(NSString*)titulo :(NSString*)textoConto;
-(NSArray*)lerArquivo;
-(id)init;
-(void)deletarArquivoConfig;
@end
