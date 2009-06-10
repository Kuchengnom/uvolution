package {
	import flash.display.Sprite;
	import flash.utils.*;
	import classes.ScreenTest;
	import classes.DotGeneration;

	[SWF(width="1024", height = "658", backgroundColor = "0xFFFFFF", frameRate = "24")]
	
	public class uVoluion extends Sprite
	{
		
		public function uVoluion()
		{
            this.addChild(new ScreenTest);
            this.addChild(new DotGeneration);
		}
	}
}
