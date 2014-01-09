﻿package br.com.nandico.SpeedTest{	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.events.IOErrorEvent;	import flash.events.Event;	import flash.events.EventDispatcher;	import br.com.nandico.SpeedTest.ConfigModel;	import br.com.nandico.SpeedTest.DownstreamPackageModel;	import flash.events.ProgressEvent;	public class DownstreamTest extends EventDispatcher	{		public static var packages:Array = new Array();		public function DownstreamTest()		{		}		private static var dispatcher:EventDispatcher = new EventDispatcher();		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void		{			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);		}		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void		{			dispatcher.removeEventListener(type, listener, useCapture);		}		public static function dispatchEvent(event:Event):Boolean		{			return dispatcher.dispatchEvent(event);		}		public static function hasEventListener(type:String):Boolean		{			return dispatcher.hasEventListener(type);		}		public static function startTest(configModel:ConfigModel):void		{			for each (var packageUrl:String in configModel.downstreamPackages)			{				packages.push(new DownstreamPackageModel(randomizeUrl(packageUrl)));			}			processPackages();		}		private static function randomizeUrl(url:String):String		{			return url + "?" + Math.random();		}		private static function processPackages():void		{			if (packages.length == 0)			{				trace("There is no packages configured in the config file.");				dispatchEvent(new DownstreamEvent(DownstreamEvent.DOWNSTREAM_ERROR));				return;			}			var packageLength:uint = packages.length;			var myPackage:DownstreamPackageModel;						for(var i:uint = 0; i < packageLength; i++)			{				myPackage = packages[i];				myPackage.birthDate = new Date();				myPackage.status = DownstreamPackageModel.STATUS_DOWNLOADING;				startDownstream(myPackage);			}		}		private static function startDownstream(downstreamPackage:DownstreamPackageModel)		{			downstreamPackage.request = new URLRequest(downstreamPackage.url);			downstreamPackage.loader = new URLLoader();			try			{				downstreamPackage.loader.load(downstreamPackage.request);			}			catch (error:SecurityError)			{				trace("A SecurityError has occurred trying to download package '" + downstreamPackage.url + "'.");			}			downstreamPackage.loader.addEventListener(IOErrorEvent.IO_ERROR, downstreamErrorHandler);			downstreamPackage.loader.addEventListener(Event.COMPLETE, downstreamCompleteHandler);			downstreamPackage.loader.addEventListener(ProgressEvent.PROGRESS, downstreamProgressHandler);		}				private static function downstreamErrorHandler(event:IOErrorEvent):void		{			trace("Error handling downstream for " + event);		}				private static function downstreamCompleteHandler(event:Event):void		{			var loader:URLLoader = event.target as URLLoader;			var myPackage:DownstreamPackageModel = getPackageByTarget(loader);						if(myPackage)			{				myPackage.deathDate = new Date();				myPackage.status = DownstreamPackageModel.STATUS_FINISHED;								dispatchEvent(new DownstreamEvent(DownstreamEvent.DOWNSTREAM_PACKAGE_FINISHED));								if(isDownstreamFinished())				{					dispatchEvent(new DownstreamEvent(DownstreamEvent.DOWNSTREAM_FINISHED));				}			}			else			{				trace("The package was not identified after downstream.")				dispatchEvent(new DownstreamEvent(DownstreamEvent.DOWNSTREAM_ERROR));			}		}				private static function isDownstreamFinished():Boolean		{			var packageLength:uint = packages.length;			var downstreamPackage:DownstreamPackageModel = null;						for(var i:uint = 0; i < packageLength; i++)			{				if(packages[i].status != DownstreamPackageModel.STATUS_FINISHED)				{					return false;				}			}						return true;		}				private static function getPackageByTarget(loader:URLLoader):DownstreamPackageModel		{			var packageLength:uint = packages.length;			var downstreamPackage:DownstreamPackageModel = null;						for(var i:uint = 0; i < packageLength; i++)			{				if(loader == packages[i].loader)				{					downstreamPackage = packages[i];					break;				}			}						return downstreamPackage;		}				private static function downstreamProgressHandler(event:ProgressEvent):void		{			var percentLoaded:Number = event.bytesLoaded / event.bytesTotal;			percentLoaded = Math.round(percentLoaded * 100);							var loader:URLLoader = event.target as URLLoader;			var myPackage:DownstreamPackageModel = getPackageByTarget(loader);			myPackage.percentLoaded = percentLoaded;			myPackage.bytesTotal = event.bytesTotal;			myPackage.bytesLoaded = event.bytesLoaded;						dispatchEvent(new DownstreamEvent(DownstreamEvent.DOWNSTREAM_UPDATE));		}	}}