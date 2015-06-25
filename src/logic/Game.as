/**
 * Created by mainn_000 on 6/25/2015.
 */
package logic
{
import flash.display.Sprite;
import flash.events.Event;

import physics.WorldBody;

public class Game extends Sprite
{
	private var _world:WorldBody;
	private var _debug:Sprite;

	public function Game()
	{
		this._world = new WorldBody();
		this._debug = new Sprite();

		this._world.enableDebugDraw(this._debug);

		if (this.stage)
			init();
		else
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
	}

	private function init(e:Event = null):void
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
		this.stage.addEventListener(Event.ENTER_FRAME, this.update);

		this.addChild(_debug);
	}

	private function update(e:Event):void
	{
		this._world.step();
	}

	public function createHero():Hero
	{
		var hero:Hero = new Hero(this);

		return hero;
	}

	public function createMap(data:String):void
	{

	}

	public function get world():WorldBody
	{
		return _world;
	}
}
}
