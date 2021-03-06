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

#include <Ioss_Field.h>
#include <Ioss_VariableType.h>
#include <stddef.h>
#include <transform/Iotr_Offset.h>
#include <string>

#include "Ioss_Transform.h"

namespace Iotr {

  const Offset_Factory* Offset_Factory::factory()
  {
    static Offset_Factory registerThis;
    return &registerThis;
  }

  Offset_Factory::Offset_Factory()
    : Factory("offset")
  {
    Factory::alias("offset", "add");
  }

  Ioss::Transform* Offset_Factory::make(const std::string&) const
  { return new Offset(); }

  Offset::Offset()
    : intOffset(0), realOffset(0.0)
  {}

  void Offset::set_property(const std::string&, int value)
  { intOffset = value; }

  void Offset::set_property(const std::string&, double value)
  { realOffset = value; }

  const Ioss::VariableType
  *Offset::output_storage(const Ioss::VariableType *in) const
  {
    return in;
  }

  int Offset::output_count(int in) const
  {
    // Does not modify the entity count...
    return in;
  }

  bool Offset::internal_execute(const Ioss::Field &field, void *data)
  {
    size_t count = field.transformed_count();
    int components = field.transformed_storage()->component_count();

    if (field.get_type() == Ioss::Field::REAL) {
      double *rdata = static_cast<double*>(data);

      for (size_t i = 0; i < count*components; i++) {
	rdata[i] = rdata[i] + realOffset;
      }
    } else if (field.get_type() == Ioss::Field::INTEGER) {
      int *idata = static_cast<int*>(data);

      for (size_t i = 0; i < count*components; i++) {
	idata[i] = idata[i] + intOffset;
      }
    } else {
    }
    return true;
  }
}
