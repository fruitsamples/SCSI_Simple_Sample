/*								SCSISimpleSample.r								*/#include "Types.r"#include "SysTypes.r"#define REZ#include "SCSISimpleSample.h"#ifdef __powerc/* * All Power PC applications need a code-fragment resource that the code * fragment manager uses to facilitate dynamic fragment binding. */#include "CodeFragmentTypes.r"	resource 'cfrg' (0) {	{		kPowerPC,		kFullLib,		kNoVersionNum,		kNoVersionNum,		kDefaultStackSize,		kNoAppSubFolder,		kIsApp,		kOnDiskFlat,		kZeroOffset,		kWholeFork,		"SCSISimpleSamplePPC"	}};#endiftype kApplicationCreator as 'STR ';resource kApplicationCreator (0, "Owner Resource", purgeable) {	"A Simple Sample for the Asynchronous and Original SCSI Managers"};resource 'vers' (1) {	0x1,	0x0,	release,	0x0,	verUS,	"1.0",	"1.0 � 1993-94 Apple Computer Inc. All Rights Reserved"};resource 'vers' (2) {	0x1,	0x0,	release,	0x0,	verUS,	"1.0",	"1.0 � 1993-94 Apple Computer Inc. All Rights Reserved"};resource 'MBAR' (MBAR_MenuBar, "Menu Bar") {	{		MENU_Apple,		MENU_File,		MENU_Edit,		MENU_Test,		MENU_CurrentBus,		MENU_CurrentTarget,		MENU_CurrentLUN,	}};resource 'MENU' (MENU_Apple, "Apple Menu") {	MENU_Apple,	textMenuProc,	0x7FFFFFFD,	enabled,	apple,	{		"About SCSI Simple Sample�",	noIcon, noKey, noMark, plain,		"-",							noIcon, noKey, noMark, plain	}};resource 'MENU' (MENU_File, "File Menu") {	MENU_File,	textMenuProc,	0,	enabled,	"File",	{		"Create Log File�",	noIcon,   "S", noMark, plain,		"Close Log File�",	noIcon,   "W", noMark, plain,		"-",				noIcon, noKey, noMark, plain,		"Page Setup�",		noIcon, noKey, noMark, plain,		"Print Report�",	noIcon,   "P", noMark, plain,		"-",				noIcon, noKey, noMark, plain,		"Debug Trap",		noIcon,   ".", noMark, plain,		"-",				noIcon, noKey, noMark, plain,		"Quit",				noIcon,   "Q", noMark, plain,	}};resource 'MENU' (MENU_Edit, "Edit Menu") {	MENU_Edit,	textMenuProc,	0,	enabled,	"Edit",	{		"Undo",				noIcon,   "Z", noMark, plain,		"-",				noIcon, noKey, noMark, plain,		"Cut",				noIcon,   "X", noMark, plain,		"Copy",				noIcon,   "C", noMark, plain,		"Paste",			noIcon,   "V", noMark, plain,		"Clear",			noIcon, noKey, noMark, plain	}};resource 'MENU' (MENU_Test, "Test Commands") {	MENU_Test,	textMenuProc,	allEnabled,	enabled,	"Commands",	{		"Enable Asynchronous SCSI Manager",	noIcon, noKey, noMark, plain,		"Enable All Logical Units",			noIcon, noKey, noMark, plain,		"Enable Select with Attention",		noIcon, noKey, noMark, plain,		"-",								noIcon, noKey, noMark, plain,		"Explicitly Do Disconnect",			noIcon, noKey, noMark, plain,		"Explicitly Do Not Disconnect",		noIcon, noKey, noMark, plain,		"-",								noIcon, noKey, noMark, plain,		"List All SCSI Devices",			noIcon, noKey, noMark, plain,		"Device Inquiry",					noIcon, noKey, noMark, plain,		"Test Unit Ready",					noIcon, noKey, noMark, plain,		"Read Block Zero",					noIcon, noKey, noMark, plain,		"-",								noIcon, noKey, noMark, plain,		"Verbose Display",					noIcon, noKey, noMark, plain,	}};/* * We should build this dynamically. */resource 'MENU' (MENU_CurrentBus, "Current Bus") {	MENU_CurrentBus,	textMenuProc,	allEnabled,	enabled,	"Host Bus",	{		"0",								noIcon, noKey, noMark, plain,		"1",								noIcon, noKey, noMark, plain,		"2",								noIcon, noKey, noMark, plain,		"3",								noIcon, noKey, noMark, plain,		"4",								noIcon, noKey, noMark, plain,		"5",								noIcon, noKey, noMark, plain,		"6",								noIcon, noKey, noMark, plain,		"7",								noIcon, noKey, noMark, plain,		"8",								noIcon, noKey, noMark, plain,		"9",								noIcon, noKey, noMark, plain,		"10",								noIcon, noKey, noMark, plain,		"11",								noIcon, noKey, noMark, plain,		"12",								noIcon, noKey, noMark, plain,		"13",								noIcon, noKey, noMark, plain,		"14",								noIcon, noKey, noMark, plain,		"15",								noIcon, noKey, noMark, plain,	}};resource 'MENU' (MENU_CurrentTarget, "Current Target") {	MENU_CurrentTarget,	textMenuProc,	allEnabled,	enabled,	"Target",	{		"0",								noIcon, noKey, noMark, plain,		"1",								noIcon, noKey, noMark, plain,		"2",								noIcon, noKey, noMark, plain,		"3",								noIcon, noKey, noMark, plain,		"4",								noIcon, noKey, noMark, plain,		"5",								noIcon, noKey, noMark, plain,		"6",								noIcon, noKey, noMark, plain,		"7",								noIcon, noKey, noMark, plain,	}};resource 'MENU' (MENU_CurrentLUN, "Current LUN") {	MENU_CurrentLUN,	textMenuProc,	allEnabled,	enabled,	"Logical Unit",	{		"0",								noIcon, noKey, noMark, plain,		"1",								noIcon, noKey, noMark, plain,		"2",								noIcon, noKey, noMark, plain,		"3",								noIcon, noKey, noMark, plain,		"4",								noIcon, noKey, noMark, plain,		"5",								noIcon, noKey, noMark, plain,		"6",								noIcon, noKey, noMark, plain,		"7",								noIcon, noKey, noMark, plain,	}};resource 'DLOG' (DLOG_About, "About SCSI Scan Bus") {	{	100, 100, 256, 425 },	dBoxProc,	invisible,	noGoAway,	0x0,	DLOG_About,	""};resource 'DITL' (DLOG_About, "About SCSI Scan Bus") {	{		{ 124, 244, 144, 312 }, Button		{ enabled,				"OK"		},		{  10,  10, 118, 312 },	StaticText	{ disabled,			"SCSI Simple Sample shows how to call the original and"			" asynchronous SCSI managers.\n"			"Written by Martin Minow, Developer Technical Support.\n"			"Copyright � 1993-94 Apple Computer Inc."		},	}};/* * SCSI Manager Errors */type 'Estr' as 'STR ';resource 'Estr'	(-50)					{ "paramErr: Error in user parameter block"				};resource 'Estr'	(2)						{ "scCommErr: SCSI operation timeout - no such device"	};resource 'Estr' (3)						{ "scArbNBErr: SCSI arbitration timeout waiting for bus" };resource 'Estr' (4)						{ "scBadParmsErr: SCSI bat parameter or TIB opcode"		};resource 'Estr' (5)						{ "scPhaseErr: SCSI phase mismatch for operation"		};resource 'Estr' (6)						{ "scCompareErr: SCSI data compare error"				};resource 'Estr' (7)						{ "scMgrBusyErr: SCSI Manager busy"						};resource 'Estr' (8)						{ "scSequenceErr: SCSI operation out of sequence"		};resource 'Estr' (9)						{ "scBusTOErr: SCSI CPU bus timeout error"				};resource 'Estr' (10)					{ "scComplPhaseErr: SCSI phase error at completion"		};#define scsiErrorBase		-7936resource 'Estr'	(scsiErrorBase + 0x02)	{ "scsiRequestAborted: Request aborted by host"			};resource 'Estr'	(scsiErrorBase + 0x03)	{ "scsiUnableToAbort: Unable to abort SCSI request"		};resource 'Estr'	(scsiErrorBase + 0x04)	{ "scsiNonZeroStatus: Completed with non-zero status"	};resource 'Estr'	(scsiErrorBase + 0x09)	{ "scsiUnableToTerminate: Unable to terminate I/O Request"	};resource 'Estr'	(scsiErrorBase + 0x0A)	{ "scsiSelectTimeout: Target selection timeout"			};resource 'Estr'	(scsiErrorBase + 0x0B)	{ "scsiCommandTimeout: Command timeout"					};resource 'Estr'	(scsiErrorBase + 0x0C)	{ "scsiIdentifyMessageRejected: Target reject (no LUN?)" };resource 'Estr'	(scsiErrorBase + 0x0D)	{ "scsiMessageRejectReceived: Target rejected message"	};resource 'Estr'	(scsiErrorBase + 0x0E)	{ "scsiSCSIBusReset: SCSI Bus Reset sent or received"	};resource 'Estr'	(scsiErrorBase + 0x0F)	{ "scsiParityError: Uncorrectable bus parity error"		};resource 'Estr'	(scsiErrorBase + 0x10)	{ "scsiAutosenseFailed: Autosense failed"				};resource 'Estr'	(scsiErrorBase + 0x11)	{ "scsiRequestAborted: Request aborted by host"			};resource 'Estr'	(scsiErrorBase + 0x12)	{ "scsiRequestAborted: Request aborted by host"			};resource 'Estr'	(scsiErrorBase + 0x13)	{ "scsiRequestAborted: Request aborted by host"			};resource 'Estr'	(scsiErrorBase + 0x14)	{ "scsiRequestAborted: Request aborted by host"			};resource 'Estr'	(scsiErrorBase + 0x17)	{ "scsiBDRsent: Issued SCSI Bus Device Reset"			};resource 'Estr'	(scsiErrorBase + 0x18)	{ "scsiTerminated: Request terminated by host"			};resource 'Estr'	(scsiErrorBase + 0x19)	{ "scsiNoNexus: Nexus is not established"				};resource 'Estr'	(scsiErrorBase + 0x1A)	{ "scsiCDBReceived: SCSI Command Data Block received"	};resource 'Estr'	(scsiErrorBase + 0x30)	{ "scsiTooManyBuses: Too many busses registered"		};resource 'Estr'	(scsiErrorBase + 0x31)	{ "scsiBusy: SCSI subsystem busy"						};resource 'Estr'	(scsiErrorBase + 0x32)	{ "scsiProvideFail: Can't provide requested capability"	};resource 'Estr'	(scsiErrorBase + 0x33)	{ "scsiDeviceNotThere: Device not installed or present"	};resource 'Estr'	(scsiErrorBase + 0x34)	{ "scsiNoHBA: Missing host bus adaptor"					};resource 'Estr'	(scsiErrorBase + 0x35)	{ "scsiDeviceConflict: Max 1 refNum per device"			};resource 'Estr'	(scsiErrorBase + 0x36)	{ "scsiNoSuchXref: No such refNum cross-reference"		};resource 'Estr'	(scsiErrorBase + 0x37)	{ "scsiQLinkInvalid: Pre-linked param blocks not supported" };resource 'Estr'	(scsiErrorBase + 0x40)	{ "scsiPBLengthError: Param block length error"			};resource 'Estr'	(scsiErrorBase + 0x41)	{ "scsiFunctionNotAvailable: No such SCSI function"		};resource 'Estr'	(scsiErrorBase + 0x42)	{ "scsiErrorBase: Invalid SCSI request"					};resource 'Estr'	(scsiErrorBase + 0x43)	{ "scsiBusInvalid: Invalid host bus reference"			};resource 'Estr'	(scsiErrorBase + 0x44)	{ "scsiTIDInvalid: Invalid target id"					};resource 'Estr'	(scsiErrorBase + 0x45)	{ "scsiLUNInvalid: Invalid logical unit number"			};resource 'Estr'	(scsiErrorBase + 0x46)	{ "scsiIIDInvalid: Invalid initiator identifier"		};resource 'Estr'	(scsiErrorBase + 0x47)	{ "scsiDataTypeInvalid: Invalid or unsupported data type" };resource 'Estr'	(scsiErrorBase + 0x48)	{ "scsiTransferTypeInvalid: Invalid transfer type"		};resource 'Estr'	(scsiErrorBase + 0x49)	{ "scsiCDBLengthInvalid: Invalide command data block length" };/* * ASC and ASQ messages.  Each ASC value defines a STR# resource * in the range 1000 + ASC value.  Within that resource, each * defined ASQ value is in a string, whose first byte contains * the ASQ value (in binary).  Note that the comments give the * ASC value in HEX, but the STR# number is in decimal. * * If the first byte of the string is 0xFF, the string means * "all other ASQ values."  (It goes without saying that that * value must be last. *//* * --------00--------             *//* * Ugh: Think Rez crashes if you give it Hex constants. * MPW Rez won't compile an expression either. Grumble. */resource 'STR#' (STRS_SenseBase + 0, "00") {	{		"\0x00No additional sense information",		"\0x01Filemark detected",		"\0x02End-of-partition/medium detected",		"\0x03Set mark detected",		"\0x04Beginning of partition/medium detected",		"\0x05End of data detected",		"\0x06I/O terminated",		"\0x11Audio play operation in progress",		"\0x12Audio play operation paused",		"\0x13Audio play operation successfully completed",		"\0x14Audio play operation stopped due to error",		"\0x15No current audio status to return"	}};resource 'STR#' (STRS_SenseBase + 1, "01") {	{		"\0x00No index/sector signal (dead motor, perhaps)"	}};resource 'STR#' (STRS_SenseBase + 3, "03") {	{		"\0x00Peripheral device write fault",		"\0x01No write current",		"\0x02Excessive write errors"	}};resource 'STR#' (STRS_SenseBase + 5, "05") {	{		"\0x00Logical unit does not respond to selection"	}};resource 'STR#' (STRS_SenseBase + 6, "06") {	{		"\0x00No reference position found"	}};resource 'STR#' (STRS_SenseBase + 7, "07") {	{		"\0x00Multiple peripheral devices selected"	}};resource 'STR#' (STRS_SenseBase + 8, "08") {	{		"\0x00Logical unit communication failure",		"\0x01Logical unit communication time-out",		"\0x02Logical unit communication parity error"	}};resource 'STR#' (STRS_SenseBase + 9, "09") {	{		"\0x00Track following error",		"\0x01Tracking servo failure",		"\0x02Focus servo failure",		"\0x03Spindle servo failure"	}};resource 'STR#' (STRS_SenseBase + 10, "0A") {	{		"\0x00Error log overflow"	}};resource 'STR#' (STRS_SenseBase + 12, "0C") {	{		"\0x00Write error",		"\0x01Write error recovered with auto reallocation",		"\0x02Write error - auto reallocation failed"	}};resource 'STR#' (STRS_SenseBase + 16, "10") {	{		"\0x00ID CRC or ECC error"	}};resource 'STR#' (STRS_SenseBase + 17, "11") {	{		"\0x00Unrecovered read error",		"\0x01Read retries exhausted",		"\0x02Error too long to correct",		"\0x03Multiple read errors",		"\0x04Unrecovered read error - auto reallocate failed",		"\0x05L-EC uncorrectable error",		"\0x06Circ unrecovered error",		"\0x07Data resychronization error",		"\0x08Incomplete block read",		"\0x09No gap found",		"\0x0aMiscorrected error",		"\0x0bUnrecovered read error - recommend reassignment",		"\0x0cUnrecovered read error - recommend rewrite the data"	}};resource 'STR#' (STRS_SenseBase + 18, "12") {	{		"\0x00Address mark not found for ID field"	}};resource 'STR#' (STRS_SenseBase + 19, "13") {	{		"\0x00Address mark not found for data field"	}};resource 'STR#' (STRS_SenseBase + 20, "14") {	{		"\0x00Recorded entity not found",		"\0x01Record not found",		"\0x02Filemark or setmark not found",		"\0x03End of data not found",		"\0x04Block sequence error"	}};resource 'STR#' (STRS_SenseBase + 21, "15") {	{		"\0x00Random positioning error",		"\0x01Mechanical positioning error",		"\0x02Positioning error detected by read of medium"	}};resource 'STR#' (STRS_SenseBase + 22, "16") {	{		"\0x00Data synchronization mark error"	}};resource 'STR#' (STRS_SenseBase + 23, "17") {	{		"\0x00Recovered data with no error correction applied",		"\0x01Recovered data with retries",		"\0x02Recovered data with positive head offset",		"\0x03Recovered data with negative head offset",		"\0x04Recovered data with retries and/or circ applied",		"\0x05Recovered data using previous sector ID",		"\0x06Recovered data without ECC - Data auto reallocated",		"\0x07Recovered data without ECC - Recommend reassignment"	}};resource 'STR#' (STRS_SenseBase + 24, "18") {	{		"\0x00Recovered data with error correction applied",		"\0x01Recovered data with error correction and retries applied",		"\0x02Recovered data - data auto re\0x00\rallocated",		"\0x03Recovered data with circ",		"\0x04Recovered data with lec",		"\0x05Recovered data - recommend reassignment"	}};resource 'STR#' (STRS_SenseBase + 25, "19") {	{		"\0x00Defect list error",		"\0x01Defect list not available",		"\0x02Defect list error in primary list",		"\0x03Defect list error in grown list"	}};resource 'STR#' (STRS_SenseBase + 26, "1A") {	{		"\0x00Parameter list length error"	}};resource 'STR#' (STRS_SenseBase + 27, "1B") {	{		"\0x00Synchronous data transfer error"	}};resource 'STR#' (STRS_SenseBase + 28, "1C") {	{		"\0x00Defect list not found",		"\0x01Primary defect list not found",		"\0x02Grown defect list not found"	}};resource 'STR#' (STRS_SenseBase + 29, "1D") {	{		"\0x00Miscompare during verify operation"	}};resource 'STR#' (STRS_SenseBase + 30, "1E") {	{		"\0x00Recovered Id with ECC correction"	}};resource 'STR#' (STRS_SenseBase + 32, "20") {	{		"\0x00Invalid command operation code"	}};resource 'STR#' (STRS_SenseBase + 33, "21") {	{		"\0x00Logical block address out of range",		"\0x01Invalid element address"	}};resource 'STR#' (STRS_SenseBase + 34, "22") {	{		"\0x00Illegal function (should use 20 00, 24 00, or 26 00)"	}};resource 'STR#' (STRS_SenseBase + 36, "24") {	{		"\0x00Invalid field in CDB"	}};resource 'STR#' (STRS_SenseBase + 37, "25") {	{		"\0x00Logical unit not supported"	}};resource 'STR#' (STRS_SenseBase + 38, "26") {	{		"\0x00Invalid field in parameter list",		"\0x01Parameter not supported",		"\0x02Parameter value invalid",		"\0x03Thershold parameters not supported"	}};resource 'STR#' (STRS_SenseBase + 39, "27") {	{		"\0x00Write protected"	}};resource 'STR#' (STRS_SenseBase + 40, "28") {	{		"\0x00Not ready to ready transition (medium may have changed)",		"\0x01Import or export element accessed"	}};resource 'STR#' (STRS_SenseBase + 41, "29") {	{		"\0x00Power on, reset, or bus device reset occurred"	}};resource 'STR#' (STRS_SenseBase + 42, "2A") {	{		"\0x00Parameters changed",		"\0x01Mode parameters changed",		"\0x02Log parameters changed"	}};resource 'STR#' (STRS_SenseBase + 43, "2B") {	{		"\0x00Copy cannot execute since host cannot disconnect"	}};resource 'STR#' (STRS_SenseBase + 44, "2C") {	{		"\0x00Command sequence error",		"\0x01Too many windows specified",		"\0x02Invalid combination of windows specified"	}};resource 'STR#' (STRS_SenseBase + 45, "2D") {	{		"\0x00Overwrite error on update in place"	}};resource 'STR#' (STRS_SenseBase + 47, "2F") {	{		"\0x00Commands cleared by another initiator"	}};resource 'STR#' (STRS_SenseBase + 48, "30") {	{		"\0x00Incompatible medium installed",		"\0x01Cannot read meduim - unknown format",		"\0x02Cannot read meduim - incompatible format",		"\0x03Cleaning cartridge installed"	}};resource 'STR#' (STRS_SenseBase + 49, "31") {	{		"\0x00Medium format corrupted",		"\0x01Format command failed"	}};resource 'STR#' (STRS_SenseBase + 50, "32") {	{		"\0x00No defect spare location available",		"\0x01Defect list update failure"	}};resource 'STR#' (STRS_SenseBase + 51, "33") {	{		"\0x00Tape length error"	}};resource 'STR#' (STRS_SenseBase + 54, "36") {	{		"\0x00Ribbon, ink, or toner failure"	}};resource 'STR#' (STRS_SenseBase + 55, "37") {	{		"\0x00Rounded parameter"	}};resource 'STR#' (STRS_SenseBase + 57, "39") {	{		"\0x00Saving parameters not supported"	}};resource 'STR#' (STRS_SenseBase + 58, "3A") {	{		"\0x00Medium not present"	}};resource 'STR#' (STRS_SenseBase + 59, "3B") {	{		"\0x00Sequential positioning error",		"\0x01Tape position error at beginning of medium",		"\0x02Tape position errror at end of medium",		"\0x03Tape or electronic vertical forms unit not ready",		"\0x04Slew failure",		"\0x05Paper Jam",		"\0x06Failed to sense top of form",		"\0x07Failed to sense bottom of form",		"\0x08Reposition error",		"\0x09Read past end of medium",		"\0x0aRead past beginning of medium",		"\0x0bPosition past end of medium",		"\0x0cPosition past beginning of medium",		"\0x0dMedium destination element full",		"\0x0eMedium source element empty"	}};resource 'STR#' (STRS_SenseBase + 61, "3D") {	{		"\0x00Invalid bits in identify message"	}};resource 'STR#' (STRS_SenseBase + 62, "3E") {	{		"\0x00Logical unit has not self-configured yet"	}};resource 'STR#' (STRS_SenseBase + 63, "3F") {	{		"\0x00Target operating conditions have changed",		"\0x01Microcode has been changed",		"\0x02Changed operating definition",		"\0x03Inquiry data has changed"	}};resource 'STR#' (STRS_SenseBase + 64, "40") {	{		"\0x00RAM failure (should use 40 NN)",		"�Diagnostic failure on component NN (80H-FFH)"	}};resource 'STR#' (STRS_SenseBase + 65, "41") {	{		"\0x00Data path failure (should use 40 NN)"	}};resource 'STR#' (STRS_SenseBase + 66, "42") {	{		"\0x00Power on or self-test failure (should use 40 NN)"	}};resource 'STR#' (STRS_SenseBase + 67, "43") {	{		"\0x00Message error"	}};resource 'STR#' (STRS_SenseBase + 68, "44") {	{		"\0x00Internal target failure"	}};resource 'STR#' (STRS_SenseBase + 69, "45") {	{		"\0x00Select or reselect failure"	}};resource 'STR#' (STRS_SenseBase + 70, "46") {	{		"\0x00Unsuccessful soft reset"	}};resource 'STR#' (STRS_SenseBase + 71, "47") {	{		"\0x00SCSI parity error"	}};resource 'STR#' (STRS_SenseBase + 72, "48") {	{		"\0x00Initiator detected error message received"	}};resource 'STR#' (STRS_SenseBase + 73, "49") {	{		"\0x00Invalid message error"	}};resource 'STR#' (STRS_SenseBase + 74, "4A") {	{		"\0x00Command phase error"	}};resource 'STR#' (STRS_SenseBase + 75, "4B") {	{		"\0x00Data phase error"	}};resource 'STR#' (STRS_SenseBase + 76, "4C") {	{		"\0x00Logical unit failed self-configuration"	}};resource 'STR#' (STRS_SenseBase + 78, "4E") {	{		"\0x00Overlapped command attempted"	}};resource 'STR#' (STRS_SenseBase + 80, "50") {	{		"\0x00Write append error",		"\0x01Write append positiion error",		"\0x02Position error related to timing"	}};resource 'STR#' (STRS_SenseBase + 81, "51") {	{		"\0x00Erase failure"	}};resource 'STR#' (STRS_SenseBase + 82, "52") {	{		"\0x00Cartridge fault"	}};resource 'STR#' (STRS_SenseBase + 83, "53") {	{		"\0x00Media load or eject failed",		"\0x01Unload tape failure",		"\0x02Medium removal prevented"	}};resource 'STR#' (STRS_SenseBase + 84, "54") {	{		"\0x00SCSI to host system interface failure"	}};resource 'STR#' (STRS_SenseBase + 85, "55") {	{		"\0x00System resource failure"	}};resource 'STR#' (STRS_SenseBase + 87, "57") {	{		"\0x00unable to recover table of contents"	}};resource 'STR#' (STRS_SenseBase + 88, "58") {	{		"\0x00Generation does not exist"	}};resource 'STR#' (STRS_SenseBase + 89, "59") {	{		"\0x00Updated block read"	}};resource 'STR#' (STRS_SenseBase + 90, "5A") {	{		"\0x00Operator request or state change input (unspecified)",		"\0x01Operator medium removal request",		"\0x02Operator selected write protect",		"\0x03Operator selected write permit"	}};resource 'STR#' (STRS_SenseBase + 91, "5B") {	{		"\0x00Log exception",		"\0x01Threshold condition met",		"\0x02Log counter at maximum",		"\0x03Log list codes exhausted"	}};resource 'STR#' (STRS_SenseBase + 92, "5C") {	{		"\0x00RPL status change",		"\0x01Spindles synchronized",		"\0x02Spindles not synchronized"	}};resource 'STR#' (STRS_SenseBase + 96, "60") {	{		"\0x00Lamp failure"	}};resource 'STR#' (STRS_SenseBase + 97, "61") {	{	/* array StringArray: 3 elements */		/* [1] */		"\0x00Video acquisition error",		"\0x01unable to acquire video",		"\0x02Out of focus"	}};resource 'STR#' (STRS_SenseBase + 98, "62") {	{		"\0x00Scan head positioning error"	}};resource 'STR#' (STRS_SenseBase + 99, "63") {	{		"\0x00End of user area encountered on this track"	}};resource 'STR#' (STRS_SenseBase + 100, "64") {	{		"\0x00Illegal mode for this track"	}};resource 'SIZE' (-1) {	reserved,	ignoreSuspendResumeEvents,	reserved,	cannotBackground,	notMultiFinderAware,	backgroundAndForeground,	dontGetFrontClicks,	ignoreChildDiedEvents,	is32BitCompatible,	notHighLevelEventAware,	onlyLocalHLEvents,	notStationeryAware,	dontUseTextEditServices,	reserved,	reserved,	reserved,	393216,	393216};