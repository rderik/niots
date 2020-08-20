import NIO

final class VowelsHandler: ChannelInboundHandler {
    public typealias InboundIn = [CChar]
    public typealias InboundOut = ByteBuffer

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let inBuff = self.unwrapInboundIn(data)
        let str = String(cString: inBuff)

        let vowels: [Character] = ["a","e","i","o","u", "A", "E", "I", "O", "U"]
        let result = String(str.map { return vowels.contains($0) ? Character("*") : $0 })
        
        var buffOut = context.channel.allocator.buffer(capacity: result.count )
        buffOut.writeString(result)

        context.fireChannelRead(self.wrapInboundOut(buffOut))
    }

    public func channelReadComplete(context: ChannelHandlerContext) {
        context.flush()
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("error: ", error)

        context.close(promise: nil)
    }
}
