﻿package br.com.nandico.SpeedTest{	public class ConfigModel	{		public var upstreamUrl:String;		public var downstreamPackages:Array;		public function ConfigModel()		{		}		public static function parseToModel(jsonString:String):ConfigModel		{			var jsonObject = JSON.parse(jsonString);			var model:ConfigModel = new ConfigModel  ;			model.upstreamUrl = jsonObject.config.upstreamUrl;			model.downstreamPackages = jsonObject.config.downstreamPackages;			return model;		}	}}