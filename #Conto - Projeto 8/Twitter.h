//
//  Twitter.h
//  ProjetoContinuando
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/03/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>



@interface Twitter : NSObject 

@property ACAccountStore *conta;
@property ACAccountType *tipoDeConta;
@property ACAccount *contaDoTwitter;
@property NSData *tweets;

-(void)mandarTweet :(NSString*)textoTweet;
-(void)pegarImagem :(NSString*)contaDoUsuario :(UIImageView*)imagem;
-(id)init;
-(void)pegarTweetsDaHistoria : (NSString*)hashTag;
-(void)seguirUser:(NSString *)userName;

@end
