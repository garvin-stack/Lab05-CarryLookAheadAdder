# Lab 5 - Carry Look Ahead Adder 

## Introduction

This lab is the second of two related labs that looks to explore how designs can start from a naive
approach based on how humans make computations and exloring what the limiations of this naive 
approach are and optimizing the design to make them faster. In this case we will look at a 
carry look ahead adder. For a more detailed explanation you can look in any computer architecture 
text book or read [this](https://en.wikipedia.org/wiki/Carry-lookahead_adder) wikipedia article.

The carry look ahead adder is more complex and uses more transisters in order to calculate the
carry for each binary digit concurrently, rather than wait each lower order bit to finish before
sending the carry to the next column. By calculating the carry in parallel an using two level
circuits, the ripple carry adder avoids most of **propagation delay**, that makes the ripple carry
adder slower, espcially as more bits are added. In this lab we'll compare the timing of these two
approaches and observe how the carry look ahead adder does not take longer to complete addition
even as the number of bits increases.

The figure below shows the basic circuit of a 4-bit carry look ahead adder. Notice the design is uses
the half adder module, rather than a full adder. While this diagram uses full adders, it is also
possiblre to use half adders are connected to the carry look ahead logic. The implmentation we use
will use half adders. Refer to the chapter from Prof. Vahid's book. As with the ripple carry 
adder, the carry in to the lowest orderfull adder is hard coded to 0, and the carry out of the highest
order bit is the carry out of the entire adder (this can be used, for example, to determine overflow in an ALU).

![Circuit diagram of a 4-bit carry look ahead adder](./assets/4-bit_carry_lookahead_adder.svg)

The high level discription of how this carry look ahead logic works is given by the following formulas:

To determine if a bit pair will generate a carry we use the formula:

$G_i = A_i \cdot B_i$

To determin if a bit pair will propagate a carry we use the formula:

$P_i = A_i \oplus B_i$ or $P_i = A_i + B_i$

For a 4-bit adder all the carries can therefore be calculated with the following formulas:

$C_1 = G_0 + P_0 \cdot C_0$

$C_2 = G_1 + P_1 \cdot C_1$

$C_3 = G_2 + P_2 \cdot C_2$

$C_4 = G_3 + P_3 \cdot C_3$

If we substitute $C_0$ in to $C_1$ then subsitute that in to $C_2$, and so on, we get that each carrie is:

$C_1 = G_0 + P_0 \cdot C_0$

$C_2 = G_1 + G_0 \cdot P_1 + C_0 \cdot P_0 \cdot P_1$

$C_3 = G_2 + G_1 \cdot P_2 + G_0 \cdot P_1 \cdot P_2 + C_0 \cdot P_0 \cdot P_1 \cdot P_2$

$C_4 = G_3 + G_2 \cdot P_3 + G_1 \cdot P_1 \cdot P_2 + G_0 \cdot P_1 \cdot P_2 \cdot P_3 + C_0 \cdot P_0 \cdot P_1 \cdot P_2 \cdot P_3$

We'll go over in lab how to generate these forumulas using the `generate` block and `for` loops to work
for any number of bits.

## Prelab

For the prelab you will modify test-bench file only. You have actually already done the prelab for this
lab. You can take your test-bench from lab 2 and copy it here. Just change the unit under test from 
`ripple_carry_adder` to `carry_look_ahead_adder`. The rest of the test-bench are exactly the same. The
same tests will test both the funcitionality and whether the addition completes in the given time
(_Hint:_ it should).

You will submit the entire lab repository to Gradescope. Part of your score will come from the fact
that it properly sythesizes. The other part of your score will be based on the completeness of your
tests, which the TA and I will grade.

## Deliverables

For this lab your are expected to build a Carry Look Aheader Adder that is parameterized to allow for any
number of bits to be added, though mostly the sizes will be powers of 2 greater than or equal to 8.
It should take two N-bit values, where N is the number of bits supported by the adder. These two 
inputs, `A` and `B`, are the operands for the addition operator. The output will be the N-bit `result` of
adding A and B, and a `carryout`, which indicates what the carry out of the highest order bit of the
addition operation. The only files you need to write code in, other than the test-bench, is 
[carry_look_ahead_adder.v](./carry_look_ahead_adder.v) and 
[carry_look_ahead_logic.v](./carry_look_ahead_logic.v). Do not modify any of the other files. 

_Hint_: Your carry look ahead adder will instatiate and wire up N half_adder modules and then wire it to
the carry look ahead logic.

### Carry Look Ahead Adder Specification

- The module name **must** be named `carry_look_ahead_adder` (it's arleady named that in [carry_look_ahead_adder.v](./carry_look_ahead_adder.v))
- The module **must** use a parameter called "`NUMBITS`", specifying the bit width of the operands and result
- The module **must** have input/output ports with the **EXACT** names listed below

|Inputs   |Size |Outputs   |Size |
|---------|-----|----------|-----|
|`A`      |N-bit|`result`  |N-bit|
|`B`      |N-bit|`carryout`|1-bit|
|`carryin`|1-bit|          |     |

We'll discuss later what the `carryin` input is. For now, you can assume it will be zero.

#### Carryout

The `carryout` output of the Carry Look Ahead Adder is the same as the carryout for the most significant
bit of the circuit. This output can be used to indicate overflow, for example when adding xFF and 
01.

### Writing the Test-Bench

You should have already written the test-bench for the prelab for this lab and all future labs. 
However, it's common to make changes before turning in based on actually building the module. 
Therefore changes to the test-bench are normal and have no impact on your grade. Gradescope will 
use it's own set of test cases for grading this lab, but should be similar to your final
test-bench.

### Producing the Waveform

Once you've synthesized the code for the test-bench and the Ripple Carry Adder module, you can run
the test-bench simulation script to make sure all the tests pass. This simluation run should
produce the code to make a waveform. Use techniques you learned in the previous lab to produce a
waveform for this lab and save it as a PNG. You will use this waveform in the lab write up and you
should look at it to see no ripple this time, but rather that the addition is complete after one 
propagation delay, no matter what the size of the adder.

You don't need to add a marker this time. Also, I've provided a .gtkw.

### The Lab Report

Finally, create a file called REPORT.md and use GitHub markdown to write your lab report. This lab
report will again be short, and comprised of two sections. The first section is a description of 
each test case. Use this section to discuss what changes you made in your tests from the prelab
until this final report. The second section should include your waveform and discuss how this 
waveform shows the no more ripples caused the delay. 

## Submission:

Each student **​must**​ turn in their repository from GitHub to Gradescope. The contents of which should be:
- A REPORT.md file with your name and email address, and the content described above
- All Verilog file(s) used in this lab (implementation and test benches).

**If your file does not synthesize or simulate properly, you will receive a 0 on the lab.**
