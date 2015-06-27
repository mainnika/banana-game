/**
 * Created by mainn_000 on 27.06.2015.
 */
package graphic
{
import starling.core.Starling;
import starling.display.MovieClip;
import starling.textures.Texture;

public class Animation extends MovieClip
{
	public static const FPS:int = 12;

	public function Animation(textures:Vector.<Texture>)
	{
		super(textures, FPS);
		this.loop = true;
		this.play();

		this.pivotX = this.width / 2;
		this.pivotY = this.height;

		Starling.juggler.add(this);
	}
}
}
