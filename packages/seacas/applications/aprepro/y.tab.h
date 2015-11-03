/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUM = 258,
    QSTRING = 259,
    UNDVAR = 260,
    VAR = 261,
    SVAR = 262,
    IMMVAR = 263,
    IMMSVAR = 264,
    AVAR = 265,
    FNCT = 266,
    SFNCT = 267,
    AFNCT = 268,
    EQ_PLUS = 269,
    EQ_MINUS = 270,
    EQ_TIME = 271,
    EQ_DIV = 272,
    EQ_POW = 273,
    LOR = 274,
    LAND = 275,
    LE = 276,
    GE = 277,
    EQ = 278,
    NE = 279,
    UNARY = 280,
    NOT = 281,
    POW = 282,
    INC = 283,
    DEC = 284,
    CONCAT = 285
  };
#endif
/* Tokens.  */
#define NUM 258
#define QSTRING 259
#define UNDVAR 260
#define VAR 261
#define SVAR 262
#define IMMVAR 263
#define IMMSVAR 264
#define AVAR 265
#define FNCT 266
#define SFNCT 267
#define AFNCT 268
#define EQ_PLUS 269
#define EQ_MINUS 270
#define EQ_TIME 271
#define EQ_DIV 272
#define EQ_POW 273
#define LOR 274
#define LAND 275
#define LE 276
#define GE 277
#define EQ 278
#define NE 279
#define UNARY 280
#define NOT 281
#define POW 282
#define INC 283
#define DEC 284
#define CONCAT 285

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 53 "aprepro.y" /* yacc.c:1909  */

  double  val;          /* For returning numbers.               */
  symrec *tptr;         /* For returning symbol-table pointers  */
  char   *string;       /* For returning quoted strings         */
  array  *array;

#line 121 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
