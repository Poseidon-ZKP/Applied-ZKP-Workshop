pragma circom 2.1.0;

// Function inputs: x1, x2, x3, x4
// OUT = f(x) = (x1 + x2) * x3 - x4

template Main() {
    signal input x1;
    signal input x2;
    signal input x3;
    signal input x4;
    signal output out;
    signal x1_add_x2;
    signal y;
    x1_add_x2 <-- x1 + x2;
    y <-- x1_add_x2 * x3;
    out <-- y - x4;
}

component main = Main();