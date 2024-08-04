//
// Created by marko on 20.4.22..
//

#ifndef OS_PROJEKAT_SCHEDULER_HPP
#define OS_PROJEKAT_SCHEDULER_HPP

#include "list.hpp"

class _thread;

class Scheduler
{
private:
    static List<_thread> readyCoroutineQueue;

public:
    static _thread *get();

    static void put(_thread *_thread);

};

#endif //OS_PROJEKAT_SCHEDULER_HPP