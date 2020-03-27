#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <BerryGrpcClient/Streaming.pbrpc.h>
#import <BerryGrpcClient/Streaming.pbobjc.h>
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriter+Immediate.h>


@implementation STMRepository

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@"streaming"
                 serviceName:@"Repository"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@"streaming"
                 serviceName:@"Repository"];
}

#pragma clang diagnostic pop

// Override superclass initializer to disallow different package and service names.
- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName {
  return [self initWithHost:host];
}

- (instancetype)initWithHost:(NSString *)host
                 packageName:(NSString *)packageName
                 serviceName:(NSString *)serviceName
                 callOptions:(GRPCCallOptions *)callOptions {
  return [self initWithHost:host callOptions:callOptions];
}

#pragma mark - Class Methods

+ (instancetype)serviceWithHost:(NSString *)host {
  return [[self alloc] initWithHost:host];
}

+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [[self alloc] initWithHost:host callOptions:callOptions];
}

#pragma mark - Method Implementations

#pragma mark store(stream Item) returns (StoreReply)

/**
 * client-side streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)storeWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(STMStoreReply *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCTostoreWithRequestsWriter:requestWriter handler:handler] start];
}
// Returns a not-yet-started RPC object.
/**
 * client-side streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCTostoreWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(STMStoreReply *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"store"
            requestsWriter:requestWriter
             responseClass:[STMStoreReply class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
/**
 * client-side streaming RPC
 */
- (GRPCStreamingProtoCall *)storeWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"store"
           responseHandler:handler
               callOptions:callOptions
             responseClass:[STMStoreReply class]];
}

#pragma mark fetch(FetchRequest) returns (stream Item)

/**
 * server-side streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)fetchWithRequest:(STMFetchRequest *)request eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCTofetchWithRequest:request eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * server-side streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCTofetchWithRequest:(STMFetchRequest *)request eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"fetch"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[STMItem class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * server-side streaming RPC
 */
- (GRPCUnaryProtoCall *)fetchWithMessage:(STMFetchRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"fetch"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[STMItem class]];
}

#pragma mark storeAndFetch(stream Item) returns (stream Item)

/**
 * bidirectional streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)storeAndFetchWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler{
  [[self RPCTostoreAndFetchWithRequestsWriter:requestWriter eventHandler:eventHandler] start];
}
// Returns a not-yet-started RPC object.
/**
 * bidirectional streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCTostoreAndFetchWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler{
  return [self RPCToMethod:@"storeAndFetch"
            requestsWriter:requestWriter
             responseClass:[STMItem class]
        responsesWriteable:[GRXWriteable writeableWithEventHandler:eventHandler]];
}
/**
 * bidirectional streaming RPC
 */
- (GRPCStreamingProtoCall *)storeAndFetchWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"storeAndFetch"
           responseHandler:handler
               callOptions:callOptions
             responseClass:[STMItem class]];
}

@end
#endif
