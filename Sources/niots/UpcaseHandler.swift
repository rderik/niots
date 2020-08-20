import NIO

final class UpcaseHandler: ChannelInboundHandler {
    public typealias InboundIn = ByteBuffer
    public typealias InboundOut = [CChar]

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let inBuff = self.unwrapInboundIn(data)
        let str = inBuff.getString(at: 0, length: inBuff.readableBytes)

        let result = str?.uppercased() ?? ""

        let cresult = result.cString(using: .utf8) ?? [] 
        context.fireChannelRead(self.wrapInboundOut(cresult))
    }
}
