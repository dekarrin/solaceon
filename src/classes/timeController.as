/*
   timeController class
   Author: Michael Nelson
   Version: 1.0
   Modified: 6/28/09
   Copyright: Michael Nelson
   
   This class serves as the time controller behind Solaceon.
   
*/

class timeController extends MovieClip{
   
   private var _gameSpeed:Number;
   private var _referenceFrame:Number;
   
   private var _paused:Boolean;
   
   public function timeController(){
      /*_paused = false;
      
      _referenceFrame = 0;
      _gameSpeed = 1;
      this.onEnterFrame = function(){
         if(!_paused){
            _referenceFrame++;
            if(_referenceFrame == _gameSpeed) {
               _referenceFrame = 0;
               _root.master.advanceTick();
            }
         }
      }*/
   }
   
   public function changeSpeed(inpt:Number){
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            var reciever:String = "tile("+n+","+i+")";
            
            _root._mainWindow.main.inside[reciever].gameSpeed = inpt;
            _root._mainWindow.main.inside[reciever].referenceFrame = 0;
         }
      }
   }
   
   public function stopTime(){
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            var reciever:String = "tile("+n+","+i+")";
            
            _root._mainWindow.main.inside[reciever].isPaused = true;
            _root._mainWindow.main.inside[reciever].referenceFrame = 0;
         }
      }
   }
   
   public function startTime(){
      for(var i=0; i<9; i++){
         for(var n=0; n<16; n++){
            var reciever:String = "tile("+n+","+i+")";
            
            _root._mainWindow.main.inside[reciever].isPaused = false;
         }
      }
   }
   
}