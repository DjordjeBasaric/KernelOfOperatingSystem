#include "../h/riscv.hpp"
#include "../h/_thread.hpp"
#include "../h/syscall_c.hpp"
#include "../h/print.hpp"

thread_t nitA;
thread_t nitB;
thread_t nitC;

void fa(void*){
    //running je nitA
    //threadJoin(nitB);
    for(int i=0;i<10;i++){
        printString("A\n");

    }
    printString("\n");
    _thread::running->setFinished(true);
    thread_dispatch();
}

void fb(void*){
    //threadJoin(nitC);
    for(int i=0;i<10;i++){
        printString("B\n");

    }
    printString("\n");
    _thread::running->setFinished(true);
    thread_dispatch();
}

void fc(void*){
    for(int i=0;i<10;i++){
        printString("C\n");

    }
    printString("\n");

    _thread::running->setFinished(true);
    thread_dispatch();
}

void wrapper(void* arg){
    thread_create(&nitA, fa, nullptr);
    thread_create(&nitB, fb, nullptr);
    thread_create(&nitC, fc, nullptr);

    while(!nitA->isFinished() || !nitB->isFinished() || !nitC->isFinished()){
        thread_dispatch();
    }

    printString("ZAVRSENA JE WRAPPER FJA\n");
    _thread::running->setFinished(true);
    thread_dispatch();
}

int main()
{
    Riscv::w_stvec((uint64) &Riscv::interruptRoutine);    //upisuje adresu prekidne rutine

    thread_t thread1;
    //idle nit(nit koja nema fju koja treba da izvrsava)
    thread_create(&thread1, nullptr, nullptr);
    _thread::running = thread1;

    thread_t thread2;
    thread_create(&thread2, wrapper, nullptr);

    while (!(thread2->isFinished())) {
        thread_dispatch();
    }

    return 0;
}
