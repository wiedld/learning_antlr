grammar calc;

// rule names are lowercase. tokens are uppercase

////////////////////////////////////////

// expressions. Have num bind tightest, then powExp, then multiplyExp.

exprn
    : multiplyExprn (ADD|SUB) multiplyExprn
    ;

multiplyExprn
    : powExprn (MUL|DIV|MOD) powExprn
    ;

powExprn
    : number (POW) number
    ;

number
    : MINUS? INT+ (POINT INT+)?
    ;

////////////////////////////////////////

// Tokens

INT
    : ('0'..'9')
    ;

POINT
    : '.'
    ;

LPAREN
    : '('
    ;

RPAREN
    : ')'
    ;

ADD
    : '+'
    ;

SUB
    : '-'
    ;

MUL
    : '*'
    ;

DIV
    : '/'
    ;

MOD
    : '%'
    ;

POW
    : '**'
    | '^'
    ;

WS
    : [ \r\n\t]+ -> channel(HIDDEN)
    ;