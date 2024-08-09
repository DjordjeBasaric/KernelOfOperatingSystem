//
// Created by basara on 9.8.24..
//

#ifndef OS1_PROJEKAT_MEMORYALLOCATOR_H
#define OS1_PROJEKAT_MEMORYALLOCATOR_H

#include "../lib/hw.h"

struct Mem_Block {
    Mem_Block* next=nullptr;
    Mem_Block* prev=nullptr;
    size_t size;
};


class MemoryAllocator {
public:

    static void* mem_alloc(size_t size);

    static int mem_free(void*);

    static void init_mem(){
        free_Block = (Mem_Block*)HEAP_START_ADDR;
        free_Block->size = (size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR;
        free_Block->next = nullptr;
        free_Block->prev = nullptr;

    }
private:
    static Mem_Block* free_Block;

    //static Data_Block* used_Block;




};


#endif //OS1_PROJEKAT_MEMORYALLOCATOR_H
