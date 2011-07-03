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

#ifndef IOSS_Ioss_EdgeBlock_h
#define IOSS_Ioss_EdgeBlock_h

#include <Ioss_CodeTypes.h>
#include <Ioss_Property.h>
#include <Ioss_EntityBlock.h>
#include <string>

namespace Ioss {
  class DatabaseIO;
  class EdgeSet;

  class EdgeBlock : public EntityBlock {
  public:
    friend class EdgeSet;

    EdgeBlock(const DatabaseIO *io_database, const std::string& name,
	      const std::string& edge_type, const std::string& parent_type,
	      size_t edge_count);

    std::string type_string() const {return "EdgeBlock";}
    EntityType type() const {return EDGEBLOCK;}

    const EdgeSet* owner() const {return owner_;}

    void block_membership(std::vector<std::string> &block_members);

    // Handle implicit properties -- These are calcuated from data stored
    // in the grouping entity instead of having an explicit value assigned.
    // An example would be 'element_block_count' for a region.
    Property get_implicit_property(const std::string& name) const;

  protected:
    int internal_get_field_data(const Field& field,
				void *data, size_t data_size) const;

    int internal_put_field_data(const Field& field,
				void *data, size_t data_size) const;
  private:
    // Pointer to the EdgeSet (if any) that contains this edge block.
    const EdgeSet *owner_;
    std::vector<std::string> blockMembership; // What element blocks do the
                                             // elements in this faceset belong to.
  };
}
#endif
