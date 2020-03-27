#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#import <BerryGrpcClient/Streaming.pbobjc.h>
#endif

#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
#import <ProtoRPC/ProtoService.h>
#import <ProtoRPC/ProtoRPCLegacy.h>
#import <RxLibrary/GRXWriteable.h>
#import <RxLibrary/GRXWriter.h>
#endif

@class STMFetchRequest;
@class STMItem;
@class STMStoreReply;

#if !defined(GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO) || !GPB_GRPC_FORWARD_DECLARE_MESSAGE_PROTO
#endif

@class GRPCUnaryProtoCall;
@class GRPCStreamingProtoCall;
@class GRPCCallOptions;
@protocol GRPCProtoResponseHandler;
@class GRPCProtoCall;


NS_ASSUME_NONNULL_BEGIN

@protocol STMRepository2 <NSObject>

#pragma mark store(stream Item) returns (StoreReply)

/**
 * client-side streaming RPC
 */
- (GRPCStreamingProtoCall *)storeWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark fetch(FetchRequest) returns (stream Item)

/**
 * server-side streaming RPC
 */
- (GRPCUnaryProtoCall *)fetchWithMessage:(STMFetchRequest *)message responseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

#pragma mark storeAndFetch(stream Item) returns (stream Item)

/**
 * bidirectional streaming RPC
 */
- (GRPCStreamingProtoCall *)storeAndFetchWithResponseHandler:(id<GRPCProtoResponseHandler>)handler callOptions:(GRPCCallOptions *_Nullable)callOptions;

@end

/**
 * The methods in this protocol belong to a set of old APIs that have been deprecated. They do not
 * recognize call options provided in the initializer. Using the v2 protocol is recommended.
 */
@protocol STMRepository <NSObject>

#pragma mark store(stream Item) returns (StoreReply)

/**
 * client-side streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)storeWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(STMStoreReply *_Nullable response, NSError *_Nullable error))handler;

/**
 * client-side streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCTostoreWithRequestsWriter:(GRXWriter *)requestWriter handler:(void(^)(STMStoreReply *_Nullable response, NSError *_Nullable error))handler;


#pragma mark fetch(FetchRequest) returns (stream Item)

/**
 * server-side streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)fetchWithRequest:(STMFetchRequest *)request eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * server-side streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCTofetchWithRequest:(STMFetchRequest *)request eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler;


#pragma mark storeAndFetch(stream Item) returns (stream Item)

/**
 * bidirectional streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (void)storeAndFetchWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler;

/**
 * bidirectional streaming RPC
 *
 * This method belongs to a set of APIs that have been deprecated. Using the v2 API is recommended.
 */
- (GRPCProtoCall *)RPCTostoreAndFetchWithRequestsWriter:(GRXWriter *)requestWriter eventHandler:(void(^)(BOOL done, STMItem *_Nullable response, NSError *_Nullable error))eventHandler;


@end


#if !defined(GPB_GRPC_PROTOCOL_ONLY) || !GPB_GRPC_PROTOCOL_ONLY
/**
 * Basic service implementation, over gRPC, that only does
 * marshalling and parsing.
 */
@interface STMRepository : GRPCProtoService<STMRepository2, STMRepository>
- (instancetype)initWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions NS_DESIGNATED_INITIALIZER;
+ (instancetype)serviceWithHost:(NSString *)host callOptions:(GRPCCallOptions *_Nullable)callOptions;
// The following methods belong to a set of old APIs that have been deprecated.
- (instancetype)initWithHost:(NSString *)host;
+ (instancetype)serviceWithHost:(NSString *)host;
@end
#endif

NS_ASSUME_NONNULL_END

