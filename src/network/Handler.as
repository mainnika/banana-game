/**
 * Created by mainn_000 on 6/26/2015.
 */
package network
{
import flash.events.EventDispatcher;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getClassLogger;
import org.osflash.signals.Signal;

import proto.Hello;
import proto.ID;
import proto.Packet;

public class Handler extends EventDispatcher
{
	private static var logger:ILogger = getClassLogger(Connection);

	private static const PACKETS:Dictionary = new Dictionary();
	{
		// To handle packets add their to this dictionary:
		// PACKETS BEGIN:

		PACKETS[ID.HELLO] = Hello;

		// PACKETS END;
	}

	private var signals:Dictionary;

	public function Handler()
	{
		this.signals = new Dictionary();

		for (var id:* in PACKETS)
		{
			this.signals[id] = new Signal(PACKETS[id]);
		}
	}

	public function subscribe(id:int, callback:Function):void
	{
		var signal:Signal = this.signals[id];

		if (!signal)
		{
			logger.error("Message with id {0} doesnt have handler", [id]);
			throw new Error("Message doesnt have handler");
		}

		signal.add(callback);
	}

	public function unsubscribe(id:int, callback:Function):void
	{
		var signal:Signal = this.signals[id];

		if (!signal)
		{
			logger.error("Message with id {0} doesnt have handler", [id]);
			throw new Error("Message doesnt have handler");
		}

		signal.add(callback);
	}

	public function handle(data:ByteArray):void
	{
		var common:Packet = new Packet();
		common.mergeFrom(data);

		var C:Class = PACKETS[common.id];

		if (!C)
		{
			logger.warn("Message with id {0} doesnt have handler", [common.id]);
			return;
		}

		var message:* = new C();
		message.mergeFrom(data);

		this.signals[common.id].dispatch(message);
	}

	public static function getClass(id:int):Class
	{
		var C:Class = PACKETS[id];

		if (!C)
		{
			logger.error("Message with id {0} doesnt have handler", [id]);
			throw new Error("Message doesnt have handler");
		}

		return C;
	}

}
}
