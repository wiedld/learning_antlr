grammar sqlite3;

parse
    : (sql_statement ';')* EOF
    ;

////////////////////////////////////////
// statements

sql_statement
    : query_stmt
    | delete_stmt
    | drop_table_stmt
    ;

query_stmt
    : LPAREN query_stmt RPAREN
    | SELECT fields FROM (query_stmt|IDENTIFIER) (WHERE logic_expn)? (GROUP_BY IDENTIFIER)? (HAVING logic_expn)? (ORDER_BY IDENTIFIER)?
    ;

delete_stmt
    : DELETE IDENTIFIER FROM IDENTIFIER (WHERE logic_expn)?
    ;

drop_table_stmt
    : DROP_TABLE IDENTIFIER
    ;

////////////////////////////////////////
// expressions

fields
    : fields ',' fields
    | IDENTIFIER
    ;

keyword
    : DELETE
    | DROP_TABLE
    | SELECT
    | FROM
    | WHERE
    | GROUP_BY
    | HAVING
    | ORDER_BY
    ;

logic_expn
    : logic_expn conjunction logic_expn
    | IDENTIFIER logic_symbol (IDENTIFIER|comparison_num)
    ;

logic_symbol
    : GT | LT | GE | LE | EQ | NOT_EQ
    ;

conjunction
    : OR | AND
    ;

comparison_num
    : comparison_num math_op comparison_num
    | NUM
    ;

math_op
    : ADD | SUB | MUL | DIV | POW
    ;

////////////////////////////////////////
// tokens

// INSERT
// CREATE_TABLE

DELETE:     [dD][eE][lL][eE][tT][eE];

DROP_TABLE: [dD][rR][oO][pP](' ')[tT][aA][bB][lL][eE];
SELECT:     [sS][eE][lL][eE][cC][tT];
FROM:       [fF][rR][oO][mM];
WHERE:      [wW][hH][eE][rR][eE];
GROUP_BY:   [gG][rR][oO][uU][pP](' ')[bB][yY];
HAVING:     [hH][aA][vV][iI][nN][gG];
ORDER_BY:   [oO][rR][dD][eE][rR](' ')[bB][yY];

SINGLE_LINE_COMMENT
    : ('--') (.)*? [\n] -> channel(HIDDEN)
    ;

MULTI_LINE_COMMENT
    : ('/*') (.)*? ('*/' | EOF) -> channel(HIDDEN)
    ;

// conjunctions
OR: '||';
AND: '&&';

// logic operators
GT: '>';
LT: '<';
GE: '>=';
LE: '<=';
EQ: '=' | '==';
NOT_EQ: '!=' | '!==' | '<>';

// math operators
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
POW: '**' | '^';

NUM
    : [0-9] ('.'[0-9])?
    ;

IDENTIFIER
    : [a-zA-Z]([a-zA-Z0-9]+)
    ;

SPACES
    : [ \B\t\r\n] -> channel(HIDDEN)
    ;

LPAREN: '(';
RPAREN: ')';
