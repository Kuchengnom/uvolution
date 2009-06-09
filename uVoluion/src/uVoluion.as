package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.*;

	[SWF(width="1024", height = "756", backgroundColor = "0xFFFFFF", frameRate = "24")]
	
	public class uVoluion extends Sprite
	{
		public function uVoluion()
		{
			var mcBG:MovieClip = new ScreenTest;
            this.addChild(mcBG);
		}
	}
}
