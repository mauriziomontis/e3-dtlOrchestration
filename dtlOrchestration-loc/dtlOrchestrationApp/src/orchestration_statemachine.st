/* DTL Orchestration State Machine
# State Machine devoted to control and manage DTL apparatus:
#
# Principal States:
# - Initialization:
# 	    * Initial state where DTL control system (HW and SW) is powered on
# - Stand By:
#       * DTL apparatus has all the functional sub-systems ready and there is no RF
# - RF Conditioning:
#       * DTL apparatus can accept RF for conditioning
# - RF Start-Up:
#       * DTL apparatus can accept RF but not the beam
# - Ready-for-operation:
#       * DTL apparatus has RF at the nominal frequency and filed level and it can accept the beam
# - No Accelerated Beam:
#       * This status devoted to prepare a single tank to transport the beam without RF
# - Maintenance:
#       * Status where the machine is under maintenance. Useful to indicate possible operation and works on the apparatus
#
#
# developed by Maurizio Montis | INFN-LNL
# mail: maurizio.montis@lnl.infn.it
*/

program orchestration_statemachine

/*
# Libraries
*/

%%#include <stdio.h>
%%#include <stdlib.h>
%%#include <string.h>
%%#include <unistd.h>

/*
# Variables and Constants
*/

/* -------- Ok Status -------- */
// Vacuum System
int T1_Vacuum_OK_Status;
assign T1_Vacuum_OK_Status to "";
monitor T1_Vacuum_OK_Status;
int T2_Vacuum_OK_Status;
assign T2_Vacuum_OK_Status to "";
monitor T2_Vacuum_OK_Status;
int T3_Vacuum_OK_Status;
assign T3_Vacuum_OK_Status to "";
monitor T3_Vacuum_OK_Status;
int T4_Vacuum_OK_Status;
assign T4_Vacuum_OK_Status to "";
monitor T4_Vacuum_OK_Status;
int T5_Vacuum_OK_Status;
assign T5_Vacuum_OK_Status to "";
monitor T5_Vacuum_OK_Status;

// Cooling System
int T0_Coolong_OK_Status;
assign T0_Coolong_OK_Status to "CWM-CWS04:Ctrl-Intf-001:OkStat-RB";
monitor T0_Coolong_OK_Status;
int T1_Cooling_OK_Status;
assign T1_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-010Ok-RB";
monitor T1_Cooling_OK_Status;
int T2_Cooling_OK_Status;
assign T2_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-020Ok-RB";
monitor T2_Cooling_OK_Status;
int T3_Cooling_OK_Status;
assign T3_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-030Ok-RB";
monitor T3_Cooling_OK_Status;
int T4_Cooling_OK_Status;
assign T4_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-040Ok-RB";
monitor T4_Cooling_OK_Status;
int T5_Cooling_OK_Status;
assign T5_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-050Ok-RB";
monitor T5_Cooling_OK_Status;

// Temperature --> RF
int T1_RFSlow_OK_Status;
assign T1_RFSlow_OK_Status to "DTL-010:EMR-Cav-001:WrtC_OkStatS";
monitor T1_RFSlow_OK_Status;
int T2_RFSlow_OK_Status;
assign T2_RFSlow_OK_Status to "DTL-020:EMR-Cav-001:WrtC_OkStatS";
monitor T2_RFSlow_OK_Status;
int T3_RFSlow_OK_Status;
assign T3_RFSlow_OK_Status to "DTL-030:EMR-Cav-001:WrtC_OkStatS";
monitor T3_RFSlow_OK_Status;
int T4_RFSlow_OK_Status;
assign T4_RFSlow_OK_Status to "DTL-040:EMR-Cav-001:WrtC_OkStatS";
monitor T4_RFSlow_OK_Status;
int T5_RFSlow_OK_Status;
assign T5_RFSlow_OK_Status to "DTL-050:EMR-Cav-001:WrtC_OkStatS";
monitor T5_RFSlow_OK_Status;

// Steerer System   -- TBD in steerere ST
int T1_Steerer_OK_Status;
assign T1_Steerer_OK_Status to "";
monitor T1_Steerer_OK_Status;
int T2_Steerer_OK_Status;
assign T2_Steerer_OK_Status to "";
monitor T2_Steerer_OK_Status;
int T3_Steerer_OK_Status;
assign T3_Steerer_OK_Status to "";
monitor T3_Steerer_OK_Status;
int T4_Steerer_OK_Status;
assign T4_Steerer_OK_Status to "";
monitor T4_Steerer_OK_Status;
int T5_Steerer_OK_Status;
assign T5_Steerer_OK_Status to "";
monitor T5_Steerer_OK_Status;

// Tuner System
int T1_Tuner_OK_Status;
assign T1_Tuner_OK_Status to "DTL-010:MC-MCU:OkStat-RB";
monitor T1_Tuner_OK_Status;
int T2_Tuner_OK_Status;
assign T2_Tuner_OK_Status to "DTL-020:MC-MCU:OkStat-RB";
monitor T2_Tuner_OK_Status;
int T3_Tuner_OK_Status;
assign T3_Tuner_OK_Status to "DTL-030:MC-MCU:OkStat-RB";
monitor T3_Tuner_OK_Status;
int T4_Tuner_OK_Status;
assign T4_Tuner_OK_Status to "DTL-040:MC-MCU:OkStat-RB";
monitor T4_Tuner_OK_Status;
int T5_Tuner_OK_Status;
assign T5_Tuner_OK_Status to "DTL-050:MC-MCU:OkStat-RB";
monitor T5_Tuner_OK_Status;

// Arc Detection System
int T1_ArcDetection_OK_Status;
assign T1_ArcDetection_OK_Status to "DTL-010:RFS-AD:OkStat-RB";
monitor T1_ArcDetection_OK_Status;
int T2_ArcDetection_OK_Status;
assign T2_ArcDetection_OK_Status to "DTL-020:RFS-AD:OkStat-RB";
monitor T2_ArcDetection_OK_Status;
int T3_ArcDetection_OK_Status;
assign T3_ArcDetection_OK_Status to "DTL-030:RFS-AD:OkStat-RB";
monitor T3_ArcDetection_OK_Status;
int T4_ArcDetection_OK_Status;
assign T4_ArcDetection_OK_Status to "DTL-040:RFS-AD:OkStat-RB";
monitor T4_ArcDetection_OK_Status;
int T5_ArcDetection_OK_Status;
assign T5_ArcDetection_OK_Status to "DTL-050:RFS-AD:OkStat-RB";
monitor T5_ArcDetection_OK_Status;


/* -------- Cooling System: EPICS <-> PLC Communication -------- */
double EPICS_Message;
assign EPICS_Message to "CWM-CWS04:Ctrl-Intf-001:EPICSCommMsg";
monitor EPICS_Message;
double PLC_Message;
assign PLC_Message to "CWM-CWS04:Ctrl-Intf-001:PLCCommMsg";
monitor PLC_Message;


/* -------- Manual/Auto Control -------- */
// Vacuum System - no MAN|AUTO control

// Cooling System
int Cooling_AutoControlCmd;
assign Cooling_AutoControlCmd to "DTL:WtrC:AutoCmd";
monitor Cooling_AutoControlCmd;
int Cooling_AutoControl_ActualStatus;
assign Cooling_AutoControl_ActualStatus to "DTL:WtrC:AutoCmd-RB";
monitor Cooling_AutoControl_ActualStatus;

// Temperature System - no MAN|AUTO control

// Steerer System
int Steerer_AutoControlCmd;
assign Steerer_AutoControlCmd to "DTL:PwrC-PSC:AutoCmd";
monitor Steerer_AutoControlCmd;
int Steerer_AutoControl_ActualStatus;
assign Steerer_AutoControl_ActualStatus to "DTL:PwrC-PSC:AutoCmd-RB";
monitor Steerer_AutoControl_ActualStatus;

// Tuner System
int Tuners_AutoControlCmd;
assign Tuners_AutoControlCmd to "DTL:MC-MCU:AutoCmd";
monitor Tuners_AutoControlCmd;
int Tuners_AutoControl_ActualStatus;
assign Tuners_AutoControl_ActualStatus to "DTL:MC-MCU:AutoCmd-RB";
monitor Tuners_AutoControl_ActualStatus;

// Arc Detection System
int ArcDetection_AutoControlCmd;
assign ArcDetection_AutoControlCmd to "DTL:RFS-AD:AutoCmd";
monitor ArcDetection_AutoControlCmd;
int ArcDetection_AutoControl_ActualStatus;
assign ArcDetection_AutoControl_ActualStatus to "DTL:RFS-AD:AutoCmd-RB";
monitor ArcDetection_AutoControl_ActualStatus;


/* -------- Cooling Manual Test Procedure Completed Command -------- */ //--- TBD
int Manual_Test_Done;
assign Manual_Test_Done to "DTL:WtrC:TestDone";
monitor Manual_Test_Done;


/* -------- Start and Stop Operations -------- */
// Vacuum System - not defined

// Cooling System
int Cooling_StartOperationCmd;
assign Cooling_StartOperationCmd to "DTL:WtrC:OpRun";
monitor Cooling_StartOperationCmd;
int Cooling_StopOperationCmd;
assign Cooling_StopOperationCmd to "DTL:WtrC:OpStop";
monitor Cooling_StopOperationCmd;
/* Manual Test Procedure Completed Command*/
int Cooling_Manual_Test_Done;
assign Cooling_Manual_Test_Done to "DTL:WtrC:TestDone";
monitor Cooling_Manual_Test_Done;

// Temperatures System - not defined

// Steerer System
int Steerer_StartOperationCmd;
assign Steerer_StartOperationCmd to "DTL:PwrC-PSC:OpRun";
monitor Steerer_StartOperationCmd;
int Steerer_StopOperationCmd;
assign Steerer_StopOperationCmd to "DTL:PwrC-PSC:OpStop";
monitor Steerer_StopOperationCmd;

// Tuners System
int Tuners_StartOperationCmd;
assign Tuners_StartOperationCmd to "DTL:MC-MCU:OpRun";
monitor Tuners_StartOperationCmd;
int Tuners_StopOperationCmd;
assign Tuners_StopOperationCmd to "DTL:MC-MCU:OpStop";
monitor Tuners_StopOperationCmd;

// Arc Detection System
int ArcDetection_StartOperationCmd;
assign ArcDetection_StartOperationCmd to "DTL:RFS-AD:OpRun";
monitor ArcDetection_StartOperationCmd;
/* Manual Test Procedure Completed Command*/
int ArcDetection_Manual_Test_Done;
assign ArcDetection_Manual_Test_Done to "DTL:RFS-AD:TestDone";
monitor ArcDetection_Manual_Test_Done;


/* -------- Maintenance and fault control -------- */
// Vacuum System - TBC

// Cooling System
int Cooling_MaintenanceReset;
assign Cooling_MaintenanceReset to "DTL:WtrC:MaintenanceRst";
monitor Cooling_MaintenanceReset;
int Cooling_FaultReset;
assign Cooling_FaultReset to "DTL:WtrC:FaultRst";
monitor Cooling_FaultReset;

// Temperature System
int Temperature_MaintenanceReset;
assign Temperature_MaintenanceReset to "DTL:EMR-TT:MaintenanceRst";
monitor Temperature_MaintenanceReset;
int Temperature_FaultReset;
assign Temperature_FaultReset to "DTL:EMR-TT:FaultRst";
monitor Temperature_FaultReset;

// Steerer System
int Steerer_MaintenanceReset;
assign Steerer_MaintenanceReset to "DTL:PwrC:MaintenanceRst";
monitor Steerer_MaintenanceReset;
int Steerer_FaultReset;
assign Steerer_FaultReset to "DTL:PwrC:FaultRst";
monitor Steerer_FaultReset;

// Tuners System
int Tuners_MaintenanceReset;
assign Tuners_MaintenanceReset to "DTL:MC-MCU:MaintenanceRst";
monitor Tuners_MaintenanceReset;
int Tuners_FaultReset;
assign Tuners_FaultReset to "DTL:MC-MCU:FaultRst";
monitor Tuners_FaultReset;

// Arc Detect System
int ArcDetection_MaintenanceReset;
assign ArcDetection_MaintenanceReset to "DTL:RFS-AD:MaintenanceRst";
monitor ArcDetection_MaintenanceReset;
int ArcDetection_FaultReset;
assign ArcDetection_FaultReset to "DTL:RFS-AD:FaultRst";
monitor ArcDetection_FaultReset;


/* -------- Delta Frequency Detuning -------- */
/*
 * RF Freq Low Threshold Δf1
 * RF Freq High Threshold Δf2
 * | Δf1 | < | Δf2 |
*/
double Freq_High_Delta;
assign Freq_High_Delta to "DTL:RFS:BeamOpHDeltaFreq";
monitor Freq_High_Delta;
double Freq_Low_Delta;
assign Freq_Low_Delta to "DTL:RFS:BeamOpHDeltaFreq";
monitor Freq_Low_Delta;

/* DTL Frequency Detuning  */
double DTL_Frequency_Detuning;
assign  DTL_Frequency_Detuning to "";
monitor DTL_Frequency_Detuning;

/* DTL Frequency Mode */
/*
 * Code:
 *  909 --> Frequency Following Mode (FF Mode)
 *  808 --> Fixed Frequency
*/
int DTL_Frequency_Mode;
assign DTL_Frequency_Mode to "DTL:RFS:FreqMode";
monitor DTL_Frequency_Mode;


/* -------- Vacuum Working Parameters -------- */
/*
 * RF Conditioning Pressure P0 [mBar]
 * RF Start-Up Pressure P1 [mBar]
 * RF Beam Operation && No Accelerated Beam Pressure P2 [mBar]
*/
double DTL_Vacuum_RF_Conditioning_Working_Pressure;
assign DTL_Vacuum_RF_Conditioning_Working_Pressure to "DTL:VacS:RFCondWorkingPrs";
monitor DTL_Vacuum_RF_Conditioning_Working_Pressure;
double DTL_Vacuum_StartUp_Working_Pressure;
assign DTL_Vacuum_StartUp_Working_Pressure to "DTL:VacS:RFStartUpWorkingPrs";
monitor DTL_Vacuum_StartUp_Working_Pressure;
double DTL_Vacuum_RF_Beam_Operation_Working_Pressure;
assign DTL_Vacuum_RF_Beam_Operation_Working_Pressure to "DTL:VacS:RFBeamOpWorkingPrs";
monitor DTL_Vacuum_RF_Beam_Operation_Working_Pressure;


/* -------- Cooling Working Parameters -------- */
/*
 * RF Conditioning Working Temperature t0
 * RF Start-up and Ready for Operations Working Temperature t1
 * No Accelerated Beam Working Temperature t2
 * Delta Temperature Δt
*/
double DTL_Cooling_RF_Conditioning_Working_Temperature;
assign DTL_Cooling_RF_Conditioning_Working_Temperature to "DTL:WtrC:RFCondWorkingTmp";
monitor DTL_Cooling_RF_Conditioning_Working_Temperature;
double DTL_Cooling_RF_Beam_Operation_Working_Temperature;
assign DTL_Cooling_RF_Beam_Operation_Working_Temperature to "DTL:WtrC:BeamOpWorkingTmp";
monitor DTL_Cooling_RF_Beam_Operation_Working_Temperature;
double DTL_Cooling_RF_No_Beam_Working_Temperature;
assign DTL_Cooling_RF_No_Beam_Working_Temperature to "DTL:WtrC:NoBeamWorkingTmp";
monitor DTL_Cooling_RF_No_Beam_Working_Temperature;
double DTL_Cooling_RF_Delta_Working_Temperature;
assign DTL_Cooling_RF_Delta_Working_Temperature to "DTL:WtrC:DeltaWorkingTmp";
monitor DTL_Cooling_RF_Delta_Working_Temperature;


/* -------- Temperature Working Parameters -------- */
/*
 * RF Conditioning Max Temperature T0_MAX [degC]
 * RF Start-Up && RF Bema Operation Max Temperature T1_MAX [degC]
 * No Accelerated Beam Max Temperature T2_MAX [degC]
*/
double DTL_Thermosensors_RF_Conditioning_Max_Temperature;
assign DTL_Thermosensors_RF_Conditioning_Max_Temperature to "DTL:EMR-TT:RFCondWorkingTmp";
monitor DTL_Thermosensors_RF_Conditioning_Max_Temperature;
double DTL_Thermosensors_RF_Beam_Operation_Max_Temperature;
assign DTL_Thermosensors_RF_Beam_Operation_Max_Temperature to "DTL:EMR-TT:RFBeamOpWorkingTmp";
monitor DTL_Thermosensors_RF_Beam_Operation_Max_Temperature;
double DTL_Thermosensors_RF_No_Beam_Max_Temperature;
assign DTL_Thermosensors_RF_No_Beam_Max_Temperature to "DTL:EMR-TT:RFNoBeamWorkingTmp";
monitor DTL_Thermosensors_RF_No_Beam_Max_Temperature;


/* -------- Tuners Positions Working Parameters -------- */
/*
 * RF Conditioning in homing by default
 * RF Start-Up Position Pos0 [mm]
*/
double DTL_Tuners_RF_Startup_Working_Position;
assign DTL_Tuners_RF_Startup_Working_Position to "DTL:MC-MCU:RFStartUpWorkingPos";
monitor DTL_Tuners_RF_Startup_Working_Position;



/* -------- Steerer Current Working Parameters -------- */
/*
 * RF Conditioning is disabled (0A)
 * RF Start-Up Position Cur0 [A]
*/
double DTL_Steerer_RF_Startup_Working_Current;
assign DTL_Steerer_RF_Startup_Working_Current to "DTL:PwrC-PSCV:RFStartUpWorkingCur";
monitor DTL_Steerer_RF_Startup_Working_Current;



/* -------- RF Operations -------- */
/* Missing PV from main system */
int DTL_RF_Ready;
assign DTL_RF_Ready to "DTL::RFOKStat";
monitor DTL_RF_Ready;
int DTL_T1_RF_Ready;
assign DTL_T1_RF_Ready to "DTL-010::RFOKStat";
monitor DTL_T1_RF_Ready;
int DTL_T2_RF_Ready;
assign DTL_T2_RF_Ready to "DTL-020::RFOKStat";
monitor DTL_T2_RF_Ready;
int DTL_T3_RF_Ready;
assign DTL_T3_RF_Ready to "DTL-030::RFOKStat";
monitor DTL_T3_RF_Ready;
int DTL_T4_RF_Ready;
assign DTL_T4_RF_Ready to "DTL-040::RFOKStat";
monitor DTL_T4_RF_Ready;
int DTL_T5_RF_Ready;
assign DTL_T5_RF_Ready to "DTL-050::RFOKStat";
monitor DTL_T5_RF_Ready;

/* -------- Beam Operations -------- */
/* Missing PV from main system */
int DTL_Beam_Ready;
assign DTL_Beam_Ready to "DTL::BeamOKStat";
monitor DTL_Beam_Ready;
int DTL_T1_Beam_Ready;
assign DTL_T1_Beam_Ready to "DTL-010::BeamOKStat";
monitor DTL_T1_Beam_Ready;
int DTL_T2_Beam_Ready;
assign DTL_T2_Beam_Ready to "DTL-020::BeamOKStat";
monitor DTL_T2_Beam_Ready;
int DTL_T3_Beam_Ready;
assign DTL_T3_Beam_Ready to "DTL-030::BeamOKStat";
monitor DTL_T3_Beam_Ready;
int DTL_T4_Beam_Ready;
assign DTL_T4_Beam_Ready to "DTL-040::BeamOKStat";
monitor DTL_T4_Beam_Ready;
int DTL_T5_Beam_Ready;
assign DTL_T5_Beam_Ready to "DTL-050::BeamOKStat";
monitor DTL_T5_Beam_Ready;



/* -------- Tuner PID enable commands -------- */
int Tuners_T1_M1_PID_Enable;
assign Tuners_T1_M1_PID_Enable to "DTL-010:EMR-SM-001:CtrlPID-En";
monitor Tuners_T1_M1_PID_Enable;
int Tuners_T1_M2_PID_Enable;
assign Tuners_T1_M2_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T1_M2_PID_Enable;
int Tuners_T1_M3_PID_Enable;
assign Tuners_T1_M3_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T1_M3_PID_Enable;
int Tuners_T2_M1_PID_Enable;
assign Tuners_T2_M1_PID_Enable to "DTL-010:EMR-SM-001:CtrlPID-En";
monitor Tuners_T2_M1_PID_Enable;
int Tuners_T2_M2_PID_Enable;
assign Tuners_T2_M2_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T2_M2_PID_Enable;
int Tuners_T2_M3_PID_Enable;
assign Tuners_T2_M3_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T2_M3_PID_Enable;
int Tuners_T3_M1_PID_Enable;
assign Tuners_T3_M1_PID_Enable to "DTL-010:EMR-SM-001:CtrlPID-En";
monitor Tuners_T3_M1_PID_Enable;
int Tuners_T3_M2_PID_Enable;
assign Tuners_T3_M2_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T3_M2_PID_Enable;
int Tuners_T3_M3_PID_Enable;
assign Tuners_T3_M3_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T3_M3_PID_Enable;
int Tuners_T4_M1_PID_Enable;
assign Tuners_T4_M1_PID_Enable to "DTL-010:EMR-SM-001:CtrlPID-En";
monitor Tuners_T4_M1_PID_Enable;
int Tuners_T4_M2_PID_Enable;
assign Tuners_T4_M2_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T4_M2_PID_Enable;
int Tuners_T4_M3_PID_Enable;
assign Tuners_T4_M3_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T4_M3_PID_Enable;
int Tuners_T5_M1_PID_Enable;
assign Tuners_T5_M1_PID_Enable to "DTL-010:EMR-SM-001:CtrlPID-En";
monitor Tuners_T5_M1_PID_Enable;
int Tuners_T5_M2_PID_Enable;
assign Tuners_T5_M2_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T5_M2_PID_Enable;
int Tuners_T5_M3_PID_Enable;
assign Tuners_T5_M3_PID_Enable to "DTL-010:EMR-SM-002:CtrlPID-En";
monitor Tuners_T5_M3_PID_Enable;

/* -------- Tuner motor enable commands -------- */
int Tuners_T1_M1_Axis_Enable;
assign Tuners_T1_M1_Axis_Enable to "DTL-010:EMR-SM-001.CNEN";
monitor Tuners_T1_M1_Axis_Enable;
int Tuners_T1_M2_Axis_Enable;
assign Tuners_T1_M2_Axis_Enable to "DTL-010:EMR-SM-002.CNEN";
monitor Tuners_T1_M2_Axis_Enable;
int Tuners_T1_M3_Axis_Enable;
assign Tuners_T1_M3_Axis_Enable to "DTL-010:EMR-SM-003.CNEN";
monitor Tuners_T1_M3_Axis_Enable;
int Tuners_T2_M1_Axis_Enable;
assign Tuners_T2_M1_Axis_Enable to "DTL-020:EMR-SM-001.CNEN";
monitor Tuners_T2_M1_Axis_Enable;
int Tuners_T2_M2_Axis_Enable;
assign Tuners_T2_M2_Axis_Enable to "DTL-020:EMR-SM-002.CNEN";
monitor Tuners_T2_M2_Axis_Enable;
int Tuners_T2_M3_Axis_Enable;
assign Tuners_T2_M3_Axis_Enable to "DTL-020:EMR-SM-003.CNEN";
monitor Tuners_T2_M3_Axis_Enable;
int Tuners_T3_M1_Axis_Enable;
assign Tuners_T3_M1_Axis_Enable to "DTL-030:EMR-SM-001.CNEN";
monitor Tuners_T3_M1_Axis_Enable;
int Tuners_T3_M2_Axis_Enable;
assign Tuners_T3_M2_Axis_Enable to "DTL-030:EMR-SM-002.CNEN";
monitor Tuners_T3_M2_Axis_Enable;
int Tuners_T3_M3_Axis_Enable;
assign Tuners_T3_M3_Axis_Enable to "DTL-030:EMR-SM-003.CNEN";
monitor Tuners_T3_M3_Axis_Enable;
int Tuners_T4_M1_Axis_Enable;
assign Tuners_T4_M1_Axis_Enable to "DTL-040:EMR-SM-001.CNEN";
monitor Tuners_T4_M1_Axis_Enable;
int Tuners_T4_M2_Axis_Enable;
assign Tuners_T4_M2_Axis_Enable to "DTL-040:EMR-SM-002.CNEN";
monitor Tuners_T4_M2_Axis_Enable;
int Tuners_T4_M3_Axis_Enable;
assign Tuners_T4_M3_Axis_Enable to "DTL-040:EMR-SM-003.CNEN";
monitor Tuners_T4_M3_Axis_Enable;
int Tuners_T5_M1_Axis_Enable;
assign Tuners_T5_M1_Axis_Enable to "DTL-050:EMR-SM-001.CNEN";
monitor Tuners_T5_M1_Axis_Enable;
int Tuners_T5_M2_Axis_Enable;
assign Tuners_T5_M2_Axis_Enable to "DTL-050:EMR-SM-002.CNEN";
monitor Tuners_T5_M2_Axis_Enable;
int Tuners_T5_M3_Axis_Enable;
assign Tuners_T5_M3_Axis_Enable to "DTL-050:EMR-SM-003.CNEN";
monitor Tuners_T5_M3_Axis_Enable;

/* -------- Tuner motor position -------- */
double Tuners_T1_M1_Axis_Position;
assign Tuners_T1_M1_Axis_Position to "DTL-010:EMR-SM-001.VAL";
monitor Tuners_T1_M1_Axis_Position;
double Tuners_T1_M2_Axis_Position;
assign Tuners_T1_M2_Axis_Position to "DTL-010:EMR-SM-002.VAL";
monitor Tuners_T1_M2_Axis_Position;
double Tuners_T1_M3_Axis_Position;
assign Tuners_T1_M3_Axis_Position to "DTL-010:EMR-SM-003.VAL";
monitor Tuners_T1_M3_Axis_Position;
double Tuners_T2_M1_Axis_Position;
assign Tuners_T2_M1_Axis_Position to "DTL-020:EMR-SM-001.VAL";
monitor Tuners_T2_M1_Axis_Position;
double Tuners_T2_M2_Axis_Position;
assign Tuners_T2_M2_Axis_Position to "DTL-020:EMR-SM-002.VAL";
monitor Tuners_T2_M2_Axis_Position;
double Tuners_T2_M3_Axis_Position;
assign Tuners_T2_M3_Axis_Position to "DTL-020:EMR-SM-003.VAL";
monitor Tuners_T2_M3_Axis_Position;
double Tuners_T3_M1_Axis_Position;
assign Tuners_T3_M1_Axis_Position to "DTL-030:EMR-SM-001.VAL";
monitor Tuners_T3_M1_Axis_Position;
double Tuners_T3_M2_Axis_Position;
assign Tuners_T3_M2_Axis_Position to "DTL-030:EMR-SM-002.VAL";
monitor Tuners_T3_M2_Axis_Position;
double Tuners_T3_M3_Axis_Position;
assign Tuners_T3_M3_Axis_Position to "DTL-030:EMR-SM-003.VAL";
monitor Tuners_T3_M3_Axis_Position;
double Tuners_T4_M1_Axis_Position;
assign Tuners_T4_M1_Axis_Position to "DTL-040:EMR-SM-001.VAL";
monitor Tuners_T4_M1_Axis_Position;
double Tuners_T4_M2_Axis_Position;
assign Tuners_T4_M2_Axis_Position to "DTL-040:EMR-SM-002.VAL";
monitor Tuners_T4_M2_Axis_Position;
double Tuners_T4_M3_Axis_Position;
assign Tuners_T4_M3_Axis_Position to "DTL-040:EMR-SM-003.VAL";
monitor Tuners_T4_M3_Axis_Position;
double Tuners_T5_M1_Axis_Position;
assign Tuners_T5_M1_Axis_Position to "DTL-050:EMR-SM-001.VAL";
monitor Tuners_T5_M1_Axis_Position;
double Tuners_T5_M2_Axis_Position;
assign Tuners_T5_M2_Axis_Position to "DTL-050:EMR-SM-002.VAL";
monitor Tuners_T5_M2_Axis_Position;
double Tuners_T5_M3_Axis_Position;
assign Tuners_T5_M3_Axis_Position to "DTL-050:EMR-SM-003.VAL";
monitor Tuners_T5_M3_Axis_Position;


/* -------- Steerers enable commands -------- */
int Steerer_T1_V1_ChEnableCmd;
assign Steerer_T1_V1_ChEnableCmd  to "DTL-010:BMD-CV-001:EnCmd";
monitor Steerer_T1_V1_ChEnableCmd;
int Steerer_T1_H1_ChEnableCmd;
assign Steerer_T1_H1_ChEnableCmd  to "DTL-010:BMD-CH-001:EnCmd";
monitor Steerer_T1_H1_ChEnableCmd;
int Steerer_T1_V2_ChEnableCmd;
assign Steerer_T1_V2_ChEnableCmd  to "DTL-010:BMD-CV-002:EnCmd";
monitor Steerer_T1_V2_ChEnableCmd;
int Steerer_T1_H2_ChEnableCmd;
assign Steerer_T1_H2_ChEnableCmd  to "DTL-010:BMD-CH-002:EnCmd";
monitor Steerer_T1_H2_ChEnableCmd;
int Steerer_T1_V3_ChEnableCmd;
assign Steerer_T1_V3_ChEnableCmd  to "DTL-010:BMD-CV-003:EnCmd";
monitor Steerer_T1_V3_ChEnableCmd;
int Steerer_T1_H3_ChEnableCmd;
assign Steerer_T1_H3_ChEnableCmd  to "DTL-010:BMD-CH-003:EnCmd";
monitor Steerer_T1_H3_ChEnableCmd;
int Steerer_T1_V4_ChEnableCmd;
assign Steerer_T1_V4_ChEnableCmd  to "DTL-010:BMD-CV-004:EnCmd";
monitor Steerer_T1_V4_ChEnableCmd;
int Steerer_T1_H4_ChEnableCmd;
assign Steerer_T1_H4_ChEnableCmd  to "DTL-010:BMD-CH-004:EnCmd";
monitor Steerer_T1_H4_ChEnableCmd;
int Steerer_T1_V5_ChEnableCmd;
assign Steerer_T1_V5_ChEnableCmd  to "DTL-010:BMD-CV-005:EnCmd";
monitor Steerer_T1_V5_ChEnableCmd;
int Steerer_T1_H5_ChEnableCmd;
assign Steerer_T1_H5_ChEnableCmd  to "DTL-010:BMD-CH-005:EnCmd";
monitor Steerer_T1_H5_ChEnableCmd;
int Steerer_T1_V6_ChEnableCmd;
assign Steerer_T1_V6_ChEnableCmd  to "DTL-010:BMD-CV-001:EnCmd";
monitor Steerer_T1_V6_ChEnableCmd;
int Steerer_T1_H6_ChEnableCmd;
assign Steerer_T1_H6_ChEnableCmd  to "DTL-010:BMD-CH-001:EnCmd";
monitor Steerer_T1_H6_ChEnableCmd;
int Steerer_T2_V1_ChEnableCmd;
assign Steerer_T2_V1_ChEnableCmd  to "DTL-020:BMD-CV-001:EnCmd";
monitor Steerer_T2_V1_ChEnableCmd;
int Steerer_T2_H1_ChEnableCmd;
assign Steerer_T2_H1_ChEnableCmd  to "DTL-020:BMD-CH-001:EnCmd";
monitor Steerer_T2_H1_ChEnableCmd;
int Steerer_T2_V2_ChEnableCmd;
assign Steerer_T2_V2_ChEnableCmd  to "DTL-020:BMD-CV-002:EnCmd";
monitor Steerer_T2_V2_ChEnableCmd;
int Steerer_T2_H2_ChEnableCmd;
assign Steerer_T2_H2_ChEnableCmd  to "DTL-020:BMD-CH-002:EnCmd";
monitor Steerer_T2_H2_ChEnableCmd;
int Steerer_T2_V3_ChEnableCmd;
assign Steerer_T2_V3_ChEnableCmd  to "DTL-020:BMD-CV-003:EnCmd";
monitor Steerer_T2_V3_ChEnableCmd;
int Steerer_T2_H3_ChEnableCmd;
assign Steerer_T2_H3_ChEnableCmd  to "DTL-020:BMD-CH-003:EnCmd";
monitor Steerer_T2_H3_ChEnableCmd;
int Steerer_T3_V1_ChEnableCmd;
assign Steerer_T3_V1_ChEnableCmd  to "DTL-030:BMD-CV-001:EnCmd";
monitor Steerer_T3_V1_ChEnableCmd;
int Steerer_T3_H1_ChEnableCmd;
assign Steerer_T3_H1_ChEnableCmd  to "DTL-030:BMD-CH-001:EnCmd";
monitor Steerer_T3_H1_ChEnableCmd;
int Steerer_T3_V2_ChEnableCmd;
assign Steerer_T3_V2_ChEnableCmd  to "DTL-030:BMD-CV-002:EnCmd";
monitor Steerer_T3_V2_ChEnableCmd;
int Steerer_T3_H2_ChEnableCmd;
assign Steerer_T3_H2_ChEnableCmd  to "DTL-030:BMD-CH-002:EnCmd";
monitor Steerer_T3_H2_ChEnableCmd;
int Steerer_T4_V1_ChEnableCmd;
assign Steerer_T4_V1_ChEnableCmd  to "DTL-040:BMD-CV-001:EnCmd";
monitor Steerer_T4_V1_ChEnableCmd;
int Steerer_T4_H1_ChEnableCmd;
assign Steerer_T4_H1_ChEnableCmd  to "DTL-040:BMD-CH-001:EnCmd";
monitor Steerer_T4_H1_ChEnableCmd;
int Steerer_T4_V2_ChEnableCmd;
assign Steerer_T4_V2_ChEnableCmd  to "DTL-040:BMD-CV-002:EnCmd";
monitor Steerer_T4_V2_ChEnableCmd;
int Steerer_T4_H2_ChEnableCmd;
assign Steerer_T4_H2_ChEnableCmd  to "DTL-040:BMD-CH-002:EnCmd";
monitor Steerer_T4_H2_ChEnableCmd;
int Steerer_T5_V1_ChEnableCmd;
assign Steerer_T5_V1_ChEnableCmd  to "DTL-050:BMD-CV-001:EnCmd";
monitor Steerer_T5_V1_ChEnableCmd;
int Steerer_T5_H1_ChEnableCmd;
assign Steerer_T5_H1_ChEnableCmd  to "DTL-050:BMD-CH-001:EnCmd";
monitor Steerer_T5_H1_ChEnableCmd;
int Steerer_T5_V2_ChEnableCmd;
assign Steerer_T5_V2_ChEnableCmd  to "DTL-050:BMD-CV-002:EnCmd";
monitor Steerer_T5_V2_ChEnableCmd;
int Steerer_T5_H2_ChEnableCmd;
assign Steerer_T5_H2_ChEnableCmd  to "DTL-050:BMD-CH-002:EnCmd";
monitor Steerer_T5_H2_ChEnableCmd;

/* -------- Steerers current setpoint -------- */
double Steerer_T1_V1_CurrentSet;
assign Steerer_T1_V1_CurrentSet  to "DTL-010:BMD-CV-001:CurSet";
monitor Steerer_T1_V1_CurrentSet;
double Steerer_T1_H1_CurrentSet;
assign Steerer_T1_H1_CurrentSet  to "DTL-010:BMD-CH-001:CurSet";
monitor Steerer_T1_H1_CurrentSet;
double Steerer_T1_V2_CurrentSet;
assign Steerer_T1_V2_CurrentSet  to "DTL-010:BMD-CV-002:CurSet";
monitor Steerer_T1_V2_CurrentSet;
double Steerer_T1_H2_CurrentSet;
assign Steerer_T1_H2_CurrentSet  to "DTL-010:BMD-CH-002:CurSet";
monitor Steerer_T1_H2_CurrentSet;
double Steerer_T1_V3_CurrentSet;
assign Steerer_T1_V3_CurrentSet  to "DTL-010:BMD-CV-003:CurSet";
monitor Steerer_T1_V3_CurrentSet;
double Steerer_T1_H3_CurrentSet;
assign Steerer_T1_H3_CurrentSet  to "DTL-010:BMD-CH-003:CurSet";
monitor Steerer_T1_H3_CurrentSet;
double Steerer_T1_V4_CurrentSet;
assign Steerer_T1_V4_CurrentSet  to "DTL-010:BMD-CV-004:CurSet";
monitor Steerer_T1_V4_CurrentSet;
double Steerer_T1_H4_CurrentSet;
assign Steerer_T1_H4_CurrentSet  to "DTL-010:BMD-CH-004:CurSet";
monitor Steerer_T1_H4_CurrentSet;
double Steerer_T1_V5_CurrentSet;
assign Steerer_T1_V5_CurrentSet  to "DTL-010:BMD-CV-005:CurSet";
monitor Steerer_T1_V5_CurrentSet;
double Steerer_T1_H5_CurrentSet;
assign Steerer_T1_H5_CurrentSet  to "DTL-010:BMD-CH-005:CurSet";
monitor Steerer_T1_H5_CurrentSet;
double Steerer_T1_V6_CurrentSet;
assign Steerer_T1_V6_CurrentSet  to "DTL-010:BMD-CV-001:CurSet";
monitor Steerer_T1_V6_CurrentSet;
double Steerer_T1_H6_CurrentSet;
assign Steerer_T1_H6_CurrentSet  to "DTL-010:BMD-CH-001:CurSet";
monitor Steerer_T1_H6_CurrentSet;
double Steerer_T2_V1_CurrentSet;
assign Steerer_T2_V1_CurrentSet  to "DTL-020:BMD-CV-001:CurSet";
monitor Steerer_T2_V1_CurrentSet;
double Steerer_T2_H1_CurrentSet;
assign Steerer_T2_H1_CurrentSet  to "DTL-020:BMD-CH-001:CurSet";
monitor Steerer_T2_H1_CurrentSet;
double Steerer_T2_V2_CurrentSet;
assign Steerer_T2_V2_CurrentSet  to "DTL-020:BMD-CV-002:CurSet";
monitor Steerer_T2_V2_CurrentSet;
double Steerer_T2_H2_CurrentSet;
assign Steerer_T2_H2_CurrentSet  to "DTL-020:BMD-CH-002:CurSet";
monitor Steerer_T2_H2_CurrentSet;
double Steerer_T2_V3_CurrentSet;
assign Steerer_T2_V3_CurrentSet  to "DTL-020:BMD-CV-003:CurSet";
monitor Steerer_T2_V3_CurrentSet;
double Steerer_T2_H3_CurrentSet;
assign Steerer_T2_H3_CurrentSet  to "DTL-020:BMD-CH-003:CurSet";
monitor Steerer_T2_H3_CurrentSet;
double Steerer_T3_V1_CurrentSet;
assign Steerer_T3_V1_CurrentSet  to "DTL-030:BMD-CV-001:CurSet";
monitor Steerer_T3_V1_CurrentSet;
double Steerer_T3_H1_CurrentSet;
assign Steerer_T3_H1_CurrentSet  to "DTL-030:BMD-CH-001:CurSet";
monitor Steerer_T3_H1_CurrentSet;
double Steerer_T3_V2_CurrentSet;
assign Steerer_T3_V2_CurrentSet  to "DTL-030:BMD-CV-002:CurSet";
monitor Steerer_T3_V2_CurrentSet;
double Steerer_T3_H2_CurrentSet;
assign Steerer_T3_H2_CurrentSet  to "DTL-030:BMD-CH-002:CurSet";
monitor Steerer_T3_H2_CurrentSet;
double Steerer_T4_V1_CurrentSet;
assign Steerer_T4_V1_CurrentSet  to "DTL-040:BMD-CV-001:CurSet";
monitor Steerer_T4_V1_CurrentSet;
double Steerer_T4_H1_CurrentSet;
assign Steerer_T4_H1_CurrentSet  to "DTL-040:BMD-CH-001:CurSet";
monitor Steerer_T4_H1_CurrentSet;
double Steerer_T4_V2_CurrentSet;
assign Steerer_T4_V2_CurrentSet  to "DTL-040:BMD-CV-002:CurSet";
monitor Steerer_T4_V2_CurrentSet;
double Steerer_T4_H2_CurrentSet;
assign Steerer_T4_H2_CurrentSet  to "DTL-040:BMD-CH-002:CurSet";
monitor Steerer_T4_H2_CurrentSet;
double Steerer_T5_V1_CurrentSet;
assign Steerer_T5_V1_CurrentSet  to "DTL-050:BMD-CV-001:CurSet";
monitor Steerer_T5_V1_CurrentSet;
double Steerer_T5_H1_CurrentSet;
assign Steerer_T5_H1_CurrentSet  to "DTL-050:BMD-CH-001:CurSet";
monitor Steerer_T5_H1_CurrentSet;
double Steerer_T5_V2_CurrentSet;
assign Steerer_T5_V2_CurrentSet  to "DTL-050:BMD-CV-002:CurSet";
monitor Steerer_T5_V2_CurrentSet;
double Steerer_T5_H2_CurrentSet;
assign Steerer_T5_H2_CurrentSet  to "DTL-050:BMD-CH-002:CurSet";
monitor Steerer_T5_H2_CurrentSet;


/* -------- Temperature Max level -------- */
double Thermosensors_T1_Max_Temp[62];
assign Thermosensors_T1_Max_Temp[0] to "DTL-010:EMR-TT-001:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[1] to "DTL-010:EMR-TT-002:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[2] to "DTL-010:EMR-TT-003:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[3] to "DTL-010:EMR-TT-004:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[4] to "DTL-010:EMR-TT-005:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[5] to "DTL-010:EMR-TT-006:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[6] to "DTL-010:EMR-TT-007:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[7] to "DTL-010:EMR-TT-008:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[8] to "DTL-010:EMR-TT-009:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[9] to "DTL-010:EMR-TT-010:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[10] to "DTL-010:EMR-TT-011:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[11] to "DTL-010:EMR-TT-012:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[12] to "DTL-010:EMR-TT-013:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[13] to "DTL-010:EMR-TT-014:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[14] to "DTL-010:EMR-TT-015:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[15] to "DTL-010:EMR-TT-016:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[16] to "DTL-010:EMR-TT-017:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[17] to "DTL-010:EMR-TT-018:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[18] to "DTL-010:EMR-TT-019:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[19] to "DTL-010:EMR-TT-020:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[20] to "DTL-010:EMR-TT-021:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[21] to "DTL-010:EMR-TT-022:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[22] to "DTL-010:EMR-TT-023:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[23] to "DTL-010:EMR-TT-024:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[24] to "DTL-010:EMR-TT-025:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[25] to "DTL-010:EMR-TT-026:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[26] to "DTL-010:EMR-TT-027:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[27] to "DTL-010:EMR-TT-028:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[28] to "DTL-010:EMR-TT-029:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[29] to "DTL-010:EMR-TT-030:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[30] to "DTL-010:EMR-TT-031:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[31] to "DTL-010:EMR-TT-032:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[32] to "DTL-010:EMR-TT-033:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[33] to "DTL-010:EMR-TT-034:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[34] to "DTL-010:EMR-TT-035:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[35] to "DTL-010:EMR-TT-036:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[36] to "DTL-010:EMR-TT-037:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[37] to "DTL-010:EMR-TT-038:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[38] to "DTL-010:EMR-TT-039:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[39] to "DTL-010:EMR-TT-040:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[40] to "DTL-010:EMR-TT-041:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[41] to "DTL-010:EMR-TT-042:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[42] to "DTL-010:EMR-TT-043:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[43] to "DTL-010:EMR-TT-044:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[44] to "DTL-010:EMR-TT-045:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[45] to "DTL-010:EMR-TT-046:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[46] to "DTL-010:EMR-TT-047:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[47] to "DTL-010:EMR-TT-048:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[48] to "DTL-010:EMR-TT-049:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[49] to "DTL-010:EMR-TT-050:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[50] to "DTL-010:EMR-TT-051:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[51] to "DTL-010:EMR-TT-052:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[52] to "DTL-010:EMR-TT-053:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[53] to "DTL-010:EMR-TT-054:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[54] to "DTL-010:EMR-TT-055:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[55] to "DTL-010:EMR-TT-056:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[56] to "DTL-010:EMR-TT-057:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[57] to "DTL-010:EMR-TT-058:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[58] to "DTL-010:EMR-TT-059:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[59] to "DTL-010:EMR-TT-060:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[60] to "DTL-010:EMR-TT-100:Temp.HIHI";
assign Thermosensors_T1_Max_Temp[61] to "DTL-010:EMR-TT-200:Temp.HIHI";
monitor Thermosensors_T1_Max_Temp;
double Thermosensors_T2_Max_Temp[35];
assign Thermosensors_T2_Max_Temp[0] to "DTL-020:EMR-TT-001:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[1] to "DTL-020:EMR-TT-002:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[2] to "DTL-020:EMR-TT-003:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[3] to "DTL-020:EMR-TT-004:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[4] to "DTL-020:EMR-TT-005:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[5] to "DTL-020:EMR-TT-006:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[6] to "DTL-020:EMR-TT-007:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[7] to "DTL-020:EMR-TT-008:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[8] to "DTL-020:EMR-TT-009:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[9] to "DTL-020:EMR-TT-010:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[10] to "DTL-020:EMR-TT-011:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[11] to "DTL-020:EMR-TT-012:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[12] to "DTL-020:EMR-TT-013:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[13] to "DTL-020:EMR-TT-014:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[14] to "DTL-020:EMR-TT-015:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[15] to "DTL-020:EMR-TT-016:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[16] to "DTL-020:EMR-TT-017:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[17] to "DTL-020:EMR-TT-018:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[18] to "DTL-020:EMR-TT-019:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[19] to "DTL-020:EMR-TT-020:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[20] to "DTL-020:EMR-TT-021:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[21] to "DTL-020:EMR-TT-022:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[22] to "DTL-020:EMR-TT-023:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[23] to "DTL-020:EMR-TT-024:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[24] to "DTL-020:EMR-TT-025:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[25] to "DTL-020:EMR-TT-026:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[26] to "DTL-020:EMR-TT-027:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[27] to "DTL-020:EMR-TT-028:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[28] to "DTL-020:EMR-TT-029:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[29] to "DTL-020:EMR-TT-030:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[30] to "DTL-020:EMR-TT-031:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[31] to "DTL-020:EMR-TT-032:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[32] to "DTL-020:EMR-TT-033:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[33] to "DTL-020:EMR-TT-100:Temp.HIHI";
assign Thermosensors_T2_Max_Temp[34] to "DTL-020:EMR-TT-200:Temp.HIHI";
monitor Thermosensors_T2_Max_Temp;
double Thermosensors_T3_Max_Temp[30];
assign Thermosensors_T3_Max_Temp[0] to "DTL-030:EMR-TT-001:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[1] to "DTL-030:EMR-TT-002:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[2] to "DTL-030:EMR-TT-003:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[3] to "DTL-030:EMR-TT-004:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[4] to "DTL-030:EMR-TT-005:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[5] to "DTL-030:EMR-TT-006:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[6] to "DTL-030:EMR-TT-007:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[7] to "DTL-030:EMR-TT-008:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[8] to "DTL-030:EMR-TT-009:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[9] to "DTL-030:EMR-TT-010:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[10] to "DTL-030:EMR-TT-011:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[11] to "DTL-030:EMR-TT-012:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[12] to "DTL-030:EMR-TT-013:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[13] to "DTL-030:EMR-TT-014:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[14] to "DTL-030:EMR-TT-015:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[15] to "DTL-030:EMR-TT-016:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[16] to "DTL-030:EMR-TT-017:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[17] to "DTL-030:EMR-TT-018:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[18] to "DTL-030:EMR-TT-019:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[19] to "DTL-030:EMR-TT-020:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[20] to "DTL-030:EMR-TT-021:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[21] to "DTL-030:EMR-TT-022:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[22] to "DTL-030:EMR-TT-023:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[23] to "DTL-030:EMR-TT-024:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[24] to "DTL-030:EMR-TT-025:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[25] to "DTL-030:EMR-TT-026:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[26] to "DTL-030:EMR-TT-027:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[27] to "DTL-030:EMR-TT-028:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[28] to "DTL-030:EMR-TT-100:Temp.HIHI";
assign Thermosensors_T3_Max_Temp[29] to "DTL-030:EMR-TT-200:Temp.HIHI";
monitor Thermosensors_T3_Max_Temp;
double Thermosensors_T4_Max_Temp[27];
assign Thermosensors_T4_Max_Temp[0] to "DTL-040:EMR-TT-001:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[1] to "DTL-040:EMR-TT-002:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[2] to "DTL-040:EMR-TT-003:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[3] to "DTL-040:EMR-TT-004:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[4] to "DTL-040:EMR-TT-005:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[5] to "DTL-040:EMR-TT-006:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[6] to "DTL-040:EMR-TT-007:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[7] to "DTL-040:EMR-TT-008:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[8] to "DTL-040:EMR-TT-009:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[9] to "DTL-040:EMR-TT-010:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[10] to "DTL-040:EMR-TT-011:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[11] to "DTL-040:EMR-TT-012:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[12] to "DTL-040:EMR-TT-013:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[13] to "DTL-040:EMR-TT-014:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[14] to "DTL-040:EMR-TT-015:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[15] to "DTL-040:EMR-TT-016:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[16] to "DTL-040:EMR-TT-017:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[17] to "DTL-040:EMR-TT-018:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[18] to "DTL-040:EMR-TT-019:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[19] to "DTL-040:EMR-TT-020:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[20] to "DTL-040:EMR-TT-021:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[21] to "DTL-040:EMR-TT-022:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[22] to "DTL-040:EMR-TT-023:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[23] to "DTL-040:EMR-TT-024:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[24] to "DTL-040:EMR-TT-025:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[25] to "DTL-040:EMR-TT-100:Temp.HIHI";
assign Thermosensors_T4_Max_Temp[26] to "DTL-040:EMR-TT-200:Temp.HIHI";
monitor Thermosensors_T4_Max_Temp;
double Thermosensors_T5_Max_Temp[24];
assign Thermosensors_T5_Max_Temp[0] to "DTL-050:EMR-TT-001:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[1] to "DTL-050:EMR-TT-002:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[2] to "DTL-050:EMR-TT-003:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[3] to "DTL-050:EMR-TT-004:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[4] to "DTL-050:EMR-TT-005:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[5] to "DTL-050:EMR-TT-006:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[6] to "DTL-050:EMR-TT-007:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[7] to "DTL-050:EMR-TT-008:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[8] to "DTL-050:EMR-TT-009:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[9] to "DTL-050:EMR-TT-010:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[10] to "DTL-050:EMR-TT-011:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[11] to "DTL-050:EMR-TT-012:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[12] to "DTL-050:EMR-TT-013:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[13] to "DTL-050:EMR-TT-014:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[14] to "DTL-050:EMR-TT-015:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[15] to "DTL-050:EMR-TT-016:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[16] to "DTL-050:EMR-TT-017:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[17] to "DTL-050:EMR-TT-018:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[18] to "DTL-050:EMR-TT-019:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[19] to "DTL-050:EMR-TT-020:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[20] to "DTL-050:EMR-TT-021:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[21] to "DTL-050:EMR-TT-022:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[22] to "DTL-050:EMR-TT-100:Temp.HIHI";
assign Thermosensors_T5_Max_Temp[23] to "DTL-050:EMR-TT-200:Temp.HIHI";
monitor Thermosensors_T5_Max_Temp;


/* -------- Vacuum Tank Pressures  -------- */
double Vacuum_T1_Pressure;
assign Vacuum_T1_Pressure to "";
monitor Vacuum_T1_Pressure;
double Vacuum_T2_Pressure;
assign Vacuum_T2_Pressure to "";
monitor Vacuum_T2_Pressure;
double Vacuum_T3_Pressure;
assign Vacuum_T3_Pressure to "";
monitor Vacuum_T3_Pressure;
double Vacuum_T4_Pressure;
assign Vacuum_T4_Pressure to "";
monitor Vacuum_T4_Pressure;
double Vacuum_T5_Pressure;
assign Vacuum_T5_Pressure to "";
monitor Vacuum_T5_Pressure;

/* -------- Vacuum inter-Tank valves   -------- */
int Vacuum_T1_Intertank_Valve_Status;
assign Vacuum_T1_Intertank_Valve_Status to "";
monitor Vacuum_T1_Intertank_Valve_Status;
int Vacuum_T2_Intertank_Valve_Status;
assign Vacuum_T2_Intertank_Valve_Status to "";
monitor Vacuum_T2_Intertank_Valve_Status;
int Vacuum_T3_Intertank_Valve_Status;
assign Vacuum_T3_Intertank_Valve_Status to "";
monitor Vacuum_T3_Intertank_Valve_Status;
int Vacuum_T4_Intertank_Valve_Status;
assign Vacuum_T4_Intertank_Valve_Status to "";
monitor Vacuum_T4_Intertank_Valve_Status;
int Vacuum_T5_Intertank_Valve_Status;
assign Vacuum_T5_Intertank_Valve_Status to "";
monitor Vacuum_T5_Intertank_Valve_Status;






/*
# Stages Code:
# 	0  -> INIT
# 	10 -> SELF-CHECK
# 	20 -> IDLE
# 	30 -> START-UP
# 	40 -> READY FOR OPERATION
# 	50 -> FAILURE
# 	60 -> MAINTENANCE
*/
// Vacuum System - not defined

// Cooling System
int Cooling_StateMachineCode;
assign Cooling_StateMachineCode to "DTL:WtrC:StateMachine";
monitor Cooling_StateMachineCode;

// Temperature System
int Temperature_T1_StateMachineCode;
assign Temperature_T1_StateMachineCode to "DTL-010:EMR-TT:StateMachine";
monitor Temperature_T1_StateMachineCode;
int Temperature_T2_StateMachineCode;
assign Temperature_T2_StateMachineCode to "DTL-020:EMR-TT:StateMachine";
monitor Temperature_T2_StateMachineCode;
int Temperature_T3_StateMachineCode;
assign Temperature_T3_StateMachineCode to "DTL-030:EMR-TT:StateMachine";
monitor Temperature_T3_StateMachineCode;
int Temperature_T4_StateMachineCode;
assign Temperature_T4_StateMachineCode to "DTL-040:EMR-TT:StateMachine";
monitor Temperature_T4_StateMachineCode;
int Temperature_T5_StateMachineCode;
assign Temperature_T5_StateMachineCode to "DTL-050:EMR-TT:StateMachine";
monitor Temperature_T5_StateMachineCode;

// Steerer System
int Steerer_StateMachineCode;
assign Steerer_StateMachineCode to "DTL:PwrC:StateMachine";
monitor Steerer_StateMachineCode;

// Tuner System
int Tuners_StateMachineCode;
assign Tuners_StateMachineCode to "DTL:MC-MCU:StateMachine";
monitor Tuners_StateMachineCode;

// Arc Detection System
int ArcDetection_StateMachineCode;
assign ArcDetection_StateMachineCode to "DTL:RFS-AD:StateMachine";
monitor ArcDetection_StateMachineCode;


/*
# DTL Operational State Machine Code:
# 	0   -> INIT
# 	101 -> STAND-BY
# 	202 -> RF CONDITIONING
# 	303 -> RF START-UP
# 	404 -> READY FOR OPERATION
# 	505 -> NO ACCELERATED BEAM
# 	606 -> MAINTENANCE
*/
int dtlOperationalCode;
assign dtlOperationalCode to "DTL::StateMachine";
monitor dtlOperationalCode;

// PV "DTL::Operation" to temporary (to be changed)
/*
  Notes:
    - stage INITIALIZATION cannot be forced to change (only automatic setup)
    - stage MAINTENANCE cannot be forced to change (only maintenance reset allowed)
*/
int dtlOperationalCode_Command;
assign dtlOperationalCode_Command to "DTL::Operation";
monitor dtlOperationalCode_Command;



/* -------- DTL Maintenance -------- */
int DTL_Maintenance_Command;
assign DTL_Maintenance_Command to "DTL::Maintenance";
monitor DTL_Maintenance_Command;
int DTL_Maintenance_Readback;
assign DTL_Maintenance_Readback to "DTL::Maintenance-RB";
monitor DTL_Maintenance_Readback;


/* -------- Constants -------- */


/* Internal Variables */
int dtl_operation_code_prev=0;
int dtl_operation_command_prev=0;
int index;

/* -------- Debug Mode: -------- */
double DEBUG=1;



/*
# State Machine Definition
*/

ss  orchestration_statemachine {

/* state INITIALIZATION	*/
	state initialization {
      entry {
        printf("\n\nPreliminary controls executed due to Application Startup - Intialization\n\n");
        dtl_operation_code_prev=dtlOperationalCode;
        dtlOperationalCode=0;
        pvPut(dtlOperationalCode);
        dtl_operation_command_prev=dtlOperationalCode_Command;

        /* Actual man|auto control initialization */
        printf("[SEQ ORCHESTRATION] MAN|AUTO control initialization: set systems to MANUAL Mode\n");
        // Cooling
        Cooling_AutoControlCmd=0;
        Cooling_AutoControl_ActualStatus=Cooling_AutoControlCmd;
        pvPut(Cooling_AutoControlCmd);
        pvPut(Cooling_AutoControl_ActualStatus);
        // Steerers
        Steerer_AutoControlCmd=0;
        Steerer_AutoControl_ActualStatus=Steerer_AutoControlCmd;
        pvPut(Steerer_AutoControlCmd);
        pvPut(Steerer_AutoControl_ActualStatus);
        // Tuners
        Tuners_AutoControlCmd=0;
        Tuners_AutoControl_ActualStatus=Tuners_AutoControlCmd;
        pvPut(Tuners_AutoControlCmd);
        pvPut(Tuners_AutoControl_ActualStatus);
        // Arc Detection
        ArcDetection_AutoControlCmd=0;
        ArcDetection_AutoControl_ActualStatus=ArcDetection_AutoControlCmd;
        pvPut(ArcDetection_AutoControlCmd);
        pvPut(ArcDetection_AutoControl_ActualStatus);


        /* Maintenance and Fault Reset Buttons initialization */
        printf("[SEQ ORCHESTRATION] Maintenance and Fault Buttons: set to Zero Reset commands\n");
        // Cooling
        Cooling_MaintenanceReset=0;
        pvPut(Cooling_MaintenanceReset);
        Cooling_FaultReset=0;
        pvPut(Cooling_FaultReset);
        // Thermosensors
        Temperature_MaintenanceReset=0;
        pvPut(Temperature_MaintenanceReset);
        Temperature_FaultReset=0;
        pvPut(Temperature_FaultReset);
        // Steerers
        Steerer_MaintenanceReset=0;
        pvPut(Steerer_MaintenanceReset);
        Steerer_FaultReset=0;
        pvPut(Steerer_FaultReset);
        // Tuners
        Tuners_MaintenanceReset=0;
        pvPut(Tuners_MaintenanceReset);
        Tuners_FaultReset=0;
        pvPut(Tuners_FaultReset);
        // Arc Detection
        ArcDetection_MaintenanceReset=0;
        pvPut(ArcDetection_MaintenanceReset);
        ArcDetection_FaultReset=0;
        pvPut(ArcDetection_FaultReset);

        /* Main Maintenance readback initialization */
        DTL_Maintenance_Readback=DTL_Maintenance_Command;
        pvPut(DTL_Maintenance_Readback);

      }

      /* DTL Maintenance Status Request */
      when (DTL_Maintenance_Command == 1) {
        printf("[SEQ ORCHESTRATION] DTL request for maintenance by operator\n");
        printf("[SEQ ORCHESTRATION] Main System goes to MAINTENANCE stage. \n");
        DTL_Maintenance_Readback=DTL_Maintenance_Command;
        pvPut(DTL_Maintenance_Readback);

      } state maintenance

      /* Request for Maintenance stage by the Operator */
      when (dtlOperationalCode_Command == 606) {
          printf("[SEQ ORCHESTRATION] Request for Maintenance operation by the user. \n");
          printf("[SEQ ORCHESTRATION] Main system goes to MAINTENANCE stage. \n");

          /* Arm Maintenance Reset Command */
          DTL_Maintenance_Command=1;
          DTL_Maintenance_Readback=DTL_Maintenance_Command;
          pvPut(DTL_Maintenance_Command);
          pvPut(DTL_Maintenance_Readback);

          /* save last operational code command sent */
          dtl_operation_command_prev=dtlOperationalCode_Command;

      } state maintenance

      /* Start control only when skid is in remote control */
      /* Check if all functional sub-systems have OK Status */
      when ( (pvConnectCount()==pvAssignCount()) && (PLC_Message == -108) && (T1_Vacuum_OK_Status == 1) && (T2_Vacuum_OK_Status == 1) && (T3_Vacuum_OK_Status == 1) && (T4_Vacuum_OK_Status == 1) && (T5_Vacuum_OK_Status == 1) && (T0_Coolong_OK_Status == 1) && (T1_Cooling_OK_Status == 1) && (T2_Cooling_OK_Status == 1) && (T3_Cooling_OK_Status == 1) && (T4_Cooling_OK_Status == 1) && (T5_Cooling_OK_Status == 1) && (T1_RFSlow_OK_Status == 1) && (T2_RFSlow_OK_Status == 1) && (T3_RFSlow_OK_Status == 1) && (T4_RFSlow_OK_Status == 1) && (T5_RFSlow_OK_Status == 1) && (T1_Steerer_OK_Status == 1) && (T2_Steerer_OK_Status == 1) && (T3_Steerer_OK_Status == 1) && (T4_Steerer_OK_Status == 1) && (T5_Steerer_OK_Status == 1) && (T1_Tuner_OK_Status == 1) && (T2_Tuner_OK_Status == 1) && (T3_Tuner_OK_Status == 1) && (T4_Tuner_OK_Status == 1) && (T5_Tuner_OK_Status == 1) && (T1_ArcDetection_OK_Status == 1) && (T2_ArcDetection_OK_Status == 1) && (T3_ArcDetection_OK_Status == 1) && (T4_ArcDetection_OK_Status == 1) && (T5_ArcDetection_OK_Status == 1) ) {
        printf("[SEQ ORCHESTRATION] All PVs connected and System in Remote Control\n");
        printf("[SEQ ORCHESTRATION] All functional sub-systems are in OK Status\n");
        printf("[SEQ ORCHESTRATION] Self Check Passed. \n");

      } state stand_by
	}


/* state STAND_BY	*/
	state stand_by {
      entry {
        printf("\n[SEQ ORCHESTRATION] Enter in STAND BY status\n");
        dtl_operation_code_prev=dtlOperationalCode;
        dtlOperationalCode=101;
        pvPut(dtlOperationalCode);

      }

      /* If there is at least one sub-system is not ok, come back to initialization stage */
      when ( (T1_Vacuum_OK_Status == 0) || (T2_Vacuum_OK_Status == 0) || (T3_Vacuum_OK_Status == 0) || (T4_Vacuum_OK_Status == 0) || (T5_Vacuum_OK_Status == 0) || (T0_Coolong_OK_Status == 0) || (T1_Cooling_OK_Status == 0) || (T2_Cooling_OK_Status == 0) || (T3_Cooling_OK_Status == 0) || (T4_Cooling_OK_Status == 0) || (T5_Cooling_OK_Status == 0) || (T1_RFSlow_OK_Status == 0) || (T2_RFSlow_OK_Status == 0) || (T3_RFSlow_OK_Status == 0) || (T4_RFSlow_OK_Status == 0) || (T5_RFSlow_OK_Status == 0) || (T1_Steerer_OK_Status == 0) || (T2_Steerer_OK_Status == 0) || (T3_Steerer_OK_Status == 0) || (T4_Steerer_OK_Status == 0) || (T5_Steerer_OK_Status == 0) || (T1_Tuner_OK_Status == 0) || (T2_Tuner_OK_Status == 0) || (T3_Tuner_OK_Status == 0) || (T4_Tuner_OK_Status == 0) || (T5_Tuner_OK_Status == 0) || (T1_ArcDetection_OK_Status == 0) || (T2_ArcDetection_OK_Status == 0) || (T3_ArcDetection_OK_Status == 0) || (T4_ArcDetection_OK_Status == 0) || (T5_ArcDetection_OK_Status == 0) ) {
          printf("[SEQ ORCHESTRATION] One or more sub-systems are NOT OK. \n");
          printf("[SEQ ORCHESTRATION] Main system goes to INITIALIZATION stage. \n");

      } state initialization

      /* Error in operation request  the Operator */
      when ( ( (dtlOperationalCode_Command != 202) || (dtlOperationalCode_Command != 303) || (dtlOperationalCode_Command != 505) || (dtlOperationalCode_Command != 606) ) && (dtlOperationalCode_Command != dtl_operation_code_prev) ) {
          printf("[SEQ ORCHESTRATION] Error in operation request by the user: operation transition not allowed. \n");
          printf("[SEQ ORCHESTRATION] Main system remains in STAND_BY stage. \n");

      } state stand_by

      /* Request for RF Conditioning stage by the Operator */
      when ( (dtlOperationalCode_Command == 202) && (Vacuum_T1_Pressure <= DTL_Vacuum_RF_Conditioning_Working_Pressure) && (Vacuum_T2_Pressure <= DTL_Vacuum_RF_Conditioning_Working_Pressure) && (Vacuum_T3_Pressure <= DTL_Vacuum_RF_Conditioning_Working_Pressure) && (Vacuum_T4_Pressure <= DTL_Vacuum_RF_Conditioning_Working_Pressure) && (Vacuum_T5_Pressure <= DTL_Vacuum_RF_Conditioning_Working_Pressure) ) {
          printf("[SEQ ORCHESTRATION] Request for RF Conditioning operation by the user. \n");
          printf("[SEQ ORCHESTRATION] Main system goes to RF_CONDITIONING stage. \n");
          /* save last operational code command sent */
          dtl_operation_command_prev=dtlOperationalCode_Command;

      } state rf_conditioning

      /* Request for RF Startup stage by the Operator */
      when ( (dtlOperationalCode_Command == 303) && (Vacuum_T1_Pressure <= DTL_Vacuum_StartUp_Working_Pressure) && (Vacuum_T2_Pressure <= DTL_Vacuum_StartUp_Working_Pressure) && (Vacuum_T3_Pressure <= DTL_Vacuum_StartUp_Working_Pressure) && (Vacuum_T4_Pressure <= DTL_Vacuum_StartUp_Working_Pressure) && (Vacuum_T5_Pressure <= DTL_Vacuum_StartUp_Working_Pressure) ) {
          printf("[SEQ ORCHESTRATION] Request for RF Start-up operation by the user. \n");
          printf("[SEQ ORCHESTRATION] Main system goes to RF STARTUP stage. \n");
          /* save last operational code command sent */
          dtl_operation_command_prev=dtlOperationalCode_Command;

      } state rf_start_up

      /* Request for No Accelerated Beam stage by the Operator */
      when ( (dtlOperationalCode_Command == 505) && (Vacuum_T1_Pressure <= DTL_Vacuum_no_Operation_Working_Pressure) && (Vacuum_T2_Pressure <= DTL_Vacuum_RF_Beam_Operation_Working_Pressure) && (Vacuum_T3_Pressure <= DTL_Vacuum_RF_Beam_Operation_Working_Pressure) && (Vacuum_T4_Pressure <= DTL_Vacuum_RF_Beam_Operation_Working_Pressure) && (Vacuum_T5_Pressure <= DTL_Vacuum_RF_Beam_Operation_Working_Pressure) )  {
          printf("[SEQ ORCHESTRATION] Request for No Accelerated Beam operation by the user. \n");
          printf("[SEQ ORCHESTRATION] Main system goes to NO_ACCELERATED_BEAM stage. \n");
          /* save last operational code command sent */
          dtl_operation_command_prev=dtlOperationalCode_Command;

      } state no_accelerated_beam

      /* Request for Maintenance stage by the Operator */
      when (dtlOperationalCode_Command == 606) {
          printf("[SEQ ORCHESTRATION] Request for Maintenance operation by the user. \n");
          printf("[SEQ ORCHESTRATION] Main system goes to MAINTENANCE stage. \n");

          /* Arm Maintenance Reset Command */
          DTL_Maintenance_Command=1;
          DTL_Maintenance_Readback=DTL_Maintenance_Command;
          pvPut(DTL_Maintenance_Command);
          pvPut(DTL_Maintenance_Readback);
          /* save last operational code command sent */
          dtl_operation_command_prev=dtlOperationalCode_Command;

      } state maintenance

      /* DTL Maintenance Status Request */
      when (DTL_Maintenance_Command == 1) {
        printf("[SEQ ORCHESTRATION] DTL request for maintenance by operator\n");
        printf("[SEQ ORCHESTRATION] Main System goes to MAINTENANCE stage. \n");
        DTL_Maintenance_Readback=DTL_Maintenance_Command;
        pvPut(DTL_Maintenance_Readback);

      } state maintenance

  }


/* state RF_CONDITIONING   	*/
  state rf_conditioning {
    entry {
      printf("\n[SEQ ORCHESTRATION] Enter in RF CONDITIONING status\n");
      dtl_operation_code_prev=dtlOperationalCode;
      dtlOperationalCode=202;
      pvPut(dtlOperationalCode);

      /*
       * Setup Tuner System
       * - set autoControl to MANUAL [0]
       * - set start operation command to ENABLE
       * - DISABLE Motors
       * - DISABLE PID control
      */
      /* Case sub-system in idle */
      if (Tuners_StateMachineCode == 20) {
        printf("[SEQ ORCHESTRATION] Tuner System in IDLE: set MANUAL control and enable operation\n");

        Tuners_AutoControlCmd=0;
        pvPut(Tuners_AutoControlCmd);
        Tuners_StartOperationCmd=1;
        pvPut(Tuners_StartOperationCmd);
      }

      /* Case sub-system in ready for operation */
      else if ( (Tuners_StateMachineCode == 30) && (Tuners_AutoControl_ActualStatus == 1) ) {
        printf("[SEQ ORCHESTRATION] Tuner System in READY FOR OPERATION: set only MANUAL control \n");
        Tuners_AutoControlCmd=0;
        pvPut(Tuners_AutoControlCmd);

      }
      printf("[SEQ ORCHESTRATION] Disable Tuners PID control \n");
      Tuners_T1_M1_PID_Enable=0;
      pvPut(Tuners_T1_M1_PID_Enable);
      Tuners_T1_M2_PID_Enable=0;
      pvPut(Tuners_T1_M2_PID_Enable);
      Tuners_T1_M3_PID_Enable=0;
      pvPut(Tuners_T1_M3_PID_Enable);
      Tuners_T2_M1_PID_Enable=0;
      pvPut(Tuners_T2_M1_PID_Enable);
      Tuners_T2_M2_PID_Enable=0;
      pvPut(Tuners_T2_M2_PID_Enable);
      Tuners_T2_M3_PID_Enable=0;
      pvPut(Tuners_T2_M3_PID_Enable);
      Tuners_T3_M1_PID_Enable=0;
      pvPut(Tuners_T3_M1_PID_Enable);
      Tuners_T3_M2_PID_Enable=0;
      pvPut(Tuners_T3_M2_PID_Enable);
      Tuners_T3_M3_PID_Enable=0;
      pvPut(Tuners_T3_M3_PID_Enable);
      Tuners_T4_M1_PID_Enable=0;
      pvPut(Tuners_T4_M1_PID_Enable);
      Tuners_T4_M2_PID_Enable=0;
      pvPut(Tuners_T4_M2_PID_Enable);
      Tuners_T4_M3_PID_Enable=0;
      pvPut(Tuners_T4_M3_PID_Enable);
      Tuners_T5_M1_PID_Enable=0;
      pvPut(Tuners_T5_M1_PID_Enable);
      Tuners_T5_M2_PID_Enable=0;
      pvPut(Tuners_T5_M2_PID_Enable);
      Tuners_T5_M3_PID_Enable=0;
      pvPut(Tuners_T5_M3_PID_Enable);

      printf("[SEQ ORCHESTRATION] Disable Tuners motor axis \n");
      Tuners_T1_M1_Axis_Enable=0;
      pvPut(Tuners_T1_M1_Axis_Enable);
      Tuners_T1_M2_Axis_Enable=0;
      pvPut(Tuners_T1_M2_Axis_Enable);
      Tuners_T1_M3_Axis_Enable=0;
      pvPut(Tuners_T1_M3_Axis_Enable);
      Tuners_T2_M1_Axis_Enable=0;
      pvPut(Tuners_T2_M1_Axis_Enable);
      Tuners_T2_M2_Axis_Enable=0;
      pvPut(Tuners_T2_M2_Axis_Enable);
      Tuners_T2_M3_Axis_Enable=0;
      pvPut(Tuners_T2_M3_Axis_Enable);
      Tuners_T3_M1_Axis_Enable=0;
      pvPut(Tuners_T3_M1_Axis_Enable);
      Tuners_T3_M2_Axis_Enable=0;
      pvPut(Tuners_T3_M2_Axis_Enable);
      Tuners_T3_M3_Axis_Enable=0;
      pvPut(Tuners_T3_M3_Axis_Enable);
      Tuners_T4_M1_Axis_Enable=0;
      pvPut(Tuners_T4_M1_Axis_Enable);
      Tuners_T4_M2_Axis_Enable=0;
      pvPut(Tuners_T4_M2_Axis_Enable);
      Tuners_T4_M3_Axis_Enable=0;
      pvPut(Tuners_T4_M3_Axis_Enable);
      Tuners_T5_M1_Axis_Enable=0;
      pvPut(Tuners_T5_M1_Axis_Enable);
      Tuners_T5_M2_Axis_Enable=0;
      pvPut(Tuners_T5_M2_Axis_Enable);
      Tuners_T5_M3_Axis_Enable=0;
      pvPut(Tuners_T5_M3_Axis_Enable);

      /*
       * Setup Steerer System
       * - set autoControl to MANUAL [0]
       * - set start operation command to ENABLE
       * - set current setpoint to 0A
       * - DISABLE steerers
      */
      /* Case sub-system in idle */
      if (Steerer_StateMachineCode == 20) {
        printf("[SEQ ORCHESTRATION] Steerer System in IDLE: set MANUAL control and enable operation\n");

        Steerer_AutoControlCmd=0;
        pvPut(Steerer_AutoControlCmd);
        Steerer_StartOperationCmd=1;
        pvPut(Steerer_StartOperationCmd);
      }

      /* Case sub-system in ready for operation */
      else if ( (Steerer_StateMachineCode == 30) && (Steerer_AutoControl_ActualStatus == 1) ) {
        printf("[SEQ ORCHESTRATION] Steerer System in READY FOR OPERATION: set only MANUAL control \n");
        Steerer_AutoControlCmd=0;
        pvPut(Steerer_AutoControlCmd);

      }
      printf("[SEQ ORCHESTRATION] Set Steerers setpoint to 0A \n");
      Steerer_T1_V1_CurrentSet = 0;
      pvPut(Steerer_T1_V1_CurrentSet);
      Steerer_T1_H1_CurrentSet = 0;
      pvPut(Steerer_T1_H1_CurrentSet);
      Steerer_T1_V2_CurrentSet = 0;
      pvPut(Steerer_T1_V2_CurrentSet);
      Steerer_T1_H2_CurrentSet = 0;
      pvPut(Steerer_T1_H2_CurrentSet);
      Steerer_T1_V3_CurrentSet = 0;
      pvPut(Steerer_T1_V3_CurrentSet);
      Steerer_T1_H3_CurrentSet = 0;
      pvPut(Steerer_T1_H3_CurrentSet);
      Steerer_T1_V4_CurrentSet = 0;
      pvPut(Steerer_T1_V4_CurrentSet);
      Steerer_T1_H4_CurrentSet = 0;
      pvPut(Steerer_T1_H4_CurrentSet);
      Steerer_T1_V5_CurrentSet = 0;
      pvPut(Steerer_T1_V5_CurrentSet);
      Steerer_T1_H5_CurrentSet = 0;
      pvPut(Steerer_T1_H5_CurrentSet);
      Steerer_T1_V6_CurrentSet = 0;
      pvPut(Steerer_T1_V6_CurrentSet);
      Steerer_T1_H6_CurrentSet = 0;
      pvPut(Steerer_T1_H6_CurrentSet);
      Steerer_T2_V1_CurrentSet = 0;
      pvPut(Steerer_T2_V1_CurrentSet);
      Steerer_T2_H1_CurrentSet = 0;
      pvPut(Steerer_T2_H1_CurrentSet);
      Steerer_T2_V2_CurrentSet = 0;
      pvPut(Steerer_T2_V2_CurrentSet);
      Steerer_T2_H2_CurrentSet = 0;
      pvPut(Steerer_T2_H2_CurrentSet);
      Steerer_T2_V3_CurrentSet = 0;
      pvPut(Steerer_T2_V3_CurrentSet);
      Steerer_T2_H3_CurrentSet = 0;
      pvPut(Steerer_T2_H3_CurrentSet);
      Steerer_T3_V1_CurrentSet = 0;
      pvPut(Steerer_T3_V1_CurrentSet);
      Steerer_T3_H1_CurrentSet = 0;
      pvPut(Steerer_T3_H1_CurrentSet);
      Steerer_T3_V2_CurrentSet = 0;
      pvPut(Steerer_T3_V2_CurrentSet);
      Steerer_T3_H2_CurrentSet = 0;
      pvPut(Steerer_T3_H2_CurrentSet);
      Steerer_T4_V1_CurrentSet = 0;
      pvPut(Steerer_T4_V1_CurrentSet);
      Steerer_T4_H1_CurrentSet = 0;
      pvPut(Steerer_T4_H1_CurrentSet);
      Steerer_T4_V2_CurrentSet = 0;
      pvPut(Steerer_T4_V2_CurrentSet);
      Steerer_T4_H2_CurrentSet = 0;
      pvPut(Steerer_T4_H2_CurrentSet);
      Steerer_T5_V1_CurrentSet = 0;
      pvPut(Steerer_T5_V1_CurrentSet);
      Steerer_T5_H1_CurrentSet = 0;
      pvPut(Steerer_T5_H1_CurrentSet);
      Steerer_T5_V2_CurrentSet = 0;
      pvPut(Steerer_T5_V2_CurrentSet);
      Steerer_T5_H2_CurrentSet = 0;
      pvPut(Steerer_T5_H2_CurrentSet);

      printf("[SEQ ORCHESTRATION] Disable Steerers \n");
      Steerer_T1_V1_ChEnableCmd = 0;
      pvPut(Steerer_T1_V1_ChEnableCmd);
      Steerer_T1_H1_ChEnableCmd = 0;
      pvPut(Steerer_T1_H1_ChEnableCmd);
      Steerer_T1_V2_ChEnableCmd = 0;
      pvPut(Steerer_T1_V2_ChEnableCmd);
      Steerer_T1_H2_ChEnableCmd = 0;
      pvPut(Steerer_T1_H2_ChEnableCmd);
      Steerer_T1_V3_ChEnableCmd = 0;
      pvPut(Steerer_T1_V3_ChEnableCmd);
      Steerer_T1_H3_ChEnableCmd = 0;
      pvPut(Steerer_T1_H3_ChEnableCmd);
      Steerer_T1_V4_ChEnableCmd = 0;
      pvPut(Steerer_T1_V4_ChEnableCmd);
      Steerer_T1_H4_ChEnableCmd = 0;
      pvPut(Steerer_T1_H4_ChEnableCmd);
      Steerer_T1_V5_ChEnableCmd = 0;
      pvPut(Steerer_T1_V5_ChEnableCmd);
      Steerer_T1_H5_ChEnableCmd = 0;
      pvPut(Steerer_T1_H5_ChEnableCmd);
      Steerer_T1_V6_ChEnableCmd = 0;
      pvPut(Steerer_T1_V6_ChEnableCmd);
      Steerer_T1_H6_ChEnableCmd = 0;
      pvPut(Steerer_T1_H6_ChEnableCmd);
      Steerer_T2_V1_ChEnableCmd = 0;
      pvPut(Steerer_T2_V1_ChEnableCmd);
      Steerer_T2_H1_ChEnableCmd = 0;
      pvPut(Steerer_T2_H1_ChEnableCmd);
      Steerer_T2_V2_ChEnableCmd = 0;
      pvPut(Steerer_T2_V2_ChEnableCmd);
      Steerer_T2_H2_ChEnableCmd = 0;
      pvPut(Steerer_T2_H2_ChEnableCmd);
      Steerer_T2_V3_ChEnableCmd = 0;
      pvPut(Steerer_T2_V3_ChEnableCmd);
      Steerer_T2_H3_ChEnableCmd = 0;
      pvPut(Steerer_T2_H3_ChEnableCmd);
      Steerer_T3_V1_ChEnableCmd = 0;
      pvPut(Steerer_T3_V1_ChEnableCmd);
      Steerer_T3_H1_ChEnableCmd = 0;
      pvPut(Steerer_T3_H1_ChEnableCmd);
      Steerer_T3_V2_ChEnableCmd = 0;
      pvPut(Steerer_T3_V2_ChEnableCmd);
      Steerer_T3_H2_ChEnableCmd = 0;
      pvPut(Steerer_T3_H2_ChEnableCmd);
      Steerer_T4_V1_ChEnableCmd = 0;
      pvPut(Steerer_T4_V1_ChEnableCmd);
      Steerer_T4_H1_ChEnableCmd = 0;
      pvPut(Steerer_T4_H1_ChEnableCmd);
      Steerer_T4_V2_ChEnableCmd = 0;
      pvPut(Steerer_T4_V2_ChEnableCmd);
      Steerer_T4_H2_ChEnableCmd = 0;
      pvPut(Steerer_T4_H2_ChEnableCmd);
      Steerer_T5_V1_ChEnableCmd = 0;
      pvPut(Steerer_T5_V1_ChEnableCmd);
      Steerer_T5_H1_ChEnableCmd = 0;
      pvPut(Steerer_T5_H1_ChEnableCmd);
      Steerer_T5_V2_ChEnableCmd = 0;
      pvPut(Steerer_T5_V2_ChEnableCmd);
      Steerer_T5_H2_ChEnableCmd = 0;
      pvPut(Steerer_T5_H2_ChEnableCmd);

      /*
       * Setup Cooling System
       * - check if sub-system is in MANUAL or AUTO mode
       * - set start operation command to ENABLE
       * - working temperature set in cooling state machine (ready for operations stage)
      */
      Cooling_StartOperationCmd=1;
      pvPut(Cooling_StartOperationCmd);
      sleep(5);
      /* Case sub-system in start-up stage: system requires pressures and fluxes check  */
      if (Cooling_StateMachineCode == 30) {
        if (Cooling_AutoControlCmd == 0 && Cooling_Manual_Test_Done == 0) {
          printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and MANUAL control. Wait for test parameters control \n");
        }
        else if (Cooling_AutoControlCmd == 0 && Cooling_Manual_Test_Done == 1) {
          printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and MANUAL control. Test check already set on DONE \n");
        }
        else if (Cooling_AutoControlCmd == 1) {
          printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and AUTO control. Execute fluxes and pressures check \n");
          Cooling_Manual_Test_Done=1;
          pvPut(Cooling_Manual_Test_Done);
        }
        else {
          printf("[SEQ ORCHESTRATION] This message should not appear :) \n");
        }
      }

      /*
       * Setup Arc Detection System
       * -check if sub-system is in MANUAL or AUTO mode
       * - set start operation command to ENABLE
      */
      ArcDetection_StartOperationCmd=1;
      pvPut(ArcDetection_StartOperationCmd);

      if (ArcDetection_StateMachineCode == 30) {
        if (ArcDetection_AutoControlCmd == 0 && ArcDetection_Manual_Test_Done == 0) {
          printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and MANUAL control. Wait for test parameters control \n");
        }
        else if (ArcDetection_AutoControlCmd == 0 && ArcDetection_Manual_Test_Done == 1) {
          printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and MANUAL control. Test check already set on DONE \n");
        }
        else if (ArcDetection_AutoControlCmd == 1) {
          printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and AUTO control. Execute fluxes and pressures check \n");
          ArcDetection_Manual_Test_Done=1;
          pvPut(ArcDetection_Manual_Test_Done);
        }
        else {
          printf("[SEQ ORCHESTRATION] This message should not appear :) \n");
        }
      }


      /*
       * Setup RF System
       * - set control in Frequency Follower Mode
      */
      DTL_Frequency_Mode=909;
      pvPut(DTL_Frequency_Mode);

      /*
       * Setup Temperature System
       * - set Alarm Temperature to T0_MAX (used HIHI limit)
      */
      /* Tank 1 */
      for (index = 0; index < 62; index++) {
        Thermosensors_T1_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T1_Max_Temp[index]);
      }
      /* Tank 2 */
      for (index = 0; index < 35; index++) {
        Thermosensors_T2_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T2_Max_Temp[index]);
      }
      /* Tank 3 */
      for (index = 0; index < 30; index++) {
        Thermosensors_T3_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T3_Max_Temp[index]);
      }
      /* Tank 4 */
      for (index = 0; index < 27; index++) {
        Thermosensors_T4_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T4_Max_Temp[index]);
      }
      /* Tank 5 */
      for (index = 0; index < 24; index++) {
        Thermosensors_T5_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T5_Max_Temp[index]);
      }

      /*
       * Indicate DTL ready for RF (not BEAM)
      */
      DTL_T1_RF_Ready=1;
      pvPut(DTL_T1_RF_Ready);
      DTL_T2_RF_Ready=1;
      pvPut(DTL_T2_RF_Ready);
      DTL_T3_RF_Ready=1;
      pvPut(DTL_T3_RF_Ready);
      DTL_T4_RF_Ready=1;
      pvPut(DTL_T4_RF_Ready);
      DTL_T5_RF_Ready=1;
      pvPut(DTL_T5_RF_Ready);
      DTL_RF_Ready=1;
      pvPut(DTL_RF_Ready);
      DTL_T1_Beam_Ready=0;
      pvPut(DTL_T1_Beam_Ready);
      DTL_T2_Beam_Ready=0;
      pvPut(DTL_T2_Beam_Ready);
      DTL_T3_Beam_Ready=0;
      pvPut(DTL_T3_Beam_Ready);
      DTL_T4_Beam_Ready=0;
      pvPut(DTL_T4_Beam_Ready);
      DTL_T5_Beam_Ready=0;
      pvPut(DTL_T5_Beam_Ready);
      DTL_Beam_Ready=0;
      pvPut(DTL_Beam_Ready);

    }

    /* If there is at least one sub-system is not ok, come back to stand_by stage */
    when ( (T1_Vacuum_OK_Status == 0) || (T2_Vacuum_OK_Status == 0) || (T3_Vacuum_OK_Status == 0) || (T4_Vacuum_OK_Status == 0) || (T5_Vacuum_OK_Status == 0) || (T0_Coolong_OK_Status == 0) || (T1_Cooling_OK_Status == 0) || (T2_Cooling_OK_Status == 0) || (T3_Cooling_OK_Status == 0) || (T4_Cooling_OK_Status == 0) || (T5_Cooling_OK_Status == 0) || (T1_RFSlow_OK_Status == 0) || (T2_RFSlow_OK_Status == 0) || (T3_RFSlow_OK_Status == 0) || (T4_RFSlow_OK_Status == 0) || (T5_RFSlow_OK_Status == 0) || (T1_Steerer_OK_Status == 0) || (T2_Steerer_OK_Status == 0) || (T3_Steerer_OK_Status == 0) || (T4_Steerer_OK_Status == 0) || (T5_Steerer_OK_Status == 0) || (T1_Tuner_OK_Status == 0) || (T2_Tuner_OK_Status == 0) || (T3_Tuner_OK_Status == 0) || (T4_Tuner_OK_Status == 0) || (T5_Tuner_OK_Status == 0) || (T1_ArcDetection_OK_Status == 0) || (T2_ArcDetection_OK_Status == 0) || (T3_ArcDetection_OK_Status == 0) || (T4_ArcDetection_OK_Status == 0) || (T5_ArcDetection_OK_Status == 0) ) {
        printf("[SEQ ORCHESTRATION] One or more sub-systems are NOT OK. Check sub-systems state machine stages\n");
        printf("[SEQ ORCHESTRATION] Main system goes to STAND_BY stage. \n");

        /* Stop Operations for sub-systems */
        Steerer_StopOperationCmd=1;
        pvPut(Steerer_StopOperationCmd);
        Tuners_StopOperationCmd=1;
        pvPut(Tuners_StopOperationCmd);
        Cooling_StopOperationCmd=1;
        pvPut(Cooling_StopOperationCmd);
        ArcDetection_StartOperationCmd=0;
        pvPut(ArcDetection_StartOperationCmd);

        /*
         *  Additional cmds for checks
         */

    } state stand_by

    /* Execute cooling manual start-up test on fluxes and pressures */
    when ( (Cooling_StateMachineCode == 30) && (Cooling_AutoControlCmd == 0) && (Cooling_Manual_Test_Done == 1)  ) {
        printf("[SEQ ORCHESTRATION] Cooling sub-system: executed start-up procedure. \n");

    } state rf_conditioning

    /* Error: cooling system not in ready for operation stage */
    when (Cooling_StateMachineCode != 40) {
        printf("[SEQ ORCHESTRATION] Cooling sub-system error: system not in ready for operation stage. \n");
        printf("[SEQ ORCHESTRATION] Main system reset to STAND_BY stage. \n");

    } state stand_by

    /* Error: tuner system not in ready for operation stage */
    when (Tuners_StateMachineCode != 40) {
        printf("[SEQ ORCHESTRATION] Tuner sub-system error: system not in ready for operation stage. \n");
        printf("[SEQ ORCHESTRATION] Main system reset to STAND_BY stage. \n");

    } state stand_by

    /* Error: steerer system not in ready for operation stage */
    when (Steerer_StateMachineCode != 40) {
        printf("[SEQ ORCHESTRATION] Steerer sub-system error: system not in ready for operation stage. \n");
        printf("[SEQ ORCHESTRATION] Main system reset to STAND_BY stage. \n");

    } state stand_by

    /* Error in operation request by the Operator */
    when ( (dtlOperationalCode_Command != 101) && (dtlOperationalCode_Command != dtl_operation_command_prev) ) {
        printf("[SEQ ORCHESTRATION] Error in operation request by the user: operation transition not allowed. \n");
        printf("[SEQ ORCHESTRATION] Main system remains in RF_CONDITIONING stage. \n");

    } state rf_conditioning

    /* Request for RF stand_by stage by the Operator */
    when (dtlOperationalCode_Command == 101) {
        printf("[SEQ ORCHESTRATION] Request for Stand-by operation by the user. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to STAND_BY stage. \n");

        /* Stop operation commands for cooling, tuners and steerer sub-systems */
        Tuners_StopOperationCmd=1;
        pvPut(Tuners_StopOperationCmd);
        Steerer_StopOperationCmd=1;
        pvPut(Steerer_StopOperationCmd);
        Cooling_StopOperationCmd=1;
        pvPut(Cooling_StopOperationCmd);
        ArcDetection_StartOperationCmd=0;
        pvPut(ArcDetection_StartOperationCmd);

        /* save last operational code command sent */
        dtl_operation_command_prev=dtlOperationalCode_Command;

    } state stand_by

  }



/* state RF START-UP	*/
state rf_start_up {

    entry {
      printf("\n[SEQ ORCHESTRATION] Enter in RF START-UP status\n");
      dtl_operation_code_prev=dtlOperationalCode;
      dtlOperationalCode=303;
      pvPut(dtlOperationalCode);

      /*
       * Setup Tuner System
       * - set autoControl to MANUAL [0]
       * - set start operation command to ENABLE
       * - ENABLE Motors
       * - DISABLE PID control
       * - set start-up working position
      */
      /* Case sub-system in idle */
      if (Tuners_StateMachineCode == 20) {
        printf("[SEQ ORCHESTRATION] Tuner System in IDLE: set MANUAL control and enable operation\n");

        Tuners_AutoControlCmd=0;
        pvPut(Tuners_AutoControlCmd);
        Tuners_StartOperationCmd=1;
        pvPut(Tuners_StartOperationCmd);
      }

      /* Case sub-system in ready for operation */
      else if ( (Tuners_StateMachineCode == 30) && (Tuners_AutoControl_ActualStatus == 1) ) {
        printf("[SEQ ORCHESTRATION] Tuner System in READY FOR OPERATION: set only MANUAL control \n");
        Tuners_AutoControlCmd=0;
        pvPut(Tuners_AutoControlCmd);

      }
      printf("[SEQ ORCHESTRATION] Disable Tuners PID control \n");
      Tuners_T1_M1_PID_Enable=0;
      pvPut(Tuners_T1_M1_PID_Enable);
      Tuners_T1_M2_PID_Enable=0;
      pvPut(Tuners_T1_M2_PID_Enable);
      Tuners_T1_M3_PID_Enable=0;
      pvPut(Tuners_T1_M3_PID_Enable);
      Tuners_T2_M1_PID_Enable=0;
      pvPut(Tuners_T2_M1_PID_Enable);
      Tuners_T2_M2_PID_Enable=0;
      pvPut(Tuners_T2_M2_PID_Enable);
      Tuners_T2_M3_PID_Enable=0;
      pvPut(Tuners_T2_M3_PID_Enable);
      Tuners_T3_M1_PID_Enable=0;
      pvPut(Tuners_T3_M1_PID_Enable);
      Tuners_T3_M2_PID_Enable=0;
      pvPut(Tuners_T3_M2_PID_Enable);
      Tuners_T3_M3_PID_Enable=0;
      pvPut(Tuners_T3_M3_PID_Enable);
      Tuners_T4_M1_PID_Enable=0;
      pvPut(Tuners_T4_M1_PID_Enable);
      Tuners_T4_M2_PID_Enable=0;
      pvPut(Tuners_T4_M2_PID_Enable);
      Tuners_T4_M3_PID_Enable=0;
      pvPut(Tuners_T4_M3_PID_Enable);
      Tuners_T5_M1_PID_Enable=0;
      pvPut(Tuners_T5_M1_PID_Enable);
      Tuners_T5_M2_PID_Enable=0;
      pvPut(Tuners_T5_M2_PID_Enable);
      Tuners_T5_M3_PID_Enable=0;
      pvPut(Tuners_T5_M3_PID_Enable);

      printf("[SEQ ORCHESTRATION] Enable Tuners motor axis \n");
      Tuners_T1_M1_Axis_Enable=1;
      pvPut(Tuners_T1_M1_Axis_Enable);
      Tuners_T1_M2_Axis_Enable=1;
      pvPut(Tuners_T1_M2_Axis_Enable);
      Tuners_T1_M3_Axis_Enable=1;
      pvPut(Tuners_T1_M3_Axis_Enable);
      Tuners_T2_M1_Axis_Enable=1;
      pvPut(Tuners_T2_M1_Axis_Enable);
      Tuners_T2_M2_Axis_Enable=1;
      pvPut(Tuners_T2_M2_Axis_Enable);
      Tuners_T2_M3_Axis_Enable=1;
      pvPut(Tuners_T2_M3_Axis_Enable);
      Tuners_T3_M1_Axis_Enable=1;
      pvPut(Tuners_T3_M1_Axis_Enable);
      Tuners_T3_M2_Axis_Enable=1;
      pvPut(Tuners_T3_M2_Axis_Enable);
      Tuners_T3_M3_Axis_Enable=1;
      pvPut(Tuners_T3_M3_Axis_Enable);
      Tuners_T4_M1_Axis_Enable=1;
      pvPut(Tuners_T4_M1_Axis_Enable);
      Tuners_T4_M2_Axis_Enable=1;
      pvPut(Tuners_T4_M2_Axis_Enable);
      Tuners_T4_M3_Axis_Enable=1;
      pvPut(Tuners_T4_M3_Axis_Enable);
      Tuners_T5_M1_Axis_Enable=1;
      pvPut(Tuners_T5_M1_Axis_Enable);
      Tuners_T5_M2_Axis_Enable=1;
      pvPut(Tuners_T5_M2_Axis_Enable);
      Tuners_T5_M3_Axis_Enable=1;
      pvPut(Tuners_T5_M3_Axis_Enable);

      printf("[SEQ ORCHESTRATION] SEt Tuners position to Start-up working position \n");
      Tuners_T1_M1_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T1_M1_Axis_Enable);
      Tuners_T1_M2_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T1_M2_Axis_Enable);
      Tuners_T1_M3_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T1_M3_Axis_Enable);
      Tuners_T2_M1_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T2_M1_Axis_Enable);
      Tuners_T2_M2_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T2_M2_Axis_Enable);
      Tuners_T2_M3_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T2_M3_Axis_Enable);
      Tuners_T3_M1_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T3_M1_Axis_Enable);
      Tuners_T3_M2_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T3_M2_Axis_Enable);
      Tuners_T3_M3_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T3_M3_Axis_Enable);
      Tuners_T4_M1_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T4_M1_Axis_Enable);
      Tuners_T4_M2_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T4_M2_Axis_Enable);
      Tuners_T4_M3_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T4_M3_Axis_Enable);
      Tuners_T5_M1_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T5_M1_Axis_Enable);
      Tuners_T5_M2_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T5_M2_Axis_Enable);
      Tuners_T5_M3_Axis_Position=DTL_Tuners_RF_Startup_Working_Position;
      pvPut(Tuners_T5_M3_Axis_Enable);

      /*
       * Setup Steerer System
       * - set autoControl to MANUAL [0]
       * - set start operation command to ENABLE
       * - set current setpoint to RF Startup Working Current
       * - ENABLE steerers
      */
      /* Case sub-system in idle */
      if (Steerer_StateMachineCode == 20) {
        printf("[SEQ ORCHESTRATION] Steerer System in IDLE: set MANUAL control and enable operation\n");

        Steerer_AutoControlCmd=0;
        pvPut(Steerer_AutoControlCmd);
        Steerer_StartOperationCmd=1;
        pvPut(Steerer_StartOperationCmd);
      }

      /* Case sub-system in ready for operation */
      else if ( (Steerer_StateMachineCode == 30) && (Steerer_AutoControl_ActualStatus == 1) ) {
        printf("[SEQ ORCHESTRATION] Steerer System in READY FOR OPERATION: set only MANUAL control \n");
        Steerer_AutoControlCmd=0;
        pvPut(Steerer_AutoControlCmd);

      }

      printf("[SEQ ORCHESTRATION] Enable Steerers \n");
      Steerer_T1_V1_ChEnableCmd = 1;
      pvPut(Steerer_T1_V1_ChEnableCmd);
      Steerer_T1_H1_ChEnableCmd = 1;
      pvPut(Steerer_T1_H1_ChEnableCmd);
      Steerer_T1_V2_ChEnableCmd = 1;
      pvPut(Steerer_T1_V2_ChEnableCmd);
      Steerer_T1_H2_ChEnableCmd = 1;
      pvPut(Steerer_T1_H2_ChEnableCmd);
      Steerer_T1_V3_ChEnableCmd = 1;
      pvPut(Steerer_T1_V3_ChEnableCmd);
      Steerer_T1_H3_ChEnableCmd = 1;
      pvPut(Steerer_T1_H3_ChEnableCmd);
      Steerer_T1_V4_ChEnableCmd = 1;
      pvPut(Steerer_T1_V4_ChEnableCmd);
      Steerer_T1_H4_ChEnableCmd = 1;
      pvPut(Steerer_T1_H4_ChEnableCmd);
      Steerer_T1_V5_ChEnableCmd = 1;
      pvPut(Steerer_T1_V5_ChEnableCmd);
      Steerer_T1_H5_ChEnableCmd = 1;
      pvPut(Steerer_T1_H5_ChEnableCmd);
      Steerer_T1_V6_ChEnableCmd = 1;
      pvPut(Steerer_T1_V6_ChEnableCmd);
      Steerer_T1_H6_ChEnableCmd = 1;
      pvPut(Steerer_T1_H6_ChEnableCmd);
      Steerer_T2_V1_ChEnableCmd = 1;
      pvPut(Steerer_T2_V1_ChEnableCmd);
      Steerer_T2_H1_ChEnableCmd = 1;
      pvPut(Steerer_T2_H1_ChEnableCmd);
      Steerer_T2_V2_ChEnableCmd = 1;
      pvPut(Steerer_T2_V2_ChEnableCmd);
      Steerer_T2_H2_ChEnableCmd = 1;
      pvPut(Steerer_T2_H2_ChEnableCmd);
      Steerer_T2_V3_ChEnableCmd = 1;
      pvPut(Steerer_T2_V3_ChEnableCmd);
      Steerer_T2_H3_ChEnableCmd = 1;
      pvPut(Steerer_T2_H3_ChEnableCmd);
      Steerer_T3_V1_ChEnableCmd = 1;
      pvPut(Steerer_T3_V1_ChEnableCmd);
      Steerer_T3_H1_ChEnableCmd = 1;
      pvPut(Steerer_T3_H1_ChEnableCmd);
      Steerer_T3_V2_ChEnableCmd = 1;
      pvPut(Steerer_T3_V2_ChEnableCmd);
      Steerer_T3_H2_ChEnableCmd = 1;
      pvPut(Steerer_T3_H2_ChEnableCmd);
      Steerer_T4_V1_ChEnableCmd = 1;
      pvPut(Steerer_T4_V1_ChEnableCmd);
      Steerer_T4_H1_ChEnableCmd = 1;
      pvPut(Steerer_T4_H1_ChEnableCmd);
      Steerer_T4_V2_ChEnableCmd = 1;
      pvPut(Steerer_T4_V2_ChEnableCmd);
      Steerer_T4_H2_ChEnableCmd = 1;
      pvPut(Steerer_T4_H2_ChEnableCmd);
      Steerer_T5_V1_ChEnableCmd = 1;
      pvPut(Steerer_T5_V1_ChEnableCmd);
      Steerer_T5_H1_ChEnableCmd = 1;
      pvPut(Steerer_T5_H1_ChEnableCmd);
      Steerer_T5_V2_ChEnableCmd = 1;
      pvPut(Steerer_T5_V2_ChEnableCmd);
      Steerer_T5_H2_ChEnableCmd = 1;
      pvPut(Steerer_T5_H2_ChEnableCmd);

      printf("[SEQ ORCHESTRATION] Set Steerers setpoint to DTL_Steerer_RF_Startup_Working_Current \n");
      Steerer_T1_V1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_V1_CurrentSet);
      Steerer_T1_H1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_H1_CurrentSet);
      Steerer_T1_V2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_V2_CurrentSet);
      Steerer_T1_H2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_H2_CurrentSet);
      Steerer_T1_V3_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_V3_CurrentSet);
      Steerer_T1_H3_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_H3_CurrentSet);
      Steerer_T1_V4_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_V4_CurrentSet);
      Steerer_T1_H4_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_H4_CurrentSet);
      Steerer_T1_V5_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_V5_CurrentSet);
      Steerer_T1_H5_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_H5_CurrentSet);
      Steerer_T1_V6_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_V6_CurrentSet);
      Steerer_T1_H6_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T1_H6_CurrentSet);
      Steerer_T2_V1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T2_V1_CurrentSet);
      Steerer_T2_H1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T2_H1_CurrentSet);
      Steerer_T2_V2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T2_V2_CurrentSet);
      Steerer_T2_H2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T2_H2_CurrentSet);
      Steerer_T2_V3_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T2_V3_CurrentSet);
      Steerer_T2_H3_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T2_H3_CurrentSet);
      Steerer_T3_V1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T3_V1_CurrentSet);
      Steerer_T3_H1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T3_H1_CurrentSet);
      Steerer_T3_V2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T3_V2_CurrentSet);
      Steerer_T3_H2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T3_H2_CurrentSet);
      Steerer_T4_V1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T4_V1_CurrentSet);
      Steerer_T4_H1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T4_H1_CurrentSet);
      Steerer_T4_V2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T4_V2_CurrentSet);
      Steerer_T4_H2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T4_H2_CurrentSet);
      Steerer_T5_V1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T5_V1_CurrentSet);
      Steerer_T5_H1_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T5_H1_CurrentSet);
      Steerer_T5_V2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T5_V2_CurrentSet);
      Steerer_T5_H2_CurrentSet = DTL_Steerer_RF_Startup_Working_Current;
      pvPut(Steerer_T5_H2_CurrentSet);


      /*
       * Setup Cooling System
       * - check if sub-system is in MANUAL or AUTO mode
       * - set start operation command to ENABLE
       * - working temperature set in cooling state machine (ready for operations stage)
      */
      Cooling_StartOperationCmd=1;
      pvPut(Cooling_StartOperationCmd);
      sleep(5);
      /* Case sub-system in start-up stage: system requires pressures and fluxes check  */
      if (Cooling_StateMachineCode == 30) {
        if (Cooling_AutoControlCmd == 0 && Cooling_Manual_Test_Done == 0) {
          printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and MANUAL control. Wait for test parameters control \n");
        }
        else if (Cooling_AutoControlCmd == 0 && Cooling_Manual_Test_Done == 1) {
          printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and MANUAL control. Test check already set on DONE \n");
        }
        else if (Cooling_AutoControlCmd == 1) {
          printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and AUTO control. Execute fluxes and pressures check \n");
          Cooling_Manual_Test_Done=1;
          pvPut(Cooling_Manual_Test_Done);
        }
        else {
          printf("[SEQ ORCHESTRATION] This message should not appear :) \n");
        }
      }

      /*
       * Setup Arc Detection System
       * -check if sub-system is in MANUAL or AUTO mode
       * - set start operation command to ENABLE
      */
      ArcDetection_StartOperationCmd=1;
      pvPut(ArcDetection_StartOperationCmd);

      if (ArcDetection_StateMachineCode == 30) {
        if (ArcDetection_AutoControlCmd == 0 && ArcDetection_Manual_Test_Done == 0) {
          printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and MANUAL control. Wait for test parameters control \n");
        }
        else if (ArcDetection_AutoControlCmd == 0 && ArcDetection_Manual_Test_Done == 1) {
          printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and MANUAL control. Test check already set on DONE \n");
        }
        else if (ArcDetection_AutoControlCmd == 1) {
          printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and AUTO control. Execute fluxes and pressures check \n");
          ArcDetection_Manual_Test_Done=1;
          pvPut(ArcDetection_Manual_Test_Done);
        }
        else {
          printf("[SEQ ORCHESTRATION] This message should not appear :) \n");
        }
      }

      /*
       * Setup RF System
       * - set control in Frequency Follower Mode
      */
      DTL_Frequency_Mode=909;
      pvPut(DTL_Frequency_Mode);

      /*
       * Setup Temperature System
       * - set Alarm Temperature to T1_MAX (used HIHI limit)
      */
      /* Tank 1 */
      for (index = 0; index < 62; index++) {
        Thermosensors_T1_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T1_Max_Temp[index]);
      }
      /* Tank 2 */
      for (index = 0; index < 35; index++) {
        Thermosensors_T2_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T2_Max_Temp[index]);
      }
      /* Tank 3 */
      for (index = 0; index < 30; index++) {
        Thermosensors_T3_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T3_Max_Temp[index]);
      }
      /* Tank 4 */
      for (index = 0; index < 27; index++) {
        Thermosensors_T4_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T4_Max_Temp[index]);
      }
      /* Tank 5 */
      for (index = 0; index < 24; index++) {
        Thermosensors_T5_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
        pvPut(Thermosensors_T5_Max_Temp[index]);
      }

      /*
       * Indicate DTL ready for RF (not BEAM)
      */
      DTL_T1_RF_Ready=1;
      pvPut(DTL_T1_RF_Ready);
      DTL_T2_RF_Ready=1;
      pvPut(DTL_T2_RF_Ready);
      DTL_T3_RF_Ready=1;
      pvPut(DTL_T3_RF_Ready);
      DTL_T4_RF_Ready=1;
      pvPut(DTL_T4_RF_Ready);
      DTL_T5_RF_Ready=1;
      pvPut(DTL_T5_RF_Ready);
      DTL_RF_Ready=1;
      pvPut(DTL_RF_Ready);
      DTL_T1_Beam_Ready=0;
      pvPut(DTL_T1_Beam_Ready);
      DTL_T2_Beam_Ready=0;
      pvPut(DTL_T2_Beam_Ready);
      DTL_T3_Beam_Ready=0;
      pvPut(DTL_T3_Beam_Ready);
      DTL_T4_Beam_Ready=0;
      pvPut(DTL_T4_Beam_Ready);
      DTL_T5_Beam_Ready=0;
      pvPut(DTL_T5_Beam_Ready);
      DTL_Beam_Ready=0;
      pvPut(DTL_Beam_Ready);

    }

    /* If there is at least one sub-system is not ok, come back to stand_by stage */
    when ( (T1_Vacuum_OK_Status == 0) || (T2_Vacuum_OK_Status == 0) || (T3_Vacuum_OK_Status == 0) || (T4_Vacuum_OK_Status == 0) || (T5_Vacuum_OK_Status == 0) || (T0_Coolong_OK_Status == 0) || (T1_Cooling_OK_Status == 0) || (T2_Cooling_OK_Status == 0) || (T3_Cooling_OK_Status == 0) || (T4_Cooling_OK_Status == 0) || (T5_Cooling_OK_Status == 0) || (T1_RFSlow_OK_Status == 0) || (T2_RFSlow_OK_Status == 0) || (T3_RFSlow_OK_Status == 0) || (T4_RFSlow_OK_Status == 0) || (T5_RFSlow_OK_Status == 0) || (T1_Steerer_OK_Status == 0) || (T2_Steerer_OK_Status == 0) || (T3_Steerer_OK_Status == 0) || (T4_Steerer_OK_Status == 0) || (T5_Steerer_OK_Status == 0) || (T1_Tuner_OK_Status == 0) || (T2_Tuner_OK_Status == 0) || (T3_Tuner_OK_Status == 0) || (T4_Tuner_OK_Status == 0) || (T5_Tuner_OK_Status == 0) || (T1_ArcDetection_OK_Status == 0) || (T2_ArcDetection_OK_Status == 0) || (T3_ArcDetection_OK_Status == 0) || (T4_ArcDetection_OK_Status == 0) || (T5_ArcDetection_OK_Status == 0) ) {
        printf("[SEQ ORCHESTRATION] One or more sub-systems are NOT OK. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to STAND_BY stage. \n");

        /* Stop Operations for sub-systems */
        Steerer_StopOperationCmd=1;
        pvPut(Steerer_StopOperationCmd);
        Tuners_StopOperationCmd=1;
        pvPut(Tuners_StopOperationCmd);
        Cooling_StopOperationCmd=1;
        pvPut(Cooling_StopOperationCmd);
        ArcDetection_StartOperationCmd=0;
        pvPut(ArcDetection_StartOperationCmd);

        /*
         *  Additional cmds
         */

    } state stand_by

    /* Execute cooling manual start-up test on fluxes and pressures */
    when ( (Cooling_StateMachineCode == 30) && (Cooling_AutoControlCmd == 0) && (Cooling_Manual_Test_Done == 1)  ) {
        printf("[SEQ ORCHESTRATION] Cooling sub-system: executed start-up procedure. \n");

    } state rf_start_up

    /* Error: cooling system not in ready for operation stage */
    when (Cooling_StateMachineCode != 40) {
        printf("[SEQ ORCHESTRATION] Cooling sub-system error: system not in ready for operation stage. \n");
        printf("[SEQ ORCHESTRATION] Main system reset to STAND_BY stage. \n");

    } state stand_by

    /* Error: tuner system not in ready for operation stage */
    when (Tuners_StateMachineCode != 40) {
        printf("[SEQ ORCHESTRATION] Tuner sub-system error: system not in ready for operation stage. \n");
        printf("[SEQ ORCHESTRATION] Main system reset to STAND_BY stage. \n");

    } state stand_by

    /* Error: steerer system not in ready for operation stage */
    when (Steerer_StateMachineCode != 40) {
        printf("[SEQ ORCHESTRATION] Steerer sub-system error: system not in ready for operation stage. \n");
        printf("[SEQ ORCHESTRATION] Main system reset to STAND_BY stage. \n");

    } state stand_by

    /* Error in operation request by the Operator */
    when ( ( (dtlOperationalCode_Command != 101) || (dtlOperationalCode_Command != 404) ) && (dtlOperationalCode_Command != dtl_operation_command_prev) ) {
        printf("[SEQ ORCHESTRATION] Error in operation request by the user: operation transition not allowed. \n");
        printf("[SEQ ORCHESTRATION] Main system remains in RF START-UP stage. \n");

    } state rf_start_up

    /* Request for Stand By stage by the Operator */
    when (dtlOperationalCode_Command == 101) {
        printf("[SEQ ORCHESTRATION] Request for Stand-by operation by the user. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to STAND_BY stage. \n");

        /* Stop operation commands for cooling, tuners and steerer sub-systems */
        Tuners_StopOperationCmd=1;
        pvPut(Tuners_StopOperationCmd);
        Steerer_StopOperationCmd=1;
        pvPut(Steerer_StopOperationCmd);
        Cooling_StopOperationCmd=1;
        pvPut(Cooling_StopOperationCmd);
        ArcDetection_StartOperationCmd=0;
        pvPut(ArcDetection_StartOperationCmd);

        /* save last operational code command sent */
        dtl_operation_command_prev=dtlOperationalCode_Command;

    } state stand_by

    /* Request for Ready for Operation by the Operator */
    /* Error if request is done when vacuum pressure is not under P2 [mBar] or frequency error (detuning) is less the Low Threshold Δf1: | f | >= | Δf1 |  */
    when ( (dtlOperationalCode_Command == 404) && ( (DTL_Frequency_Detuning >= Freq_Low_Delta) || (Vacuum_T1_Pressure > DTL_Vacuum_RF_Beam_Operation_Working_Pressure) || (Vacuum_T1_Pressure > DTL_Vacuum_RF_Beam_Operation_Working_Pressure) || (Vacuum_T2_Pressure > DTL_Vacuum_RF_Beam_Operation_Working_Pressure) || (Vacuum_T3_Pressure > DTL_Vacuum_RF_Beam_Operation_Working_Pressure) || (Vacuum_T4_Pressure > DTL_Vacuum_RF_Beam_Operation_Working_Pressure) || (Vacuum_T5_Pressure > DTL_Vacuum_RF_Beam_Operation_Working_Pressure) ) ) {
        printf("[SEQ ORCHESTRATION] Error in operation request by the user: frequency error higher than threshold. \n");
        printf("[SEQ ORCHESTRATION] Main system remains in RF START-UP stage. \n");

        /* save last operational code command sent */
        dtl_operation_command_prev=dtlOperationalCode_Command;

    } state rf_start_up

    /* it is mandatory the tanks vacuum pressure is below P2 pressure and the frequency error (detuning) is lower than the Low Threshold Δf1: | f | < | Δf1 | */
    when ( (dtlOperationalCode_Command == 404) && (DTL_Frequency_Detuning < Freq_Low_Delta) && (Vacuum_T1_Pressure <= DTL_Vacuum_RF_Beam_Operation_Working_Pressure) && (Vacuum_T2_Pressure <= DTL_Vacuum_RF_Beam_Operation_Working_Pressure) && (Vacuum_T3_Pressure <= DTL_Vacuum_RF_Beam_Operation_Working_Pressure) && (Vacuum_T4_Pressure <= DTL_Vacuum_RF_Beam_Operation_Working_Pressure) && (Vacuum_T5_Pressure <= DTL_Vacuum_RF_Beam_Operation_Working_Pressure) ) {
        printf("[SEQ ORCHESTRATION] Request for Ready for Operation operation by the user. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to READY_FOR_OPERATION stage. \n");

        /* save last operational code command sent */
        dtl_operation_command_prev=dtlOperationalCode_Command;

    } state ready_for_operation


}



/* state READY_FOR_OPERATION 	*/
state ready_for_operation {

    entry {
      printf("\n[SEQ ORCHESTRATION] Enter in READY FOR OPERATION status\n");
      dtl_operation_code_prev=dtlOperationalCode;
      dtlOperationalCode=404;
      pvPut(dtlOperationalCode);

      /*
       * Setup Tuner System
       * - set autoControl to AUTO [0]
       * - set start operation is already ENABLE
       * - Motors are already ENABLE
       * - ENABLE PID control
      */
      /* Case sub-system in idle */
      if (Tuners_StateMachineCode == 20) {
        printf("[SEQ ORCHESTRATION] Tuner System in IDLE: set AUTO control and enable operation\n");

        Tuners_AutoControlCmd=1;
        pvPut(Tuners_AutoControlCmd);
        Tuners_StartOperationCmd=1;
        pvPut(Tuners_StartOperationCmd);
      }

      /* Case sub-system in ready for operation */
      else if ( (Tuners_StateMachineCode == 30) && (Tuners_AutoControl_ActualStatus == 0) ) {
        printf("[SEQ ORCHESTRATION] Tuner System in READY FOR OPERATION: set only AUTO control \n");
        Tuners_AutoControlCmd=1;
        pvPut(Tuners_AutoControlCmd);

      }
      printf("[SEQ ORCHESTRATION] Enable Tuners PID control \n");
      Tuners_T1_M1_PID_Enable=1;
      pvPut(Tuners_T1_M1_PID_Enable);
      Tuners_T1_M2_PID_Enable=1;
      pvPut(Tuners_T1_M2_PID_Enable);
      Tuners_T1_M3_PID_Enable=1;
      pvPut(Tuners_T1_M3_PID_Enable);
      Tuners_T2_M1_PID_Enable=1;
      pvPut(Tuners_T2_M1_PID_Enable);
      Tuners_T2_M2_PID_Enable=1;
      pvPut(Tuners_T2_M2_PID_Enable);
      Tuners_T2_M3_PID_Enable=1;
      pvPut(Tuners_T2_M3_PID_Enable);
      Tuners_T3_M1_PID_Enable=1;
      pvPut(Tuners_T3_M1_PID_Enable);
      Tuners_T3_M2_PID_Enable=1;
      pvPut(Tuners_T3_M2_PID_Enable);
      Tuners_T3_M3_PID_Enable=1;
      pvPut(Tuners_T3_M3_PID_Enable);
      Tuners_T4_M1_PID_Enable=1;
      pvPut(Tuners_T4_M1_PID_Enable);
      Tuners_T4_M2_PID_Enable=1;
      pvPut(Tuners_T4_M2_PID_Enable);
      Tuners_T4_M3_PID_Enable=1;
      pvPut(Tuners_T4_M3_PID_Enable);
      Tuners_T5_M1_PID_Enable=1;
      pvPut(Tuners_T5_M1_PID_Enable);
      Tuners_T5_M2_PID_Enable=1;
      pvPut(Tuners_T5_M2_PID_Enable);
      Tuners_T5_M3_PID_Enable=1;
      pvPut(Tuners_T5_M3_PID_Enable);

      /*
       * Setup Steerer System
       * - set autoControl to AUTO [1]
       * - start operation command already ENABLE
       * - steerers already ENABLED
      */
      /* Case sub-system in idle */
      if (Steerer_StateMachineCode == 20) {
        printf("[SEQ ORCHESTRATION] Steerer System in IDLE: set MANUAL control and enable operation\n");

        Steerer_AutoControlCmd=1;
        pvPut(Steerer_AutoControlCmd);
        Steerer_StartOperationCmd=1;
        pvPut(Steerer_StartOperationCmd);
      }

      /* Case sub-system in ready for operation */
      else if ( (Steerer_StateMachineCode == 30) && (Steerer_AutoControl_ActualStatus == 0) ) {
        printf("[SEQ ORCHESTRATION] Steerer System in READY FOR OPERATION: set only AUTO control \n");
        Steerer_AutoControlCmd=1;
        pvPut(Steerer_AutoControlCmd);

      }

      /*
       * Setup Cooling System
       * - check if sub-system is in MANUAL or AUTO mode
       * - start operation command already ENABLE
       * - working temperature already set in cooling state machine (ready for operations stage)
      */

      /* Case sub-system in start-up stage: system requires pressures and fluxes check  */
      /* To Be Checked */
      if (Cooling_StateMachineCode == 30) {
        if (Cooling_AutoControlCmd == 0 && Cooling_Manual_Test_Done == 0) {
          printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and MANUAL control. Wait for test parameters control \n");
        }
        else if (Cooling_AutoControlCmd == 0 && Cooling_Manual_Test_Done == 1) {
          printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and MANUAL control. Test check already set on DONE \n");
        }
        else if (Cooling_AutoControlCmd == 1) {
          printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and AUTO control. Execute fluxes and pressures check \n");
          Cooling_Manual_Test_Done=1;
        }
        else {
          printf("[SEQ ORCHESTRATION] This message should not appear :) \n");
        }
      }

      /*
       * Setup Arc Detection System
       * -check if sub-system is in MANUAL or AUTO mode
       * - set start operation command already ENABLE
      */
      /* To Be Checked */
      if (ArcDetection_StateMachineCode == 30) {
        if (ArcDetection_AutoControlCmd == 0 && ArcDetection_Manual_Test_Done == 0) {
          printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and MANUAL control. Wait for test parameters control \n");
        }
        else if (ArcDetection_AutoControlCmd == 0 && ArcDetection_Manual_Test_Done == 1) {
          printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and MANUAL control. Test check already set on DONE \n");
        }
        else if (ArcDetection_AutoControlCmd == 1) {
          printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and AUTO control. Execute fluxes and pressures check \n");
          ArcDetection_Manual_Test_Done=1;
          pvPut(ArcDetection_Manual_Test_Done);
        }
        else {
          printf("[SEQ ORCHESTRATION] This message should not appear :) \n");
        }
      }

      /*
       * Setup RF System
       * - set control in Fixed Frequency
       * - RF system works in amplitude and phase closed loop --> To be check
      */
      DTL_Frequency_Mode=808;
      pvPut(DTL_Frequency_Mode);

      /*
       * Setup Temperature System
       * - Alarm Temperature already set to T1_MAX (used HIHI limit)
      */

      /*
       * Indicate DTL ready for BEAM (already ready for RF)
      */
      DTL_T1_Beam_Ready=1;
      pvPut(DTL_T1_Beam_Ready);
      DTL_T2_Beam_Ready=1;
      pvPut(DTL_T2_Beam_Ready);
      DTL_T3_Beam_Ready=1;
      pvPut(DTL_T3_Beam_Ready);
      DTL_T4_Beam_Ready=1;
      pvPut(DTL_T4_Beam_Ready);
      DTL_T5_Beam_Ready=1;
      pvPut(DTL_T5_Beam_Ready);
      DTL_Beam_Ready=1;
      pvPut(DTL_Beam_Ready);

      /*
       * Setup Vacuum System
       * - Check Intertank valves are OPENED
      */


    }

    /* If there is at least one sub-system is not ok, come back to stand_by stage */
    when ( (T1_Vacuum_OK_Status == 0) || (T2_Vacuum_OK_Status == 0) || (T3_Vacuum_OK_Status == 0) || (T4_Vacuum_OK_Status == 0) || (T5_Vacuum_OK_Status == 0) || (T0_Coolong_OK_Status == 0) || (T1_Cooling_OK_Status == 0) || (T2_Cooling_OK_Status == 0) || (T3_Cooling_OK_Status == 0) || (T4_Cooling_OK_Status == 0) || (T5_Cooling_OK_Status == 0) || (T1_RFSlow_OK_Status == 0) || (T2_RFSlow_OK_Status == 0) || (T3_RFSlow_OK_Status == 0) || (T4_RFSlow_OK_Status == 0) || (T5_RFSlow_OK_Status == 0) || (T1_Steerer_OK_Status == 0) || (T2_Steerer_OK_Status == 0) || (T3_Steerer_OK_Status == 0) || (T4_Steerer_OK_Status == 0) || (T5_Steerer_OK_Status == 0) || (T1_Tuner_OK_Status == 0) || (T2_Tuner_OK_Status == 0) || (T3_Tuner_OK_Status == 0) || (T4_Tuner_OK_Status == 0) || (T5_Tuner_OK_Status == 0) || (T1_ArcDetection_OK_Status == 0) || (T2_ArcDetection_OK_Status == 0) || (T3_ArcDetection_OK_Status == 0) || (T4_ArcDetection_OK_Status == 0) || (T5_ArcDetection_OK_Status == 0) ) {
        printf("[SEQ ORCHESTRATION] One or more sub-systems are NOT OK. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to STAND_BY stage. \n");

        /* Stop Operations for sub-systems */
        Steerer_StopOperationCmd=1;
        pvPut(Steerer_StopOperationCmd);
        Tuners_StopOperationCmd=1;
        pvPut(Tuners_StopOperationCmd);
        Cooling_StopOperationCmd=1;
        pvPut(Cooling_StopOperationCmd);
        ArcDetection_StartOperationCmd=0;
        pvPut(ArcDetection_StartOperationCmd);

        /*
         *  Additional cmds
         */

    } state stand_by

    /* Error: cooling system not in ready for operation stage */
    when (Cooling_StateMachineCode != 40) {
        printf("[SEQ ORCHESTRATION] Cooling sub-system error: system not in ready for operation stage. \n");
        printf("[SEQ ORCHESTRATION] Main system reset to RF STARTUP stage. \n");

    } state rf_start_up

    /* Error: tuner system not in ready for operation stage */
    when (Tuners_StateMachineCode != 40) {
        printf("[SEQ ORCHESTRATION] Tuner sub-system error: system not in ready for operation stage. \n");
        printf("[SEQ ORCHESTRATION] Main system reset to RF STARTUP stage. \n");

    } state rf_start_up

    /* Error in operation request  the Operator */
    when ( ( (dtlOperationalCode_Command != 101) || (dtlOperationalCode_Command != 303) ) && (dtlOperationalCode_Command != dtl_operation_command_prev) ) {
        printf("[SEQ ORCHESTRATION] Error in operation request by the user: operation transition not allowed. \n");
        printf("[SEQ ORCHESTRATION] Main system remains in RF READY_FOR_OPERATION stage. \n");

    } state ready_for_operation

    /* Request for Stand By stage by the Operator */
    when (dtlOperationalCode_Command == 101) {
        printf("[SEQ ORCHESTRATION] Request for RF Conditioning operation by the user. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to STAND_BY stage. \n");

        /* save last operational code command sent */
        dtl_operation_command_prev=dtlOperationalCode_Command;

    } state rf_start_up

    /* Request for RF Startup by the Operator */
    when (dtlOperationalCode_Command == 303) {
        printf("[SEQ ORCHESTRATION] Request for RF Start-up operation by the user. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to START-UP stage. \n");

        /* save last operational code command sent */
        dtl_operation_command_prev=dtlOperationalCode_Command;

    } state rf_start_up


    /* it is mandatory the frequency error (detuning) is bigger than the High Threshold Δf2: | f | > | Δf2 | */
    when (DTL_Frequency_Detuning > Freq_High_Delta) {
        printf("[SEQ ORCHESTRATION] Frequency error higher than High Threshold. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to RF STARTUP stage. \n");

        /* Disable PID control */
        Tuners_T1_M1_PID_Enable=0;
        pvPut(Tuners_T1_M1_PID_Enable);
        Tuners_T1_M2_PID_Enable=0;
        pvPut(Tuners_T1_M2_PID_Enable);
        Tuners_T1_M3_PID_Enable=0;
        pvPut(Tuners_T1_M3_PID_Enable);
        Tuners_T2_M1_PID_Enable=0;
        pvPut(Tuners_T2_M1_PID_Enable);
        Tuners_T2_M2_PID_Enable=0;
        pvPut(Tuners_T2_M2_PID_Enable);
        Tuners_T2_M3_PID_Enable=0;
        pvPut(Tuners_T2_M3_PID_Enable);
        Tuners_T3_M1_PID_Enable=0;
        pvPut(Tuners_T3_M1_PID_Enable);
        Tuners_T3_M2_PID_Enable=0;
        pvPut(Tuners_T3_M2_PID_Enable);
        Tuners_T3_M3_PID_Enable=0;
        pvPut(Tuners_T3_M3_PID_Enable);
        Tuners_T4_M1_PID_Enable=0;
        pvPut(Tuners_T4_M1_PID_Enable);
        Tuners_T4_M2_PID_Enable=0;
        pvPut(Tuners_T4_M2_PID_Enable);
        Tuners_T4_M3_PID_Enable=0;
        pvPut(Tuners_T4_M3_PID_Enable);
        Tuners_T5_M1_PID_Enable=0;
        pvPut(Tuners_T5_M1_PID_Enable);
        Tuners_T5_M2_PID_Enable=0;
        pvPut(Tuners_T5_M2_PID_Enable);
        Tuners_T5_M3_PID_Enable=0;
        pvPut(Tuners_T5_M3_PID_Enable);

    } state rf_start_up

  }


/* state NO_ACCELERATED_BEAM	*/
state no_accelerated_beam {

    entry {
        printf("\n[SEQ ORCHESTRATION] Enter in NO ACCELERATED BEAM status\n");
        dtl_operation_code_prev=dtlOperationalCode;
        dtlOperationalCode=505;
        pvPut(dtlOperationalCode);


        /*
         * Setup Tuner System
         * - no conditions required
         * - keep the configuration user for RF conditioning
        */
        /* Case sub-system in idle */
        if (Tuners_StateMachineCode == 20) {
          printf("[SEQ ORCHESTRATION] Tuner System in IDLE: set MANUAL control and enable operation\n");

          Tuners_AutoControlCmd=0;
          pvPut(Tuners_AutoControlCmd);
          Tuners_StartOperationCmd=1;
          pvPut(Tuners_StartOperationCmd);
        }

        /* Case sub-system in ready for operation */
        else if ( (Tuners_StateMachineCode == 30) && (Tuners_AutoControl_ActualStatus == 1) ) {
          printf("[SEQ ORCHESTRATION] Tuner System in READY FOR OPERATION: set only MANUAL control \n");
          Tuners_AutoControlCmd=0;
          pvPut(Tuners_AutoControlCmd);

        }
        printf("[SEQ ORCHESTRATION] Disable Tuners PID control \n");
        Tuners_T1_M1_PID_Enable=0;
        pvPut(Tuners_T1_M1_PID_Enable);
        Tuners_T1_M2_PID_Enable=0;
        pvPut(Tuners_T1_M2_PID_Enable);
        Tuners_T1_M3_PID_Enable=0;
        pvPut(Tuners_T1_M3_PID_Enable);
        Tuners_T2_M1_PID_Enable=0;
        pvPut(Tuners_T2_M1_PID_Enable);
        Tuners_T2_M2_PID_Enable=0;
        pvPut(Tuners_T2_M2_PID_Enable);
        Tuners_T2_M3_PID_Enable=0;
        pvPut(Tuners_T2_M3_PID_Enable);
        Tuners_T3_M1_PID_Enable=0;
        pvPut(Tuners_T3_M1_PID_Enable);
        Tuners_T3_M2_PID_Enable=0;
        pvPut(Tuners_T3_M2_PID_Enable);
        Tuners_T3_M3_PID_Enable=0;
        pvPut(Tuners_T3_M3_PID_Enable);
        Tuners_T4_M1_PID_Enable=0;
        pvPut(Tuners_T4_M1_PID_Enable);
        Tuners_T4_M2_PID_Enable=0;
        pvPut(Tuners_T4_M2_PID_Enable);
        Tuners_T4_M3_PID_Enable=0;
        pvPut(Tuners_T4_M3_PID_Enable);
        Tuners_T5_M1_PID_Enable=0;
        pvPut(Tuners_T5_M1_PID_Enable);
        Tuners_T5_M2_PID_Enable=0;
        pvPut(Tuners_T5_M2_PID_Enable);
        Tuners_T5_M3_PID_Enable=0;
        pvPut(Tuners_T5_M3_PID_Enable);

        printf("[SEQ ORCHESTRATION] Disable Tuners motor axis \n");
        Tuners_T1_M1_Axis_Enable=0;
        pvPut(Tuners_T1_M1_Axis_Enable);
        Tuners_T1_M2_Axis_Enable=0;
        pvPut(Tuners_T1_M2_Axis_Enable);
        Tuners_T1_M3_Axis_Enable=0;
        pvPut(Tuners_T1_M3_Axis_Enable);
        Tuners_T2_M1_Axis_Enable=0;
        pvPut(Tuners_T2_M1_Axis_Enable);
        Tuners_T2_M2_Axis_Enable=0;
        pvPut(Tuners_T2_M2_Axis_Enable);
        Tuners_T2_M3_Axis_Enable=0;
        pvPut(Tuners_T2_M3_Axis_Enable);
        Tuners_T3_M1_Axis_Enable=0;
        pvPut(Tuners_T3_M1_Axis_Enable);
        Tuners_T3_M2_Axis_Enable=0;
        pvPut(Tuners_T3_M2_Axis_Enable);
        Tuners_T3_M3_Axis_Enable=0;
        pvPut(Tuners_T3_M3_Axis_Enable);
        Tuners_T4_M1_Axis_Enable=0;
        pvPut(Tuners_T4_M1_Axis_Enable);
        Tuners_T4_M2_Axis_Enable=0;
        pvPut(Tuners_T4_M2_Axis_Enable);
        Tuners_T4_M3_Axis_Enable=0;
        pvPut(Tuners_T4_M3_Axis_Enable);
        Tuners_T5_M1_Axis_Enable=0;
        pvPut(Tuners_T5_M1_Axis_Enable);
        Tuners_T5_M2_Axis_Enable=0;
        pvPut(Tuners_T5_M2_Axis_Enable);
        Tuners_T5_M3_Axis_Enable=0;
        pvPut(Tuners_T5_M3_Axis_Enable);

        /*
         * Setup Steerer System
         * - set autoControl to MANUAL [0]
         * - set start operation command to ENABLE
         * - set current setpoint to 0A
         * - steerers can be ENABLED (default: DISABLED)
        */
        /* Case sub-system in idle */
        if (Steerer_StateMachineCode == 20) {
          printf("[SEQ ORCHESTRATION] Steerer System in IDLE: set MANUAL control and enable operation\n");

          Steerer_AutoControlCmd=0;
          pvPut(Steerer_AutoControlCmd);
          Steerer_StartOperationCmd=1;
          pvPut(Steerer_StartOperationCmd);
        }

        /* Case sub-system in ready for operation */
        else if ( (Steerer_StateMachineCode == 30) && (Steerer_AutoControl_ActualStatus == 1) ) {
          printf("[SEQ ORCHESTRATION] Steerer System in READY FOR OPERATION: set only MANUAL control \n");
          Steerer_AutoControlCmd=0;
          pvPut(Steerer_AutoControlCmd);

        }
        printf("[SEQ ORCHESTRATION] Set Steerers setpoint to 0A \n");
        Steerer_T1_V1_CurrentSet = 0;
        pvPut(Steerer_T1_V1_CurrentSet);
        Steerer_T1_H1_CurrentSet = 0;
        pvPut(Steerer_T1_H1_CurrentSet);
        Steerer_T1_V2_CurrentSet = 0;
        pvPut(Steerer_T1_V2_CurrentSet);
        Steerer_T1_H2_CurrentSet = 0;
        pvPut(Steerer_T1_H2_CurrentSet);
        Steerer_T1_V3_CurrentSet = 0;
        pvPut(Steerer_T1_V3_CurrentSet);
        Steerer_T1_H3_CurrentSet = 0;
        pvPut(Steerer_T1_H3_CurrentSet);
        Steerer_T1_V4_CurrentSet = 0;
        pvPut(Steerer_T1_V4_CurrentSet);
        Steerer_T1_H4_CurrentSet = 0;
        pvPut(Steerer_T1_H4_CurrentSet);
        Steerer_T1_V5_CurrentSet = 0;
        pvPut(Steerer_T1_V5_CurrentSet);
        Steerer_T1_H5_CurrentSet = 0;
        pvPut(Steerer_T1_H5_CurrentSet);
        Steerer_T1_V6_CurrentSet = 0;
        pvPut(Steerer_T1_V6_CurrentSet);
        Steerer_T1_H6_CurrentSet = 0;
        pvPut(Steerer_T1_H6_CurrentSet);
        Steerer_T2_V1_CurrentSet = 0;
        pvPut(Steerer_T2_V1_CurrentSet);
        Steerer_T2_H1_CurrentSet = 0;
        pvPut(Steerer_T2_H1_CurrentSet);
        Steerer_T2_V2_CurrentSet = 0;
        pvPut(Steerer_T2_V2_CurrentSet);
        Steerer_T2_H2_CurrentSet = 0;
        pvPut(Steerer_T2_H2_CurrentSet);
        Steerer_T2_V3_CurrentSet = 0;
        pvPut(Steerer_T2_V3_CurrentSet);
        Steerer_T2_H3_CurrentSet = 0;
        pvPut(Steerer_T2_H3_CurrentSet);
        Steerer_T3_V1_CurrentSet = 0;
        pvPut(Steerer_T3_V1_CurrentSet);
        Steerer_T3_H1_CurrentSet = 0;
        pvPut(Steerer_T3_H1_CurrentSet);
        Steerer_T3_V2_CurrentSet = 0;
        pvPut(Steerer_T3_V2_CurrentSet);
        Steerer_T3_H2_CurrentSet = 0;
        pvPut(Steerer_T3_H2_CurrentSet);
        Steerer_T4_V1_CurrentSet = 0;
        pvPut(Steerer_T4_V1_CurrentSet);
        Steerer_T4_H1_CurrentSet = 0;
        pvPut(Steerer_T4_H1_CurrentSet);
        Steerer_T4_V2_CurrentSet = 0;
        pvPut(Steerer_T4_V2_CurrentSet);
        Steerer_T4_H2_CurrentSet = 0;
        pvPut(Steerer_T4_H2_CurrentSet);
        Steerer_T5_V1_CurrentSet = 0;
        pvPut(Steerer_T5_V1_CurrentSet);
        Steerer_T5_H1_CurrentSet = 0;
        pvPut(Steerer_T5_H1_CurrentSet);
        Steerer_T5_V2_CurrentSet = 0;
        pvPut(Steerer_T5_V2_CurrentSet);
        Steerer_T5_H2_CurrentSet = 0;
        pvPut(Steerer_T5_H2_CurrentSet);

        printf("[SEQ ORCHESTRATION] Disable Steerers \n");
        Steerer_T1_V1_ChEnableCmd = 0;
        pvPut(Steerer_T1_V1_ChEnableCmd);
        Steerer_T1_H1_ChEnableCmd = 0;
        pvPut(Steerer_T1_H1_ChEnableCmd);
        Steerer_T1_V2_ChEnableCmd = 0;
        pvPut(Steerer_T1_V2_ChEnableCmd);
        Steerer_T1_H2_ChEnableCmd = 0;
        pvPut(Steerer_T1_H2_ChEnableCmd);
        Steerer_T1_V3_ChEnableCmd = 0;
        pvPut(Steerer_T1_V3_ChEnableCmd);
        Steerer_T1_H3_ChEnableCmd = 0;
        pvPut(Steerer_T1_H3_ChEnableCmd);
        Steerer_T1_V4_ChEnableCmd = 0;
        pvPut(Steerer_T1_V4_ChEnableCmd);
        Steerer_T1_H4_ChEnableCmd = 0;
        pvPut(Steerer_T1_H4_ChEnableCmd);
        Steerer_T1_V5_ChEnableCmd = 0;
        pvPut(Steerer_T1_V5_ChEnableCmd);
        Steerer_T1_H5_ChEnableCmd = 0;
        pvPut(Steerer_T1_H5_ChEnableCmd);
        Steerer_T1_V6_ChEnableCmd = 0;
        pvPut(Steerer_T1_V6_ChEnableCmd);
        Steerer_T1_H6_ChEnableCmd = 0;
        pvPut(Steerer_T1_H6_ChEnableCmd);
        Steerer_T2_V1_ChEnableCmd = 0;
        pvPut(Steerer_T2_V1_ChEnableCmd);
        Steerer_T2_H1_ChEnableCmd = 0;
        pvPut(Steerer_T2_H1_ChEnableCmd);
        Steerer_T2_V2_ChEnableCmd = 0;
        pvPut(Steerer_T2_V2_ChEnableCmd);
        Steerer_T2_H2_ChEnableCmd = 0;
        pvPut(Steerer_T2_H2_ChEnableCmd);
        Steerer_T2_V3_ChEnableCmd = 0;
        pvPut(Steerer_T2_V3_ChEnableCmd);
        Steerer_T2_H3_ChEnableCmd = 0;
        pvPut(Steerer_T2_H3_ChEnableCmd);
        Steerer_T3_V1_ChEnableCmd = 0;
        pvPut(Steerer_T3_V1_ChEnableCmd);
        Steerer_T3_H1_ChEnableCmd = 0;
        pvPut(Steerer_T3_H1_ChEnableCmd);
        Steerer_T3_V2_ChEnableCmd = 0;
        pvPut(Steerer_T3_V2_ChEnableCmd);
        Steerer_T3_H2_ChEnableCmd = 0;
        pvPut(Steerer_T3_H2_ChEnableCmd);
        Steerer_T4_V1_ChEnableCmd = 0;
        pvPut(Steerer_T4_V1_ChEnableCmd);
        Steerer_T4_H1_ChEnableCmd = 0;
        pvPut(Steerer_T4_H1_ChEnableCmd);
        Steerer_T4_V2_ChEnableCmd = 0;
        pvPut(Steerer_T4_V2_ChEnableCmd);
        Steerer_T4_H2_ChEnableCmd = 0;
        pvPut(Steerer_T4_H2_ChEnableCmd);
        Steerer_T5_V1_ChEnableCmd = 0;
        pvPut(Steerer_T5_V1_ChEnableCmd);
        Steerer_T5_H1_ChEnableCmd = 0;
        pvPut(Steerer_T5_H1_ChEnableCmd);
        Steerer_T5_V2_ChEnableCmd = 0;
        pvPut(Steerer_T5_V2_ChEnableCmd);
        Steerer_T5_H2_ChEnableCmd = 0;
        pvPut(Steerer_T5_H2_ChEnableCmd);

        /*
         * Setup Cooling System
         * - check if sub-system is in MANUAL or AUTO mode
         * - set start operation command to ENABLE
         * - working temperature set in cooling state machine (ready for operations stage)
        */
        Cooling_StartOperationCmd=1;
        pvPut(Cooling_StartOperationCmd);
        sleep(5);
        /* Case sub-system in start-up stage: system requires pressures and fluxes check  */
        if (Cooling_StateMachineCode == 30) {
          if (Cooling_AutoControlCmd == 0 && Cooling_Manual_Test_Done == 0) {
            printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and MANUAL control. Wait for test parameters control \n");
          }
          else if (Cooling_AutoControlCmd == 0 && Cooling_Manual_Test_Done == 1) {
            printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and MANUAL control. Test check already set on DONE \n");
          }
          else if (Cooling_AutoControlCmd == 1) {
            printf("[SEQ ORCHESTRATION] Cooling sub-system in start-up stage and AUTO control. Execute fluxes and pressures check \n");
            Cooling_Manual_Test_Done=1;
            pvPut(Cooling_Manual_Test_Done);
          }
          else {
            printf("[SEQ ORCHESTRATION] This message should not appear :) \n");
          }
        }

        /*
         * Setup Arc Detection System
         * - check if sub-system is in MANUAL or AUTO mode
         * - set start operation command to ENABLE
        */
        ArcDetection_StartOperationCmd=1;
        pvPut(ArcDetection_StartOperationCmd);

        if (ArcDetection_StateMachineCode == 30) {
          if (ArcDetection_AutoControlCmd == 0 && ArcDetection_Manual_Test_Done == 0) {
            printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and MANUAL control. Wait for test parameters control \n");
          }
          else if (ArcDetection_AutoControlCmd == 0 && ArcDetection_Manual_Test_Done == 1) {
            printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and MANUAL control. Test check already set on DONE \n");
          }
          else if (ArcDetection_AutoControlCmd == 1) {
            printf("[SEQ ORCHESTRATION] Arc Detection sub-system in start-up stage and AUTO control. Execute fluxes and pressures check \n");
            ArcDetection_Manual_Test_Done=1;
            pvPut(ArcDetection_Manual_Test_Done);
          }
          else {
            printf("[SEQ ORCHESTRATION] This message should not appear :) \n");
          }
        }


        /*
         * Setup RF System
         * - no requests for RF Control Mode
         * - left on the last setting used
        */

        /*
         * Setup Temperature System
         * - set Alarm Temperature to T0_MAX (used HIHI limit)
        */
        /* Tank 1 */
        for (index = 0; index < 62; index++) {
          Thermosensors_T1_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
          pvPut(Thermosensors_T1_Max_Temp[index]);
        }
        /* Tank 2 */
        for (index = 0; index < 35; index++) {
          Thermosensors_T2_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
          pvPut(Thermosensors_T2_Max_Temp[index]);
        }
        /* Tank 3 */
        for (index = 0; index < 30; index++) {
          Thermosensors_T3_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
          pvPut(Thermosensors_T3_Max_Temp[index]);
        }
        /* Tank 4 */
        for (index = 0; index < 27; index++) {
          Thermosensors_T4_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
          pvPut(Thermosensors_T4_Max_Temp[index]);
        }
        /* Tank 5 */
        for (index = 0; index < 24; index++) {
          Thermosensors_T5_Max_Temp[index]=DTL_Thermosensors_RF_Conditioning_Max_Temperature;
          pvPut(Thermosensors_T5_Max_Temp[index]);
        }

        /*
         * Indicate DTL ready for RF (not BEAM)
        */
        /* To be updated */
        DTL_T1_RF_Ready=1;
        pvPut(DTL_T1_RF_Ready);
        DTL_T2_RF_Ready=1;
        pvPut(DTL_T2_RF_Ready);
        DTL_T3_RF_Ready=1;
        pvPut(DTL_T3_RF_Ready);
        DTL_T4_RF_Ready=1;
        pvPut(DTL_T4_RF_Ready);
        DTL_T5_RF_Ready=1;
        pvPut(DTL_T5_RF_Ready);
        DTL_RF_Ready=1;
        pvPut(DTL_RF_Ready);
        DTL_T1_Beam_Ready=0;
        pvPut(DTL_T1_Beam_Ready);
        DTL_T2_Beam_Ready=0;
        pvPut(DTL_T2_Beam_Ready);
        DTL_T3_Beam_Ready=0;
        pvPut(DTL_T3_Beam_Ready);
        DTL_T4_Beam_Ready=0;
        pvPut(DTL_T4_Beam_Ready);
        DTL_T5_Beam_Ready=0;
        pvPut(DTL_T5_Beam_Ready);
        DTL_Beam_Ready=0;
        pvPut(DTL_Beam_Ready);


    }

    /* If there is at least one sub-system is not ok, come back to stand_by stage */
    when ( (T1_Vacuum_OK_Status == 0) || (T2_Vacuum_OK_Status == 0) || (T3_Vacuum_OK_Status == 0) || (T4_Vacuum_OK_Status == 0) || (T5_Vacuum_OK_Status == 0) || (T0_Coolong_OK_Status == 0) || (T1_Cooling_OK_Status == 0) || (T2_Cooling_OK_Status == 0) || (T3_Cooling_OK_Status == 0) || (T4_Cooling_OK_Status == 0) || (T5_Cooling_OK_Status == 0) || (T1_RFSlow_OK_Status == 0) || (T2_RFSlow_OK_Status == 0) || (T3_RFSlow_OK_Status == 0) || (T4_RFSlow_OK_Status == 0) || (T5_RFSlow_OK_Status == 0) || (T1_Steerer_OK_Status == 0) || (T2_Steerer_OK_Status == 0) || (T3_Steerer_OK_Status == 0) || (T4_Steerer_OK_Status == 0) || (T5_Steerer_OK_Status == 0) || (T1_Tuner_OK_Status == 0) || (T2_Tuner_OK_Status == 0) || (T3_Tuner_OK_Status == 0) || (T4_Tuner_OK_Status == 0) || (T5_Tuner_OK_Status == 0) || (T1_ArcDetection_OK_Status == 0) || (T2_ArcDetection_OK_Status == 0) || (T3_ArcDetection_OK_Status == 0) || (T4_ArcDetection_OK_Status == 0) || (T5_ArcDetection_OK_Status == 0) ) {
        printf("[SEQ ORCHESTRATION] One or more sub-systems are NOT OK. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to STAND_BY stage. \n");

        /* Stop Operations for sub-systems */
        Steerer_StopOperationCmd=1;
        pvPut(Steerer_StopOperationCmd);
        Tuners_StopOperationCmd=1;
        pvPut(Tuners_StopOperationCmd);
        Cooling_StopOperationCmd=1;
        pvPut(Cooling_StopOperationCmd);
        ArcDetection_StartOperationCmd=0;
        pvPut(ArcDetection_StartOperationCmd);

        /*
         *  Additional cmds
         */

    } state stand_by

    /* Execute cooling manual start-up test on fluxes and pressures */
    when ( (Cooling_StateMachineCode == 30) && (Cooling_AutoControlCmd == 0) && (Cooling_Manual_Test_Done == 1)  ) {
        printf("[SEQ ORCHESTRATION] Cooling sub-system: executed start-up procedure. \n");

    } state rf_start_up

    /* Error: cooling system not in ready for operation stage */
    when (Cooling_StateMachineCode != 40) {
        printf("[SEQ ORCHESTRATION] Cooling sub-system error: system not in ready for operation stage. \n");
        printf("[SEQ ORCHESTRATION] Main system reset to STAND_BY stage. \n");

    } state stand_by

    /* Error in operation request  the Operator */
    when ( (dtlOperationalCode_Command != 101) && (dtlOperationalCode_Command != dtl_operation_command_prev) ) {
        printf("[SEQ ORCHESTRATION] Error in operation request by the user: operation transition not allowed. \n");
        printf("[SEQ ORCHESTRATION] Main system remains in NO_ACCELERATED_BEAM stage. \n");

    } state no_accelerated_beam

    /* Request for Stand By stage by the Operator */
    when (dtlOperationalCode_Command == 101) {
        printf("[SEQ ORCHESTRATION] Request for RF Conditioning operation by the user. \n");
        printf("[SEQ ORCHESTRATION] Main system goes to STAND_BY stage. \n");

        /* save last operational code command sent */
        dtl_operation_command_prev=dtlOperationalCode_Command;

    } state stand_by

  }


/* state MAINTENANCE	*/
  state maintenance {

    entry {
        printf("\n[SEQ ORCHESTRATION] Enter in MAINTENANCE status\n");
        dtl_operation_code_prev=dtlOperationalCode;
        dtlOperationalCode=606;
        pvPut(dtlOperationalCode);

        /* additional commands */
    }

    /* Error in operation request  the Operator */
    when ( (dtlOperationalCode_Command != 606) ) {
        printf("[SEQ ORCHESTRATION] Error in operation request by the user: operation transition not allowed. \n");
        printf("[SEQ ORCHESTRATION] Main system remains in MAINTENANCE stage. \n");

    } state stand_by

    /* DTL Maintenance Status Reset */
    when (DTL_Maintenance_Command == 0) {
      printf("[SEQ ORCHESTRATION] DTL maintenance reset required by operator\n");
      printf("[SEQ ORCHESTRATION] Main System goes to INITIALIZATION stage. \n");
      DTL_Maintenance_Readback=DTL_Maintenance_Command;
      pvPut(DTL_Maintenance_Readback);



    } state initialization

  }


/* end statemachine */
}
