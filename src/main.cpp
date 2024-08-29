#include "../h/riscv.hpp"
#include "../h/_thread.hpp"
#include "../h/MemoryAllocator.h"
#include "../h/syscall_c.hpp"


//extern void userMain();
extern void testMainGetId();
extern void testMaxThreads();
extern void testMainJoin();


void mainWrapper(void*){
    //userMain();
}

void testWrapper(void*){
    //testMain();
    //testMaxThreads(); //NAPRAVLJENO ZA MAXTHREAD
    testMainJoin();
}

int main()
{
    MemoryAllocator::init_mem();
    Riscv::w_stvec((uint64) &Riscv::interruptRoutine);
    Riscv::ms_sstatus (Riscv:: SSTATUS_SIE);


    thread_t thread1;

    thread_create(&thread1, nullptr, nullptr);
    _thread::running = thread1;


    thread_t thread2;

    //thread_create(&thread2, mainWrapper, nullptr);
    thread_create(&thread2, testWrapper, nullptr);

    while (!thread2->isFinished()) {
        thread_dispatch();
    }

    return 0;
}
