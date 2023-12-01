%{
#define IDENT_LENGTH 2
#define LINE_WIDTH 78

#include <stdio.h>
#include "defs.h"
#include "x.tab.h"
int yylex(void);
int yyerror(const char *txt);
 
void found( const char *nonterminal, const char *value );
void ident(int nesting_lvl);

int level = 0;
int pos = 0;

%}

%union {
	char s[ MAX_STR_LEN + 1 ]; 
    char c;
}

%token<s> PI_TAG_BEG STAG_BEG ETAG_BEG
%token<c> CHAR S
%token PI_TAG_END TAG_END ETAG_END

%type<s> START_TAG END_TAG WORD

%%
DOCUMENT: INTRO ELEMENT;

INTRO: INTRO '\n' PI  | PI ;
PI: PI_TAG_BEG PI_TAG_END ;

ELEMENT: ETAG | TAG_PAIR  ;
ETAG: STAG_BEG ETAG_END ;
TAG_PAIR: START_TAG CONTENT END_TAG ;
START_TAG: STAG_BEG TAG_END ;
END_TAG: ETAG_BEG TAG_END ;

CONTENT: CONTENT CONTENT_ENTRY | /* empty */;
CONTENT_ENTRY: ELEMENT | S | WORD | '\n' ;
WORD: WORD CHAR | CHAR ;

%%

int main( void ){
	return yyparse();
}

int yyerror( const char *txt ){
	printf( "Syntax error %s\n", txt );
    return 0;
}

void ident(int nesting_lvl){

}

