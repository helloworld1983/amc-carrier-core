U_Core: entity work.AmcCarrierCore
  port map (
    timingClk => timingClk,
    timingRst => timingRst,
    \timingBus[strobe]\ => timingBus.strobe,
    \timingBus[valid]\ => timingBus.valid,
    \timingBus[message][version]\ => timingBus.message.version,
    \timingBus[message][pulseId]\ => timingBus.message.pulseId,
    \timingBus[message][timeStamp]\ => timingBus.message.timeStamp,
    \timingBus[message][fixedRates]\ => timingBus.message.fixedRates,
    \timingBus[message][acRates]\ => timingBus.message.acRates,
    \timingBus[message][acTimeSlot]\ => timingBus.message.acTimeSlot,
    \timingBus[message][acTimeSlotPhase]\ => timingBus.message.acTimeSlotPhase,
    \timingBus[message][resync]\ => timingBus.message.resync,
    \timingBus[message][beamRequest]\ => timingBus.message.beamRequest,
    \timingBus[message][beamEnergy][0]\ => timingBus.message.beamEnergy(0),
    \timingBus[message][beamEnergy][1]\ => timingBus.message.beamEnergy(1),
    \timingBus[message][beamEnergy][2]\ => timingBus.message.beamEnergy(2),
    \timingBus[message][beamEnergy][3]\ => timingBus.message.beamEnergy(3),
    \timingBus[message][syncStatus]\ => timingBus.message.syncStatus,
    \timingBus[message][calibrationGap]\ => timingBus.message.calibrationGap,
    \timingBus[message][bcsFault]\ => timingBus.message.bcsFault,
    \timingBus[message][mpsLimit]\ => timingBus.message.mpsLimit,
    \timingBus[message][mpsClass][0]\ => timingBus.message.mpsClass(0),
    \timingBus[message][mpsClass][1]\ => timingBus.message.mpsClass(1),
    \timingBus[message][mpsClass][2]\ => timingBus.message.mpsClass(2),
    \timingBus[message][mpsClass][3]\ => timingBus.message.mpsClass(3),
    \timingBus[message][mpsClass][4]\ => timingBus.message.mpsClass(4),
    \timingBus[message][mpsClass][5]\ => timingBus.message.mpsClass(5),
    \timingBus[message][mpsClass][6]\ => timingBus.message.mpsClass(6),
    \timingBus[message][mpsClass][7]\ => timingBus.message.mpsClass(7),
    \timingBus[message][mpsClass][8]\ => timingBus.message.mpsClass(8),
    \timingBus[message][mpsClass][9]\ => timingBus.message.mpsClass(9),
    \timingBus[message][mpsClass][10]\ => timingBus.message.mpsClass(10),
    \timingBus[message][mpsClass][11]\ => timingBus.message.mpsClass(11),
    \timingBus[message][mpsClass][12]\ => timingBus.message.mpsClass(12),
    \timingBus[message][mpsClass][13]\ => timingBus.message.mpsClass(13),
    \timingBus[message][mpsClass][14]\ => timingBus.message.mpsClass(14),
    \timingBus[message][mpsClass][15]\ => timingBus.message.mpsClass(15),
    \timingBus[message][bsaInit]\ => timingBus.message.bsaInit,
    \timingBus[message][bsaActive]\ => timingBus.message.bsaActive,
    \timingBus[message][bsaAvgDone]\ => timingBus.message.bsaAvgDone,
    \timingBus[message][bsaDone]\ => timingBus.message.bsaDone,
    \timingBus[message][control][0]\ => timingBus.message.control(0),
    \timingBus[message][control][1]\ => timingBus.message.control(1),
    \timingBus[message][control][2]\ => timingBus.message.control(2),
    \timingBus[message][control][3]\ => timingBus.message.control(3),
    \timingBus[message][control][4]\ => timingBus.message.control(4),
    \timingBus[message][control][5]\ => timingBus.message.control(5),
    \timingBus[message][control][6]\ => timingBus.message.control(6),
    \timingBus[message][control][7]\ => timingBus.message.control(7),
    \timingBus[message][control][8]\ => timingBus.message.control(8),
    \timingBus[message][control][9]\ => timingBus.message.control(9),
    \timingBus[message][control][10]\ => timingBus.message.control(10),
    \timingBus[message][control][11]\ => timingBus.message.control(11),
    \timingBus[message][control][12]\ => timingBus.message.control(12),
    \timingBus[message][control][13]\ => timingBus.message.control(13),
    \timingBus[message][control][14]\ => timingBus.message.control(14),
    \timingBus[message][control][15]\ => timingBus.message.control(15),
    \timingBus[message][control][16]\ => timingBus.message.control(16),
    \timingBus[message][control][17]\ => timingBus.message.control(17),
    \timingBus[stream][pulseId]\ => timingBus.stream.pulseId,
    \timingBus[stream][eventCodes]\ => timingBus.stream.eventCodes,
    \timingBus[stream][dbuff][dtype]\ => timingBus.stream.dbuff.dtype,
    \timingBus[stream][dbuff][version]\ => timingBus.stream.dbuff.version,
    \timingBus[stream][dbuff][dmod]\ => timingBus.stream.dbuff.dmod,
    \timingBus[stream][dbuff][epicsTime]\ => timingBus.stream.dbuff.epicsTime,
    \timingBus[stream][dbuff][edefAvgDn]\ => timingBus.stream.dbuff.edefAvgDn,
    \timingBus[stream][dbuff][edefMinor]\ => timingBus.stream.dbuff.edefMinor,
    \timingBus[stream][dbuff][edefMajor]\ => timingBus.stream.dbuff.edefMajor,
    \timingBus[stream][dbuff][edefInit]\ => timingBus.stream.dbuff.edefInit,
    \timingBus[v1][linkUp]\ => timingBus.v1.linkUp,
    \timingBus[v1][gtRxData]\ => timingBus.v1.gtRxData,
    \timingBus[v1][gtRxDataK]\ => timingBus.v1.gtRxDataK,
    \timingBus[v1][gtRxDispErr]\ => timingBus.v1.gtRxDispErr,
    \timingBus[v1][gtRxDecErr]\ => timingBus.v1.gtRxDecErr,
    \timingBus[v2][linkUp]\ => timingBus.v2.linkUp,
    \timingPhy[dataK]\ => timingPhy.dataK,
    \timingPhy[data]\ => timingPhy.data,
    \timingPhy[control][reset]\ => timingPhy.control.reset,
    \timingPhy[control][inhibit]\ => timingPhy.control.inhibit,
    \timingPhy[control][polarity]\ => timingPhy.control.polarity,
    \timingPhy[control][bufferByRst]\ => timingPhy.control.bufferByRst,
    \timingPhy[control][pllReset]\ => timingPhy.control.pllReset,
    timingPhyClk => timingPhyClk,
    timingPhyRst => timingPhyRst,
    diagnosticClk => diagnosticClk,
    diagnosticRst => diagnosticRst,
    \diagnosticBus[strobe]\ => diagnosticBus.strobe,
    \diagnosticBus[data][31]\ => diagnosticBus.data(31),
    \diagnosticBus[data][30]\ => diagnosticBus.data(30),
    \diagnosticBus[data][29]\ => diagnosticBus.data(29),
    \diagnosticBus[data][28]\ => diagnosticBus.data(28),
    \diagnosticBus[data][27]\ => diagnosticBus.data(27),
    \diagnosticBus[data][26]\ => diagnosticBus.data(26),
    \diagnosticBus[data][25]\ => diagnosticBus.data(25),
    \diagnosticBus[data][24]\ => diagnosticBus.data(24),
    \diagnosticBus[data][23]\ => diagnosticBus.data(23),
    \diagnosticBus[data][22]\ => diagnosticBus.data(22),
    \diagnosticBus[data][21]\ => diagnosticBus.data(21),
    \diagnosticBus[data][20]\ => diagnosticBus.data(20),
    \diagnosticBus[data][19]\ => diagnosticBus.data(19),
    \diagnosticBus[data][18]\ => diagnosticBus.data(18),
    \diagnosticBus[data][17]\ => diagnosticBus.data(17),
    \diagnosticBus[data][16]\ => diagnosticBus.data(16),
    \diagnosticBus[data][15]\ => diagnosticBus.data(15),
    \diagnosticBus[data][14]\ => diagnosticBus.data(14),
    \diagnosticBus[data][13]\ => diagnosticBus.data(13),
    \diagnosticBus[data][12]\ => diagnosticBus.data(12),
    \diagnosticBus[data][11]\ => diagnosticBus.data(11),
    \diagnosticBus[data][10]\ => diagnosticBus.data(10),
    \diagnosticBus[data][9]\ => diagnosticBus.data(9),
    \diagnosticBus[data][8]\ => diagnosticBus.data(8),
    \diagnosticBus[data][7]\ => diagnosticBus.data(7),
    \diagnosticBus[data][6]\ => diagnosticBus.data(6),
    \diagnosticBus[data][5]\ => diagnosticBus.data(5),
    \diagnosticBus[data][4]\ => diagnosticBus.data(4),
    \diagnosticBus[data][3]\ => diagnosticBus.data(3),
    \diagnosticBus[data][2]\ => diagnosticBus.data(2),
    \diagnosticBus[data][1]\ => diagnosticBus.data(1),
    \diagnosticBus[data][0]\ => diagnosticBus.data(0),
    \diagnosticBus[timingMessage][version]\ => diagnosticBus.timingMessage.version,
    \diagnosticBus[timingMessage][pulseId]\ => diagnosticBus.timingMessage.pulseId,
    \diagnosticBus[timingMessage][timeStamp]\ => diagnosticBus.timingMessage.timeStamp,
    \diagnosticBus[timingMessage][fixedRates]\ => diagnosticBus.timingMessage.fixedRates,
    \diagnosticBus[timingMessage][acRates]\ => diagnosticBus.timingMessage.acRates,
    \diagnosticBus[timingMessage][acTimeSlot]\ => diagnosticBus.timingMessage.acTimeSlot,
    \diagnosticBus[timingMessage][acTimeSlotPhase]\ => diagnosticBus.timingMessage.acTimeSlotPhase,
    \diagnosticBus[timingMessage][resync]\ => diagnosticBus.timingMessage.resync,
    \diagnosticBus[timingMessage][beamRequest]\ => diagnosticBus.timingMessage.beamRequest,
    \diagnosticBus[timingMessage][beamEnergy][0]\ => diagnosticBus.timingMessage.beamEnergy(0),
    \diagnosticBus[timingMessage][beamEnergy][1]\ => diagnosticBus.timingMessage.beamEnergy(1),
    \diagnosticBus[timingMessage][beamEnergy][2]\ => diagnosticBus.timingMessage.beamEnergy(2),
    \diagnosticBus[timingMessage][beamEnergy][3]\ => diagnosticBus.timingMessage.beamEnergy(3),
    \diagnosticBus[timingMessage][syncStatus]\ => diagnosticBus.timingMessage.syncStatus,
    \diagnosticBus[timingMessage][calibrationGap]\ => diagnosticBus.timingMessage.calibrationGap,
    \diagnosticBus[timingMessage][bcsFault]\ => diagnosticBus.timingMessage.bcsFault,
    \diagnosticBus[timingMessage][mpsLimit]\ => diagnosticBus.timingMessage.mpsLimit,
    \diagnosticBus[timingMessage][mpsClass][0]\ => diagnosticBus.timingMessage.mpsClass(0),
    \diagnosticBus[timingMessage][mpsClass][1]\ => diagnosticBus.timingMessage.mpsClass(1),
    \diagnosticBus[timingMessage][mpsClass][2]\ => diagnosticBus.timingMessage.mpsClass(2),
    \diagnosticBus[timingMessage][mpsClass][3]\ => diagnosticBus.timingMessage.mpsClass(3),
    \diagnosticBus[timingMessage][mpsClass][4]\ => diagnosticBus.timingMessage.mpsClass(4),
    \diagnosticBus[timingMessage][mpsClass][5]\ => diagnosticBus.timingMessage.mpsClass(5),
    \diagnosticBus[timingMessage][mpsClass][6]\ => diagnosticBus.timingMessage.mpsClass(6),
    \diagnosticBus[timingMessage][mpsClass][7]\ => diagnosticBus.timingMessage.mpsClass(7),
    \diagnosticBus[timingMessage][mpsClass][8]\ => diagnosticBus.timingMessage.mpsClass(8),
    \diagnosticBus[timingMessage][mpsClass][9]\ => diagnosticBus.timingMessage.mpsClass(9),
    \diagnosticBus[timingMessage][mpsClass][10]\ => diagnosticBus.timingMessage.mpsClass(10),
    \diagnosticBus[timingMessage][mpsClass][11]\ => diagnosticBus.timingMessage.mpsClass(11),
    \diagnosticBus[timingMessage][mpsClass][12]\ => diagnosticBus.timingMessage.mpsClass(12),
    \diagnosticBus[timingMessage][mpsClass][13]\ => diagnosticBus.timingMessage.mpsClass(13),
    \diagnosticBus[timingMessage][mpsClass][14]\ => diagnosticBus.timingMessage.mpsClass(14),
    \diagnosticBus[timingMessage][mpsClass][15]\ => diagnosticBus.timingMessage.mpsClass(15),
    \diagnosticBus[timingMessage][bsaInit]\ => diagnosticBus.timingMessage.bsaInit,
    \diagnosticBus[timingMessage][bsaActive]\ => diagnosticBus.timingMessage.bsaActive,
    \diagnosticBus[timingMessage][bsaAvgDone]\ => diagnosticBus.timingMessage.bsaAvgDone,
    \diagnosticBus[timingMessage][bsaDone]\ => diagnosticBus.timingMessage.bsaDone,
    \diagnosticBus[timingMessage][control][0]\ => diagnosticBus.timingMessage.control(0),
    \diagnosticBus[timingMessage][control][1]\ => diagnosticBus.timingMessage.control(1),
    \diagnosticBus[timingMessage][control][2]\ => diagnosticBus.timingMessage.control(2),
    \diagnosticBus[timingMessage][control][3]\ => diagnosticBus.timingMessage.control(3),
    \diagnosticBus[timingMessage][control][4]\ => diagnosticBus.timingMessage.control(4),
    \diagnosticBus[timingMessage][control][5]\ => diagnosticBus.timingMessage.control(5),
    \diagnosticBus[timingMessage][control][6]\ => diagnosticBus.timingMessage.control(6),
    \diagnosticBus[timingMessage][control][7]\ => diagnosticBus.timingMessage.control(7),
    \diagnosticBus[timingMessage][control][8]\ => diagnosticBus.timingMessage.control(8),
    \diagnosticBus[timingMessage][control][9]\ => diagnosticBus.timingMessage.control(9),
    \diagnosticBus[timingMessage][control][10]\ => diagnosticBus.timingMessage.control(10),
    \diagnosticBus[timingMessage][control][11]\ => diagnosticBus.timingMessage.control(11),
    \diagnosticBus[timingMessage][control][12]\ => diagnosticBus.timingMessage.control(12),
    \diagnosticBus[timingMessage][control][13]\ => diagnosticBus.timingMessage.control(13),
    \diagnosticBus[timingMessage][control][14]\ => diagnosticBus.timingMessage.control(14),
    \diagnosticBus[timingMessage][control][15]\ => diagnosticBus.timingMessage.control(15),
    \diagnosticBus[timingMessage][control][16]\ => diagnosticBus.timingMessage.control(16),
    \diagnosticBus[timingMessage][control][17]\ => diagnosticBus.timingMessage.control(17),
    waveformClk => waveformClk,
    waveformRst => waveformRst,
    \obAppWaveformMasters[1][3][tValid]\ => obAppWaveformMasters(1)(3).tValid,
    \obAppWaveformMasters[1][3][tData]\ => obAppWaveformMasters(1)(3).tData,
    \obAppWaveformMasters[1][3][tStrb]\ => obAppWaveformMasters(1)(3).tStrb,
    \obAppWaveformMasters[1][3][tKeep]\ => obAppWaveformMasters(1)(3).tKeep,
    \obAppWaveformMasters[1][3][tLast]\ => obAppWaveformMasters(1)(3).tLast,
    \obAppWaveformMasters[1][3][tDest]\ => obAppWaveformMasters(1)(3).tDest,
    \obAppWaveformMasters[1][3][tId]\ => obAppWaveformMasters(1)(3).tId,
    \obAppWaveformMasters[1][3][tUser]\ => obAppWaveformMasters(1)(3).tUser,
    \obAppWaveformMasters[1][2][tValid]\ => obAppWaveformMasters(1)(2).tValid,
    \obAppWaveformMasters[1][2][tData]\ => obAppWaveformMasters(1)(2).tData,
    \obAppWaveformMasters[1][2][tStrb]\ => obAppWaveformMasters(1)(2).tStrb,
    \obAppWaveformMasters[1][2][tKeep]\ => obAppWaveformMasters(1)(2).tKeep,
    \obAppWaveformMasters[1][2][tLast]\ => obAppWaveformMasters(1)(2).tLast,
    \obAppWaveformMasters[1][2][tDest]\ => obAppWaveformMasters(1)(2).tDest,
    \obAppWaveformMasters[1][2][tId]\ => obAppWaveformMasters(1)(2).tId,
    \obAppWaveformMasters[1][2][tUser]\ => obAppWaveformMasters(1)(2).tUser,
    \obAppWaveformMasters[1][1][tValid]\ => obAppWaveformMasters(1)(1).tValid,
    \obAppWaveformMasters[1][1][tData]\ => obAppWaveformMasters(1)(1).tData,
    \obAppWaveformMasters[1][1][tStrb]\ => obAppWaveformMasters(1)(1).tStrb,
    \obAppWaveformMasters[1][1][tKeep]\ => obAppWaveformMasters(1)(1).tKeep,
    \obAppWaveformMasters[1][1][tLast]\ => obAppWaveformMasters(1)(1).tLast,
    \obAppWaveformMasters[1][1][tDest]\ => obAppWaveformMasters(1)(1).tDest,
    \obAppWaveformMasters[1][1][tId]\ => obAppWaveformMasters(1)(1).tId,
    \obAppWaveformMasters[1][1][tUser]\ => obAppWaveformMasters(1)(1).tUser,
    \obAppWaveformMasters[1][0][tValid]\ => obAppWaveformMasters(1)(0).tValid,
    \obAppWaveformMasters[1][0][tData]\ => obAppWaveformMasters(1)(0).tData,
    \obAppWaveformMasters[1][0][tStrb]\ => obAppWaveformMasters(1)(0).tStrb,
    \obAppWaveformMasters[1][0][tKeep]\ => obAppWaveformMasters(1)(0).tKeep,
    \obAppWaveformMasters[1][0][tLast]\ => obAppWaveformMasters(1)(0).tLast,
    \obAppWaveformMasters[1][0][tDest]\ => obAppWaveformMasters(1)(0).tDest,
    \obAppWaveformMasters[1][0][tId]\ => obAppWaveformMasters(1)(0).tId,
    \obAppWaveformMasters[1][0][tUser]\ => obAppWaveformMasters(1)(0).tUser,
    \obAppWaveformMasters[0][3][tValid]\ => obAppWaveformMasters(0)(3).tValid,
    \obAppWaveformMasters[0][3][tData]\ => obAppWaveformMasters(0)(3).tData,
    \obAppWaveformMasters[0][3][tStrb]\ => obAppWaveformMasters(0)(3).tStrb,
    \obAppWaveformMasters[0][3][tKeep]\ => obAppWaveformMasters(0)(3).tKeep,
    \obAppWaveformMasters[0][3][tLast]\ => obAppWaveformMasters(0)(3).tLast,
    \obAppWaveformMasters[0][3][tDest]\ => obAppWaveformMasters(0)(3).tDest,
    \obAppWaveformMasters[0][3][tId]\ => obAppWaveformMasters(0)(3).tId,
    \obAppWaveformMasters[0][3][tUser]\ => obAppWaveformMasters(0)(3).tUser,
    \obAppWaveformMasters[0][2][tValid]\ => obAppWaveformMasters(0)(2).tValid,
    \obAppWaveformMasters[0][2][tData]\ => obAppWaveformMasters(0)(2).tData,
    \obAppWaveformMasters[0][2][tStrb]\ => obAppWaveformMasters(0)(2).tStrb,
    \obAppWaveformMasters[0][2][tKeep]\ => obAppWaveformMasters(0)(2).tKeep,
    \obAppWaveformMasters[0][2][tLast]\ => obAppWaveformMasters(0)(2).tLast,
    \obAppWaveformMasters[0][2][tDest]\ => obAppWaveformMasters(0)(2).tDest,
    \obAppWaveformMasters[0][2][tId]\ => obAppWaveformMasters(0)(2).tId,
    \obAppWaveformMasters[0][2][tUser]\ => obAppWaveformMasters(0)(2).tUser,
    \obAppWaveformMasters[0][1][tValid]\ => obAppWaveformMasters(0)(1).tValid,
    \obAppWaveformMasters[0][1][tData]\ => obAppWaveformMasters(0)(1).tData,
    \obAppWaveformMasters[0][1][tStrb]\ => obAppWaveformMasters(0)(1).tStrb,
    \obAppWaveformMasters[0][1][tKeep]\ => obAppWaveformMasters(0)(1).tKeep,
    \obAppWaveformMasters[0][1][tLast]\ => obAppWaveformMasters(0)(1).tLast,
    \obAppWaveformMasters[0][1][tDest]\ => obAppWaveformMasters(0)(1).tDest,
    \obAppWaveformMasters[0][1][tId]\ => obAppWaveformMasters(0)(1).tId,
    \obAppWaveformMasters[0][1][tUser]\ => obAppWaveformMasters(0)(1).tUser,
    \obAppWaveformMasters[0][0][tValid]\ => obAppWaveformMasters(0)(0).tValid,
    \obAppWaveformMasters[0][0][tData]\ => obAppWaveformMasters(0)(0).tData,
    \obAppWaveformMasters[0][0][tStrb]\ => obAppWaveformMasters(0)(0).tStrb,
    \obAppWaveformMasters[0][0][tKeep]\ => obAppWaveformMasters(0)(0).tKeep,
    \obAppWaveformMasters[0][0][tLast]\ => obAppWaveformMasters(0)(0).tLast,
    \obAppWaveformMasters[0][0][tDest]\ => obAppWaveformMasters(0)(0).tDest,
    \obAppWaveformMasters[0][0][tId]\ => obAppWaveformMasters(0)(0).tId,
    \obAppWaveformMasters[0][0][tUser]\ => obAppWaveformMasters(0)(0).tUser,
    \obAppWaveformSlaves[1][3][slave][tReady]\ => obAppWaveformSlaves(1)(3).slave.tReady,
    \obAppWaveformSlaves[1][3][ctrl][pause]\ => obAppWaveformSlaves(1)(3).ctrl.pause,
    \obAppWaveformSlaves[1][3][ctrl][overflow]\ => obAppWaveformSlaves(1)(3).ctrl.overflow,
    \obAppWaveformSlaves[1][3][ctrl][idle]\ => obAppWaveformSlaves(1)(3).ctrl.idle,
    \obAppWaveformSlaves[1][2][slave][tReady]\ => obAppWaveformSlaves(1)(2).slave.tReady,
    \obAppWaveformSlaves[1][2][ctrl][pause]\ => obAppWaveformSlaves(1)(2).ctrl.pause,
    \obAppWaveformSlaves[1][2][ctrl][overflow]\ => obAppWaveformSlaves(1)(2).ctrl.overflow,
    \obAppWaveformSlaves[1][2][ctrl][idle]\ => obAppWaveformSlaves(1)(2).ctrl.idle,
    \obAppWaveformSlaves[1][1][slave][tReady]\ => obAppWaveformSlaves(1)(1).slave.tReady,
    \obAppWaveformSlaves[1][1][ctrl][pause]\ => obAppWaveformSlaves(1)(1).ctrl.pause,
    \obAppWaveformSlaves[1][1][ctrl][overflow]\ => obAppWaveformSlaves(1)(1).ctrl.overflow,
    \obAppWaveformSlaves[1][1][ctrl][idle]\ => obAppWaveformSlaves(1)(1).ctrl.idle,
    \obAppWaveformSlaves[1][0][slave][tReady]\ => obAppWaveformSlaves(1)(0).slave.tReady,
    \obAppWaveformSlaves[1][0][ctrl][pause]\ => obAppWaveformSlaves(1)(0).ctrl.pause,
    \obAppWaveformSlaves[1][0][ctrl][overflow]\ => obAppWaveformSlaves(1)(0).ctrl.overflow,
    \obAppWaveformSlaves[1][0][ctrl][idle]\ => obAppWaveformSlaves(1)(0).ctrl.idle,
    \obAppWaveformSlaves[0][3][slave][tReady]\ => obAppWaveformSlaves(0)(3).slave.tReady,
    \obAppWaveformSlaves[0][3][ctrl][pause]\ => obAppWaveformSlaves(0)(3).ctrl.pause,
    \obAppWaveformSlaves[0][3][ctrl][overflow]\ => obAppWaveformSlaves(0)(3).ctrl.overflow,
    \obAppWaveformSlaves[0][3][ctrl][idle]\ => obAppWaveformSlaves(0)(3).ctrl.idle,
    \obAppWaveformSlaves[0][2][slave][tReady]\ => obAppWaveformSlaves(0)(2).slave.tReady,
    \obAppWaveformSlaves[0][2][ctrl][pause]\ => obAppWaveformSlaves(0)(2).ctrl.pause,
    \obAppWaveformSlaves[0][2][ctrl][overflow]\ => obAppWaveformSlaves(0)(2).ctrl.overflow,
    \obAppWaveformSlaves[0][2][ctrl][idle]\ => obAppWaveformSlaves(0)(2).ctrl.idle,
    \obAppWaveformSlaves[0][1][slave][tReady]\ => obAppWaveformSlaves(0)(1).slave.tReady,
    \obAppWaveformSlaves[0][1][ctrl][pause]\ => obAppWaveformSlaves(0)(1).ctrl.pause,
    \obAppWaveformSlaves[0][1][ctrl][overflow]\ => obAppWaveformSlaves(0)(1).ctrl.overflow,
    \obAppWaveformSlaves[0][1][ctrl][idle]\ => obAppWaveformSlaves(0)(1).ctrl.idle,
    \obAppWaveformSlaves[0][0][slave][tReady]\ => obAppWaveformSlaves(0)(0).slave.tReady,
    \obAppWaveformSlaves[0][0][ctrl][pause]\ => obAppWaveformSlaves(0)(0).ctrl.pause,
    \obAppWaveformSlaves[0][0][ctrl][overflow]\ => obAppWaveformSlaves(0)(0).ctrl.overflow,
    \obAppWaveformSlaves[0][0][ctrl][idle]\ => obAppWaveformSlaves(0)(0).ctrl.idle,
    \ibAppWaveformMasters[1][3][tValid]\ => ibAppWaveformMasters(1)(3).tValid,
    \ibAppWaveformMasters[1][3][tData]\ => ibAppWaveformMasters(1)(3).tData,
    \ibAppWaveformMasters[1][3][tStrb]\ => ibAppWaveformMasters(1)(3).tStrb,
    \ibAppWaveformMasters[1][3][tKeep]\ => ibAppWaveformMasters(1)(3).tKeep,
    \ibAppWaveformMasters[1][3][tLast]\ => ibAppWaveformMasters(1)(3).tLast,
    \ibAppWaveformMasters[1][3][tDest]\ => ibAppWaveformMasters(1)(3).tDest,
    \ibAppWaveformMasters[1][3][tId]\ => ibAppWaveformMasters(1)(3).tId,
    \ibAppWaveformMasters[1][3][tUser]\ => ibAppWaveformMasters(1)(3).tUser,
    \ibAppWaveformMasters[1][2][tValid]\ => ibAppWaveformMasters(1)(2).tValid,
    \ibAppWaveformMasters[1][2][tData]\ => ibAppWaveformMasters(1)(2).tData,
    \ibAppWaveformMasters[1][2][tStrb]\ => ibAppWaveformMasters(1)(2).tStrb,
    \ibAppWaveformMasters[1][2][tKeep]\ => ibAppWaveformMasters(1)(2).tKeep,
    \ibAppWaveformMasters[1][2][tLast]\ => ibAppWaveformMasters(1)(2).tLast,
    \ibAppWaveformMasters[1][2][tDest]\ => ibAppWaveformMasters(1)(2).tDest,
    \ibAppWaveformMasters[1][2][tId]\ => ibAppWaveformMasters(1)(2).tId,
    \ibAppWaveformMasters[1][2][tUser]\ => ibAppWaveformMasters(1)(2).tUser,
    \ibAppWaveformMasters[1][1][tValid]\ => ibAppWaveformMasters(1)(1).tValid,
    \ibAppWaveformMasters[1][1][tData]\ => ibAppWaveformMasters(1)(1).tData,
    \ibAppWaveformMasters[1][1][tStrb]\ => ibAppWaveformMasters(1)(1).tStrb,
    \ibAppWaveformMasters[1][1][tKeep]\ => ibAppWaveformMasters(1)(1).tKeep,
    \ibAppWaveformMasters[1][1][tLast]\ => ibAppWaveformMasters(1)(1).tLast,
    \ibAppWaveformMasters[1][1][tDest]\ => ibAppWaveformMasters(1)(1).tDest,
    \ibAppWaveformMasters[1][1][tId]\ => ibAppWaveformMasters(1)(1).tId,
    \ibAppWaveformMasters[1][1][tUser]\ => ibAppWaveformMasters(1)(1).tUser,
    \ibAppWaveformMasters[1][0][tValid]\ => ibAppWaveformMasters(1)(0).tValid,
    \ibAppWaveformMasters[1][0][tData]\ => ibAppWaveformMasters(1)(0).tData,
    \ibAppWaveformMasters[1][0][tStrb]\ => ibAppWaveformMasters(1)(0).tStrb,
    \ibAppWaveformMasters[1][0][tKeep]\ => ibAppWaveformMasters(1)(0).tKeep,
    \ibAppWaveformMasters[1][0][tLast]\ => ibAppWaveformMasters(1)(0).tLast,
    \ibAppWaveformMasters[1][0][tDest]\ => ibAppWaveformMasters(1)(0).tDest,
    \ibAppWaveformMasters[1][0][tId]\ => ibAppWaveformMasters(1)(0).tId,
    \ibAppWaveformMasters[1][0][tUser]\ => ibAppWaveformMasters(1)(0).tUser,
    \ibAppWaveformMasters[0][3][tValid]\ => ibAppWaveformMasters(0)(3).tValid,
    \ibAppWaveformMasters[0][3][tData]\ => ibAppWaveformMasters(0)(3).tData,
    \ibAppWaveformMasters[0][3][tStrb]\ => ibAppWaveformMasters(0)(3).tStrb,
    \ibAppWaveformMasters[0][3][tKeep]\ => ibAppWaveformMasters(0)(3).tKeep,
    \ibAppWaveformMasters[0][3][tLast]\ => ibAppWaveformMasters(0)(3).tLast,
    \ibAppWaveformMasters[0][3][tDest]\ => ibAppWaveformMasters(0)(3).tDest,
    \ibAppWaveformMasters[0][3][tId]\ => ibAppWaveformMasters(0)(3).tId,
    \ibAppWaveformMasters[0][3][tUser]\ => ibAppWaveformMasters(0)(3).tUser,
    \ibAppWaveformMasters[0][2][tValid]\ => ibAppWaveformMasters(0)(2).tValid,
    \ibAppWaveformMasters[0][2][tData]\ => ibAppWaveformMasters(0)(2).tData,
    \ibAppWaveformMasters[0][2][tStrb]\ => ibAppWaveformMasters(0)(2).tStrb,
    \ibAppWaveformMasters[0][2][tKeep]\ => ibAppWaveformMasters(0)(2).tKeep,
    \ibAppWaveformMasters[0][2][tLast]\ => ibAppWaveformMasters(0)(2).tLast,
    \ibAppWaveformMasters[0][2][tDest]\ => ibAppWaveformMasters(0)(2).tDest,
    \ibAppWaveformMasters[0][2][tId]\ => ibAppWaveformMasters(0)(2).tId,
    \ibAppWaveformMasters[0][2][tUser]\ => ibAppWaveformMasters(0)(2).tUser,
    \ibAppWaveformMasters[0][1][tValid]\ => ibAppWaveformMasters(0)(1).tValid,
    \ibAppWaveformMasters[0][1][tData]\ => ibAppWaveformMasters(0)(1).tData,
    \ibAppWaveformMasters[0][1][tStrb]\ => ibAppWaveformMasters(0)(1).tStrb,
    \ibAppWaveformMasters[0][1][tKeep]\ => ibAppWaveformMasters(0)(1).tKeep,
    \ibAppWaveformMasters[0][1][tLast]\ => ibAppWaveformMasters(0)(1).tLast,
    \ibAppWaveformMasters[0][1][tDest]\ => ibAppWaveformMasters(0)(1).tDest,
    \ibAppWaveformMasters[0][1][tId]\ => ibAppWaveformMasters(0)(1).tId,
    \ibAppWaveformMasters[0][1][tUser]\ => ibAppWaveformMasters(0)(1).tUser,
    \ibAppWaveformMasters[0][0][tValid]\ => ibAppWaveformMasters(0)(0).tValid,
    \ibAppWaveformMasters[0][0][tData]\ => ibAppWaveformMasters(0)(0).tData,
    \ibAppWaveformMasters[0][0][tStrb]\ => ibAppWaveformMasters(0)(0).tStrb,
    \ibAppWaveformMasters[0][0][tKeep]\ => ibAppWaveformMasters(0)(0).tKeep,
    \ibAppWaveformMasters[0][0][tLast]\ => ibAppWaveformMasters(0)(0).tLast,
    \ibAppWaveformMasters[0][0][tDest]\ => ibAppWaveformMasters(0)(0).tDest,
    \ibAppWaveformMasters[0][0][tId]\ => ibAppWaveformMasters(0)(0).tId,
    \ibAppWaveformMasters[0][0][tUser]\ => ibAppWaveformMasters(0)(0).tUser,
    \ibAppWaveformSlaves[1][3][slave][tReady]\ => ibAppWaveformSlaves(1)(3).slave.tReady,
    \ibAppWaveformSlaves[1][3][ctrl][pause]\ => ibAppWaveformSlaves(1)(3).ctrl.pause,
    \ibAppWaveformSlaves[1][3][ctrl][overflow]\ => ibAppWaveformSlaves(1)(3).ctrl.overflow,
    \ibAppWaveformSlaves[1][3][ctrl][idle]\ => ibAppWaveformSlaves(1)(3).ctrl.idle,
    \ibAppWaveformSlaves[1][2][slave][tReady]\ => ibAppWaveformSlaves(1)(2).slave.tReady,
    \ibAppWaveformSlaves[1][2][ctrl][pause]\ => ibAppWaveformSlaves(1)(2).ctrl.pause,
    \ibAppWaveformSlaves[1][2][ctrl][overflow]\ => ibAppWaveformSlaves(1)(2).ctrl.overflow,
    \ibAppWaveformSlaves[1][2][ctrl][idle]\ => ibAppWaveformSlaves(1)(2).ctrl.idle,
    \ibAppWaveformSlaves[1][1][slave][tReady]\ => ibAppWaveformSlaves(1)(1).slave.tReady,
    \ibAppWaveformSlaves[1][1][ctrl][pause]\ => ibAppWaveformSlaves(1)(1).ctrl.pause,
    \ibAppWaveformSlaves[1][1][ctrl][overflow]\ => ibAppWaveformSlaves(1)(1).ctrl.overflow,
    \ibAppWaveformSlaves[1][1][ctrl][idle]\ => ibAppWaveformSlaves(1)(1).ctrl.idle,
    \ibAppWaveformSlaves[1][0][slave][tReady]\ => ibAppWaveformSlaves(1)(0).slave.tReady,
    \ibAppWaveformSlaves[1][0][ctrl][pause]\ => ibAppWaveformSlaves(1)(0).ctrl.pause,
    \ibAppWaveformSlaves[1][0][ctrl][overflow]\ => ibAppWaveformSlaves(1)(0).ctrl.overflow,
    \ibAppWaveformSlaves[1][0][ctrl][idle]\ => ibAppWaveformSlaves(1)(0).ctrl.idle,
    \ibAppWaveformSlaves[0][3][slave][tReady]\ => ibAppWaveformSlaves(0)(3).slave.tReady,
    \ibAppWaveformSlaves[0][3][ctrl][pause]\ => ibAppWaveformSlaves(0)(3).ctrl.pause,
    \ibAppWaveformSlaves[0][3][ctrl][overflow]\ => ibAppWaveformSlaves(0)(3).ctrl.overflow,
    \ibAppWaveformSlaves[0][3][ctrl][idle]\ => ibAppWaveformSlaves(0)(3).ctrl.idle,
    \ibAppWaveformSlaves[0][2][slave][tReady]\ => ibAppWaveformSlaves(0)(2).slave.tReady,
    \ibAppWaveformSlaves[0][2][ctrl][pause]\ => ibAppWaveformSlaves(0)(2).ctrl.pause,
    \ibAppWaveformSlaves[0][2][ctrl][overflow]\ => ibAppWaveformSlaves(0)(2).ctrl.overflow,
    \ibAppWaveformSlaves[0][2][ctrl][idle]\ => ibAppWaveformSlaves(0)(2).ctrl.idle,
    \ibAppWaveformSlaves[0][1][slave][tReady]\ => ibAppWaveformSlaves(0)(1).slave.tReady,
    \ibAppWaveformSlaves[0][1][ctrl][pause]\ => ibAppWaveformSlaves(0)(1).ctrl.pause,
    \ibAppWaveformSlaves[0][1][ctrl][overflow]\ => ibAppWaveformSlaves(0)(1).ctrl.overflow,
    \ibAppWaveformSlaves[0][1][ctrl][idle]\ => ibAppWaveformSlaves(0)(1).ctrl.idle,
    \ibAppWaveformSlaves[0][0][slave][tReady]\ => ibAppWaveformSlaves(0)(0).slave.tReady,
    \ibAppWaveformSlaves[0][0][ctrl][pause]\ => ibAppWaveformSlaves(0)(0).ctrl.pause,
    \ibAppWaveformSlaves[0][0][ctrl][overflow]\ => ibAppWaveformSlaves(0)(0).ctrl.overflow,
    \ibAppWaveformSlaves[0][0][ctrl][idle]\ => ibAppWaveformSlaves(0)(0).ctrl.idle,
    \obBpMsgClientMaster[tValid]\ => obBpMsgClientMaster.tValid,
    \obBpMsgClientMaster[tData]\ => obBpMsgClientMaster.tData,
    \obBpMsgClientMaster[tStrb]\ => obBpMsgClientMaster.tStrb,
    \obBpMsgClientMaster[tKeep]\ => obBpMsgClientMaster.tKeep,
    \obBpMsgClientMaster[tLast]\ => obBpMsgClientMaster.tLast,
    \obBpMsgClientMaster[tDest]\ => obBpMsgClientMaster.tDest,
    \obBpMsgClientMaster[tId]\ => obBpMsgClientMaster.tId,
    \obBpMsgClientMaster[tUser]\ => obBpMsgClientMaster.tUser,
    \obBpMsgClientSlave[tReady]\ => obBpMsgClientSlave.tReady,
    \ibBpMsgClientMaster[tValid]\ => ibBpMsgClientMaster.tValid,
    \ibBpMsgClientMaster[tData]\ => ibBpMsgClientMaster.tData,
    \ibBpMsgClientMaster[tStrb]\ => ibBpMsgClientMaster.tStrb,
    \ibBpMsgClientMaster[tKeep]\ => ibBpMsgClientMaster.tKeep,
    \ibBpMsgClientMaster[tLast]\ => ibBpMsgClientMaster.tLast,
    \ibBpMsgClientMaster[tDest]\ => ibBpMsgClientMaster.tDest,
    \ibBpMsgClientMaster[tId]\ => ibBpMsgClientMaster.tId,
    \ibBpMsgClientMaster[tUser]\ => ibBpMsgClientMaster.tUser,
    \ibBpMsgClientSlave[tReady]\ => ibBpMsgClientSlave.tReady,
    \obBpMsgServerMaster[tValid]\ => obBpMsgServerMaster.tValid,
    \obBpMsgServerMaster[tData]\ => obBpMsgServerMaster.tData,
    \obBpMsgServerMaster[tStrb]\ => obBpMsgServerMaster.tStrb,
    \obBpMsgServerMaster[tKeep]\ => obBpMsgServerMaster.tKeep,
    \obBpMsgServerMaster[tLast]\ => obBpMsgServerMaster.tLast,
    \obBpMsgServerMaster[tDest]\ => obBpMsgServerMaster.tDest,
    \obBpMsgServerMaster[tId]\ => obBpMsgServerMaster.tId,
    \obBpMsgServerMaster[tUser]\ => obBpMsgServerMaster.tUser,
    \obBpMsgServerSlave[tReady]\ => obBpMsgServerSlave.tReady,
    \ibBpMsgServerMaster[tValid]\ => ibBpMsgServerMaster.tValid,
    \ibBpMsgServerMaster[tData]\ => ibBpMsgServerMaster.tData,
    \ibBpMsgServerMaster[tStrb]\ => ibBpMsgServerMaster.tStrb,
    \ibBpMsgServerMaster[tKeep]\ => ibBpMsgServerMaster.tKeep,
    \ibBpMsgServerMaster[tLast]\ => ibBpMsgServerMaster.tLast,
    \ibBpMsgServerMaster[tDest]\ => ibBpMsgServerMaster.tDest,
    \ibBpMsgServerMaster[tId]\ => ibBpMsgServerMaster.tId,
    \ibBpMsgServerMaster[tUser]\ => ibBpMsgServerMaster.tUser,
    \ibBpMsgServerSlave[tReady]\ => ibBpMsgServerSlave.tReady,
    \obAppDebugMaster[tValid]\ => obAppDebugMaster.tValid,
    \obAppDebugMaster[tData]\ => obAppDebugMaster.tData,
    \obAppDebugMaster[tStrb]\ => obAppDebugMaster.tStrb,
    \obAppDebugMaster[tKeep]\ => obAppDebugMaster.tKeep,
    \obAppDebugMaster[tLast]\ => obAppDebugMaster.tLast,
    \obAppDebugMaster[tDest]\ => obAppDebugMaster.tDest,
    \obAppDebugMaster[tId]\ => obAppDebugMaster.tId,
    \obAppDebugMaster[tUser]\ => obAppDebugMaster.tUser,
    \obAppDebugSlave[tReady]\ => obAppDebugSlave.tReady,
    \ibAppDebugMaster[tValid]\ => ibAppDebugMaster.tValid,
    \ibAppDebugMaster[tData]\ => ibAppDebugMaster.tData,
    \ibAppDebugMaster[tStrb]\ => ibAppDebugMaster.tStrb,
    \ibAppDebugMaster[tKeep]\ => ibAppDebugMaster.tKeep,
    \ibAppDebugMaster[tLast]\ => ibAppDebugMaster.tLast,
    \ibAppDebugMaster[tDest]\ => ibAppDebugMaster.tDest,
    \ibAppDebugMaster[tId]\ => ibAppDebugMaster.tId,
    \ibAppDebugMaster[tUser]\ => ibAppDebugMaster.tUser,
    \ibAppDebugSlave[tReady]\ => ibAppDebugSlave.tReady,
    recTimingClk => recTimingClk,
    recTimingRst => recTimingRst,
    ref156MHzClk => ref156MHzClk,
    ref156MHzRst => ref156MHzRst,
    gthFabClk => gthFabClk,
    \axilReadMasters[1][araddr]\ => axilReadMasters(1).araddr,
    \axilReadMasters[1][arprot]\ => axilReadMasters(1).arprot,
    \axilReadMasters[1][arvalid]\ => axilReadMasters(1).arvalid,
    \axilReadMasters[1][rready]\ => axilReadMasters(1).rready,
    \axilReadMasters[0][araddr]\ => axilReadMasters(0).araddr,
    \axilReadMasters[0][arprot]\ => axilReadMasters(0).arprot,
    \axilReadMasters[0][arvalid]\ => axilReadMasters(0).arvalid,
    \axilReadMasters[0][rready]\ => axilReadMasters(0).rready,
    \axilReadSlaves[1][arready]\ => axilReadSlaves(1).arready,
    \axilReadSlaves[1][rdata]\ => axilReadSlaves(1).rdata,
    \axilReadSlaves[1][rresp]\ => axilReadSlaves(1).rresp,
    \axilReadSlaves[1][rvalid]\ => axilReadSlaves(1).rvalid,
    \axilReadSlaves[0][arready]\ => axilReadSlaves(0).arready,
    \axilReadSlaves[0][rdata]\ => axilReadSlaves(0).rdata,
    \axilReadSlaves[0][rresp]\ => axilReadSlaves(0).rresp,
    \axilReadSlaves[0][rvalid]\ => axilReadSlaves(0).rvalid,
    \axilWriteMasters[1][awaddr]\ => axilWriteMasters(1).awaddr,
    \axilWriteMasters[1][awprot]\ => axilWriteMasters(1).awprot,
    \axilWriteMasters[1][awvalid]\ => axilWriteMasters(1).awvalid,
    \axilWriteMasters[1][wdata]\ => axilWriteMasters(1).wdata,
    \axilWriteMasters[1][wstrb]\ => axilWriteMasters(1).wstrb,
    \axilWriteMasters[1][wvalid]\ => axilWriteMasters(1).wvalid,
    \axilWriteMasters[1][bready]\ => axilWriteMasters(1).bready,
    \axilWriteMasters[0][awaddr]\ => axilWriteMasters(0).awaddr,
    \axilWriteMasters[0][awprot]\ => axilWriteMasters(0).awprot,
    \axilWriteMasters[0][awvalid]\ => axilWriteMasters(0).awvalid,
    \axilWriteMasters[0][wdata]\ => axilWriteMasters(0).wdata,
    \axilWriteMasters[0][wstrb]\ => axilWriteMasters(0).wstrb,
    \axilWriteMasters[0][wvalid]\ => axilWriteMasters(0).wvalid,
    \axilWriteMasters[0][bready]\ => axilWriteMasters(0).bready,
    \axilWriteSlaves[1][awready]\ => axilWriteSlaves(1).awready,
    \axilWriteSlaves[1][wready]\ => axilWriteSlaves(1).wready,
    \axilWriteSlaves[1][bresp]\ => axilWriteSlaves(1).bresp,
    \axilWriteSlaves[1][bvalid]\ => axilWriteSlaves(1).bvalid,
    \axilWriteSlaves[0][awready]\ => axilWriteSlaves(0).awready,
    \axilWriteSlaves[0][wready]\ => axilWriteSlaves(0).wready,
    \axilWriteSlaves[0][bresp]\ => axilWriteSlaves(0).bresp,
    \axilWriteSlaves[0][bvalid]\ => axilWriteSlaves(0).bvalid,
    \ethReadMaster[araddr]\ => ethReadMaster.araddr,
    \ethReadMaster[arprot]\ => ethReadMaster.arprot,
    \ethReadMaster[arvalid]\ => ethReadMaster.arvalid,
    \ethReadMaster[rready]\ => ethReadMaster.rready,
    \ethReadSlave[arready]\ => ethReadSlave.arready,
    \ethReadSlave[rdata]\ => ethReadSlave.rdata,
    \ethReadSlave[rresp]\ => ethReadSlave.rresp,
    \ethReadSlave[rvalid]\ => ethReadSlave.rvalid,
    \ethWriteMaster[awaddr]\ => ethWriteMaster.awaddr,
    \ethWriteMaster[awprot]\ => ethWriteMaster.awprot,
    \ethWriteMaster[awvalid]\ => ethWriteMaster.awvalid,
    \ethWriteMaster[wdata]\ => ethWriteMaster.wdata,
    \ethWriteMaster[wstrb]\ => ethWriteMaster.wstrb,
    \ethWriteMaster[wvalid]\ => ethWriteMaster.wvalid,
    \ethWriteMaster[bready]\ => ethWriteMaster.bready,
    \ethWriteSlave[awready]\ => ethWriteSlave.awready,
    \ethWriteSlave[wready]\ => ethWriteSlave.wready,
    \ethWriteSlave[bresp]\ => ethWriteSlave.bresp,
    \ethWriteSlave[bvalid]\ => ethWriteSlave.bvalid,
    localMac => localMac,
    localIp => localIp,
    ethLinkUp => ethLinkUp,
    \timingReadMaster[araddr]\ => timingReadMaster.araddr,
    \timingReadMaster[arprot]\ => timingReadMaster.arprot,
    \timingReadMaster[arvalid]\ => timingReadMaster.arvalid,
    \timingReadMaster[rready]\ => timingReadMaster.rready,
    \timingReadSlave[arready]\ => timingReadSlave.arready,
    \timingReadSlave[rdata]\ => timingReadSlave.rdata,
    \timingReadSlave[rresp]\ => timingReadSlave.rresp,
    \timingReadSlave[rvalid]\ => timingReadSlave.rvalid,
    \timingWriteMaster[awaddr]\ => timingWriteMaster.awaddr,
    \timingWriteMaster[awprot]\ => timingWriteMaster.awprot,
    \timingWriteMaster[awvalid]\ => timingWriteMaster.awvalid,
    \timingWriteMaster[wdata]\ => timingWriteMaster.wdata,
    \timingWriteMaster[wstrb]\ => timingWriteMaster.wstrb,
    \timingWriteMaster[wvalid]\ => timingWriteMaster.wvalid,
    \timingWriteMaster[bready]\ => timingWriteMaster.bready,
    \timingWriteSlave[awready]\ => timingWriteSlave.awready,
    \timingWriteSlave[wready]\ => timingWriteSlave.wready,
    \timingWriteSlave[bresp]\ => timingWriteSlave.bresp,
    \timingWriteSlave[bvalid]\ => timingWriteSlave.bvalid,
    \bsaReadMaster[araddr]\ => bsaReadMaster.araddr,
    \bsaReadMaster[arprot]\ => bsaReadMaster.arprot,
    \bsaReadMaster[arvalid]\ => bsaReadMaster.arvalid,
    \bsaReadMaster[rready]\ => bsaReadMaster.rready,
    \bsaReadSlave[arready]\ => bsaReadSlave.arready,
    \bsaReadSlave[rdata]\ => bsaReadSlave.rdata,
    \bsaReadSlave[rresp]\ => bsaReadSlave.rresp,
    \bsaReadSlave[rvalid]\ => bsaReadSlave.rvalid,
    \bsaWriteMaster[awaddr]\ => bsaWriteMaster.awaddr,
    \bsaWriteMaster[awprot]\ => bsaWriteMaster.awprot,
    \bsaWriteMaster[awvalid]\ => bsaWriteMaster.awvalid,
    \bsaWriteMaster[wdata]\ => bsaWriteMaster.wdata,
    \bsaWriteMaster[wstrb]\ => bsaWriteMaster.wstrb,
    \bsaWriteMaster[wvalid]\ => bsaWriteMaster.wvalid,
    \bsaWriteMaster[bready]\ => bsaWriteMaster.bready,
    \bsaWriteSlave[awready]\ => bsaWriteSlave.awready,
    \bsaWriteSlave[wready]\ => bsaWriteSlave.wready,
    \bsaWriteSlave[bresp]\ => bsaWriteSlave.bresp,
    \bsaWriteSlave[bvalid]\ => bsaWriteSlave.bvalid,
    \ddrReadMaster[araddr]\ => ddrReadMaster.araddr,
    \ddrReadMaster[arprot]\ => ddrReadMaster.arprot,
    \ddrReadMaster[arvalid]\ => ddrReadMaster.arvalid,
    \ddrReadMaster[rready]\ => ddrReadMaster.rready,
    \ddrReadSlave[arready]\ => ddrReadSlave.arready,
    \ddrReadSlave[rdata]\ => ddrReadSlave.rdata,
    \ddrReadSlave[rresp]\ => ddrReadSlave.rresp,
    \ddrReadSlave[rvalid]\ => ddrReadSlave.rvalid,
    \ddrWriteMaster[awaddr]\ => ddrWriteMaster.awaddr,
    \ddrWriteMaster[awprot]\ => ddrWriteMaster.awprot,
    \ddrWriteMaster[awvalid]\ => ddrWriteMaster.awvalid,
    \ddrWriteMaster[wdata]\ => ddrWriteMaster.wdata,
    \ddrWriteMaster[wstrb]\ => ddrWriteMaster.wstrb,
    \ddrWriteMaster[wvalid]\ => ddrWriteMaster.wvalid,
    \ddrWriteMaster[bready]\ => ddrWriteMaster.bready,
    \ddrWriteSlave[awready]\ => ddrWriteSlave.awready,
    \ddrWriteSlave[wready]\ => ddrWriteSlave.wready,
    \ddrWriteSlave[bresp]\ => ddrWriteSlave.bresp,
    \ddrWriteSlave[bvalid]\ => ddrWriteSlave.bvalid,
    ddrMemReady => ddrMemReady,
    ddrMemError => ddrMemError,
    fabClkP => fabClkP,
    fabClkN => fabClkN,
    ethRxP => ethRxP,
    ethRxN => ethRxN,
    ethTxP => ethTxP,
    ethTxN => ethTxN,
    ethClkP => ethClkP,
    ethClkN => ethClkN,
    timingRxP => timingRxP,
    timingRxN => timingRxN,
    timingTxP => timingTxP,
    timingTxN => timingTxN,
    timingRefClkInP => timingRefClkInP,
    timingRefClkInN => timingRefClkInN,
    timingRecClkOutP => timingRecClkOutP,
    timingRecClkOutN => timingRecClkOutN,
    timingClkSel => timingClkSel,
    enAuxPwrL => enAuxPwrL,
    ddrClkP => ddrClkP,
    ddrClkN => ddrClkN,
    ddrDm => ddrDm,
    ddrDqsP => ddrDqsP,
    ddrDqsN => ddrDqsN,
    ddrDq => ddrDq,
    ddrA => ddrA,
    ddrBa => ddrBa,
    ddrCsL => ddrCsL,
    ddrOdt => ddrOdt,
    ddrCke => ddrCke,
    ddrCkP => ddrCkP,
    ddrCkN => ddrCkN,
    ddrWeL => ddrWeL,
    ddrRasL => ddrRasL,
    ddrCasL => ddrCasL,
    ddrRstL => ddrRstL,
    ddrAlertL => ddrAlertL,
    ddrPg => ddrPg,
    ddrPwrEnL => ddrPwrEnL);