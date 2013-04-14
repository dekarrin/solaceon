/*
   windowController class
   Author: Michael Nelson
   Version: 1.0
   Modified: Today
   Copyright: Michael Nelson
   
   This class keeps track of the states of and controls all of the
   windows in the game.
   
*/

class windowController extends Object{
   
   private var _mainWindow:Boolean = false;
   private var _windowMenu:Boolean = false;
   private var _infoBox:Boolean = false;
   
   private var _infoLinkedX:Number;
   private var _infoLinkedY:Number;
   
   public function windowController(){
      this._mainWindow = true;
      _root._mainWindow._visible = true;
      this._windowMenu = false;
      _root._windowMenu._visible = false;
      this._infoBox = false;
      _root._infoBox._visible = false;
   }
   
   public function createWindow(windowName:String){
      this[windowName] = true;
      _root[windowName]._visible = true;
   }
   
   public function closeWindow(windowName:String){
      this[windowName] = false;
      _root[windowName]._visible = false;
   }
   
   public function endInfo(endWindow:Boolean, disengage:Boolean){
      if(endWindow){
         this._infoBox = false;
         _root._infoBox._visible = false;
      }
      
      var nameOfReceiver:String = "tile(" + _infoLinkedX + "," + _infoLinkedY + ")";
      _root._mainWindow.main.inside[nameOfReceiver].autoUpdating = false;
      if(disengage){
         _root._mainWindow.main.inside[nameOfReceiver].stroke.disengage();
      }
   }
   
   public function startInfo(tileX:Number, tileY:Number){
      this._infoBox = true;
      _root._infoBox._visible = true;
      
      endInfo(false, true);
      
      this._infoLinkedX = tileX;
      this._infoLinkedY = tileY;
   }
   
   public function checkLinkX(){
      return this._infoLinkedX;
   }
   public function checkLinkY(){
      return this._infoLinkedY;
   }
}