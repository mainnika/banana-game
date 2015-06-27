/**
 * Created by mainn_000 on 6/28/2015.
 */
package helpers
{
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getClassLogger;
import org.osflash.signals.Signal;

import starling.utils.AssetManager;

public class StaticAssets extends AssetManager
{
	private static var logger:ILogger = getClassLogger(StaticAssets);
	private static var _oncomplete:Signal = new Signal();
	private static var _instance:StaticAssets = new StaticAssets();
	{
		_instance.verbose = true;
		_instance.enqueue(EmbeddedAssets);

		_instance.loadQueue(function (ratio:Number):void
		{
			logger.debug("Loading {0}", [ratio]);

			if (ratio == 1)
			{
				_oncomplete.dispatch();
			}
		});
	}

	public static function complete():Signal
	{
		return _oncomplete;
	}

	public static function instance():StaticAssets
	{
		return _instance;
	}
}
}
