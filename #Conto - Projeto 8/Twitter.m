//
//  Twitter.m
//  #Conto-Projeto 8
//
//  Created by FELIPE TEOFILO SOUZA SANTOS on 11/03/14.
//  Copyright (c) 2014 FELIPE TEOFILO SOUZA SANTOS. All rights reserved.
//

#import "Twitter.h"


@implementation Twitter


-(id)init{
    
    if (self = [super init]) {
        
        self.conta = [[ACAccountStore alloc]init];
        self.tipoDeConta = [self.conta accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        NSArray *contasConfiguradas = [self.conta accountsWithAccountType:self.tipoDeConta];
        
        self.tweets = [[NSData alloc]init];
        
        if ([contasConfiguradas count] > 0) {
        self.contaDoTwitter = [contasConfiguradas lastObject];
        }
        
    }
    return self;
}

-(void)mandarTweet : (NSString*)textoTweet{
    
    
    [self.conta requestAccessToAccountsWithType:self.tipoDeConta options:nil completion:^(BOOL granted, NSError *error){
        
        if (granted == YES) {
            
            NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/statuses/update.json"];
                
                SLRequest * mensagem = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:[NSDictionary dictionaryWithObject:textoTweet forKey:@"status"]];
                
                [mensagem setAccount:self.contaDoTwitter];
                
                [mensagem performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                 {
                     //show status after done
                     NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
                     NSLog(@"Twiter post status : %@", output);
                 }];
        }
        else{
            // Handle failure to get account access
            NSLog(@"%@", [error localizedDescription]);
            
        }
    }];
}
-(void)pegarImagem :(NSString*)contaDoUsuario :(UIImageView*)imagem{
    
    [self.conta requestAccessToAccountsWithType:self.tipoDeConta options:nil completion:^(BOOL granted, NSError *error){
        
        if (granted == YES) {
            
            NSURL *url = [[NSURL alloc]initWithString:@"https://api.twitter.com/1.1/users/show.json"];
            
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:contaDoUsuario, @"screen_name",nil];
            
            
            SLRequest *pegarImagem = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters: params];
            
            [pegarImagem setAccount:self.contaDoTwitter];
                                      
            [pegarImagem performRequestWithHandler:
             ^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                 if (responseData) {
                     NSDictionary *user =
                     [NSJSONSerialization JSONObjectWithData:responseData
                                                     options:NSJSONReadingAllowFragments
                                                       error:nil];
                     
                     NSString *profileImageUrl = [user objectForKey:@"profile_image_url"];
                     
                     int tamanho = profileImageUrl.length - 11;
                     
                     NSString *urlDaImagem = [NSString stringWithFormat:@"%@%@",[profileImageUrl substringToIndex:tamanho],@".png"];
                     
                     dispatch_async
                     (dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                         
                         NSData *imageData =
                         [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:urlDaImagem]];
                         
                         UIImage *image = [UIImage imageWithData:imageData];
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [imagem setImage:image];
                             
                             NSString *output = [NSString stringWithFormat:@"HTTP response status: %i", [urlResponse statusCode]];
                             NSLog(@"Twiter post status : %@", output);
                         });
                     });
                 }
             }];
            
        }
        else{
            // Handle failure to get account access
            NSLog(@"%@", [error localizedDescription]);
            
        }
    }];
}

-(void)pegarTweetsDaHistoria : (NSString*)hashTag {
    
    [self.conta requestAccessToAccountsWithType:self.tipoDeConta options:nil completion:^(BOOL granted, NSError *error){
        
        if (granted == YES) {
            
            NSURL *url = [[NSURL alloc]initWithString:@"https://stream.twitter.com/1.1/statuses/filter.json"];
            
            NSDictionary *params = [NSDictionary dictionaryWithObject:hashTag forKey:@"track"];
            
            SLRequest *pegarTweets= [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters: params];
            
            [pegarTweets setAccount:self.contaDoTwitter];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                     NSURLConnection * conection = [NSURLConnection connectionWithRequest:[pegarTweets preparedURLRequest]   delegate:self];
                     [conection start];
            });
        }
        else{
            // Handle failure to get account access
            NSLog(@"%@", [error localizedDescription]);
            
        }
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    
    
}

-(void)seguirUser:(NSString *)userName{
    
    [self.conta requestAccessToAccountsWithType:self.tipoDeConta options:nil completion:^(BOOL granted, NSError *error) {
        
        if (granted){
            NSURL *url=[[NSURL alloc]initWithString:@"https://api.twitter.com/1.1/friendships/create.json"];
            NSDictionary *parametros=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:userName,@"true", nil] forKeys:[NSArray arrayWithObjects:@"screen_name",@"follow", nil] ];
            
            SLRequest *follow=[SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:url parameters:parametros];
            
            [follow setAccount:self.contaDoTwitter];
            [follow performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                NSLog(@"%i",[urlResponse statusCode]);
                
            }];        }
    }];
}




@end
