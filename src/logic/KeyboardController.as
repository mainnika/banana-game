/**
 * Created by mainn_000 on 6/28/2015.
 */
package logic
{
import logic.$.IControllable;
import logic.$.IController;

import starling.display.Sprite;
import starling.events.KeyboardEvent;

public class KeyboardController implements IController
{
	private var _hero:IControllable;

	public function KeyboardController(listener:Sprite)
	{
		listener.addEventListener(KeyboardEvent.KEY_DOWN, this.eventDown);
		listener.addEventListener(KeyboardEvent.KEY_UP, this.eventUp);
	}

	public function pairHero(hero:Hero):void
	{
		if (this._hero)
		{
			this._hero.removeController();
		}

		this._hero = hero;
		this._hero.attachController(this);
	}

	public function eventDown(e:KeyboardEvent):void
	{
		var key:int = e.keyCode;

		switch (key)
		{
			case 87:
				this._hero.up(true);
				break;
			case 68:
				this._hero.right(true);
				break;
			case 65:
				this._hero.left(true);
				break;
		}
	}

	public function eventUp(e:KeyboardEvent):void
	{
		var key:int = e.keyCode;

		switch (key)
		{
			case 68:
				this._hero.right(false);
				break;
			case 65:
				this._hero.left(false);
				break;
		}
	}
}
}
