// Copyright(C) 1999-2010
// Sandia Corporation. Under the terms of Contract
// DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government retains
// certain rights in this software.
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

#ifndef IOSS_Ioss_DBUsage_h
#define IOSS_Ioss_DBUsage_h

namespace Ioss {

enum DatabaseUsage {
  WRITE_RESTART   =  1,
  READ_RESTART    =  2,
  WRITE_RESULTS   =  4,
  READ_MODEL      =  8,
  WRITE_HISTORY   = 16,
  WRITE_HEARTBEAT = 32
};

 enum IfDatabaseExistsBehavior {
   DB_OVERWRITE,
   DB_APPEND,
   DB_APPEND_GROUP,
   DB_ABORT,
   DB_ADD_SUFFIX,
   DB_ADD_SUFFIX_OVERWRITE}; // Used if topology change in DB_OVERWRITE mode

inline bool is_input_event(Ioss::DatabaseUsage db_usage) {
  return db_usage == Ioss::READ_MODEL || db_usage == Ioss::READ_RESTART;
}

}
#endif // IOSS_Ioss_DBUsage_h
