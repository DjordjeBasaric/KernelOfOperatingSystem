#ifndef OS1_PROJEKAT__SEMQ_H
#define OS1_PROJEKAT__SEMQ_H

#include "list.hpp"

class _thread;

class _semQ{
public:

    void put(_thread *t){ blockedThreads.addLast(t); }
    _thread* get(){ return blockedThreads.removeFirst(); }
    bool empty(){ return blockedThreads.peekFirst() == nullptr; }
private:
    List<_thread> blockedThreads;
};

#endif