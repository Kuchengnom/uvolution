package classes
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class ScreenTest extends MovieClip
	{
		private var oUpperBox: MovieClip;
		private var oLowerBox: MovieClip;
		private var oBg: MovieClip;
		private var oMap: MovieClip;
		private var oSpeech: MovieClip;
		private var oTabPreHistorics: MovieClip;
		private var oLogo: MovieClip;
		 
		public function ScreenTest()
		{
			super();
			oUpperBox = new Main_Disp_upperbar;
			oLowerBox = new Main_Disp_lowerbar;
			oBg = new Main_bg_Plain;
			oMap = new Main_bg_map;
			oSpeech = new Main_app_speechbaloon;
			oTabPreHistorics = new Main_Disp_TabsPreHistorics;
			oLogo = new Main_logo_jon_1;
			
			this.addChild(oBg);
			
			oMap.y = 50;
			oMap.x = 20;
			this.addChild(oMap);
			
			oLowerBox.y = 620;
			this.addChild(oLowerBox);
			
			this.addChild(oUpperBox);
			
			oLogo.x = 150;
			oLogo.y = 45;
			oLogo.scaleX = 0.4;
			oLogo.scaleY = 0.4;
			oUpperBox.addChild(oLogo);
			
		}
		
	}
}