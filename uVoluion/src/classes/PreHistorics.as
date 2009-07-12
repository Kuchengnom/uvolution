package classes
{
	import flash.display.MovieClip;
	
	public class PreHistorics extends Field
	{
		public var oMap:MovieClip = new Screen_Map_PreHis;
		
		public function PreHistorics()
		{
			super();
			
			oMap.x = 0;
			oMap.y = 300;
			this.addChild(oMap);
			
			
		}
		
		
		
	}
}