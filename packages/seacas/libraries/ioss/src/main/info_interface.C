/*
 * Copyright(C) 2010 Sandia Corporation.  Under the terms of Contract
 * DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
 * certain rights in this software
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 * 
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 * 
 *     * Neither the name of Sandia Corporation nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 */
#include "info_interface.h"
#include <stddef.h>                     // for NULL
#include <cstdlib>                      // for exit, EXIT_SUCCESS, getenv
#include <iostream>                     // for operator<<, basic_ostream, etc
#include <string>                       // for char_traits, string
#include "Ioss_GetLongOpt.h"            // for GetLongOption, etc




Info::Interface::Interface()
  : checkNodeStatus_(false), computeVolume_(false), adjacencies_(false),
    ints64Bit_(false), computeBBox_(false), listGroups_(false),
    useGenericNames_(false), fieldSuffixSeparator_('_'), summary_(0),
    surfaceSplitScheme_(1), minimumTime_(0.0), maximumTime_(0.0),
    cwd_(""), filetype_("exodus")
{
  enroll_options();
}

Info::Interface::~Interface() {}

void Info::Interface::enroll_options()
{
  options_.usage("[options] basename");

  options_.enroll("help", Ioss::GetLongOption::NoValue,
		  "Print this summary and exit", 0);

  options_.enroll("version", Ioss::GetLongOption::NoValue,
		  "Print version and exit", NULL);

  options_.enroll("check_node_status", Ioss::GetLongOption::NoValue,
		  "Check whether there are any nodes not connected to any elements",
		  NULL);
  options_.enroll("adjacencies", Ioss::GetLongOption::NoValue,
		  "Calculate which element blocks touch which surfaces and other element blocks",
		  NULL);
  options_.enroll("64-bit", Ioss::GetLongOption::NoValue,
		  "True if using 64-bit integers",
		  NULL);
  options_.enroll("compute_volume", Ioss::GetLongOption::NoValue,
		  "Compute the volume of all hex elements in the mesh. Outputs min/max and count",
		  NULL);
  options_.enroll("compute_bbox", Ioss::GetLongOption::NoValue,
		  "Compute the bounding box of all element blocks in the mesh.",
		  NULL);

  options_.enroll("list_groups", Ioss::GetLongOption::NoValue,
		  "Print a list of the names of all groups in this file and then exit.",
		  NULL);

  options_.enroll("field_suffix_separator", Ioss::GetLongOption::MandatoryValue,
		  "Character used to separate a field suffix from the field basename\n"
		  "\t\t when recognizing vector, tensor fields. Enter '0' for no separaor", "_");

  options_.enroll("db_type", Ioss::GetLongOption::MandatoryValue,
		  "Database Type: exodus, generated","exodusii");

  options_.enroll("group_name", Ioss::GetLongOption::MandatoryValue,
                 "List information only for the specified group.",
                 NULL);

  options_.enroll("use_generic_names", Ioss::GetLongOption::NoValue,
		  "True to use generic names (type_id) instead of names in database",
		  NULL);

  options_.enroll("summary", Ioss::GetLongOption::NoValue,
		  "Only output counts of nodes, elements, and entities",
		  NULL);
  
  options_.enroll("surface_split_scheme", Ioss::GetLongOption::MandatoryValue,
		  "Method used to split sidesets into homogenous blocks\n"
		  "\t\tOptions are: TOPOLOGY, BLOCK, NOSPLIT",
		  "TOPOLOGY");

  options_.enroll("copyright", Ioss::GetLongOption::NoValue,
		  "Show copyright and license data.",
		  NULL);
}

bool Info::Interface::parse_options(int argc, char **argv)
{
#if (__SUNPRO_CC == 0x500)
  using namespace std;
#endif

  // Get options from environment variable also...
  char *options = getenv("IO_INFO_OPTIONS");
  if (options != NULL) {
    std::cerr << "\nThe following options were specified via the IO_INFO_OPTIONS environment variable:\n"
	      << "\t" << options << "\n\n";
    options_.parse(options, options_.basename(*argv));
  }

  int option_index = options_.parse(argc, argv);
  if ( option_index < 1 )
    return false;

  if (options_.retrieve("help")) {
    options_.usage();
    std::cerr << "\n\tCan also set options via IO_INFO_OPTIONS environment variable.\n\n";
    std::cerr << "\n\t->->-> Send email to gdsjaar@sandia.gov for epu support.<-<-<-\n";
    exit(EXIT_SUCCESS);
  }

  if (options_.retrieve("version")) {
    // Version is printed up front, just exit...
    exit(0);
  }
  
  if (options_.retrieve("check_node_status")) {
    checkNodeStatus_ = true;
  }

  if (options_.retrieve("adjacencies")) {
    adjacencies_ = true;
  }

  if (options_.retrieve("64-bit")) {
    ints64Bit_ = true;
  }

  if (options_.retrieve("compute_volume")) {
    computeVolume_ = true;
  }

  if (options_.retrieve("compute_bbox")) {
    computeBBox_ = true;
  }

  if (options_.retrieve("list_groups")) {
    listGroups_ = true;
  }

  if (options_.retrieve("use_generic_names")) {
    useGenericNames_ = true;
  }

  if (options_.retrieve("summary")) {
    summary_ = 1;
  }

  {
    const char *temp = options_.retrieve("db_type");
    if (temp != NULL) {
      filetype_ = temp;
    }
  }

  {
    const char *temp = options_.retrieve("group_name");
    if (temp != NULL) {
      groupname_ = temp;
    }
  }

  {
    const char *temp = options_.retrieve("field_suffix_separator");
    if (temp != NULL) {
      fieldSuffixSeparator_ = temp[0];
    }
  }

  if (options_.retrieve("copyright")) {
    std::cerr << "\n"
	      << "Copyright(C) 2012 Sandia Corporation.  Under the terms of Contract\n"
	      << "DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains\n"
	      << "certain rights in this software\n"
	      << "\n"
	      << "Redistribution and use in source and binary forms, with or without\n"
	      << "modification, are permitted provided that the following conditions are\n"
	      << "met:\n"
	      << "\n"
	      << "    * Redistributions of source code must retain the above copyright\n"
	      << "      notice, this list of conditions and the following disclaimer.\n"
	      << "\n"
	      << "    * Redistributions in binary form must reproduce the above\n"
	      << "      copyright notice, this list of conditions and the following\n"
	      << "      disclaimer in the documentation and/or other materials provided\n"
	      << "      with the distribution.\n"
	      << "\n"
	      << "    * Neither the name of Sandia Corporation nor the names of its\n"
	      << "      contributors may be used to endorse or promote products derived\n"
	      << "      from this software without specific prior written permission.\n"
	      << "\n"
	      << "THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS\n"
	      << "'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT\n"
	      << "LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR\n"
	      << "A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT\n"
	      << "OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,\n"
	      << "SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT\n"
	      << "LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,\n"
	      << "DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY\n"
	      << "THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n"
	      << "(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE\n"
	      << "OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n\n";
    exit(EXIT_SUCCESS);
  }  
  
  // Parse remaining options as directory paths.
  if (option_index < argc) {
    filename_ = argv[option_index];
  } else {
    std::cerr << "\nERROR: filename not specified\n\n";
    return false;
  }
  return true;
}

