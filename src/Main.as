package {

import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2DebugDraw;
import Box2D.Dynamics.b2FixtureDef;
import Box2D.Dynamics.b2World;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

import helpers.MapCreator;

import logic.Game;
import logic.Hero;

[SWF(frameRate="30", width="800", height="600")]
public class Main extends Sprite {

	public function Main() {

		var game:Game = new Game();
		this.addChild(game);

		var hero:Hero = game.createHero();
		hero.setPosition(400, 300);

		game.createMap("[[[100,500], [700,500], [700, 550], [100, 550]]]");


		MapCreator.parse("[1,2,3,4]");


//		var m_sprite:Sprite=this;
//
//		m_world = new b2World(new b2Vec2(0,10),true);
//		var dbgDraw:b2DebugDraw = new b2DebugDraw();
//		dbgDraw.SetSprite(m_sprite);
//		dbgDraw.SetDrawScale(30.0);
//		dbgDraw.SetFillAlpha(0.3);
//		dbgDraw.SetLineThickness(1.0);
//		dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
//		m_world.SetDebugDraw(dbgDraw);
//
//		var bodydef:b2BodyDef=new b2BodyDef();
//		bodydef.type=b2Body.b2_dynamicBody;
//		var bodyshape:b2CircleShape = new b2CircleShape(1);
//		var fixtdef:b2FixtureDef = new b2FixtureDef();
//		fixtdef.shape=bodyshape;
//
//		var body:b2Body=m_world.CreateBody(bodydef);
//		body.CreateFixture(fixtdef);
//
//		var vxs:Array = [new b2Vec2(0, 0),
//			new b2Vec2(0, -100 / m_physScale),
//			new b2Vec2(200 / m_physScale, 0)];
//		sd.SetAsArray(vxs, vxs.length);
//		fd.density = 0;
//		bd.type = b2Body.b2_staticBody;
//		bd.userData = "ramp";
//		bd.position.Set(0, 360 / m_physScale);
//		b = m_world.CreateBody(bd);
//		b.CreateFixture(fd);
//
//
//		this.stage.addEventListener(Event.ENTER_FRAME, step);

	}

}
}
