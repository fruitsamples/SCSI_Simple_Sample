/*								DoTestUnitReady.c								*//* * DoTestUnitReady.c * Copyright � 1992-94 Apple Computer Inc. All Rights Reserved. */#include "SCSISimpleSample.h"/* * Execute a Test Unit Ready command on the specified device and display * the result. */voidDoTestUnitReady(		DeviceIdent				scsiDevice				/* -> Bus/target/LUN	*/	){		ScsiCmdBlock				scsiCmdBlock;#define SCB	(scsiCmdBlock)				ShowSCSIBusID(scsiDevice, "\pTest Unit Ready");		CLEAR(SCB);		SCB.scsiDevice = scsiDevice;		SCB.command.scsi6.opcode = kScsiCmdTestUnitReady;		/* All other command bytes are zero */		DoSCSICommandWithSense(&scsiCmdBlock, TRUE, TRUE);		if (SCB.status == noErr)			LOG("\pTest Unit Ready successful");#undef SCB}		