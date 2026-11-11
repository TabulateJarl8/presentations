---
marp: true
theme: default
class: invert
footer: Slides written by Connor Sample - https://tabulate.tech
math: katex
---

# Verilog/FPGA Programming

---

# What is an FPGA?

- Field-Programmable Gate Array
- Reprogrammable Hardware
- Lies between a CPU and an ASIC (Application-Specific Integrated Circuit)

---

<!-- footer: "*: These can also use FPGAs, just depends on scenario" -->

|               | CPU                                  | FPGA                            | ASIC                                      |
| ------------- | ------------------------------------ | ------------------------------- | ----------------------------------------- |
| Flexibility   | Extremely High                       | High                            | None                                      |
| Upfront Cost  | Low                                  | Medium                          | High                                      |
| Cost Per Unit | Medium-High                          | High                            | Low at scale                              |
| Power         | Low Efficiency                       | Medium Efficiency               | High Efficiency                           |
| Use Case      | Operating Systems, General computing | Prototyping, high-speed trading | Bitcoin mining, Aerospace\*, Automotive\* |

---

<!-- footer: "Slides written by Connor Sample - https://tabulate.tech" -->

# FPGA Use Cases

- High Speed Trading
  - Algorithms change often
  - Faster than traditional CPU
- Hardware Acceleration
  - Video Transcoding
  - Genome Sequencing
- Autonomous driving data processing
- 5G Telecom data processing
- Many More...

---

# What is Verilog?

- Describes FPGA circuits
- Synthesizes into physical logic gates rather than CPU instructions

---

# Verilog Logic Gate Functions

```verilog
and(out, in1, in2);
or(out, in1, in2);
nand(out, in1, in2);
nor(out, in1, in2);
xor(out, in1, in2);
xnor(out, in1, in2);

// not only has one input
not(out, in);
```

---

# Making a 2x1 Multiplexer

---

<style scoped>
th, td {
    font-size: 20pt;
}
</style>

# Making a 2x1 Mux - Truth Table

| sel | a   | b   | y   |
| --- | --- | --- | --- |
| 0   | 0   | 0   |     |
| 0   | 0   | 1   |     |
| 0   | 1   | 0   |     |
| 0   | 1   | 1   |     |
| 1   | 0   | 0   |     |
| 1   | 0   | 1   |     |
| 1   | 1   | 0   |     |
| 1   | 1   | 1   |     |

---

<style scoped>
th, td {
    font-size: 20pt;
}
</style>

# Making a 2x1 Mux - Truth Table

| sel | a   | b   | y   |
| --- | --- | --- | --- |
| 0   | 0   | 0   | 0   |
| 0   | 0   | 1   | 0   |
| 0   | 1   | 0   | 1   |
| 0   | 1   | 1   | 1   |
| 1   | 0   | 0   | 0   |
| 1   | 0   | 1   | 1   |
| 1   | 1   | 0   | 0   |
| 1   | 1   | 1   | 1   |

---

<style scoped>
.columns {
  display: grid;
  grid-template-columns: 1fr 1fr;
  align-items: center;
  gap: 2rem;
}
th, td {
    font-size: 17pt;
}
</style>

# Making a 2x1 Mux - Truth Table

<div class="columns">
<div>

| sel | a   | b   | y              |
| --- | --- | --- | -------------- |
| 0   | 0   | 0   | 0              |
| 0   | 0   | 1   | 0              |
| 0   | 1   | 0   | <mark>1</mark> |
| 0   | 1   | 1   | <mark>1</mark> |
| 1   | 0   | 0   | 0              |
| 1   | 0   | 1   | <mark>1</mark> |
| 1   | 1   | 0   | 0              |
| 1   | 1   | 1   | <mark>1</mark> |

</div>
<div>

$$ y = (\overline{sel} \cdot a \cdot \overline{b}) + (\overline{sel} \cdot a \cdot b) + (sel \cdot \overline{a} \cdot b) + (sel \cdot a \cdot b) $$

$$ y = \overline{sel} \cdot a \cdot (\overline{b} + b) + sel \cdot b \cdot (\overline{a} + a) $$

$$ y = (\overline{sel} \cdot a \cdot 1) + (sel \cdot b \cdot 1) $$

$$ y = (\overline{sel} \cdot a) + (sel \cdot b) $$

</div>
</div>

- K-Maps

---

# Making a 2x1 Mux - Code

```verilog
module mux_2x1(
  input a, b, sel,
  output y
);

  wire not_sel, w1, w2;

  not(not_sel, sel);
  and(w1, a, not_sel);
  and(w2, b, sel);
  or(y, w1, w2);

endmodule
```

---

<!--
# Making a Half-Adder

---

# Making a Half-Adder - Truth Table

| a   | b   | sum | cout |
| --- | --- | --- | ---- |
| 0   | 0   |     |      |
| 0   | 1   |     |      |
| 1   | 0   |     |      |
| 1   | 1   |     |      |

---

# Making a Half-Adder - Truth Table

| a   | b   | sum | cout |
| --- | --- | --- | ---- |
| 0   | 0   | 0   | 0    |
| 0   | 1   | 1   | 0    |
| 1   | 0   | 1   | 0    |
| 1   | 1   | 1   | 1    |

---

<style scoped>
.columns {
  display: grid;
  grid-template-columns: 1fr 1fr;
  align-items: center;
  gap: 2rem;
}
</style>

# Making a Half-Adder - Truth Table

<div class="columns">
<div>

| a   | b   | sum            | cout           |
| --- | --- | -------------- | -------------- |
| 0   | 0   | 0              | 0              |
| 0   | 1   | <mark>1</mark> | 0              |
| 1   | 0   | <mark>1</mark> | 0              |
| 1   | 1   | 0              | <mark>1</mark> |

</div>
<div>

$$
sum = a \oplus b \\
cout = a \land b
$$

</div>
</div>

---

# Making a Half-Adder

```verilog
module half_adder(
  input a, b,
  output sum, cout
);

  xor(sum, a, b);
  and(cout, a, b);

endmodule
```

----->

# Full Adder - Code

```verilog
module full_adder(
    input a, input b, input c_in, output sum, output c_out
);
    wire first_xor_out;
    wire first_and_out;
    wire second_and_out;

    xor(first_xor_out, a, b);
    and(first_and_out, a, b);

    xor(sum, c_in, first_xor_out);
    and(second_and_out, c_in, first_xor_out);

    or(c_out, second_and_out, first_and_out);
endmodule
```

---

# 4-bit Ripple-Carry Adder

- Chain full adders together to add multiple bits

---

# 4-bit Ripple-Carry Adder - Code

```verilog
module ripple_carry_4bit(
  input [3:0] a, b,
  input cin,
  output [3:0] sum,
  output cout
);
  wire c1, c2, c3;

  full_adder fa0(a[0], b[0], cin, sum[0], c1);
  full_adder fa1(a[1], b[1], c1,  sum[1], c2);
  full_adder fa2(a[2], b[2], c2,  sum[2], c3);
  full_adder fa3(a[3], b[3], c3,  sum[3], cout);
endmodule
```

---

<style scoped>
pre {
    font-size: 14pt;
}
</style>

### Top Module - Writing to the FPGA

<!-- TODO: test this -->

```verilog
module top(
  input [1:0] SWITCHES,
  input [3:0] BUTTONS,
  output [5:0] LEDS
);
  wire w_sum;
  wire w_cout;

  full_adder adder(
    BUTTONS[0], // a
    BUTTONS[1], // b
    BUTTONS[2], // cin
    w_sum,
    w_cout
  );

  mux_2x1 mux(
    w_sum, // d0 (selected when s=0)
    w_cout, // d1 (selected when s=1)
    SWITCHES[0], // sel
    LEDS[0]
  );
endmodule
```

---

# Behavioral Verilog

---

# Remaking the 2x1 Mux

```verilog
module mux_2x1(
  input d0, d1, sel,
  output reg out
);
  always @(d0, d1, sel) begin
    if (sel == 0) begin
      out = d0;
    end else begin
      out = d1;
    end
  end
endmodule
```

---

<style scoped>
pre {
    font-size: 11pt;
}
</style>

# Remaking the 2x1 Mux - Simplification

```verilog
module mux_2x1(
  input d0, d1, sel,
  output reg out
);
  always @(*) begin
    out = sel ? d1 : d0;
  end
endmodule
```

Now it's easier to increase the width of the inputs:

```verilog
module mux_2x1(
  input [31:0] d0, d1,
  input sel,
  output reg out
);
  always @(*) begin
    out = sel ? d1 : d0;
  end
endmodule
```

---

# Creating a 4x1 Mux

```verilog
module mux_4x1(
  input a, b, c, d,
  input [1:0] sel,
  output reg out
)
  always @(*) begin
    case (sel)
      2'b00: out = a;
      2'b01: out = b;
      2'b10: out = c;
      2'b11: out = d;
      default: out = 1'bx;
    endcase
  end
endmodule
```

---

# New 4-bit adder

```verilog
module adder_4bit (
    input [3:0] a, b,
    input cin,
    output [3:0] sum,
    output cout
);
    assign {cout, sum} = a + b + cin;
endmodule
```

---

<style scoped>
th, td {
    font-size: 17pt;
}
</style>

## Demo: Takeoff Config Warning System - Inputs

| Button       | Item                   |
| ------------ | ---------------------- |
| `BUTTONS[0]` | Flaps Set              |
| `BUTTONS[1]` | Parking brake released |
| `BUTTONS[2]` | Doors Closed           |
| `BUTTONS[3]` | Trim Set               |

| Switches State | Throttle         | Behavior                                              |
| -------------- | ---------------- | ----------------------------------------------------- |
| `00`           | Idle             | No checks                                             |
| `01`           | Taxi             | Checks run, but only the "not ready" light is shown   |
| `10`           | Takeoff          | Checks run and the warning fires if anything is wrong |
| `11`           | Takeoff override | Warning is silenced; ready light shows no matter what |

---

## Demo: Takeoff Config Warning System - Outputs

## LEDs

| LED         | Meaning                                              |
| ----------- | ---------------------------------------------------- |
| `LEDS[3:0]` | Fault lights corresponding to each button            |
| `LEDS[4]`   | WARNING (takeoff throttle and 2+ faults)             |
| `LEDS[5]`   | READY (no faults + throttle above idle, or override) |

---

```verilog
module takeoff_config(
    input  wire [3:0] BUTTONS,
    input  wire [1:0] SWITCHES,
    output wire [5:0] LEDS
);

    reg [3:0] faults; // 1 indicates a fault
    reg [2:0] fault_count;
    reg warning;

    always @(*) begin
        faults = 4'b0000;
        warning = 1'b0;

        case (SWITCHES)
            2'b00: begin
                // idle; nothing happens
            end

            // taxi or takeoff both show faults
            2'b01, 2'b10: begin
                faults = ~BUTTONS;
            end

            2'b11: begin
                // override; nothing happens
            end
        endcase

        fault_count = faults[0] + faults[1] + faults[2] + faults[3];

        if (SWITCHES == 2'b10 && fault_count >= 3'd2)
          warning = 1'b1;
    end

    assign LEDS[3:0] = faults;
    assign LEDS[4] = warning;
    assign LEDS[5] = (SWITCHES == 2'b11) || ((SWITCHES != 2'b00) && (faults == 4'b0000));
endmodule
```

---

<!-- footer: "NOTE: This testbench is partially AI generated because writing testbenches is not fun" -->

<style scoped>
pre {
    font-size: 6pt;
}
</style>

##### Example Testbench

```verilog
`define assert(signal, value) \
    if (signal !== value) begin \
        $display(`"ASSERTION FAILED in %m: signal (%d) != value (%d)`", signal, value); \
        $finish; \
    end

module takeoff_warning_tb;
    reg [3:0] BUTTONS;
    reg [1:0] SWITCHES;
    wire [5:0] LEDS;

    takeoff_config dut(
        .BUTTONS(BUTTONS),
        .SWITCHES(SWITCHES),
        .LEDS(LEDS)
    );

    task check;
        input [1:0] sw;
        input [3:0] btn;
        input [5:0] expected;
        begin
            SWITCHES = sw;
            BUTTONS  = btn;
            #10;
            `assert(LEDS, expected)
        end
    endtask

    initial begin
        // idle: always dark
        check(2'b00, 4'b0000, 6'b000000);
        check(2'b00, 4'b1111, 6'b000000);

        // taxi: fault lights only, never WARNING
        check(2'b01, 4'b0000, 6'b001111);  // all faults, no warning
        check(2'b01, 4'b1111, 6'b100000);  // all OK -> READY
        check(2'b01, 4'b1011, 6'b000100);  // doors button released

        // takeoff: 1 fault = caution, 2+ = warning
        check(2'b10, 4'b1110, 6'b000001);  // 1 fault: caution (no warning, no ready)
        check(2'b10, 4'b1100, 6'b010011);  // 2 faults: WARNING
        check(2'b10, 4'b0000, 6'b011111);  // 4 faults: WARNING
        check(2'b10, 4'b1111, 6'b100000);  // all OK -> READY

        // override: silenced, READY regardless
        check(2'b11, 4'b0000, 6'b100000);
        check(2'b11, 4'b1111, 6'b100000);

        $display("ALL TESTS PASSED");
        $finish;
    end
endmodule
```

---

<!-- footer: "Slides written by Connor Sample - https://tabulate.tech" -->

# What I didn't cover

- Clocks & Sequential Logic
  - Blocking vs nonblocking assignment
- Constraint files
- Macros
- Probably some other stuff I'm forgetting

---

# Questions
