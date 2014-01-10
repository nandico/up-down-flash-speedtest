﻿package br.com.nandico.SpeedTest{	public class DownstreamCalc	{		private var packages:Array;		public var downloadedPackageCount:Number = 0;		public var errorPackageCount:Number = 0;		public var finishedPackageCount:Number = 0;		public var idlePackageCount:Number = 0;		public function DownstreamCalc(packages:Array)		{			this.packages = packages;						updatePackageCount();		}				private function updatePackageCount():void		{			var packageLength:uint = packages.length;			var downstreamPackage:DownstreamPackageModel = null;						downloadedPackageCount = errorPackageCount = finishedPackageCount = idlePackageCount = 0;						for(var i:uint = 0; i < packageLength; i++)			{				downstreamPackage = packages[i];					if(downstreamPackage.status == DownstreamPackageModel.STATUS_DOWNLOADING) downloadedPackageCount++;				if(downstreamPackage.status == DownstreamPackageModel.STATUS_ERROR) errorPackageCount++;				if(downstreamPackage.status == DownstreamPackageModel.STATUS_FINISHED) finishedPackageCount++;				if(downstreamPackage.status == DownstreamPackageModel.STATUS_IDLE) idlePackageCount++;							}		}				public function getStatus():String		{			updatePackageCount();						if(finishedPackageCount == packages.length)			{				return "Downstream test finished without errors.";			}			else if(errorPackageCount > 0)			{				return "Error in one or more downstream packages.";			}			else			{				return "Downstream test in progress.";			}		}	}}