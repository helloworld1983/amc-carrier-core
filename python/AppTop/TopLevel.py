#!/usr/bin/env python
#-----------------------------------------------------------------------------
# Title      : PyRogue AMC Carrier Cryo Demo Board Application
#-----------------------------------------------------------------------------
# File       : AppCore.py
# Created    : 2017-04-03
#-----------------------------------------------------------------------------
# Description:
# PyRogue AMC Carrier Cryo Demo Board Application
#-----------------------------------------------------------------------------
# This file is part of the rogue software platform. It is subject to
# the license terms in the LICENSE.txt file found in the top-level directory
# of this distribution and at:
#    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
# No part of the rogue software platform, including this file, may be
# copied, modified, propagated, or distributed except according to the terms
# contained in the LICENSE.txt file.
#-----------------------------------------------------------------------------

import pyrogue as pr
import pyrogue.simulation
import pyrogue.protocols
import pyrogue.utilities.fileio

from AmcCarrierCore import *
from AppTop import *

class TopLevel(pr.Device):
    def __init__(   self, 
            name            = "FpgaTopLevel", 
            description     = "FPGA Top-Level", 
            simGui          = False,
            ipAddr          = "10.0.1.101",
            numRxLanes      = [0,0],
            numTxLanes      = [0,0],
            numSigGen       = [0,0],
            sizeSigGen      = [0,0],
            modeSigGen      = [False,False],
            enableBsa       = False,
            enableMps       = False,
            interleaveRSSI  = False,
            **kwargs):
        super().__init__(name=name, description=description, **kwargs)
        
        self._numRxLanes = numRxLanes
        self._numTxLanes = numTxLanes
        
        if (simGui):
            # Create simulation srp interface
            srp=pyrogue.simulation.MemEmulate()
        else:
        
            # File writer
            dataWriter = pyrogue.utilities.fileio.StreamWriter(name='dataWriter')
            self.add(dataWriter)
            
            # Create SRPv3 module
            srp = rogue.protocols.srp.SrpV3()
            
            # Check for interleaving
            if (interleaveRSSI):
                
                # Create Interleaved RSSI interface
                rudp = pyrogue.protocols.UdpRssiPack( host=ipAddr, port=8193, size=1024, packVer = 2)              
                    
                # Connect the SRPv3 to tDest = 0x0
                pr.streamConnectBiDir( srp, rudp.application(dest=0x0) )                    
                 
                # Add data streams
                for i in range(8):
                    pyrogue.streamConnect(rudp.application(0x80 + i), dataWriter.getChannel(i))   
                 
            else:
            
                # Create SRP/ASYNC_MSG interface
                udp = pyrogue.protocols.UdpRssiPack( host=ipAddr, port=8193, size=1024)
                
                # Connect the SRPv3 to tDest = 0x0
                pr.streamConnectBiDir( srp, udp.application(dest=0x0) )

                # Create stream interface
                udpStream = pr.protocols.UdpRssiPack( host=ipAddr, port=8194, size=1024)
            
                # Add data streams
                for i in range(8):
                    pyrogue.streamConnect(udpStream.application(0x80 + i), dataWriter.getChannel(i))            
        
        # Add devices
        self.add(AmcCarrierCore(    
            memBase    =  srp,
            offset     =  0x00000000,
            enableBsa  =  enableBsa,
            enableMps  =  enableMps,
        ))
        self.add(AppTop(
            memBase      =  srp,
            offset       =  0x80000000,
            numRxLanes   =  numRxLanes,
            numTxLanes   =  numTxLanes,
            numSigGen    =  numSigGen,
            sizeSigGen   =  sizeSigGen,
            modeSigGen   =  modeSigGen,
        ))

        # Define SW trigger command
        @self.command(description="Software Trigger for DAQ MUX",)
        def SwDaqMuxTrig():
            for i in range(2): 
                self.AppTop.DaqMuxV2[i].TriggerDaq.call()

    def writeBlocks(self, force=False, recurse=True, variable=None, checkEach=False):
        """
        Write all of the blocks held by this Device to memory
        """
        if not self.enable.get(): return

        # Process local blocks.
        if variable is not None:
            #variable._block.startTransaction(rogue.interfaces.memory.Write, check=checkEach) # > 2.4.0
            variable._block.backgroundTransaction(rogue.interfaces.memory.Write)
        else:
            for block in self._blocks:
                if force or block.stale:
                    if block.bulkEn:
                        #block.startTransaction(rogue.interfaces.memory.Write, check=checkEach) # > 2.4.0
                        block.backgroundTransaction(rogue.interfaces.memory.Write)

        # Process rest of tree
        if recurse:
            for key,value in self.devices.items():
                #value.writeBlocks(force=force, recurse=True, checkEach=checkEach)  # > 2.4.0
                value.writeBlocks(force=force, recurse=True)

        # Retire any in-flight transactions before starting
        self._root.checkBlocks(recurse=True)

        # Calculate the BsaWaveformEngine buffer sizes
        size    = [[0,0,0,0],[0,0,0,0]]
        for i in range(2):
            if ((self._numRxLanes[i] > 0) or (self._numTxLanes[i] > 0)):  
                for j in range(4):
                    waveBuff = self.AmcCarrierCore.AmcCarrierBsa.BsaWaveformEngine[i].WaveformEngineBuffers
                    if ( (waveBuff.Enabled[j].get() > 0) and (waveBuff.EndAddr[j].get() > waveBuff.StartAddr[j].get()) ):
                        size[i][j] = waveBuff.EndAddr[j].get() - waveBuff.StartAddr[j].get()
        
        # Calculate the 
        minSize = [size[0][0],size[1][0]]
        for i in range(2):
            if ((self._numRxLanes[i] > 0) or (self._numTxLanes[i] > 0)):          
                for j in range(4):
                    if ( size[i][j]<minSize[i] ):
                        minSize[i] = size[i][j]
        
        # Set the DAQ MUX buffer sizes to match the BsaWaveformEngine buffer sizes
        for i in range(2):
            if ((self._numRxLanes[i] > 0) or (self._numTxLanes[i] > 0)):  
                # Convert from bytes to words
                minSize[i] = minSize[i] >> 2 
                # Set the DAQ MUX buffer sizes
                self.AppTop.DaqMuxV2[i].DataBufferSize.set(minSize[i])
         
        self.checkBlocks(recurse=True)
