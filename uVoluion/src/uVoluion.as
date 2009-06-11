package {
	import classes.*;
	
	import flash.display.Sprite;
	import flash.utils.*;
	

	[SWF(width="1024", height = "658", backgroundColor = "0xFFFFFF", frameRate = "24")]
	
	public class uVoluion extends Sprite
	{
		private var main:Main_bg_blue = new Main_bg_blue;
		
		public function uVoluion()
		{
			
			main.x = 0;
			main.y = 0;
			this.addChild(main);
			
            this.addChild(new ScreenTest);
            this.addChild(new Slider);
            
            
           // this.addChild(new DotGeneration);
		}
	}
}
