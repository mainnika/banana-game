package
{

import flash.display.Sprite;

import helpers.StaticAssets;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.LOGGER_FACTORY;
import org.as3commons.logging.api.getClassLogger;
import org.as3commons.logging.setup.SimpleTargetSetup;
import org.as3commons.logging.setup.target.TraceTarget;

import starling.core.Starling;
import starling.events.Event;

[SWF(frameRate="30", width="800", height="600")]
public class Main extends Sprite
{
	private static var logger:ILogger = getClassLogger(Main);
	{
		LOGGER_FACTORY.setup = new SimpleTargetSetup(new TraceTarget());
	}

	private var _starling:Starling;

	public function Main()
	{
		logger.info("Init starling");

		this._starling = new Starling(Root, this.stage);
		this._starling.addEventListener(Event.CONTEXT3D_CREATE, this.assets);
		this._starling.showStats = true;
		this._starling.start();
	}

	public function assets():void
	{
		logger.info("Loading assets");
		StaticAssets.complete().add(this.start);
	}

	public function start():void
	{
		logger.info("Creating game");
		(this._starling.root as Root).create();
	}

}
}
