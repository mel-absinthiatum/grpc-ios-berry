#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <BerryGrpcClient/Greenberry.pbrpc.h>
#import <BerryGrpcClient/Greenberry.pbobjc.h>
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriter+Immediate.h>


@implementation BRRGreenberry

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

// Designated initializer
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [super initWithHost:host
                 packageName:@"greenberry"
                 serviceName:@"Greenberry"
                 callOptions:callOptions];
}

- (instancetype)initWithHost:(NSString *)host {
  return [super initWithHost:host
                 packageName:@"greenberry"
                 serviceName:@"Greenberry"];
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

#pragma mark call(GreenberryRequest) returns (GreenberryReply)

- (void)callWithRequest:(BRRGreenberryRequest *)request handler:(void(^)(BRRGreenberryReply *_Nullable response, NSError *_Nullable error))handler{
  [[self RPCTocallWithRequest:request handler:handler] start];
}
// Returns a not-yet-started RPC object.
- (GRPCProtoCall *)RPCTocallWithRequest:(BRRGreenberryRequest *)request handler:(void(^)(BRRGreenberryReply *_Nullable response, NSError *_Nullable error))handler{
  return [self RPCToMethod:@"call"
            requestsWriter:[GRXWriter writerWithValue:request]
             responseClass:[BRRGreenberryReply class]
        responsesWriteable:[GRXWriteable writeableWithSingleHandler:handler]];
}
- (GRPCUnaryProtoCall *)callWithMessage:(BRRGreenberryRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions {
  return [self RPCToMethod:@"call"
                   message:message
           responseHandler:handler
               callOptions:callOptions
             responseClass:[BRRGreenberryReply class]];
}

@end
#endif
