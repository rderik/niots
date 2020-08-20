import Foundation
import NIO

let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
let bootstrap = ServerBootstrap(group: group)
    // Set up our ServerChannel
    .serverChannelOption(ChannelOptions.backlog, value: 256)
    .serverChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)

    //Set up the closure that will be used to initialise Child channels
    // (when a connection is accepted to our server)
    .childChannelInitializer { channel in
        channel.pipeline.addHandlers([BackPressureHandler(), UpcaseHandler(), VowelsHandler(), ColourHandler()])
    }

    // Set up child channel options
    .childChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
    .childChannelOption(ChannelOptions.maxMessagesPerRead, value: 16)
    .childChannelOption(ChannelOptions.recvAllocator, value: AdaptiveRecvByteBufferAllocator())

let defaultHost = "::1"
let defaultPort = 8888


let channel = try bootstrap.bind(host: defaultHost, port: defaultPort).wait()

print("Server started and listening on \(channel.localAddress!)")

try channel.closeFuture.wait()

print("Server closed")
