/*
   worldController class
   Author: Michael Nelson
   Version: 1.0
   Modified: 7/5/09
   Copyright: Michael Nelson
   
   This class controlls all worldTile instances. From here, global
   weather is changed.
*/

class worldController extends Object{
   
   //for the demo, we'll use an 9x16 grid of 40x40 tiles
   
   private var _elevationMap:Array = new Array();
   private var _create:Number;
   private var _member:String;
   private var _reciever:String;
   private var _randomer:Number;
   
   //These three vars should be changed when done to the permanent grid size
   private var _worldHeight:Number;
   private var _worldLength:Number;
   private var _worldCenter:Number;
   
   public function worldController() {
      _worldHeight = 9;
      _worldLength = 16;
      _worldCenter = 4;
      generateWorld();
   }
   
   public function generateWorld(){
      _create = 50;
      //generate world
      for(var i=0; i<9; i++) {
         _elevationMap.push(new Array());
         for(var n=0; n<16; n++) {
            
            _elevationMap[i].push(_create);
            switch(random(2)) {
               case 0 :
                  if(_create != 100){
                     _create += 2;
                  }
                  break;
               case 1 :
                  if(_create != 0){
                     _create -= 2;
                  }
                  break;
            }
         }
      }
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            _reciever = "tile("+n+","+i+")";
   
            _root._mainWindow.main.inside.attachMovie("tile_id", _reciever , _root._mainWindow.main.inside.getNextHighestDepth());
            _root._mainWindow.main.inside[_reciever]._x = ((n+1)*40)-20;
            _root._mainWindow.main.inside[_reciever]._y = ((i+1)*40)-20;
            _root._mainWindow.main.inside[_reciever].setDarkness(_elevationMap[i][n]);
            _root._mainWindow.main.inside[_reciever].elevation = _elevationMap[i][n];
            _root._mainWindow.main.inside[_reciever].tileX = n;
            _root._mainWindow.main.inside[_reciever].tileY = i;
            _root._mainWindow.main.inside[_reciever].central = _worldCenter;
         }
      }
      //check what function the map button is on, and switch
      //immediatly to the appropriate mode:
      switch(_root.bar.tb1._currentframe){
         case 1 :
            resetAll();
            break;
         case 2 :
            sunMode();
            break;
         case 3 :
            moistMode();
            break;
         default :
            trace("Error: Unknown tile display mode");
            break;
      }
   }
   
   private function destroyAll(){
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            _reciever = "tile("+n+","+i+")";
            _root._mainWindow.main.inside[_reciever].removeMovieClip();
         }
      }
   }
   
   public function regenerate(){
      destroyAll();
      _elevationMap = [];
      generateWorld();
   }
   
   public function moistMode(){
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            _reciever = "tile("+n+","+i+")";
            
            _root._mainWindow.main.inside[_reciever].moistTime();
         }
      }
   }
   
   public function resetAll(){
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            _reciever = "tile("+n+","+i+")";
            
            _root._mainWindow.main.inside[_reciever].resetSelf();
         }
      }
   }
   
   public function sunMode(){
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            _reciever = "tile("+n+","+i+")";
            
            _root._mainWindow.main.inside[_reciever].sunTime(true);
         }
      }
   }
   
   public function advanceState(){
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            _reciever = "tile("+n+","+i+")";
            
            _root._mainWindow.main.inside[_reciever].updateState();
            //trace(sumOfAll("_moisture") + sumOfAll("_groundWater"));
            
         }
      }
   }
   
   public function advanceDay(){
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            _reciever = "tile("+n+","+i+")";
            
            _root._mainWindow.main.inside[_reciever].advanceDay();
            
         }
      }
   }
   public function sumOfAll(arg:String):Number{
      var multiple:Number = 0;
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            _reciever = "tile("+n+","+i+")";
            
            multiple += _root._mainWindow.main.inside[_reciever][arg];
            
         }
      }
      return multiple;
   }
}