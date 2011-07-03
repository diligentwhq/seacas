/*
 * Copyright(C) 2008 Sandia Corporation.  Under the terms of Contract
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
#ifndef SIERRA_Excn_ExodusEntity_H
#define SIERRA_Excn_ExodusEntity_H

#define NO_NETCDF_2
#include <exodusII.h>
#include <string>
#include <vector>
#include <iostream>
#include <string.h>
#include <Excn_ObjectType.h>

namespace Excn {
  typedef std::vector<int>  IntVector;
  typedef std::vector<char> DistVector;

  struct Mesh
  {
    Mesh() :   dimensionality(0), nodeCount(0), elementCount(0),
	 blockCount(0), nodesetCount(0), sidesetCount(0) {}
    
    size_t count(ObjectType type) const
    {
      switch(type) {
      case EBLK:
	return blockCount;
      case NSET:
	return nodesetCount;
      case SSET:
	return sidesetCount;
      case NODE:
	return nodeCount;
      case ELEM:
	return elementCount;
      default:
	return 0;
      }
    }
    
    IntVector truthTable[3];

    std::string title;
    int dimensionality;
    int nodeCount;
    int elementCount;
    int blockCount;
    int nodesetCount;
    int sidesetCount;

  };
  
  struct Block
  {
    Block() : id(0), elementCount(0), nodesPerElement(0), attributeCount(0),
	      offset_(0), position_(0), name_("")
    {
      strcpy(elType, "");
    }
    
    Block(const Block &other) : id(other.id), elementCount(other.elementCount),
				nodesPerElement(other.nodesPerElement),
				attributeCount(other.attributeCount), offset_(other.offset_),
				position_(other.position_),
				name_(other.name_)
    {
      strcpy(elType, other.elType);
    }
    
    ~Block() {}
    
    size_t entity_count() const {return elementCount;}
    
    char elType[MAX_STR_LENGTH+1];
    std::string name_;
    std::vector<std::string> attributeNames;
    int id;
    int elementCount;
    int nodesPerElement;
    int attributeCount;
    int offset_;
    int position_;

    Block& operator=(const Block& other) {
      id = other.id;
      elementCount = other.elementCount;
      nodesPerElement = other.nodesPerElement;
      attributeCount  = other.attributeCount;
      attributeNames  = other.attributeNames;
      offset_ = other.offset_;
      position_ = other.position_;
      strcpy(elType, other.elType);
      name_ = other.name_;
      return *this;
    }
  };
  
  struct NodeSet
  {
    NodeSet() : id(0), nodeCount(0), dfCount(0), offset_(0), position_(-1), name_("") {}
    
    int id;
    int nodeCount;
    int dfCount;
    int offset_;
    int position_;
    std::string name_;
    
    IntVector  nodeSetNodes;
    IntVector  nodeOrderMap;
    DistVector distFactors;
    
    size_t entity_count() const {return nodeCount;}

    void dump() const {
      std::cerr << "NodeSet " << id << ", Name: " << name_ << ", " << nodeCount << " nodes, "
		<< dfCount << " df,\torder = " << position_ << "\n";
    }

    void dump_order() const {
      dump();
      for (int i=0; i < nodeCount; i++) {
	std::cerr << nodeOrderMap[i] << ", ";
      }
      std::cerr << "\n";
    }
  };
  
  typedef std::pair<int,int> Side;
  struct SideSet
  {
    SideSet() : id(0), sideCount(0), dfCount(0), offset_(-1), position_(-1), name_("") {}
    
    int id;
    int sideCount;
    int dfCount;
    int offset_;
    int position_;
    std::string name_;
    
    IntVector  elems;
    IntVector  sides;
    DistVector distFactors;
    
    size_t entity_count() const {return sideCount;}

    void dump() const {
      std::cerr << "SideSet " << id << ", Name: " << name_ << ", " << sideCount << " sides, "
		<< dfCount << " df\toffset = " << offset_ << ", order = " << position_ << "\n";
    }
  };
  
  struct CommunicationMap
  {
    CommunicationMap() : id(0), entityCount(0), type('U') {}
    CommunicationMap(int the_id, int count, char the_type) :
      id(the_id), entityCount(count), type(the_type) {}
    int id;
    int entityCount;
    char type; // 'n' for node, 'e' for element
  };

  struct CommunicationMetaData
  {
    CommunicationMetaData() : processorId(0), processorCount(0),
	 globalNodes(0), globalElements(0),
	 nodesInternal(0), nodesBorder(0), nodesExternal(0),
	 elementsInternal(0), elementsBorder(0) {}
    
    std::vector<CommunicationMap> nodeMap;
    std::vector<CommunicationMap> elementMap;

    int processorId;
    int processorCount;
    int globalNodes;
    int globalElements;
    int nodesInternal;
    int nodesBorder;
    int nodesExternal;
    int elementsInternal;
    int elementsBorder;
    
    private:
    CommunicationMetaData(const CommunicationMetaData &);
  };
  
}
#endif /* SIERRA_Excn_ExodusEntity_H */

