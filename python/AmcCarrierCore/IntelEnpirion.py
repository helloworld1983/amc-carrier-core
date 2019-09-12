#!/usr/bin/env python
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

class IntelEnpirion(pr.Device):
    def __init__(   self,       
            name         = "IntelEnpirion",
            description  = "Intel Enpirion EM22xx",
            **kwargs):
        super().__init__(name=name, description=description, **kwargs) 

        def addPair(name, offset, units, description, pollInterval = 0,):
            self.add(pr.RemoteVariable(  
                name         = (name+"_RAW"), 
                offset       = offset, 
                bitSize      = 16, 
                bitOffset    = 0,
                mode         = 'RO', 
                base         = pr.Int,
                description  = description,
                pollInterval = pollInterval,
                hidden       = True,
            ))

            self.add(pr.LinkVariable(
                name         = name, 
                mode         = 'RO', 
                units        = units,
                linkedGet    = self.convLinear,
                typeStr      = "Float32",
                dependencies = [self.variables[name+"_RAW"]],
            ))

        addPair(
            name         = "READ_IOUT",
            offset       = 0x8C*4,
            units        = "A",
            description  = "Current readback",
            pollInterval = 2,
        )
        
        addPair(
            name         = "READ_TEMPERATURE_1",
            offset       = 0x8D*4,
            units        = "degC",
            description  = "Internal power train temperature",
            pollInterval = 2,
        )
        
        addPair(
            name         = "READ_TEMPERATURE_2",
            offset       = 0x8E*4,
            units        = "degC",
            description  = "Controller temperature",
            pollInterval = 2,
        )


    @staticmethod
    def convLinear(dev, var)
        def twosComplement(val, nbits):
            if (val >= 2**(nbits-1)):
                return (val - 2**nbits)
            else:
                return val

        val = var.dependencies[0].get(read=False)
        
        Y = (0x07FF & val)
        N = (0xF100 & val) >> 11

        return twosComplement(Y, 11)*2**twosComplement(N, 5)
