pragma circom 2.1.0;

// This circuit is "wrong"
template Mul(){
    signal input x;
    signal input y;
    signal z;
    signal output out;
    z <-- x * y;
    out <-- z * x;
    out === x * y;
}

component main {public [x]} = Mul();