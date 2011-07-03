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
#ifndef EXODIFF_MAP_H
#define EXODIFF_MAP_H
#include "exoII_read.h"

enum MAP_TYPE_enum {FILE_ORDER=0, PARTIAL, USE_FILE_IDS, DISTANCE};

void Compute_Maps(int*& node_map, int*& elmt_map,
                  ExoII_Read& file1, ExoII_Read& file2);
void Compute_Partial_Maps(int*& node_map, int*& elmt_map,
			  ExoII_Read& file1, ExoII_Read& file2);
void Compute_FileId_Maps(int*& node_map, int*& elmt_map,
			 ExoII_Read& file1, ExoII_Read& file2);
void Dump_Maps(const int *node_map, const int *elmt_map, ExoII_Read& file1);
bool Check_Maps(const int *node_map, const int *elmt_map, ExoII_Read& file1);
bool Compare_Maps(ExoII_Read& file1, ExoII_Read& file2, const int *node_map, const int *elmt_map, bool partial_flag);

#endif
