module cm3_matrix_lite (

    // Common AHB signals
    HCLK,
    HRESETn,

    // System Address Remap control
    REMAP,

    // Input port SI0 (inputs from master 0)
    HADDRS0,
    HTRANSS0,
    HWRITES0,
    HSIZES0,
    HBURSTS0,
    HPROTS0,
    HWDATAS0,
    HMASTLOCKS0,
    HAUSERS0,
    HWUSERS0,

    // Input port SI1 (inputs from master 1)
    HADDRS1,
    HTRANSS1,
    HWRITES1,
    HSIZES1,
    HBURSTS1,
    HPROTS1,
    HWDATAS1,
    HMASTLOCKS1,
    HAUSERS1,
    HWUSERS1,

    // Input port SI2 (inputs from master 2)
    HADDRS3,
    HTRANSS3,
    HWRITES3,
    HSIZES3,
    HBURSTS3,
    HPROTS3,
    HWDATAS3,
    HMASTLOCKS3,
    HAUSERS3,
    HWUSERS3,

    // Input port SI3 (inputs from master 3)
    HADDRS4,
    HTRANSS4,
    HWRITES4,
    HSIZES4,
    HBURSTS4,
    HPROTS4,
    HWDATAS4,
    HMASTLOCKS4,
    HAUSERS4,
    HWUSERS4,

    // Input port SI4 (inputs from master 4)
    HADDRS5,
    HTRANSS5,
    HWRITES5,
    HSIZES5,
    HBURSTS5,
    HPROTS5,
    HWDATAS5,
    HMASTLOCKS5,
    HAUSERS5,
    HWUSERS5,

    // Output port MI0 (inputs from slave 0)
    HRDATAM0,
    HREADYOUTM0,
    HRESPM0,
    HRUSERM0,

    // Output port MI1 (inputs from slave 1)
    HRDATAM1,
    HREADYOUTM1,
    HRESPM1,
    HRUSERM1,

    // Output port MI2 (inputs from slave 2)
    HRDATAM2,
    HREADYOUTM2,
    HRESPM2,
    HRUSERM2,

    // Output port MI3 (inputs from slave 3)
    HRDATAM3,
    HREADYOUTM3,
    HRESPM3,
    HRUSERM3,

    // Scan test dummy signals; not connected until scan insertion
    SCANENABLE,   // Scan Test Mode Enable
    SCANINHCLK,   // Scan Chain Input


    // Output port MI0 (outputs to slave 0)
    HSELM0,
    HADDRM0,
    HTRANSM0,
    HWRITEM0,
    HSIZEM0,
    HBURSTM0,
    HPROTM0,
    HWDATAM0,
    HMASTLOCKM0,
    HREADYMUXM0,
    HAUSERM0,
    HWUSERM0,

    // Output port MI1 (outputs to slave 1)
    HSELM1,
    HADDRM1,
    HTRANSM1,
    HWRITEM1,
    HSIZEM1,
    HBURSTM1,
    HPROTM1,
    HWDATAM1,
    HMASTLOCKM1,
    HREADYMUXM1,
    HAUSERM1,
    HWUSERM1,

    // Output port MI2 (outputs to slave 2)
    HSELM2,
    HADDRM2,
    HTRANSM2,
    HWRITEM2,
    HSIZEM2,
    HBURSTM2,
    HPROTM2,
    HWDATAM2,
    HMASTLOCKM2,
    HREADYMUXM2,
    HAUSERM2,
    HWUSERM2,

    // Output port MI3 (outputs to slave 3)
    HSELM3,
    HADDRM3,
    HTRANSM3,
    HWRITEM3,
    HSIZEM3,
    HBURSTM3,
    HPROTM3,
    HWDATAM3,
    HMASTLOCKM3,
    HREADYMUXM3,
    HAUSERM3,
    HWUSERM3,

    // Input port SI0 (outputs to master 0)
    HRDATAS0,
    HREADYS0,
    HRESPS0,
    HRUSERS0,

    // Input port SI1 (outputs to master 1)
    HRDATAS1,
    HREADYS1,
    HRESPS1,
    HRUSERS1,

    // Input port SI2 (outputs to master 2)
    HRDATAS3,
    HREADYS3,
    HRESPS3,
    HRUSERS3,

    // Input port SI3 (outputs to master 3)
    HRDATAS4,
    HREADYS4,
    HRESPS4,
    HRUSERS4,

    // Input port SI4 (outputs to master 4)
    HRDATAS5,
    HREADYS5,
    HRESPS5,
    HRUSERS5,

    // Scan test dummy signals; not connected until scan insertion
    SCANOUTHCLK   // Scan Chain Output

    );

// -----------------------------------------------------------------------------
// Input and Output declarations
// -----------------------------------------------------------------------------

    // Common AHB signals
    input         HCLK;            // AHB System Clock
    input         HRESETn;         // AHB System Reset

    // System Address Remap control
    input   [3:0] REMAP;           // System Address REMAP control

    // Input port SI0 (inputs from master 0)
    input  [31:0] HADDRS0;         // Address bus
    input   [1:0] HTRANSS0;        // Transfer type
    input         HWRITES0;        // Transfer direction
    input   [2:0] HSIZES0;         // Transfer size
    input   [2:0] HBURSTS0;        // Burst type
    input   [3:0] HPROTS0;         // Protection control
    input  [31:0] HWDATAS0;        // Write data
    input         HMASTLOCKS0;     // Locked Sequence
    input  [31:0] HAUSERS0;        // Address USER signals
    input  [31:0] HWUSERS0;        // Write-data USER signals

    // Input port SI1 (inputs from master 1)
    input  [31:0] HADDRS1;         // Address bus
    input   [1:0] HTRANSS1;        // Transfer type
    input         HWRITES1;        // Transfer direction
    input   [2:0] HSIZES1;         // Transfer size
    input   [2:0] HBURSTS1;        // Burst type
    input   [3:0] HPROTS1;         // Protection control
    input  [31:0] HWDATAS1;        // Write data
    input         HMASTLOCKS1;     // Locked Sequence
    input  [31:0] HAUSERS1;        // Address USER signals
    input  [31:0] HWUSERS1;        // Write-data USER signals

    // Input port SI2 (inputs from master 2)
    input  [31:0] HADDRS3;         // Address bus
    input   [1:0] HTRANSS3;        // Transfer type
    input         HWRITES3;        // Transfer direction
    input   [2:0] HSIZES3;         // Transfer size
    input   [2:0] HBURSTS3;        // Burst type
    input   [3:0] HPROTS3;         // Protection control
    input  [31:0] HWDATAS3;        // Write data
    input         HMASTLOCKS3;     // Locked Sequence
    input  [31:0] HAUSERS3;        // Address USER signals
    input  [31:0] HWUSERS3;        // Write-data USER signals

    // Input port SI3 (inputs from master 3)
    input  [31:0] HADDRS4;         // Address bus
    input   [1:0] HTRANSS4;        // Transfer type
    input         HWRITES4;        // Transfer direction
    input   [2:0] HSIZES4;         // Transfer size
    input   [2:0] HBURSTS4;        // Burst type
    input   [3:0] HPROTS4;         // Protection control
    input  [31:0] HWDATAS4;        // Write data
    input         HMASTLOCKS4;     // Locked Sequence
    input  [31:0] HAUSERS4;        // Address USER signals
    input  [31:0] HWUSERS4;        // Write-data USER signals

    // Input port SI4 (inputs from master 4)
    input  [31:0] HADDRS5;         // Address bus
    input   [1:0] HTRANSS5;        // Transfer type
    input         HWRITES5;        // Transfer direction
    input   [2:0] HSIZES5;         // Transfer size
    input   [2:0] HBURSTS5;        // Burst type
    input   [3:0] HPROTS5;         // Protection control
    input  [31:0] HWDATAS5;        // Write data
    input         HMASTLOCKS5;     // Locked Sequence
    input  [31:0] HAUSERS5;        // Address USER signals
    input  [31:0] HWUSERS5;        // Write-data USER signals

    // Output port MI0 (inputs from slave 0)
    input  [31:0] HRDATAM0;        // Read data bus
    input         HREADYOUTM0;     // HREADY feedback
    input         HRESPM0;         // Transfer response
    input  [31:0] HRUSERM0;        // Read-data USER signals

    // Output port MI1 (inputs from slave 1)
    input  [31:0] HRDATAM1;        // Read data bus
    input         HREADYOUTM1;     // HREADY feedback
    input         HRESPM1;         // Transfer response
    input  [31:0] HRUSERM1;        // Read-data USER signals

    // Output port MI2 (inputs from slave 2)
    input  [31:0] HRDATAM2;        // Read data bus
    input         HREADYOUTM2;     // HREADY feedback
    input         HRESPM2;         // Transfer response
    input  [31:0] HRUSERM2;        // Read-data USER signals

    // Output port MI3 (inputs from slave 3)
    input  [31:0] HRDATAM3;        // Read data bus
    input         HREADYOUTM3;     // HREADY feedback
    input         HRESPM3;         // Transfer response
    input  [31:0] HRUSERM3;        // Read-data USER signals

    // Scan test dummy signals; not connected until scan insertion
    input         SCANENABLE;      // Scan enable signal
    input         SCANINHCLK;      // HCLK scan input


    // Output port MI0 (outputs to slave 0)
    output        HSELM0;          // Slave Select
    output [31:0] HADDRM0;         // Address bus
    output  [1:0] HTRANSM0;        // Transfer type
    output        HWRITEM0;        // Transfer direction
    output  [2:0] HSIZEM0;         // Transfer size
    output  [2:0] HBURSTM0;        // Burst type
    output  [3:0] HPROTM0;         // Protection control
    output [31:0] HWDATAM0;        // Write data
    output        HMASTLOCKM0;     // Locked Sequence
    output        HREADYMUXM0;     // Transfer done
    output [31:0] HAUSERM0;        // Address USER signals
    output [31:0] HWUSERM0;        // Write-data USER signals

    // Output port MI1 (outputs to slave 1)
    output        HSELM1;          // Slave Select
    output [31:0] HADDRM1;         // Address bus
    output  [1:0] HTRANSM1;        // Transfer type
    output        HWRITEM1;        // Transfer direction
    output  [2:0] HSIZEM1;         // Transfer size
    output  [2:0] HBURSTM1;        // Burst type
    output  [3:0] HPROTM1;         // Protection control
    output [31:0] HWDATAM1;        // Write data
    output        HMASTLOCKM1;     // Locked Sequence
    output        HREADYMUXM1;     // Transfer done
    output [31:0] HAUSERM1;        // Address USER signals
    output [31:0] HWUSERM1;        // Write-data USER signals

    // Output port MI2 (outputs to slave 2)
    output        HSELM2;          // Slave Select
    output [31:0] HADDRM2;         // Address bus
    output  [1:0] HTRANSM2;        // Transfer type
    output        HWRITEM2;        // Transfer direction
    output  [2:0] HSIZEM2;         // Transfer size
    output  [2:0] HBURSTM2;        // Burst type
    output  [3:0] HPROTM2;         // Protection control
    output [31:0] HWDATAM2;        // Write data
    output        HMASTLOCKM2;     // Locked Sequence
    output        HREADYMUXM2;     // Transfer done
    output [31:0] HAUSERM2;        // Address USER signals
    output [31:0] HWUSERM2;        // Write-data USER signals

    // Output port MI3 (outputs to slave 3)
    output        HSELM3;          // Slave Select
    output [31:0] HADDRM3;         // Address bus
    output  [1:0] HTRANSM3;        // Transfer type
    output        HWRITEM3;        // Transfer direction
    output  [2:0] HSIZEM3;         // Transfer size
    output  [2:0] HBURSTM3;        // Burst type
    output  [3:0] HPROTM3;         // Protection control
    output [31:0] HWDATAM3;        // Write data
    output        HMASTLOCKM3;     // Locked Sequence
    output        HREADYMUXM3;     // Transfer done
    output [31:0] HAUSERM3;        // Address USER signals
    output [31:0] HWUSERM3;        // Write-data USER signals

    // Input port SI0 (outputs to master 0)
    output [31:0] HRDATAS0;        // Read data bus
    output        HREADYS0;     // HREADY feedback
    output        HRESPS0;         // Transfer response
    output [31:0] HRUSERS0;        // Read-data USER signals

    // Input port SI1 (outputs to master 1)
    output [31:0] HRDATAS1;        // Read data bus
    output        HREADYS1;     // HREADY feedback
    output        HRESPS1;         // Transfer response
    output [31:0] HRUSERS1;        // Read-data USER signals

    // Input port SI2 (outputs to master 2)
    output [31:0] HRDATAS3;        // Read data bus
    output        HREADYS3;     // HREADY feedback
    output        HRESPS3;         // Transfer response
    output [31:0] HRUSERS3;        // Read-data USER signals

    // Input port SI3 (outputs to master 3)
    output [31:0] HRDATAS4;        // Read data bus
    output        HREADYS4;     // HREADY feedback
    output        HRESPS4;         // Transfer response
    output [31:0] HRUSERS4;        // Read-data USER signals

    // Input port SI4 (outputs to master 4)
    output [31:0] HRDATAS5;        // Read data bus
    output        HREADYS5;     // HREADY feedback
    output        HRESPS5;         // Transfer response
    output [31:0] HRUSERS5;        // Read-data USER signals

    // Scan test dummy signals; not connected until scan insertion
    output        SCANOUTHCLK;     // Scan Chain Output
endmodule
