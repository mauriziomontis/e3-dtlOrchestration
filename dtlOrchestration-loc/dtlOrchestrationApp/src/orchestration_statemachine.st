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
assign T0_Coolong_OK_Status to "CWM-CWS04:Ctrl-Intf-001:OkStat-RB"
monitor T0_Coolong_OK_Status;
int T1_Cooling_OK_Status;
assign T1_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-010Ok-RB"
monitor T1_Cooling_OK_Status;
int T2_Cooling_OK_Status;
assign T2_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-020Ok-RB"
monitor T2_Cooling_OK_Status;
int T3_Cooling_OK_Status;
assign T3_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-030Ok-RB"
monitor T3_Cooling_OK_Status;
int T4_Cooling_OK_Status;
assign T4_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-040Ok-RB"
monitor T4_Cooling_OK_Status;
int T5_Cooling_OK_Status;
assign T5_Cooling_OK_Status to "CWM-CWS04:Ctrl-Intf-001:DTL-050Ok-RB"
monitor T5_Cooling_OK_Status;

// Temperature --> RF
int T1_RFSlow_OK_Status;
assign T1_RFSlow_OK_Status to "DTL-010:EMR-Cav-001:WrtC_OkStatS"
monitor T1_RFSlow_OK_Status;
int T2_RFSlow_OK_Status;
assign T2_RFSlow_OK_Status to "DTL-020:EMR-Cav-001:WrtC_OkStatS"
monitor T2_RFSlow_OK_Status;
int T3_RFSlow_OK_Status;
assign T3_RFSlow_OK_Status to "DTL-030:EMR-Cav-001:WrtC_OkStatS"
monitor T3_RFSlow_OK_Status;
int T4_RFSlow_OK_Status;
assign T4_RFSlow_OK_Status to "DTL-040:EMR-Cav-001:WrtC_OkStatS"
monitor T4_RFSlow_OK_Status;
int T5_RFSlow_OK_Status;
assign T5_RFSlow_OK_Status to "DTL-050:EMR-Cav-001:WrtC_OkStatS"
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
assign PLC_Message to "CWM-CWS04:Ctrl-Intf-001:PLCCommMsg"
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


/* -------- Cooling Manual Test Procedure Completed Command -------- */ --- TBD
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


/* Delta Frequency Detuning */
/*
 * RF Freq Low Threshold Δf1
 * RF Freq High Threshold Δf2
 * | Δf1 | < | Δf2 |
*/
double Freq_High_Delta;
assign Freq_High_Delta to "DTL:RFS:BeamOpHDeltaFreq"
monitor Freq_High_Delta;
double Freq_Low_Delta;
assign Freq_Low_Delta to "DTL:RFS:BeamOpHDeltaFreq"
monitor Freq_Low_Delta;

/* DTL Frequency Detuning  */
double DTL_Frequency_Detuning;
assign  DTL_Frequency_Detuning to "";
monitor DTL_Frequency_Detuning;

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



/* Constants */


/* Internal Variables */
int dtl_operation_code_prev=0;

/* Debug Mode: */
double DEBUG=1;



/*
# State Machine Definition
*/

ss  orchestration_statemachine {

/* state INITIALIZATION	*/
	state initialization {
      entry {
        printf("\n\nPreliminary controls executed due to Application Startup - Intialization\n\n");
        dtlOperationalCode=0;
        pvPut(dtlOperationalCode);
      }

      /* Start control only when skid is in remote control */
      when ( (pvConnectCount()==pvAssignCount()) ) {
        printf("[SEQ ORCHESTRATION] All PVs connected and System in Remote Control\n");
        printf("[SEQ ORCHESTRATION] Starting Self Check Process\n");

        /* Actual man|auto control initialization */


        /*
         *  Set all Man|Auto controls to Zero (MAN)
         */

      } state stand_by
	}


/* state STAND_BY	*/
	state stand_by {
      entry {
        printf("\n[SEQ ORCHESTRATION] Enter in STAND BY status\n");
        dtlOperationalCode=101;
        pvPut(dtlOperationalCode);

      }

      /* Check if all functional sub-systems have OK Status */
      when( ... ) {
          printf("[SEQ ORCHESTRATION] Self Check Passed. \n");


    } state conditioning

  }


/* state RF_CONDITIONING   	*/
  state rf_conditioning {
    entry {
      printf("\n[SEQ ORCHESTRATION] Enter in RF CONDITIONING status\n");
      dtlOperationalCode=202;
      pvPut(dtlOperationalCode);
    }

    /* ... */
    when ( ... ) {

    } state rf_start_up

  }



/* state RF STARTUP	*/
state rf_start_up {

  entry {
    printf("\n[SEQ ORCHESTRATION] Enter in RF START-UP status\n");
    dtlOperationalCode=303;
    pvPut(dtlOperationalCode);
  }

  /* ... */
  when ( ... ) {
		printf("[SEQ ORCHESTRATION] ... \n");



  } state ready_for_operation

}



/* state READY_FOR_OPERATION 	*/
state ready_for_operation {

    entry {
      printf("\n[SEQ ORCHESTRATION] Enter in READY FOR OPERATION status\n");
      dtlOperationalCode=404;
      pvPut(dtlOperationalCode);

    }

    /*  ... */
    when ( ... ) {


      } state ready_for_operation

  }


/* state NO_ACCELERATED_BEAM	*/
state no_accelerated_beam {

    entry {
        printf("\n[SEQ ORCHESTRATION] Enter in NO ACCELERATED BEAM status\n");
        dtlOperationalCode=505;
        pvPut(dtlOperationalCode);

    }

    /* ... */
    when ( .. ) {


    } state maintenance

  }


/* state MAINTENANCE	*/
  state maintenance {

    entry {
        printf("\n[SEQ ORCHESTRATION] Enter in MAINTENANCE status\n");
        dtlOperationalCode=606;
        pvPut(dtlOperationalCode);
    }

    /* ... */
    when ( ... ) {
      printf("[SEQ ORCHESTRATION] ... \n");
      printf("[SEQ ORCHESTRATION] Reset conditions satisfied.\n");


    } state initialization

  }


/* end statemachine */
}
