package {
	import classes.*;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.*;
	

	[SWF(width="1024", height = "658", backgroundColor = "0xFFFFFF", frameRate = "24")]
	
	public class uVoluion extends Sprite
	{
		private var main:Main_bg_blue = new Main_bg_blue;
		private var headbar:Main_Disp_upperbar = new Main_Disp_upperbar;
		private var bottombar:Main_Disp_lowerbar = new Main_Disp_lowerbar;
		private var map:Main_bg_map = new Main_bg_map;
		private var logo:Main_logo_jon_1 = new Main_logo_jon_1;
		private var oDot:DotGeneration = new DotGeneration();
		
		public function uVoluion():void
		{
			
			
			this.graphics.lineStyle(1, 0x000000, 1);
			
		
            for (var i:int = 1; i < 60; i++)
            {
                this.graphics.moveTo(i * 16 - 0.5, 0);
                this.graphics.lineTo(i * 16 - 0.5, 658);
            }
            for (i = 1; i < 64; i++)
            {
                this.graphics.moveTo(0, i * 16 - 0.5);
                this.graphics.lineTo(1024, i * 16 - 0.5);
            }
			
			headbar.x = 0;
			headbar.y = 0;
			this.addChild(headbar);
			
			map.x = 0;
			map.y = 5*16;
			map.addEventListener(MouseEvent.CLICK, generator);
			main.addChild(map);
			
			bottombar.x = 0;
			bottombar.y = 39*16;
			this.addChild(bottombar);
			
			logo.x = (logo.width * 0.25) + 2*16;
			logo.y = 2*16;
			logo.width *= 0.5;
			logo.height *= 0.5;
			headbar.addChild(logo);
			
			
			
			main.x = 0;
			main.y = 0;
			main.alpha = 0.75;
			this.addChild(main);
			
            //this.addChild(new ScreenTest);
            this.addChild(new Slider);
            
            
            this.addChild(new DotGeneration);
		}
		public function generator(e:MouseEvent):void
		{
			oDot.generate();
			map.addChild(oDot);
			trace("generate function");
		}
	}
}
