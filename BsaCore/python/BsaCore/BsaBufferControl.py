#!/usr/bin/env python
#-----------------------------------------------------------------------------
# Title      : PyRogue BSA Diagnostic Buffer Module
#-----------------------------------------------------------------------------
# File       : BsaBufferControl.py
# Created    : 2017-04-04
#-----------------------------------------------------------------------------
# Description:
# PyRogue BSA Diagnostic Buffer Module
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

from surf.GenericMemory import *
from surf.AxiStreamDmaRingWrite import *

class BsaBufferControl(pr.Device):
    def __init__(self, name="BsaBufferControl", description="Configuration and status of the BSA dignosic buffers", memBase=None, offset=0x0, hidden=False):
        super(self.__class__, self).__init__(name, description, memBase, offset, hidden)

        ##############################
        # Variables
        ##############################

        self.add(pr.Variable(   name         = "Timestamps",
                                description  = "",
                                offset       =  0x00000000,
                                bitSize      =  32,
                                bitOffset    =  0x00,
                                base         = "hex",
                                mode         = "RO",
                            ))

        for i in range(64):
            self.Timestamps.add(GenericMemory(
                                    name         = "GenericMemory_%.*i" % (2, i),
                                    offset       =  0x00 + (i * 0x04),
                                    bitSize      =  64,
                                    mode         = "RO"
                                ))

        self.add(AxiStreamDmaRingWrite(
                                offset       =  0x00001000,
                                name         = "BsaBuffers"
                            ))