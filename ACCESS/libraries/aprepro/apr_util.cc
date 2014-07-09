
#include <ctype.h>                      // for isalnum, isalpha, isupper, etc
#include <errno.h>                      // for errno, EDOM, ERANGE
#include <stddef.h>                     // for size_t
#include <sys/stat.h>                   // for stat, S_ISDIR
#ifdef _WIN32
  #include <fcntl.h>
  #include <io.h>
#else
  #include <unistd.h>                     // for close
#endif
#include <cstdio>                       // for perror
#include <cstdlib>                      // for mkstemp
#include <cstring>                      // for strlen, strcpy, memcpy, etc
#include <iostream>                     // for operator<<, basic_ostream, etc
#include <stack>                        // for stack
#include <string>                       // for operator<<, string
#include <vector>                       // for vector
#include "aprepro.h"                    // for file_rec, Aprepro, symrec, etc
#include "aprepro_parser.h"             // for Parser, Parser::token, etc

#if !defined(S_ISDIR) && defined(_WIN32)
  #define S_ISDIR(mode) (((mode) & S_IFMT) == S_IFDIR)
#endif

namespace {
  std::vector<char*> allocations;
}

namespace SEAMS {
  extern Aprepro *aprepro;

  bool arg_check(SEAMS::symrec *symbol, bool is_null) {
    if (is_null) {
      std::cerr << "Aprepro: ERROR:  "
		<< "Incorrect argument count/type for function '" 
		<< symbol->name << "'.\n"
		<< "                 "
		<< "The correct syntax is " << symbol->syntax << " ("
		<< aprepro->ap_file_list.top().name<< ", line "
		<< aprepro->ap_file_list.top().lineno + 1 << ")\n";
      return false;
    }
    return true;
  }

  void set_type(const SEAMS::Aprepro &apr, SEAMS::symrec* var, int type)
  {
    if (var->name[0] == '_' || !apr.state_is_immutable()) {
      var->type = type;
    } else {
      if (type == Parser::token::VAR)
	var->type = Parser::token::IMMVAR;
      else if (type == Parser::token::SVAR)
	var->type = Parser::token::IMMSVAR;
      else
	var->type = type;
    }
  }

  void new_string(const char *from, char **to)
  {
    int len=strlen(from);
    *to = new char[len+1];
    std::memcpy(*to, from, len+1);
    allocations.push_back(*to);
  }

  void concat_string(const char *from1, const char *from2, char **to)
  {
    int len=strlen(from1) + strlen(from2);
    *to = new char[len+1];
    std::strcpy(*to, from1);
    std::strcat(*to, from2);
    allocations.push_back(*to);
  }

  /* This function returns a pointer to a static character array.
   * If called multiple times, the name will change on each call,
   * so don't save the pointer; copy the data it points to if you
   * need to keep it for awhile.
   */
  char *get_temp_filename()
  {
    static char tmp_name[] = "./aprepro_temp_XXXXXX";
    int fd;

    std::strcpy(tmp_name, "./aprepro_temp_XXXXXX");
#if defined(__CYGWIN__) && defined(__NO_CYGWIN_OPTION__) 
    fd = mkstemps(tmp_name, 0);
    close(fd);
#elif defined(_WIN32)
    std::strcpy(tmp_name, _mktemp(tmp_name));
#else
    fd = mkstemp(tmp_name);
    close(fd);
#endif
    return tmp_name;
  }  

  void yyerror (const SEAMS::Aprepro &apr, const std::string &s)
  {
    apr.error(s);
  }

  void immutable_modify(const SEAMS::Aprepro &apr, const SEAMS::symrec *var)
  {
    apr.error("(IMMUTABLE) Variable " + var->name +
              " is immutable and cannot be modified", true, false);
  }

  void undefined_warning (const SEAMS::Aprepro &apr, const std::string &var)
  {
    apr.warning("Undefined variable '" + var + "'");
  }

  void redefined_warning (const SEAMS::Aprepro &apr, const SEAMS::symrec* var)
  {
    if (var->name[0] != '_' && apr.ap_options.warning_msg) {
      // See if internal or user-defined variable...
      std::string type;
      if (var->isInternal)
	type = "Pre";
      else
	type = "User";

      apr.warning(type + "-defined Variable '" + var->name + "' redefined");
    }
  }

  void warning (const SEAMS::Aprepro &apr, const std::string &s)
  {
    apr.warning(s);
  }

  void math_error(const SEAMS::Aprepro &apr, const char *function)
  {
    if (errno != 0) {
      yyerror(apr, function);
    }
    if (errno == EDOM)
      perror("	DOMAIN error");
    else if (errno == ERANGE)
      perror("	RANGE error");
    else if (errno != 0)
      perror("	Unknown error");
  }

  void math_error(const char *function)
  {
    if (errno != 0) {
      yyerror(*SEAMS::aprepro, function);
    }
    if (errno == EDOM)
      perror("	DOMAIN error");
    else if (errno == ERANGE)
      perror("	RANGE error");
    else if (errno != 0)
      perror("	Unknown error");
  }

  /* Convert string to all lower-case and replace all spaces with '_' */
  void conv_string (char *string)
  {
    char *p = string;
    while (*p != '\0')
      {
	if (*p == ' ')
	  *p = '_';
	else if (isupper ((int)*p))
	  *p = tolower ((int)*p);
	p++;
      }
  }

  void cleanup_memory()
  {
    for (size_t i=0; i < allocations.size(); i++) {
      delete [] allocations[i];
    }

    // Clear the vector to avoid stale pointers.
    allocations.clear();
  }

  bool is_directory(const std::string &filepath)
  {
    struct stat s;
    stat(filepath.c_str(), &s);
    return S_ISDIR(s.st_mode);
  }

  bool check_valid_var(const char *var)
  {
    /* Check that 'var' meets the restriction for a variable name
     * L(:|L|D)*
     * D [0-9]
     * L [A-Za-z_]
     */
  
    int length = strlen(var);
    if (length == 0)
      return false;

    if (!isalpha(var[0]) && var[0] != '_') {
      return false;
    }

    for (int i=1; i < length; i++) {
      char c = var[i];
      if (!isalnum(c) && c != ':' && c != '_')
	return false;
    }
    return true;
  }

}
