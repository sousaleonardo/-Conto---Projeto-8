//
//  Conto.m
//  ProjetoContinuando
//
//  Created by LEONARDO DE SOUSA MENDES on 19/03/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import "Conto.h"

@implementation Conto

-(void)criarConto:(NSString*)titulo :(NSString*)textoConto{
    NSArray *titulosUsados =[self lerArquivo];
    BOOL tituloJaAdd=FALSE;
    
    for (int i=0;i<[titulosUsados count];i++){
        
        if ([[NSString stringWithFormat:@"#%@",titulo]isEqualToString:[titulosUsados objectAtIndex:i]]){
            tituloJaAdd=YES;
            
            [self.erro setTitle:@"Título já usado! D:"];
            [self.erro show];
            
            break;
        }
    }
    
    if (!tituloJaAdd) {
        //Cria as #(hasTag)
        NSString *hasTags=[NSString stringWithFormat:@"  #%@ #Conto",titulo];
        
        //Verifica se não irá ultrapassar a qtde de Caracteres
        NSString *textoPostar=[textoConto stringByAppendingString:hasTags];
        
        if([textoConto length]>140){
            NSLog(@"Texto Muito grande :(");
            [self.erro setTitle:@"Texto Muito Grande! D:"];
            
            [self.erro show];
            
            return;
        }
        
        //Chama método para postar
        [self.twitter mandarTweet:textoPostar];
        
        //Salva no arquivo a #
        [self escreverArquivo:[NSString stringWithFormat:@"#%@",titulo]];
    }
}

-(void)escreverArquivo:(NSString *)texto{
    
    //salva o arquivo
    NSMutableArray *arrayConteudoDinamico=[NSMutableArray arrayWithArray:[self lerArquivo]];
    
    [arrayConteudoDinamico addObject:[NSString stringWithFormat:@"%@",texto]];
    
    NSArray *arquivoEscrever = arrayConteudoDinamico;
    
    BOOL success = [arquivoEscrever writeToFile:self->nomeArquivo atomically:YES];
    NSAssert(success, @"writeToFile failed");
    
}

-(NSArray*)lerArquivo{    
    NSArray *arquivo = [NSArray arrayWithContentsOfFile:self->nomeArquivo];
    
    return arquivo;
}

-(void)deletarArquivoConfig{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:self->nomeArquivo])
    {
        [fileManager removeItemAtPath:self->nomeArquivo error:Nil];
    }
}

-(id)init {
    if (self = [super init]) {
        self->paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self->dirArquivo=[paths objectAtIndex:0];
        self->nomeArquivo=[NSString stringWithFormat:@"%@/ContoData.txt",dirArquivo];
        
        self.twitter = [[Twitter alloc]init];
        self.erro=[[UIAlertView alloc]init];
        [self.erro addButtonWithTitle:@"OK"];
    }
    return self;
}
@end
