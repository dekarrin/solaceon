/*
   worldTile class
   Author: Michael Nelson
   Version: 1.0
   Modified: 6/30/09
   Copyright: Michael Nelson
   
   This class gives characteristics for each self contained
   tile of world.
   
*/

class worldTile extends MovieClip {
   
   private var _childName:String;
   private var _locationY:Number;
   private var _sunlight:Number;
   private var _moisture:Number;
   private var _groundWater:Number;
   private var _elevation:Number;

   private var _waiting:Number;
   
   private var _tileX:Number;
   private var _tileY:Number;
   
   public var central:Number;
   
   private var _autoUpdating:Boolean;
   
   private var _gameSpeed:Number;
   private var _referenceFrame:Number;
   private var _isPaused:Boolean;
   
   public function worldTile(){
      _autoUpdating = false;
      _waiting = 0;
      
      _moisture = random(100)+1;
      _groundWater = 100-_moisture;
      
      this["darkness"]._alpha = 0;
      
      this.gotoAndStop(1);
      
      genSunlight(4);
      
      this.onPress = function(){
         _root.window.startInfo(_tileX, _tileY);
         _autoUpdating = true;
         this.stroke.engage();
      }
      _isPaused = false;
      
      _referenceFrame = 0;
      _gameSpeed = 1;
      this.onEnterFrame = function(){
         if(!_isPaused){
            _referenceFrame++;
            if(_referenceFrame == _gameSpeed) {
               _referenceFrame = 0;
               _root.master.advanceTick();
            }
         }
      }
   }
   
   public function sunTime(inpt:Boolean){
      if(inpt){
         this.gotoAndStop(2);
      }
      
      var sunStrength:Number;
      
      if(_sunlight == 100) {
         sunStrength = 1;
      }
      
      if(_sunlight < 100) {
         sunStrength = 2;
      }
      
      if(_sunlight < 75) {
         sunStrength = 3;
      }
      
      if(_sunlight < 50) {
         sunStrength = 4;
      }
      
      if(_sunlight < 25) {
         sunStrength = 5;
      }
      
      this["sun"].gotoAndStop(sunStrength);
   }
   
   public function moistTime(){
      this.gotoAndStop(3);
      
      this["brightness"]._alpha = convertVal(_moisture);
   }
   
   public function resetSelf(){
      this.gotoAndStop(1);
      
      this["darkness"]._alpha = _elevation;
   }
   
   private function convertVal(inpt:Number):Number {
      var outputVal:Number;
      
      if(inpt-50 > 0){
         outputVal = -(inpt-50)+50;
      } else {
         outputVal = Math.abs(inpt-50)+50;
      }
      return outputVal;
   }
   
   public function moistureCheck(){
      var nullCount:Number = 0;
      var child1:String = "tile(" + _tileX + "," + (_tileY + 1) + ")";
      var child2:String = "tile(" + _tileX + "," + (_tileY - 1) + ")";
      var child3:String = "tile(" + (_tileX + 1) + "," + _tileY + ")";
      var child4:String = "tile(" + (_tileX - 1) + "," + _tileY + ")";
      if(_root._mainWindow.main.inside[child1].moisture == undefined){nullCount++;}
      if(_root._mainWindow.main.inside[child2].moisture == undefined){nullCount++;}
      if(_root._mainWindow.main.inside[child3].moisture == undefined){nullCount++;}
      if(_root._mainWindow.main.inside[child4].moisture == undefined){nullCount++;}
      var average:Number = ((scanNeighbor(child1) + scanNeighbor(child2) + scanNeighbor(child3) + scanNeighbor(child4) + this._moisture)/(5-nullCount));
      
      _root._mainWindow.main.inside[child1].addMoisture(average);
      _root._mainWindow.main.inside[child2].addMoisture(average);
      _root._mainWindow.main.inside[child3].addMoisture(average);
      _root._mainWindow.main.inside[child4].addMoisture(average);
      this.addMoisture(average);
      
   }
   
   private function scanNeighbor(toScan:String):Number{
      if(_root._mainWindow.main.inside[toScan].moisture == undefined){
         return 0;
      } else {
         return _root._mainWindow.main.inside[toScan].moisture;
      }
   }
   
   public function addMoisture(inpt:Number){
      this._moisture = inpt;

      this["brightness"]._alpha = convertVal(_moisture);
   }
   
   private function rainCheck(){
         rainfall();
   }
   
   private function rainfall(){
      _groundWater += (_moisture/2);
      _moisture *= .5;
      
      this["brightness"]._alpha = convertVal(_moisture);
   }
   
   private function evaporate(){
      if(_groundWater > 0){
         var subtractor:Number;
         subtractor = _sunlight - Math.pow(_moisture, 2);
         if(subtractor < 0){
            subtractor = 0;
         }
         /*if(subtractor > (_groundWater/3)){
            subtractor = (_groundWater/3);
         }*/
         _groundWater -= subtractor;
         _moisture += subtractor;
      }
            
      this["brightness"]._alpha = convertVal(_moisture);
   }
   
   public function updateState(){
      moistureCheck();
      rainCheck();
      evaporate();
      if(_autoUpdating){
         _root._infoBox.main.moist.text = _moisture;
         _root._infoBox.main.ground.text = _groundWater;
         _root._infoBox.main.sun.text = _sunlight;
      }
   }
   
   public function advanceDay(){
      
   }
            
            
   public function genSunlight(center:Number){
      _locationY = parseInt(this._name.substr(7,1));
      if(isNaN(_locationY)){
         _locationY = parseInt(this._name.substr(8,1));
      }
      _locationY = Math.abs(_locationY-center);
      if(_locationY != 0){
         _sunlight = Math.round(100*(Math.sqrt(1.03-Math.pow((_locationY/4), 2))-0.01488915651));
         if(!isFinite(_sunlight)){
            _sunlight = 0;
         }
      } else {
         _sunlight = 100;
      }
      sunTime(false);
   }
      
   public function set moisture(value:Number):Void{
      this._moisture = value;
   }
   public function get moisture():Number{
      return this._moisture;
   }
   public function set tileX(value:Number):Void{
      this._tileX = value;
   }
   public function get tileX():Number{
      return this._tileX;
   }
   public function set tileY(value:Number):Void{
      this._tileY = value;
   }
   public function get tileY():Number{
      return this._tileY;
   }
   public function set elevation(value:Number):Void{
      this._elevation = value;
   }
   public function get elevation():Number{
      return this._elevation;
   }
   public function set autoUpdating(value:Boolean):Void{
      this._autoUpdating = value;
   }
   public function get autoUpdating():Boolean{
      return this._autoUpdating;
   }
   public function set gameSpeed(value:Number):Void{
      this._gameSpeed = value;
   }
   public function get gameSpeed():Number{
      return this._gameSpeed;
   }
   public function set referenceFrame(value:Number):Void{
      this._referenceFrame = value;
   }
   public function get referenceFrame():Number{
      return this._referenceFrame;
   }
   public function set isPaused(value:Boolean):Void{
      this._isPaused = value;
   }
   public function get isPaused():Boolean{
      return this._isPaused;
   }
}