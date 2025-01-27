/*** Arithmetic ***/
`define log2(n)   ((n) <= (1<<0) ? 0 : (n) <= (1<<1) ? 1 :\
                   (n) <= (1<<2) ? 2 : (n) <= (1<<3) ? 3 :\
                   (n) <= (1<<4) ? 4 : (n) <= (1<<5) ? 5 :\
                   (n) <= (1<<6) ? 6 : (n) <= (1<<7) ? 7 :\
                   (n) <= (1<<8) ? 8 : (n) <= (1<<9) ? 9 :\
                   (n) <= (1<<10) ? 10 : (n) <= (1<<11) ? 11 :\
                   (n) <= (1<<12) ? 12 : (n) <= (1<<13) ? 13 :\
                   (n) <= (1<<14) ? 14 : (n) <= (1<<15) ? 15 :\
                   (n) <= (1<<16) ? 16 : (n) <= (1<<17) ? 17 :\
                   (n) <= (1<<18) ? 18 : (n) <= (1<<19) ? 19 :\
                   (n) <= (1<<20) ? 20 : (n) <= (1<<21) ? 21 :\
                   (n) <= (1<<22) ? 22 : (n) <= (1<<23) ? 23 :\
                   (n) <= (1<<24) ? 24 : (n) <= (1<<25) ? 25 :\
                   (n) <= (1<<26) ? 26 : (n) <= (1<<27) ? 27 :\
                   (n) <= (1<<28) ? 28 : (n) <= (1<<29) ? 29 :\
                   (n) <= (1<<30) ? 30 : (n) <= (1<<31) ? 31 : 32)

`ifndef DEFINE_V
`define DEFINE_V

/*** SET FOLLOWING SIM_PARAM ***/
/* QUBIT PLANE */
`define NUM_LQ      {}
`define NUM_PCHROW  {}
`define NUM_PCHCOL  {}
`define CODE_DIST   {}

/* GATE CYCLE */
`define SQGATE_CYCLE    `TIME_BW'd{}
`define TQGATE_CYCLE    `TIME_BW'd{}
`define MEAS_CYCLE      `TIME_BW'd{} 

/* ISA */
// BitWidth
`define INST_BW             {}
`define OPCODE_BW           {}
`define MEAS_FLAG_BW        {}
`define MREG_DST_BW         {}
`define LQ_ADDR_OFFSET_BW   {}
`define TARGET_BW           {}
// OPCODE
`define LQI_OPCODE              `OPCODE_BW'd{}
`define LQM_X_OPCODE            `OPCODE_BW'd{}
`define LQM_Z_OPCODE            `OPCODE_BW'd{}
`define RUN_ESM_OPCODE          `OPCODE_BW'd{}
`define INIT_INTMD_OPCODE       `OPCODE_BW'd{}
`define MEAS_INTMD_OPCODE       `OPCODE_BW'd{}
`define SPLIT_INFO_OPCODE       `OPCODE_BW'd{}
`define PREP_INFO_OPCODE        `OPCODE_BW'd{}
`define MERGE_INFO_OPCODE       `OPCODE_BW'd{}
`define PPM_INTERPRET_OPCODE    `OPCODE_BW'd{}
`define LQM_FB_OPCODE           `OPCODE_BW'd{}
`define LQM_Y_OPCODE            `OPCODE_BW'd{}
`define INVALID_OPCODE          {`OPCODE_BW{1'b1}}

/* MICROARCHITECTURE */
// QID
`define TO_PDUBUF_SZ    {}
`define TO_LMUBUF_SZ    {}
// PSU
`define NUM_PCU         {}
`define NUM_UCC         {}
`define NUM_QBCTRL      {}
`define TIME_BW         {}
// EDU
`define TIMEOUT_LIMIT   {}
`define AQMEAS_TH       {}
`define BD_DELAY        {}
// LMU
`define MOBUF_SZ        {}
/*** DEPENDENT PARAM ***/
// QubitPlane
`define NUM_PCH         (`NUM_PCHROW * `NUM_PCHCOL)
`define NUM_UCROW       (`CODE_DIST+1)/2
`define NUM_UCCOL       (`CODE_DIST+1)/2
`define NUM_UC          (`NUM_UCROW * `NUM_UCCOL)
`define NUM_PQ          (`NUM_PCH * `NUM_UC * `NUM_QB)
`define NUM_AQ          (`NUM_PQ/2)
`define NUM_AQROW       (`NUM_PCHROW * `NUM_UCROW * 2)
`define NUM_AQCOL       (`NUM_PCHCOL * `NUM_UCCOL * 2)
`define NUM_EDUROW      (`NUM_AQROW + `NUM_AQCOL - 1)
`define NUM_DQ          `NUM_AQ
`define NUM_DQROW       `NUM_AQROW
`define NUM_DQCOL       `NUM_AQCOL
`define DQADDR_BW       `log2(`NUM_DQ)
`define AQADDR_BW       `log2(`NUM_AQ)
`define AQROWADDR_BW    `log2(`NUM_AQROW)
`define TKROWADDR_BW    `log2(`NUM_AQROW+`NUM_AQCOL-1)
`define NUM_PCHQB       (`NUM_UC * `NUM_QB)
`define NUM_PCHDQ       `NUM_PCHQB/2
`define NUM_PCHAQ       `NUM_PCHQB/2
// BitWidth
`define LQADDR_BW       `log2(`NUM_LQ)
`define PCHADDR_BW      `log2(`NUM_PCH)
`define ROUND_BW        `log2(`CODE_DIST)
//`define TO_PDUBUF_BW    (`NUM_LQ * (`OPCODE_BW+`MREG_DST_BW + 2 + 1) + `OPCODE_BW)
`define TO_PDUBUF_BW    (`NUM_LQ * (`OPCODE_BW+`LQADDR_BW + 2 + 1) + `OPCODE_BW)
`define TO_LMUBUF_BW    (`MEAS_FLAG_BW + (`NUM_LQ*2) + `LQADDR_BW + 1)
`define CNT_BW          (`TIME_BW + `CWD_BW + `CWD_BW)
`define QBADDR_BW       `log2(`NUM_QB)
`define UCADDR_BW       `log2(`NUM_UC)
`define AQADDR_BW       `log2(`NUM_AQ)
`define INSTINFO_BW     (`TO_LMUBUF_BW-1)
// Microarchitecture
//// PSU
`define NUM_PCHDMX_OUT          ((`NUM_PCH/`NUM_PCU)+1)
`define NUM_PCUQB               (`NUM_UCC*`NUM_QBCTRL)
`define NUM_UCDMX_OUT           ((`NUM_UC/`NUM_UCC)+1)
`define NUM_UCCQB               `NUM_QBCTRL
`define NUM_QBDMX_OUT           ((`NUM_QB/`NUM_QBCTRL)+1)
`define NUM_MASK                (`NUM_PCU * `NUM_UCC * `NUM_QBCTRL)

/*** CONSTANT NUMBER ALIAS ***/
// Qubit Plane
`define NUM_QB 8

// Pauli operator (PP)
`define PP_I    2'b00
`define PP_X    2'b01
`define PP_Z    2'b10
`define PP_Y    2'b11

// PIU
//// Bitwidth
`define PCHTYPE_BW       4
`define BDLOC_BW         3
`define FACEBD_BW        3
`define CORNERBD_BW      3
`define PCHSTAT_BW      (`PCHTYPE_BW + 2*`BDLOC_BW)
`define PCHDYN_BW       (4*`FACEBD_BW + 4*`CORNERBD_BW)
`define PCHINFO_BW      (`PCHSTAT_BW + `PCHDYN_BW + `PCHADDR_BW + (2*`OPCODE_BW) + (2*`LQADDR_BW) + (2*2))
//// PCHTYPE
`define PCHTYPE_I       `PCHTYPE_BW'b0000
`define PCHTYPE_ZT      `PCHTYPE_BW'b0001
`define PCHTYPE_ZB      `PCHTYPE_BW'b0010
`define PCHTYPE_MT      `PCHTYPE_BW'b0011
`define PCHTYPE_MB      `PCHTYPE_BW'b0100
`define PCHTYPE_M       `PCHTYPE_BW'b0101
`define PCHTYPE_X       `PCHTYPE_BW'b0110
`define PCHTYPE_AW      `PCHTYPE_BW'b0111
`define PCHTYPE_AC      `PCHTYPE_BW'b1000
`define PCHTYPE_AE      `PCHTYPE_BW'b1001
`define PCHTYPE_AWE     `PCHTYPE_BW'b1010
//// BDLOC
`define BDLOC_I         `BDLOC_BW'b000
`define BDLOC_W         `BDLOC_BW'b001
`define BDLOC_N         `BDLOC_BW'b010
`define BDLOC_E         `BDLOC_BW'b011
`define BDLOC_S         `BDLOC_BW'b100
`define BDLOC_WE        `BDLOC_BW'b101
//// FACEBD
`define FACEBD_I        `FACEBD_BW'b000
`define FACEBD_X        `FACEBD_BW'b001
`define FACEBD_Z        `FACEBD_BW'b010
`define FACEBD_PP       `FACEBD_BW'b100
`define FACEBD_LP       `FACEBD_BW'b101
`define FACEBD_MP       `FACEBD_BW'b110
//// CORNERBD
`define CORNERBD_I      `CORNERBD_BW'b000
`define CORNERBD_Z      `CORNERBD_BW'b001
`define CORNERBD_Y      `CORNERBD_BW'b010
`define CORNERBD_YE     `CORNERBD_BW'b011
`define CORNERBD_IE     `CORNERBD_BW'b100
`define CORNERBD_ZE     `CORNERBD_BW'b101
`define CORNERBD_C      `CORNERBD_BW'b110

//// PCHIDXSRC
`define PCHIDXSRC_PCHLIST   2'b00
`define PCHIDXSRC_ESMON     2'b01
`define PCHIDXSRC_MERGED    2'b10
`define PCHIDXSRC_INVALID   2'b11

// PSU
//// Bitwidth
`define CWD_BW          4
`define IDLEN_BW        5
`define UCLOC_BW        8
//// CWD
`define CWD_I       `CWD_BW'b0000
`define CWD_X       `CWD_BW'b0001
`define CWD_Z       `CWD_BW'b0010
`define CWD_Y       `CWD_BW'b0011
`define CWD_T       `CWD_BW'b0100
`define CWD_MEAS    `CWD_BW'b0101
`define CWD_CX      `CWD_BW'b0110
`define CWD_H       `CWD_BW'b0111
`define CWD_SDH     `CWD_BW'b1000
`define CWD_HS      `CWD_BW'b1001
`define CWD_CZ0     `CWD_BW'b1010
`define CWD_CZ1     `CWD_BW'b1011
`define CWD_CZ2     `CWD_BW'b1100
`define CWD_CZ3     `CWD_BW'b1101
//// SELCNT
`define SELCNT_INIT     2'b00
`define SELCNT_MEAS     2'b01
`define SELCNT_RESM     2'b10
`define SELCNT_INVALID  2'b11
//// CNTLEN
`define CNTLEN_INIT     `IDLEN_BW'd3
`define CNTLEN_MEAS     `IDLEN_BW'd2
`define CNTLEN_RESM     `IDLEN_BW'd20

// EDU
//// ROLE
`define ROLE_INACTIVE   2'b00
`define ROLE_ACTIVE     2'b01
`define ROLE_BOUNDARY   2'b10
//// SELSPIKE
`define SELSPIKE_INVALID    2'b00
`define SELSPIKE_IN         2'b01
`define SELSPIKE_ESM        2'b10
`define SELSPIKE_BD         2'b11

// PFU
////  SELCWDERR
`define SELCWDERR_CWD   1'b0
`define SELCWDERR_ERR   1'b1

// LMU
//// Bitwidth
`define SELLOC_BW       4
`define SELMEAS_BW      (`SELLOC_BW + 3)
//// SELLOC
`define SELLOC_I        `SELLOC_BW'h0
`define SELLOC_E        `SELLOC_BW'h1
`define SELLOC_EXE      `SELLOC_BW'h2
`define SELLOC_W        `SELLOC_BW'h3
`define SELLOC_WINV     `SELLOC_BW'h4
`define SELLOC_WS       `SELLOC_BW'h5
`define SELLOC_S        `SELLOC_BW'h6
`define SELLOC_SINV     `SELLOC_BW'h7
`define SELLOC_NE       `SELLOC_BW'h8
`define SELLOC_ALL      `SELLOC_BW'h9
//// SELDQAQ
`define SELDQAQ_DQ      1'b0
`define SELDQAQ_AQ      1'b1
//// SELXZ
`define SELXZ_Z         1'b0
`define SELXZ_X         1'b1
//// ABCDADDR
`define ABCDADDR_A      2'b00
`define ABCDADDR_B      2'b01
`define ABCDADDR_C      2'b10
`define ABCDADDR_D      2'b11
//// MEASSIGN
`define MEASSIGN_PLUS   1'b0
`define MEASSIGN_MINUS  1'b1
//// FBXORZ
`define FBXORZ_Z        2'b00
`define FBXORZ_X        2'b01
`define FBXORZ_INVALID  2'b11

// State
//// PDU
`define PDU_EMPTY           2'b00
`define PDU_RUNNING         2'b01
`define PDU_OUTPUT_EMPTY    2'b10
`define PDU_OUTPUT_RUNNING  2'b11
//// PIU
`define PIU_READY           2'b00
`define PIU_READING         2'b01
`define PIU_WRITING         2'b10
`define PIU_RESETTING       2'b11
//// PSU
`define PSU_READY           1'b0
`define PSU_RUNNING         1'b1
//// EDU
`define EDU_READY           2'b00
`define EDU_TOKENALLOC      2'b01
`define EDU_ERRORPAIRING    2'b10
`define EDU_WAITING         2'b11
`define EDUCELL_INACTIVE    3'b000
`define EDUCELL_SYNK        3'b001
`define EDUCELL_SOURCE      3'b010
`define EDUCELL_BOUNDARY    3'b011
`define EDUCELL_TRANSMIT    3'b100
//// PFU
`define PFU_READY           2'b00
`define PFU_UPDATING        2'b01
`define PFU_WAITING         2'b10
//// LMU
`define LMU_READY           2'b00
`define LMU_PRODUCTING      2'b01
`define LMU_INTERPRETING    2'b10
`define LMU_BPUPDATING      2'b11

`endif
