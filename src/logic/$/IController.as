/**
 * Created by mainn_000 on 6/28/2015.
 */
package logic.$
{
import logic.Hero;

import starling.events.KeyboardEvent;

public interface IController
{
	function pairHero(hero:Hero):void;

	function eventDown(e:KeyboardEvent):void;

	function eventUp(e:KeyboardEvent):void;


}
}
