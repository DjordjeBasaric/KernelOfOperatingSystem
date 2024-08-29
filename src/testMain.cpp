#include "../h/syscall_cpp.hpp"

static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;

class WorkA: public Thread {
    void workBodyA(void* arg);
    void mod_fun_A(void* arg);
public:
    WorkA():Thread() {}

    void run() override {
        //workBodyA(nullptr);
        mod_fun_A(nullptr);
    }
};

class WorkB: public Thread {
    void workBodyB(void* arg);
    void mod_fun_B(void* arg);
public:
    WorkB():Thread() {}

    void run() override {
        //workBodyB(nullptr);
        mod_fun_B(nullptr);
    }
};

class WorkC: public Thread {
    void workBodyC(void* arg);
public:
    WorkC():Thread() {}

    void run() override {
        workBodyC(nullptr);
    }
};

void WorkA::workBodyA(void *arg) {
    //printString("Ovo je nit broj = ");
    //printInt(getId());
    int id;
    for (uint64 i = 0; i < 5; i++) {
        id = getId();
        printString("threadA: Myid=");
        printInt(id);
        printString("\n");
    }
    printString("A finished!\n");
    finishedA = true;
}

void WorkB::workBodyB(void *arg) {
    //printString("Ovo je nit broj = ");
    //printInt(getId());
    int id;
    for (uint64 i = 0; i < 5; i++) {
        id = getId();
        printString("threadB: Myid=");
        printInt(id);
        printString("\n");
    }
    printString("B finished!\n");
    finishedA = true;
}

void WorkC::workBodyC(void *arg) {
    //printString("Ovo je nit broj = ");
    //printInt(getId());
    int id;
    for (uint64 i = 0; i < 5; i++) {
        id = getId();
        printString("threadC: Myid=");
        printInt(id);
        printString("\n");
    }
    printString("C finished!\n");

    finishedA = true;

}

void testMainGetId() {
    Thread* threads[4];

    threads[0] = new WorkA();
    printString("ThreadA created\n");

    threads[1] = new WorkB();
    printString("ThreadB created\n");

    threads[2] = new WorkC();
    printString("ThreadC created\n");


    for(int i=0; i<3; i++) {
        threads[i]->start();
    }

    while (!(finishedA && finishedB && finishedC)) {
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }

}


void testMaxThreads(){
    Thread* threads[20];
    Thread::SetMaximumThreads(3);


    for(int i=0; i<20; i++) {
        threads[i] = new WorkA();
    }

    for(int i=0; i<20; i++) {
        threads[i]->start();
    }

    while (!(finishedA && finishedB && finishedC)) {
        Thread::dispatch();
    }

    for (auto thread: threads) { delete thread; }

}


void WorkA::mod_fun_A(void *arg)
{
    for (uint64 i = 0; i < 10; i++)
    {
        printString("A: i=");
        printInt(i);
        printString("\n");

        for (uint64 j = 0; j < 10000; j++)
        {
            for (uint64 k = 0; k < 30000; k++)
            {
                /* busy wait */
            }

            thread_dispatch();
        }
    }

    printString("A finished!\n");
    finishedA = true;
}

void WorkB::mod_fun_B(void *arg)
{
    for (uint64 i = 0; i < 16; i++)
    {
        printString("B: i=");
        printInt(i);
        printString("\n");

        for (uint64 j = 0; j < 10000; j++)
        {
            for (uint64 k = 0; k < 30000; k++)
            {
                /* busy wait */
            }

            thread_dispatch();
        }
    }

    printString("B finished!\n");
    finishedB = true;
    thread_dispatch();
}


int testMainJoin()
{
    /* Modifikacija */
    Thread* threads[2];

    threads[0] = new WorkA();
    printString("ThreadA created\n");

    threads[1] = new WorkB();
    printString("ThreadB created\n");

    for(int i = 0; i < 2; i++)
        threads[i]->start();

    threads[0]->join(); // Blokiraj main nit(u ovom slucaju) dok se nit 0 ne zavrsi
    threads[1]->join(); // Blokiraj main nit(u ovom slucaju) dok se nit 1 ne zavrsi

    for (auto thread: threads)
        delete thread;

    printString("Main Stopped\n");

    return 0;
}
