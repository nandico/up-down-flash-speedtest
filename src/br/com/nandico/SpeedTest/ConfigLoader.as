﻿package br.com.nandico.SpeedTest{	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.events.IOErrorEvent;	import flash.events.Event;		import br.com.nandico.SpeedTest.ConfigModel;		public class ConfigLoader	{		private static const CONFIG_FILE_NAME:String = "SpeedTestConfig.json";		private static var loader:URLLoader;		private static var configModel:ConfigModel;		public function ConfigLoader()		{		}		public static function loadConfig()		{			var request:URLRequest = new URLRequest(CONFIG_FILE_NAME);			loader = new URLLoader();			try			{				loader.load( request );			}			catch (error:SecurityError)			{				trace("A SecurityError has occurred.");			}			loader.addEventListener(IOErrorEvent.IO_ERROR, ConfigLoader.errorHandler);			loader.addEventListener(Event.COMPLETE, ConfigLoader.loadCompleteHandler);		}		public static function loadCompleteHandler(event:Event):void		{			configModel = ConfigModel.parseToModel(loader.data);						trace( "Upstream: " + configModel.upstreamUrl );			trace( "Downstream: " + configModel.downstreamUrl );		}		public static function errorHandler(e:IOErrorEvent):void		{			trace("ErrorHandler has activated.");		}	}}