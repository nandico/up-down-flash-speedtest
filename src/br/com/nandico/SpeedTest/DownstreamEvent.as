﻿package br.com.nandico.SpeedTest{	import flash.events.Event;	public class DownstreamEvent extends Event	{		public static const DOWNSTREAM_UPDATE:String = "DOWNSTREAM_UPDATE";		public static const DOWNSTREAM_FINISHED:String = "DOWNSTREAM_FINISHED";		public static const DOWNSTREAM_ERROR:String = "DOWNSTREAM_ERROR";		public function DownstreamEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)		{			super(type, bubbles, cancelable);		}		public override function clone():Event		{			return new DownstreamEvent(type, bubbles, cancelable);		}	}}