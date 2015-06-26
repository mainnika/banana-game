/**
 * Created by mainn_000 on 6/26/2015.
 */
package network
{
import com.netease.protobuf.Message;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.Socket;
import flash.utils.ByteArray;
import flash.utils.Endian;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getClassLogger;

public class Connection extends Socket
{
	private static var logger:ILogger = getClassLogger(Connection);

	private var _size:int = 0;
	private var _handler:Handler;

	public function Connection(host:String, port:int)
	{
		super(host, port);

		this._handler = new Handler();

		this.endian = Endian.LITTLE_ENDIAN;

		this.addEventListener(ProgressEvent.SOCKET_DATA, this.onData);
		this.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
		this.addEventListener(Event.CONNECT, this.onConnect);
		this.addEventListener(Event.CLOSE, this.onDisconnect);
	}

	private function handleBytes(data:ByteArray):void
	{
		this._handler.handle(data);
	}

	private function onDisconnect(e:Event):void
	{
		logger.info("Disconnected");
	}

	private function onError(e:Event):void
	{
		logger.error("Error");
	}

	private function onConnect(e:Event):void
	{
		logger.info("Connected");
	}

	private function onData(e:Event):void
	{
		while (true)
		{
			if (this._size == 0)
			{
				if (this.bytesAvailable < 4)
				{
					break;
				}

				this._size = this.readUnsignedInt();
			}

			if (this.bytesAvailable < this._size)
				break;

			var data:ByteArray = new ByteArray();

			this.readBytes(data, 0, this._size);
			this.handleBytes(data);

			this._size = 0;
		}
	}

	public function send(id:int, message:Message):void
	{
		var data:ByteArray = new ByteArray();
		var C:Class = Handler.getClass(id);

		(message as C).id = id;
		(message as C).writeTo(data);

		var size:uint = data.length;

		this.writeUnsignedInt(size);
		this.writeBytes(data);
	}

	public function get $():Handler
	{
		return this._handler;
	}
}
}
