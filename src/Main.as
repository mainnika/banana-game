package
{

import flash.display.Sprite;

import logic.Game;
import logic.Hero;

import network.Connection;

import org.as3commons.logging.api.LOGGER_FACTORY;
import org.as3commons.logging.setup.SimpleTargetSetup;
import org.as3commons.logging.setup.target.TraceTarget;

import starling.core.Starling;

[SWF(frameRate="30", width="800", height="600")]
public class Main extends Sprite
{
	{
		LOGGER_FACTORY.setup = new SimpleTargetSetup(new TraceTarget());
	}

	public function Main()
	{

		var game:Game = new Game();
		this.addChild(game);

		var hero:Hero = game.createHero();
		hero.setPosition(400, 300);

		game.createMap("[[[100,500], [700,500], [700, 550], [100, 550]]]");

		var starling:Starling = new Starling(Animation,stage);
		starling.start();

		//var net:Connection = new Connection("127.0.0.1", 12343);
	}

}
}
