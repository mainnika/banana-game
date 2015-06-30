/**
 * Created by mainn_000 on 6/25/2015.
 */
package physics
{
import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Collision.Shapes.b2MassData;
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.Joints.b2RevoluteJointDef;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2FixtureDef;

import org.osflash.signals.Signal;

import physics.$.ISteppable;

public class HeroBody implements ISteppable
{

	private static const HERO_RADIUS:Number = 10 / WorldBody.PHYS_SCALE;

	private static const HERO_DEFENITION:b2BodyDef = new b2BodyDef();
	{
		HERO_DEFENITION.type = b2Body.b2_dynamicBody;
	}

	private static const FOOTS_DEFENITION:b2BodyDef = new b2BodyDef();
	{
		FOOTS_DEFENITION.type = b2Body.b2_dynamicBody;
	}

	private static const HERO_SHAPE:b2PolygonShape = new b2PolygonShape();
	{
		HERO_SHAPE.SetAsBox(HERO_RADIUS, HERO_RADIUS * 4);
	}

	private static const FOOTS_SHAPE:b2CircleShape = new b2CircleShape(HERO_RADIUS);

	private static const HERO_FIXTURE:b2FixtureDef = new b2FixtureDef();
	{
		HERO_FIXTURE.shape = HERO_SHAPE;
		HERO_FIXTURE.friction = 2;
		HERO_FIXTURE.restitution = 0;
		HERO_FIXTURE.filter.categoryBits = WorldBody.CATEGORY_HERO;
		HERO_FIXTURE.filter.maskBits = WorldBody.CATEGORY_GROUND | WorldBody.CATEGORY_HERO;
	}

	private static const FOOTS_FIXTURE:b2FixtureDef = new b2FixtureDef();
	{
		FOOTS_FIXTURE.shape = FOOTS_SHAPE;
		FOOTS_FIXTURE.isSensor = true;
		FOOTS_FIXTURE.filter.categoryBits = WorldBody.CATEGORY_FOOTS;
		FOOTS_FIXTURE.filter.maskBits = WorldBody.CATEGORY_GROUND | WorldBody.CATEGORY_HERO;
	}

	public static const INPUT_RIGHT:int = 0;
	public static const INPUT_LEFT:int = 1;
	private static const INPUT_MAX:int = 2;

	private var _body:b2Body;
	private var _foots:b2Body;
	private var _inputs:Vector.<Boolean>;
	private var _groundContacts:int;
	private var _lastInput:int;

	private var _signals:Object = {
		die: new Signal()
	};

	public function HeroBody(world:WorldBody)
	{
		this._body = world.body.CreateBody(HERO_DEFENITION);
		this._body.CreateFixture(HERO_FIXTURE);

		this._foots = world.body.CreateBody(FOOTS_DEFENITION);
		this._foots.CreateFixture(FOOTS_FIXTURE);

		this._inputs = new Vector.<Boolean>(INPUT_MAX);

		this._groundContacts = 0;

		var joint:b2RevoluteJointDef = new b2RevoluteJointDef();
		joint.bodyA = this._body;
		joint.bodyB = this._foots;
		joint.localAnchorA = this.getFootPoint();
		joint.localAnchorB = this._foots.GetLocalCenter();
		joint.collideConnected = false;

		world.body.CreateJoint(joint);

		world.sensor.ground.add(this.groundContact);
		world.sensor.hero.add(this.groundContact);

		var massData:b2MassData = new b2MassData();

		this._body.GetMassData(massData);

		massData.center = this.getFootPoint();
		massData.mass = 4;
		massData.I = 8;

		this._body.SetMassData(massData);
	}

	private function groundContact(body:b2Body, isBegin:Boolean):void
	{
		if (this._foots == body)
		{
			trace("GROUND CONTACT");
			if (isBegin)
			{
				this._groundContacts++;
			}
			else
			{
				this._groundContacts = Math.max(0, this._groundContacts - 1);
			}
		}
	}

	private function getFootPoint():b2Vec2
	{
		var point:b2Vec2 = this._body.GetLocalCenter().Copy();
		point.y = HERO_RADIUS * 4;

		return point;
	}

	public function resetVelocity():void
	{
		this._body.SetLinearVelocity(new b2Vec2(0, 0));
	}

	public function resetAngle():void
	{
		this._body.SetAngle(0);
	}

	public function setPosition(x:int, y:int):void
	{
		this._body.SetPosition(new b2Vec2(x / WorldBody.PHYS_SCALE, y / WorldBody.PHYS_SCALE));
		this._foots.SetPosition(this._body.GetPosition());
	}

	public function checkDie():void
	{
		if (this.y > 600)
		{
			this._signals.die.dispatch();
		}
	}

	public function get x():Number
	{
		return this._body.GetPosition().x * WorldBody.PHYS_SCALE;
	}

	public function get y():Number
	{
		return this._body.GetPosition().y * WorldBody.PHYS_SCALE;
	}

	public function get angle():Number
	{
		return this._body.GetAngle();
	}

	public function get jumping():Boolean
	{
		return this._groundContacts == 0;
	}

	public function get moving():Boolean
	{
		if (this._groundContacts == 0)
			return false;

		var speed:b2Vec2 = this._body.GetLinearVelocity();

		return speed.x > 0.1 || speed.x < -0.1;
	}

	public function get rightward():Boolean
	{
		return this._lastInput == INPUT_RIGHT;
	}

	public function get signals():Object
	{
		return this._signals;
	}

	public function jump():void
	{
		if (this._groundContacts == 0)
			return;

		var force:Number = 50;
		var angle:Number = this.angle;

		var impulse:b2Vec2 = new b2Vec2(Math.sin(angle) * force, -Math.cos(angle) * force);
		var point:b2Vec2 = this._body.GetWorldCenter();

		this._body.ApplyImpulse(impulse, point);
	}

	public function set_input(input:int, active:Boolean):void
	{
		this._inputs[input] = active;
	}

	public function step():void
	{
		this.checkDie();

		if (this._groundContacts == 0)
			return;

		var hasInput:Boolean = this._inputs[INPUT_RIGHT] || this._inputs[INPUT_LEFT];

		if (!hasInput)
			return;

		var force:Number = 3;
		var forceLimit:Number = force * 3;

		var impulse:b2Vec2 = this._body.GetLinearVelocity();

		if (this._inputs[INPUT_LEFT])
		{
			impulse.x -= Math.max(force, impulse.x);
			this._lastInput = INPUT_LEFT;
		}

		if (this._inputs[INPUT_RIGHT])
		{
			impulse.x += Math.max(force, impulse.x);
			this._lastInput = INPUT_RIGHT;
		}

		impulse.x = Math.max(impulse.x, -forceLimit);
		impulse.x = Math.min(impulse.x, forceLimit);


		this._body.SetLinearVelocity(impulse);
	}
}
}
