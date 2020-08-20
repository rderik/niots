import NIO

final class ColourHandler: ChannelInboundHandler {
    public typealias InboundIn = ByteBuffer
    public typealias InboundOut = ByteBuffer

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let inBuff = self.unwrapInboundIn(data)
        let str = inBuff.getString(at: 0, length: inBuff.readableBytes) ?? ""

        let result = "\u{1B}[32m\(str)\u{1B}[0m"

        var buff = context.channel.allocator.buffer(capacity: result.count )
        buff.writeString(result)

        context.write(self.wrapInboundOut(buff), promise: nil)
    }
}
