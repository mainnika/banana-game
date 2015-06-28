/**
 * Created by mainn_000 on 6/28/2015.
 */
package physics
{
import Box2D.Dynamics.Contacts.b2Contact;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2ContactListener;
import Box2D.Dynamics.b2Fixture;

import org.osflash.signals.Signal;

public class CollideSensor extends b2ContactListener
{
	private var _ground:Signal;

	public function CollideSensor()
	{
		this._ground = new Signal(b2Body, Boolean);
	}

	private function contactDispatcher(self:int, other:b2Fixture, isBegin:Boolean):void
	{
		switch (self)
		{
			case WorldBody.CATEGORY_GROUND:
				this._ground.dispatch(other.GetBody(), isBegin);
				break;
		}
	}

	private function handleContact(contact:b2Contact, isBegin:Boolean):void
	{
		contactDispatcher(contact.GetFixtureA().GetFilterData().categoryBits, contact.GetFixtureB(), isBegin);
		contactDispatcher(contact.GetFixtureB().GetFilterData().categoryBits, contact.GetFixtureA(), isBegin);
	}

	override public function BeginContact(contact:b2Contact):void
	{
		this.handleContact(contact, true);
	}

	override public function EndContact(contact:b2Contact):void
	{
		this.handleContact(contact, false);
	}

	public function get ground():Signal
	{
		return this._ground;
	}
}
}
