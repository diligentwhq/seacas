// Copyright(C) 2008 Sandia Corporation.  Under the terms of Contract
// DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
// certain rights in this software
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
// 
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
// 
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
// 
//     * Neither the name of Sandia Corporation nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// 
// $Id: exo_entity.h,v 1.1 2008/10/31 05:04:08 gdsjaar Exp $

#ifndef EXO_ENTITY_H
#define EXO_ENTITY_H

#include <iostream>
#include <string>
#include <exodusII.h>

#if defined(EX_API_VERS_NODOT)
#if EX_API_VERS_NODOT > 467
typedef ex_entity_type EXOTYPE;
#else
typedef int EXOTYPE;
#endif
#else
typedef int EXOTYPE;
#endif


class ExoII_Read;

class Exo_Entity {
 public:
  Exo_Entity();
  Exo_Entity(int file_id, int exo_id);
  Exo_Entity(int file_id, int exo_id, int num_entity);
  virtual ~Exo_Entity();

  int  Size() const  {return numEntity;}

  int  Id() const    {return id_;}
  int  Index() const {return index_;}
  
  void Display_Stats(std::ostream& = std::cout);
  void Display      (std::ostream& = std::cout);
  int  Check_State() const;
  
  void initialize(int file_id, int id);

  bool          is_valid_var(int var_index) const;
  int           var_count() const {return numVars;}
  std::string   Load_Results(int time_step_num, int var_index);
  const double* Get_Results(int var_index) const;
  void          Free_Results();

 protected:
  int fileId;
  int id_;
  int index_;          // 0-offset index into Exodus nodeset list.
  int numEntity;      // Number of items (nodes, sides, elements) 
  
  
 private:
  Exo_Entity(const Exo_Entity&);  // Not written.
  const Exo_Entity& operator=(const Exo_Entity&);  // Not written.
  
  virtual void entity_load_params() = 0;
  void internal_load_params();

  // Return "E", "N", "M", "S" depending on underlying type.
  virtual const char* exodus_flag() const = 0;

  // Return "Element Block", "Nodeset", "Sideset, depending on underlying type.
  virtual const char* label() const = 0;

  // Return EX_ELEM_BLOCK, EX_NODE_SET, ... of underlying type
  virtual EXOTYPE exodus_type() const = 0;
  
  void get_truth_table() const;

  mutable int* truth_;           // Array; holds local truth table for this entity
  int      currentStep;     // Time step number of the current results.
  int      numVars;        // Total number of variables in the file.
  double** results_;      // Array of pointers (length num_vars)
                         // to arrays of results (length num_entity).
  
  friend class ExoII_Read;

};
#endif
