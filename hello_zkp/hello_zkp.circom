pragma circom 2.1.0;

template Main() {
    signal input x;
    signal input y;
    signal output out;
    out <-- x * y;
    out === x * y;
}

component main {public [x]} = Main();