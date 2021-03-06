-------------------------------------------------------------------------------
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Example .MCS: The GZ header (0x1F8B) starts at offset: 062A0000 + 8D48 + 6 = 0x62A8D4E
-- :02   000004   062A   CA
-- :10   8D4800   27 C3 BF C3 BF 27 1F 8B 08 00 64 03 C2 5D 00 03    8E
-------------------------------------------------------------------------------
-- This file is part of 'LCLS2 Common Carrier Core'.
-- It is subject to the license terms in the LICENSE.txt file found in the 
-- top-level directory of this distribution and at: 
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html. 
-- No part of 'LCLS2 Common Carrier Core', including this file, 
-- may be copied, modified, propagated, or distributed except according to 
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


library surf;
use surf.StdRtlPkg.all;

package FpgaTypePkg is
   
   constant CPSW_TARBALL_ADDR_C : slv(31 downto 0) := x"062A8D4E";

   constant ULTRASCALE_PLUS_C : boolean := true;

end package FpgaTypePkg;
