/**
 * Created by mainn_000 on 27.06.2015.
 */
package {
import starling.animation.DelayedCall;
import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class Animation extends Sprite {
	[Embed(source="../res/atlas.xml", mimeType="application/octet-stream")]
	public static const AtlasXml:Class;

	[Embed(source="../res/atlas.png")]
	public static const AtlasTexture:Class;

	public function Animation() {

		var texture:Texture = Texture.fromEmbeddedAsset(AtlasTexture);
		var xml:XML = XML(new AtlasXml());
		var atlas:TextureAtlas = new TextureAtlas(texture,xml);

		var movie1:MovieClip = new MovieClip(atlas.getTextures("flight_"),10);
		var movie2:MovieClip = new MovieClip(atlas.getTextures("flight_"),10);
		movie1.loop = true;
		addChild(movie1);
		movie2.loop = true;
		movie2.x=100;
		addChild(movie2);


		var delayedCall:DelayedCall = new DelayedCall(method, 0.1);
		delayedCall.repeatCount = int.MAX_VALUE;
		Starling.juggler.add(delayedCall);

		function method():void
		{
			movie2.x+=5;
		}

		movie1.play();
		movie2.play();
		//movie.pause();
		//movie.stop();

		Starling.juggler.add(movie1);
		Starling.juggler.add(movie2);
		Starling.current.showStats = true;
	}
}
}
