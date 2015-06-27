/**
 * Created by mainn_000 on 6/25/2015.
 */
package logic
{
import Box2D.Dynamics.b2FixtureDef;

import flash.display.Sprite;

import graphic.RenderableScene;

import helpers.MapCreator;

import physics.GroundBody;
import physics.WorldBody;

import starling.core.Starling;
import starling.events.Event;

public class Game extends RenderableScene
{
	private var _world:WorldBody;
	private var _debug:Sprite;

	public function Game(debug_enabled:Boolean = true)
	{
		this._world = new WorldBody();

		if (debug_enabled)
		{
			this._debug = new Sprite();
			this._world.enableDebugDraw(this._debug);
		}

		if (this.stage)
		{
			init();
		}
		else
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.init);
		}
	}

	private function init(e:Event = null):void
	{
		this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
		this.stage.addEventListener(Event.ENTER_FRAME, this.update);

		if (this._debug)
		{
			Starling.current.nativeOverlay.addChild(this._debug);
		}
	}

	private function update(e:Event):void
	{
		this._world.step();
		this.renderScene();
	}

	public function createHero():Hero
	{
		var hero:Hero = new Hero(this);

		this.addChild(hero);
		this.addRenderableObject(hero);

		return hero;
	}

	public function createMap(data:String):void
	{
		var fixtures_def:Vector.<b2FixtureDef> = MapCreator.parse(data);
		var gb:GroundBody = new GroundBody(_world.body, fixtures_def[0]);

	}

	public function get world():WorldBody
	{
		return _world;
	}
}
}
