//
//  DeleteRandomMessagesSenderItem.m
//  Telegram
//
//  Created by keepcoder on 28.10.14.
//  Copyright (c) 2014 keepcoder. All rights reserved.
//

#import "DeleteRandomMessagesSenderItem.h"

@interface DeleteRandomMessagesSenderItem ()
@property (nonatomic,strong) NSArray *ids;
@end

@implementation DeleteRandomMessagesSenderItem

-(id)initWithConversation:(TL_conversation *)conversation random_ids:(NSArray *)ids {
    if(self = [super initWithConversation:conversation]) {
        _ids = ids;
        
        self.action = [[TGSecretAction alloc] initWithActionId:[MessageSender getFutureMessageId] chat_id:self.params.n_id decryptedData:[self decryptedMessageLayer] senderClass:[self class] layer:self.params.layer];
        
        [self.action save];
        
    }
    
    return self;
}



-(NSData *)decryptedMessageLayer1 {
    return [Secret1__Environment serializeObject:[Secret1_DecryptedMessage decryptedMessageServiceWithRandom_id:@(self.random_id) random_bytes:self.random_bytes action:[Secret1_DecryptedMessageAction decryptedMessageActionDeleteMessagesWithRandom_ids:self.ids]]];
}

-(NSData *)decryptedMessageLayer17 {
    return [Secret17__Environment serializeObject:[Secret17_DecryptedMessageLayer decryptedMessageLayerWithRandom_bytes:self.random_bytes layer:@(17) in_seq_no:@(2*self.params.in_seq_no + [self.params in_x]) out_seq_no:@(2*(self.params.out_seq_no++) + [self.params out_x]) message:[Secret17_DecryptedMessage decryptedMessageServiceWithRandom_id:@(self.random_id) action:[Secret17_DecryptedMessageAction decryptedMessageActionDeleteMessagesWithRandom_ids:self.ids]]]];
}

-(NSData *)decryptedMessageLayer20 {
    return [Secret20__Environment serializeObject:[Secret20_DecryptedMessageLayer decryptedMessageLayerWithRandom_bytes:self.random_bytes layer:@(20) in_seq_no:@(2*self.params.in_seq_no + [self.params in_x]) out_seq_no:@(2*(self.params.out_seq_no++) + [self.params out_x]) message:[Secret20_DecryptedMessage decryptedMessageServiceWithRandom_id:@(self.random_id) action:[Secret20_DecryptedMessageAction decryptedMessageActionDeleteMessagesWithRandom_ids:self.ids]]]];
}

-(NSData *)decryptedMessageLayer23 {
    return [Secret23__Environment serializeObject:[Secret23_DecryptedMessageLayer decryptedMessageLayerWithRandom_bytes:self.random_bytes layer:@(23) in_seq_no:@(2*self.params.in_seq_no + [self.params in_x]) out_seq_no:@(2*(self.params.out_seq_no++) + [self.params out_x]) message:[Secret23_DecryptedMessage decryptedMessageServiceWithRandom_id:@(self.random_id) action:[Secret23_DecryptedMessageAction decryptedMessageActionDeleteMessagesWithRandom_ids:self.ids]]]];
}


-(void)performRequest {
    
    TLAPI_messages_sendEncryptedService *request = [TLAPI_messages_sendEncryptedService createWithPeer:[TL_inputEncryptedChat createWithChat_id:self.action.chat_id access_hash:self.action.params.access_hash] random_id:self.random_id data:[MessageSender getEncrypted:self.action.params messageData:self.action.decryptedData]];
    
    [RPCRequest sendRequest:request successHandler:^(RPCRequest *request, TL_messages_sentEncryptedMessage *response) {
        
        self.state = MessageSendingStateSent;
        
    } errorHandler:^(RPCRequest *request, RpcError *error) {
        self.state = MessageSendingStateSent;
    }];
    
}

@end
