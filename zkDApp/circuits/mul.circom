pragma circom 2.1.0;

// This circuit is "wrong"
template Main(){
    signal input x;
    signal input y;
    signal output out;
    out <== x * y;
}

component main {public [x]} = Main();

// verify for x = 1, you know a private y, x * y = 5