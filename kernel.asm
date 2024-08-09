
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	bb013103          	ld	sp,-1104(sp) # 80008bb0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	201040ef          	jal	ra,80004a1c <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN5Riscv13pushRegistersEv>:
#CUVANJE DELA KONTEKSTA PROCESORA
.global _ZN5Riscv13pushRegistersEv
.type _ZN5Riscv13pushRegistersEv, @function
_ZN5Riscv13pushRegistersEv:
    addi sp, sp, -256 //alocirani prostor na steku
    80001020:	f0010113          	addi	sp,sp,-256
    // ra i sp se ne cuvaju ovde, zato sto ih cuvam u contextu
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001024:	00313c23          	sd	gp,24(sp)
    80001028:	02413023          	sd	tp,32(sp)
    8000102c:	02513423          	sd	t0,40(sp)
    80001030:	02613823          	sd	t1,48(sp)
    80001034:	02713c23          	sd	t2,56(sp)
    80001038:	04813023          	sd	s0,64(sp)
    8000103c:	04913423          	sd	s1,72(sp)
    80001040:	04a13823          	sd	a0,80(sp)
    80001044:	04b13c23          	sd	a1,88(sp)
    80001048:	06c13023          	sd	a2,96(sp)
    8000104c:	06d13423          	sd	a3,104(sp)
    80001050:	06e13823          	sd	a4,112(sp)
    80001054:	06f13c23          	sd	a5,120(sp)
    80001058:	09013023          	sd	a6,128(sp)
    8000105c:	09113423          	sd	a7,136(sp)
    80001060:	09213823          	sd	s2,144(sp)
    80001064:	09313c23          	sd	s3,152(sp)
    80001068:	0b413023          	sd	s4,160(sp)
    8000106c:	0b513423          	sd	s5,168(sp)
    80001070:	0b613823          	sd	s6,176(sp)
    80001074:	0b713c23          	sd	s7,184(sp)
    80001078:	0d813023          	sd	s8,192(sp)
    8000107c:	0d913423          	sd	s9,200(sp)
    80001080:	0da13823          	sd	s10,208(sp)
    80001084:	0db13c23          	sd	s11,216(sp)
    80001088:	0fc13023          	sd	t3,224(sp)
    8000108c:	0fd13423          	sd	t4,232(sp)
    80001090:	0fe13823          	sd	t5,240(sp)
    80001094:	0ff13c23          	sd	t6,248(sp)
    ret
    80001098:	00008067          	ret

000000008000109c <_ZN5Riscv12popRegistersEv>:
.type _ZN5Riscv12popRegistersEv, @function
_ZN5Riscv12popRegistersEv:
    // https://sourceware.org/binutils/docs/as/Irp.html
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp) //oslobadjanje prostora
    .endr
    8000109c:	01813183          	ld	gp,24(sp)
    800010a0:	02013203          	ld	tp,32(sp)
    800010a4:	02813283          	ld	t0,40(sp)
    800010a8:	03013303          	ld	t1,48(sp)
    800010ac:	03813383          	ld	t2,56(sp)
    800010b0:	04013403          	ld	s0,64(sp)
    800010b4:	04813483          	ld	s1,72(sp)
    800010b8:	05013503          	ld	a0,80(sp)
    800010bc:	05813583          	ld	a1,88(sp)
    800010c0:	06013603          	ld	a2,96(sp)
    800010c4:	06813683          	ld	a3,104(sp)
    800010c8:	07013703          	ld	a4,112(sp)
    800010cc:	07813783          	ld	a5,120(sp)
    800010d0:	08013803          	ld	a6,128(sp)
    800010d4:	08813883          	ld	a7,136(sp)
    800010d8:	09013903          	ld	s2,144(sp)
    800010dc:	09813983          	ld	s3,152(sp)
    800010e0:	0a013a03          	ld	s4,160(sp)
    800010e4:	0a813a83          	ld	s5,168(sp)
    800010e8:	0b013b03          	ld	s6,176(sp)
    800010ec:	0b813b83          	ld	s7,184(sp)
    800010f0:	0c013c03          	ld	s8,192(sp)
    800010f4:	0c813c83          	ld	s9,200(sp)
    800010f8:	0d013d03          	ld	s10,208(sp)
    800010fc:	0d813d83          	ld	s11,216(sp)
    80001100:	0e013e03          	ld	t3,224(sp)
    80001104:	0e813e83          	ld	t4,232(sp)
    80001108:	0f013f03          	ld	t5,240(sp)
    8000110c:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001110:	10010113          	addi	sp,sp,256
    ret
    80001114:	00008067          	ret

0000000080001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>:
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_
.type _ZN7_thread13contextSwitchEPNS_7ContextES1_, @function
_ZN7_thread13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0) #iz ra cuvam u a0, to a0 je old->context.ra
    80001118:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    8000111c:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1) #iz running->context.ra cuvam u ra
    80001120:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    80001124:	0085b103          	ld	sp,8(a1)

    80001128:	00008067          	ret
    8000112c:	0000                	unimp
	...

0000000080001130 <_ZN5Riscv16interruptRoutineEv>:
.global _ZN5Riscv16interruptRoutineEv // da bi definicija bila vidljiva od svih
.type _ZN5Riscv16interruptRoutineEv, @function
_ZN5Riscv16interruptRoutineEv: #kad se ovde uradi name manling onda se normalno citaju odavde funckije

    # cuvanje vrednosti registara na stek
    addi sp, sp, -256
    80001130:	f0010113          	addi	sp,sp,-256
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    sd x\index, \index * 8(sp)
    .endr
    80001134:	00013023          	sd	zero,0(sp)
    80001138:	00113423          	sd	ra,8(sp)
    8000113c:	00213823          	sd	sp,16(sp)
    80001140:	00313c23          	sd	gp,24(sp)
    80001144:	02413023          	sd	tp,32(sp)
    80001148:	02513423          	sd	t0,40(sp)
    8000114c:	02613823          	sd	t1,48(sp)
    80001150:	02713c23          	sd	t2,56(sp)
    80001154:	04813023          	sd	s0,64(sp)
    80001158:	04913423          	sd	s1,72(sp)
    8000115c:	04b13c23          	sd	a1,88(sp)
    80001160:	06c13023          	sd	a2,96(sp)
    80001164:	06d13423          	sd	a3,104(sp)
    80001168:	06e13823          	sd	a4,112(sp)
    8000116c:	06f13c23          	sd	a5,120(sp)
    80001170:	09013023          	sd	a6,128(sp)
    80001174:	09113423          	sd	a7,136(sp)
    80001178:	09213823          	sd	s2,144(sp)
    8000117c:	09313c23          	sd	s3,152(sp)
    80001180:	0b413023          	sd	s4,160(sp)
    80001184:	0b513423          	sd	s5,168(sp)
    80001188:	0b613823          	sd	s6,176(sp)
    8000118c:	0b713c23          	sd	s7,184(sp)
    80001190:	0d813023          	sd	s8,192(sp)
    80001194:	0d913423          	sd	s9,200(sp)
    80001198:	0da13823          	sd	s10,208(sp)
    8000119c:	0db13c23          	sd	s11,216(sp)
    800011a0:	0fc13023          	sd	t3,224(sp)
    800011a4:	0fd13423          	sd	t4,232(sp)
    800011a8:	0fe13823          	sd	t5,240(sp)
    800011ac:	0ff13c23          	sd	t6,248(sp)

     #pozivanje hendlera da ne bi pisali u asembleru
     # static void Riscv::handleSupervisorTrap
     call _ZN5Riscv23interruptRoutineHandlerEv
    800011b0:	478000ef          	jal	ra,80001628 <_ZN5Riscv23interruptRoutineHandlerEv>

    # vrati vrednosti registara sa steka
    .irp index, 0,1,2,3,4,5,6,7,8,9,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
    ld x\index, \index * 8(sp)
    .endr
    800011b4:	00013003          	ld	zero,0(sp)
    800011b8:	00813083          	ld	ra,8(sp)
    800011bc:	01013103          	ld	sp,16(sp)
    800011c0:	01813183          	ld	gp,24(sp)
    800011c4:	02013203          	ld	tp,32(sp)
    800011c8:	02813283          	ld	t0,40(sp)
    800011cc:	03013303          	ld	t1,48(sp)
    800011d0:	03813383          	ld	t2,56(sp)
    800011d4:	04013403          	ld	s0,64(sp)
    800011d8:	04813483          	ld	s1,72(sp)
    800011dc:	05813583          	ld	a1,88(sp)
    800011e0:	06013603          	ld	a2,96(sp)
    800011e4:	06813683          	ld	a3,104(sp)
    800011e8:	07013703          	ld	a4,112(sp)
    800011ec:	07813783          	ld	a5,120(sp)
    800011f0:	08013803          	ld	a6,128(sp)
    800011f4:	08813883          	ld	a7,136(sp)
    800011f8:	09013903          	ld	s2,144(sp)
    800011fc:	09813983          	ld	s3,152(sp)
    80001200:	0a013a03          	ld	s4,160(sp)
    80001204:	0a813a83          	ld	s5,168(sp)
    80001208:	0b013b03          	ld	s6,176(sp)
    8000120c:	0b813b83          	ld	s7,184(sp)
    80001210:	0c013c03          	ld	s8,192(sp)
    80001214:	0c813c83          	ld	s9,200(sp)
    80001218:	0d013d03          	ld	s10,208(sp)
    8000121c:	0d813d83          	ld	s11,216(sp)
    80001220:	0e013e03          	ld	t3,224(sp)
    80001224:	0e813e83          	ld	t4,232(sp)
    80001228:	0f013f03          	ld	t5,240(sp)
    8000122c:	0f813f83          	ld	t6,248(sp)
    addi sp, sp, 256
    80001230:	10010113          	addi	sp,sp,256

    sret
    80001234:	10200073          	sret
	...

0000000080001240 <_Znwm>:
#include "../h/MemoryAllocator.h"

using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    80001240:	ff010113          	addi	sp,sp,-16
    80001244:	00113423          	sd	ra,8(sp)
    80001248:	00813023          	sd	s0,0(sp)
    8000124c:	01010413          	addi	s0,sp,16
    //return __mem_alloc(n);
    return MemoryAllocator::mem_alloc(n);
    80001250:	00000097          	auipc	ra,0x0
    80001254:	234080e7          	jalr	564(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001258:	00813083          	ld	ra,8(sp)
    8000125c:	00013403          	ld	s0,0(sp)
    80001260:	01010113          	addi	sp,sp,16
    80001264:	00008067          	ret

0000000080001268 <_Znam>:

void *operator new[](size_t n)
{
    80001268:	ff010113          	addi	sp,sp,-16
    8000126c:	00113423          	sd	ra,8(sp)
    80001270:	00813023          	sd	s0,0(sp)
    80001274:	01010413          	addi	s0,sp,16
    //return __mem_alloc(n);
    return MemoryAllocator::mem_alloc(n);
    80001278:	00000097          	auipc	ra,0x0
    8000127c:	20c080e7          	jalr	524(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
}
    80001280:	00813083          	ld	ra,8(sp)
    80001284:	00013403          	ld	s0,0(sp)
    80001288:	01010113          	addi	sp,sp,16
    8000128c:	00008067          	ret

0000000080001290 <_ZdlPv>:

void operator delete(void *p) noexcept
{
    80001290:	ff010113          	addi	sp,sp,-16
    80001294:	00113423          	sd	ra,8(sp)
    80001298:	00813023          	sd	s0,0(sp)
    8000129c:	01010413          	addi	s0,sp,16
    //__mem_free(p);
    MemoryAllocator::mem_free(p);
    800012a0:	00000097          	auipc	ra,0x0
    800012a4:	2ac080e7          	jalr	684(ra) # 8000154c <_ZN15MemoryAllocator8mem_freeEPv>
}
    800012a8:	00813083          	ld	ra,8(sp)
    800012ac:	00013403          	ld	s0,0(sp)
    800012b0:	01010113          	addi	sp,sp,16
    800012b4:	00008067          	ret

00000000800012b8 <_ZdaPv>:

void operator delete[](void *p) noexcept
{
    800012b8:	ff010113          	addi	sp,sp,-16
    800012bc:	00113423          	sd	ra,8(sp)
    800012c0:	00813023          	sd	s0,0(sp)
    800012c4:	01010413          	addi	s0,sp,16
    //__mem_free(p);
    MemoryAllocator::mem_free(p);
    800012c8:	00000097          	auipc	ra,0x0
    800012cc:	284080e7          	jalr	644(ra) # 8000154c <_ZN15MemoryAllocator8mem_freeEPv>
    800012d0:	00813083          	ld	ra,8(sp)
    800012d4:	00013403          	ld	s0,0(sp)
    800012d8:	01010113          	addi	sp,sp,16
    800012dc:	00008067          	ret

00000000800012e0 <_Z41__static_initialization_and_destruction_0ii>:
}

void Scheduler::put(_thread *_thread)
{
    readyCoroutineQueue.addLast(_thread);
    800012e0:	ff010113          	addi	sp,sp,-16
    800012e4:	00813423          	sd	s0,8(sp)
    800012e8:	01010413          	addi	s0,sp,16
    800012ec:	00100793          	li	a5,1
    800012f0:	00f50863          	beq	a0,a5,80001300 <_Z41__static_initialization_and_destruction_0ii+0x20>
    800012f4:	00813403          	ld	s0,8(sp)
    800012f8:	01010113          	addi	sp,sp,16
    800012fc:	00008067          	ret
    80001300:	000107b7          	lui	a5,0x10
    80001304:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80001308:	fef596e3          	bne	a1,a5,800012f4 <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

    Elem *head, *tail;

public:
    List() : head(0), tail(0) {}
    8000130c:	00008797          	auipc	a5,0x8
    80001310:	ab478793          	addi	a5,a5,-1356 # 80008dc0 <_ZN9Scheduler19readyCoroutineQueueE>
    80001314:	0007b023          	sd	zero,0(a5)
    80001318:	0007b423          	sd	zero,8(a5)
    8000131c:	fd9ff06f          	j	800012f4 <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080001320 <_ZN9Scheduler3getEv>:
{
    80001320:	fe010113          	addi	sp,sp,-32
    80001324:	00113c23          	sd	ra,24(sp)
    80001328:	00813823          	sd	s0,16(sp)
    8000132c:	00913423          	sd	s1,8(sp)
    80001330:	02010413          	addi	s0,sp,32
        }
    }

    T *removeFirst()
    {
        if (!head) { return 0; }
    80001334:	00008517          	auipc	a0,0x8
    80001338:	a8c53503          	ld	a0,-1396(a0) # 80008dc0 <_ZN9Scheduler19readyCoroutineQueueE>
    8000133c:	04050263          	beqz	a0,80001380 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001340:	00853783          	ld	a5,8(a0)
    80001344:	00008717          	auipc	a4,0x8
    80001348:	a6f73e23          	sd	a5,-1412(a4) # 80008dc0 <_ZN9Scheduler19readyCoroutineQueueE>
        if (!head) { tail = 0; }
    8000134c:	02078463          	beqz	a5,80001374 <_ZN9Scheduler3getEv+0x54>

        T *ret = elem->data;
    80001350:	00053483          	ld	s1,0(a0)
        delete elem;
    80001354:	00000097          	auipc	ra,0x0
    80001358:	f3c080e7          	jalr	-196(ra) # 80001290 <_ZdlPv>
}
    8000135c:	00048513          	mv	a0,s1
    80001360:	01813083          	ld	ra,24(sp)
    80001364:	01013403          	ld	s0,16(sp)
    80001368:	00813483          	ld	s1,8(sp)
    8000136c:	02010113          	addi	sp,sp,32
    80001370:	00008067          	ret
        if (!head) { tail = 0; }
    80001374:	00008797          	auipc	a5,0x8
    80001378:	a407ba23          	sd	zero,-1452(a5) # 80008dc8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    8000137c:	fd5ff06f          	j	80001350 <_ZN9Scheduler3getEv+0x30>
        if (!head) { return 0; }
    80001380:	00050493          	mv	s1,a0
    return readyCoroutineQueue.removeFirst();
    80001384:	fd9ff06f          	j	8000135c <_ZN9Scheduler3getEv+0x3c>

0000000080001388 <_ZN9Scheduler3putEP7_thread>:
{
    80001388:	fe010113          	addi	sp,sp,-32
    8000138c:	00113c23          	sd	ra,24(sp)
    80001390:	00813823          	sd	s0,16(sp)
    80001394:	00913423          	sd	s1,8(sp)
    80001398:	02010413          	addi	s0,sp,32
    8000139c:	00050493          	mv	s1,a0
        Elem *elem = new Elem(data, 0);
    800013a0:	01000513          	li	a0,16
    800013a4:	00000097          	auipc	ra,0x0
    800013a8:	e9c080e7          	jalr	-356(ra) # 80001240 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    800013ac:	00953023          	sd	s1,0(a0)
    800013b0:	00053423          	sd	zero,8(a0)
        if (tail)
    800013b4:	00008797          	auipc	a5,0x8
    800013b8:	a147b783          	ld	a5,-1516(a5) # 80008dc8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013bc:	02078263          	beqz	a5,800013e0 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    800013c0:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800013c4:	00008797          	auipc	a5,0x8
    800013c8:	a0a7b223          	sd	a0,-1532(a5) # 80008dc8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013cc:	01813083          	ld	ra,24(sp)
    800013d0:	01013403          	ld	s0,16(sp)
    800013d4:	00813483          	ld	s1,8(sp)
    800013d8:	02010113          	addi	sp,sp,32
    800013dc:	00008067          	ret
            head = tail = elem;
    800013e0:	00008797          	auipc	a5,0x8
    800013e4:	9e078793          	addi	a5,a5,-1568 # 80008dc0 <_ZN9Scheduler19readyCoroutineQueueE>
    800013e8:	00a7b423          	sd	a0,8(a5)
    800013ec:	00a7b023          	sd	a0,0(a5)
    800013f0:	fddff06f          	j	800013cc <_ZN9Scheduler3putEP7_thread+0x44>

00000000800013f4 <_GLOBAL__sub_I__ZN9Scheduler19readyCoroutineQueueE>:
    800013f4:	ff010113          	addi	sp,sp,-16
    800013f8:	00113423          	sd	ra,8(sp)
    800013fc:	00813023          	sd	s0,0(sp)
    80001400:	01010413          	addi	s0,sp,16
    80001404:	000105b7          	lui	a1,0x10
    80001408:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    8000140c:	00100513          	li	a0,1
    80001410:	00000097          	auipc	ra,0x0
    80001414:	ed0080e7          	jalr	-304(ra) # 800012e0 <_Z41__static_initialization_and_destruction_0ii>
    80001418:	00813083          	ld	ra,8(sp)
    8000141c:	00013403          	ld	s0,0(sp)
    80001420:	01010113          	addi	sp,sp,16
    80001424:	00008067          	ret

0000000080001428 <_Z9tryToJoinP9Mem_Block>:
#include "../h/MemoryAllocator.h"
#include "../test/printing.hpp"
Mem_Block* MemoryAllocator::free_Block = nullptr;


void tryToJoin(Mem_Block* current_Block){
    80001428:	ff010113          	addi	sp,sp,-16
    8000142c:	00813423          	sd	s0,8(sp)
    80001430:	01010413          	addi	s0,sp,16
    if (!current_Block) return;
    80001434:	02050263          	beqz	a0,80001458 <_Z9tryToJoinP9Mem_Block+0x30>
    if (current_Block->next && current_Block+current_Block->size == current_Block->next){
    80001438:	00053703          	ld	a4,0(a0)
    8000143c:	00070e63          	beqz	a4,80001458 <_Z9tryToJoinP9Mem_Block+0x30>
    80001440:	01053683          	ld	a3,16(a0)
    80001444:	00169793          	slli	a5,a3,0x1
    80001448:	00d787b3          	add	a5,a5,a3
    8000144c:	00379793          	slli	a5,a5,0x3
    80001450:	00f507b3          	add	a5,a0,a5
    80001454:	00f70863          	beq	a4,a5,80001464 <_Z9tryToJoinP9Mem_Block+0x3c>
        current_Block->size += current_Block->next->size;
        current_Block->next = current_Block->next->next;
        if(current_Block->next) current_Block->next->prev = current_Block;
    }
}
    80001458:	00813403          	ld	s0,8(sp)
    8000145c:	01010113          	addi	sp,sp,16
    80001460:	00008067          	ret
        current_Block->size += current_Block->next->size;
    80001464:	01073783          	ld	a5,16(a4)
    80001468:	00f686b3          	add	a3,a3,a5
    8000146c:	00d53823          	sd	a3,16(a0)
        current_Block->next = current_Block->next->next;
    80001470:	00073783          	ld	a5,0(a4)
    80001474:	00f53023          	sd	a5,0(a0)
        if(current_Block->next) current_Block->next->prev = current_Block;
    80001478:	fe0780e3          	beqz	a5,80001458 <_Z9tryToJoinP9Mem_Block+0x30>
    8000147c:	00a7b423          	sd	a0,8(a5)
    80001480:	fd9ff06f          	j	80001458 <_Z9tryToJoinP9Mem_Block+0x30>

0000000080001484 <_ZN15MemoryAllocator9mem_allocEm>:

void *MemoryAllocator::mem_alloc(size_t size) {
    80001484:	ff010113          	addi	sp,sp,-16
    80001488:	00813423          	sd	s0,8(sp)
    8000148c:	01010413          	addi	s0,sp,16
    80001490:	00050713          	mv	a4,a0
    Mem_Block *block = free_Block;
    80001494:	00008517          	auipc	a0,0x8
    80001498:	8ac53503          	ld	a0,-1876(a0) # 80008d40 <_ZN15MemoryAllocator10free_BlockE>
    while(block != nullptr){
    8000149c:	00050a63          	beqz	a0,800014b0 <_ZN15MemoryAllocator9mem_allocEm+0x2c>
        if(block->size >= size) break;
    800014a0:	01053783          	ld	a5,16(a0)
    800014a4:	00e7f663          	bgeu	a5,a4,800014b0 <_ZN15MemoryAllocator9mem_allocEm+0x2c>
        block = block->next;
    800014a8:	00053503          	ld	a0,0(a0)
    while(block != nullptr){
    800014ac:	ff1ff06f          	j	8000149c <_ZN15MemoryAllocator9mem_allocEm+0x18>
    }

    if(block == nullptr){
    800014b0:	04050a63          	beqz	a0,80001504 <_ZN15MemoryAllocator9mem_allocEm+0x80>
        return 0; //Ne moze da se smesti
    }
    size_t remainingSize = block->size - size;
    800014b4:	01053783          	ld	a5,16(a0)
    800014b8:	40e787b3          	sub	a5,a5,a4
    if(remainingSize >= sizeof(Mem_Block) + MEM_BLOCK_SIZE) { //fragment memorije ostaje i ulancavam ga u listu
    800014bc:	05700693          	li	a3,87
    800014c0:	04f6fe63          	bgeu	a3,a5,8000151c <_ZN15MemoryAllocator9mem_allocEm+0x98>
        block->size = size;
    800014c4:	00e53823          	sd	a4,16(a0)
        size_t offset = sizeof(Mem_Block) + size; // velicina samog bloka koji alociram
    800014c8:	01870713          	addi	a4,a4,24
        Mem_Block *new_block = (Mem_Block*)((size_t)block + offset); //(Mem_Block*)((char*)block + offset) adresa blocka + velicina bloka
    800014cc:	00e50733          	add	a4,a0,a4
        if (block->prev) {
    800014d0:	00853683          	ld	a3,8(a0)
    800014d4:	02068e63          	beqz	a3,80001510 <_ZN15MemoryAllocator9mem_allocEm+0x8c>
            block->prev->next = new_block;
    800014d8:	00e6b023          	sd	a4,0(a3)
            new_block->prev = block->prev;
    800014dc:	00853683          	ld	a3,8(a0)
    800014e0:	00d73423          	sd	a3,8(a4)
        } // ovde izbacujem block iz liste freeMem i ubacujem newBlock
        else free_Block = new_block;
        new_block->next = block->next;
    800014e4:	00053683          	ld	a3,0(a0)
    800014e8:	00d73023          	sd	a3,0(a4)
        if(block->next) block->next->prev = new_block;
    800014ec:	00068463          	beqz	a3,800014f4 <_ZN15MemoryAllocator9mem_allocEm+0x70>
    800014f0:	00e6b423          	sd	a4,8(a3)
        new_block->size = remainingSize - sizeof(Mem_Block);
    800014f4:	fe878793          	addi	a5,a5,-24
    800014f8:	00f73823          	sd	a5,16(a4)
    else {//ako od ostatka ne mogu da napravim blok, onda uzimam ceo blok
        if (block->prev) block->prev->next = block->next;
        if(block->next) block->next->prev = block->prev;
        else free_Block = block->next;
    }
    block->next = nullptr;
    800014fc:	00053023          	sd	zero,0(a0)
    return block + sizeof(Mem_Block);
    80001500:	24050513          	addi	a0,a0,576
}
    80001504:	00813403          	ld	s0,8(sp)
    80001508:	01010113          	addi	sp,sp,16
    8000150c:	00008067          	ret
        else free_Block = new_block;
    80001510:	00008697          	auipc	a3,0x8
    80001514:	82e6b823          	sd	a4,-2000(a3) # 80008d40 <_ZN15MemoryAllocator10free_BlockE>
    80001518:	fcdff06f          	j	800014e4 <_ZN15MemoryAllocator9mem_allocEm+0x60>
        if (block->prev) block->prev->next = block->next;
    8000151c:	00853783          	ld	a5,8(a0)
    80001520:	00078663          	beqz	a5,8000152c <_ZN15MemoryAllocator9mem_allocEm+0xa8>
    80001524:	00053703          	ld	a4,0(a0)
    80001528:	00e7b023          	sd	a4,0(a5)
        if(block->next) block->next->prev = block->prev;
    8000152c:	00053783          	ld	a5,0(a0)
    80001530:	00078863          	beqz	a5,80001540 <_ZN15MemoryAllocator9mem_allocEm+0xbc>
    80001534:	00853703          	ld	a4,8(a0)
    80001538:	00e7b423          	sd	a4,8(a5)
    8000153c:	fc1ff06f          	j	800014fc <_ZN15MemoryAllocator9mem_allocEm+0x78>
        else free_Block = block->next;
    80001540:	00008717          	auipc	a4,0x8
    80001544:	80f73023          	sd	a5,-2048(a4) # 80008d40 <_ZN15MemoryAllocator10free_BlockE>
    80001548:	fb5ff06f          	j	800014fc <_ZN15MemoryAllocator9mem_allocEm+0x78>

000000008000154c <_ZN15MemoryAllocator8mem_freeEPv>:

int MemoryAllocator::mem_free(void * pointerToBlock) {

    if(pointerToBlock<HEAP_START_ADDR || pointerToBlock>HEAP_END_ADDR){
    8000154c:	00007797          	auipc	a5,0x7
    80001550:	6347b783          	ld	a5,1588(a5) # 80008b80 <HEAP_START_ADDR>
    80001554:	0af56263          	bltu	a0,a5,800015f8 <_ZN15MemoryAllocator8mem_freeEPv+0xac>
    80001558:	00007797          	auipc	a5,0x7
    8000155c:	6207b783          	ld	a5,1568(a5) # 80008b78 <HEAP_END_ADDR>
    80001560:	0aa7e063          	bltu	a5,a0,80001600 <_ZN15MemoryAllocator8mem_freeEPv+0xb4>
int MemoryAllocator::mem_free(void * pointerToBlock) {
    80001564:	fe010113          	addi	sp,sp,-32
    80001568:	00113c23          	sd	ra,24(sp)
    8000156c:	00813823          	sd	s0,16(sp)
    80001570:	00913423          	sd	s1,8(sp)
    80001574:	02010413          	addi	s0,sp,32
    }

    Mem_Block* current_Block = nullptr;
    Mem_Block* block_ToFree = (Mem_Block*) pointerToBlock;

    if(free_Block && block_ToFree>free_Block){ //da li uopste ima slobodnog prostora i ako ima da li je adresa Bloka veca od pocetka slobodnog prostora
    80001578:	00007717          	auipc	a4,0x7
    8000157c:	7c873703          	ld	a4,1992(a4) # 80008d40 <_ZN15MemoryAllocator10free_BlockE>
    80001580:	02070863          	beqz	a4,800015b0 <_ZN15MemoryAllocator8mem_freeEPv+0x64>
    80001584:	02a77a63          	bgeu	a4,a0,800015b8 <_ZN15MemoryAllocator8mem_freeEPv+0x6c>
        current_Block = free_Block;
    80001588:	00070793          	mv	a5,a4
        while(current_Block->next!=nullptr){ //nadji poziciju okja je pre zauzetog bloka
    8000158c:	00078493          	mv	s1,a5
    80001590:	0007b783          	ld	a5,0(a5)
    80001594:	00078463          	beqz	a5,8000159c <_ZN15MemoryAllocator8mem_freeEPv+0x50>
            if ( block_ToFree < current_Block->next ) break;
    80001598:	fef57ae3          	bgeu	a0,a5,8000158c <_ZN15MemoryAllocator8mem_freeEPv+0x40>
            current_Block = current_Block->next;
        }
    }
    if(!current_Block){  //blok se nalazi ispred slobodnog prostora
    8000159c:	02048063          	beqz	s1,800015bc <_ZN15MemoryAllocator8mem_freeEPv+0x70>
        block_ToFree->next = free_Block;
        free_Block->prev = block_ToFree;
        free_Block = block_ToFree;
    }
    else{
        block_ToFree->next = current_Block; //blok se nalazi negde u sredini ili na kraju
    800015a0:	00953023          	sd	s1,0(a0)
        current_Block->next = block_ToFree;
    800015a4:	00a4b023          	sd	a0,0(s1)
        if(current_Block->next) current_Block->next->prev = block_ToFree;
        block_ToFree->prev = current_Block;
    800015a8:	00953423          	sd	s1,8(a0)
    800015ac:	0200006f          	j	800015cc <_ZN15MemoryAllocator8mem_freeEPv+0x80>
    Mem_Block* current_Block = nullptr;
    800015b0:	00070493          	mv	s1,a4
    800015b4:	0080006f          	j	800015bc <_ZN15MemoryAllocator8mem_freeEPv+0x70>
    800015b8:	00000493          	li	s1,0
        block_ToFree->next = free_Block;
    800015bc:	00e53023          	sd	a4,0(a0)
        free_Block->prev = block_ToFree;
    800015c0:	00a73423          	sd	a0,8(a4)
        free_Block = block_ToFree;
    800015c4:	00007797          	auipc	a5,0x7
    800015c8:	76a7be23          	sd	a0,1916(a5) # 80008d40 <_ZN15MemoryAllocator10free_BlockE>
    }

    tryToJoin(block_ToFree); //pokusaj da spojis slobodan prostor sa sledecim ili blokom pre njega
    800015cc:	00000097          	auipc	ra,0x0
    800015d0:	e5c080e7          	jalr	-420(ra) # 80001428 <_Z9tryToJoinP9Mem_Block>
    tryToJoin(current_Block);
    800015d4:	00048513          	mv	a0,s1
    800015d8:	00000097          	auipc	ra,0x0
    800015dc:	e50080e7          	jalr	-432(ra) # 80001428 <_Z9tryToJoinP9Mem_Block>
    return 0;
    800015e0:	00000513          	li	a0,0
}
    800015e4:	01813083          	ld	ra,24(sp)
    800015e8:	01013403          	ld	s0,16(sp)
    800015ec:	00813483          	ld	s1,8(sp)
    800015f0:	02010113          	addi	sp,sp,32
    800015f4:	00008067          	ret
        return -1; // blockToDelete nije u opsegu granica memorije
    800015f8:	fff00513          	li	a0,-1
    800015fc:	00008067          	ret
    80001600:	fff00513          	li	a0,-1
}
    80001604:	00008067          	ret

0000000080001608 <_ZN5Riscv10popSppSpieEv>:
#include "../test/printing.hpp"
#include "../h/_sem.hpp"
#include "../h/MemoryAllocator.h"

void Riscv::popSppSpie()
{
    80001608:	ff010113          	addi	sp,sp,-16
    8000160c:	00813423          	sd	s0,8(sp)
    80001610:	01010413          	addi	s0,sp,16
    __asm__ volatile ("csrw sepc, ra"); // zato ovde upisujem da nas vrati tamo odakle je i ova funkcija bila i pozvana i zbog toga ova funckija nije inline
    80001614:	14109073          	csrw	sepc,ra
    __asm__ volatile ("sret"); //ovo sret ce vratiti tamo gde je sepc rekao, i to nam ne odgovara
    80001618:	10200073          	sret

}
    8000161c:	00813403          	ld	s0,8(sp)
    80001620:	01010113          	addi	sp,sp,16
    80001624:	00008067          	ret

0000000080001628 <_ZN5Riscv23interruptRoutineHandlerEv>:

void Riscv::interruptRoutineHandler(){
    80001628:	f8010113          	addi	sp,sp,-128
    8000162c:	06113c23          	sd	ra,120(sp)
    80001630:	06813823          	sd	s0,112(sp)
    80001634:	06913423          	sd	s1,104(sp)
    80001638:	08010413          	addi	s0,sp,128
    uint64 volatile fcode;
    asm volatile("mv %0, a0" : "=r" (fcode));
    8000163c:	00050793          	mv	a5,a0
    80001640:	fcf43c23          	sd	a5,-40(s0)
};

inline uint64 Riscv::r_scause()
{
    uint64 volatile scause;
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    80001644:	142027f3          	csrr	a5,scause
    80001648:	faf43823          	sd	a5,-80(s0)
    return scause;
    8000164c:	fb043483          	ld	s1,-80(s0)
    uint64 retval = 0;

    //r_scause -> read scause
    uint64 scause = r_scause(); // scause -> razlog prekida

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL){
    80001650:	ff848713          	addi	a4,s1,-8
    80001654:	00100793          	li	a5,1
    80001658:	0ce7fa63          	bgeu	a5,a4,8000172c <_ZN5Riscv23interruptRoutineHandlerEv+0x104>
        }

        w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
        w_sstatus(sstatus);
    }
    else if (scause == 0x8000000000000001UL){
    8000165c:	fff00793          	li	a5,-1
    80001660:	03f79793          	slli	a5,a5,0x3f
    80001664:	00178793          	addi	a5,a5,1
    80001668:	22f48a63          	beq	s1,a5,8000189c <_ZN5Riscv23interruptRoutineHandlerEv+0x274>
        mc_sip(SIP_SSIP);
    }
    else if (scause == 0x8000000000000009UL){
    8000166c:	fff00793          	li	a5,-1
    80001670:	03f79793          	slli	a5,a5,0x3f
    80001674:	00978793          	addi	a5,a5,9
    80001678:	22f48863          	beq	s1,a5,800018a8 <_ZN5Riscv23interruptRoutineHandlerEv+0x280>
        console_handler();
    }
    else{
        printString("\nPc greske: ");
    8000167c:	00006517          	auipc	a0,0x6
    80001680:	9a450513          	addi	a0,a0,-1628 # 80007020 <CONSOLE_STATUS+0x10>
    80001684:	00001097          	auipc	ra,0x1
    80001688:	05c080e7          	jalr	92(ra) # 800026e0 <_Z11printStringPKc>
}

inline uint64 Riscv::r_sepc()
{
    uint64 volatile sepc;
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000168c:	141027f3          	csrr	a5,sepc
    80001690:	fcf43823          	sd	a5,-48(s0)
    return sepc;
    80001694:	fd043503          	ld	a0,-48(s0)
        printInt(r_sepc());//cuva adresu na kooju se vracam posle prekidne rutine
    80001698:	00000613          	li	a2,0
    8000169c:	00a00593          	li	a1,10
    800016a0:	0005051b          	sext.w	a0,a0
    800016a4:	00001097          	auipc	ra,0x1
    800016a8:	1ec080e7          	jalr	492(ra) # 80002890 <_Z8printIntiii>
        printString("\nStVal greske: ");
    800016ac:	00006517          	auipc	a0,0x6
    800016b0:	98450513          	addi	a0,a0,-1660 # 80007030 <CONSOLE_STATUS+0x20>
    800016b4:	00001097          	auipc	ra,0x1
    800016b8:	02c080e7          	jalr	44(ra) # 800026e0 <_Z11printStringPKc>
}

inline uint64 Riscv::r_stval()
{
    uint64 volatile stval;
    __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    800016bc:	143027f3          	csrr	a5,stval
    800016c0:	fcf43423          	sd	a5,-56(s0)
    return stval;
    800016c4:	fc843503          	ld	a0,-56(s0)
        printInt(r_stval());
    800016c8:	00000613          	li	a2,0
    800016cc:	00a00593          	li	a1,10
    800016d0:	0005051b          	sext.w	a0,a0
    800016d4:	00001097          	auipc	ra,0x1
    800016d8:	1bc080e7          	jalr	444(ra) # 80002890 <_Z8printIntiii>
        printString("\nRazlog greske scause: ");
    800016dc:	00006517          	auipc	a0,0x6
    800016e0:	96450513          	addi	a0,a0,-1692 # 80007040 <CONSOLE_STATUS+0x30>
    800016e4:	00001097          	auipc	ra,0x1
    800016e8:	ffc080e7          	jalr	-4(ra) # 800026e0 <_Z11printStringPKc>
        printInt(scause);
    800016ec:	00000613          	li	a2,0
    800016f0:	00a00593          	li	a1,10
    800016f4:	0004851b          	sext.w	a0,s1
    800016f8:	00001097          	auipc	ra,0x1
    800016fc:	198080e7          	jalr	408(ra) # 80002890 <_Z8printIntiii>
        switch(scause) {
    80001700:	00500793          	li	a5,5
    80001704:	1cf48263          	beq	s1,a5,800018c8 <_ZN5Riscv23interruptRoutineHandlerEv+0x2a0>
    80001708:	00700793          	li	a5,7
    8000170c:	1cf48863          	beq	s1,a5,800018dc <_ZN5Riscv23interruptRoutineHandlerEv+0x2b4>
    80001710:	00200793          	li	a5,2
    80001714:	1af48063          	beq	s1,a5,800018b4 <_ZN5Riscv23interruptRoutineHandlerEv+0x28c>
                break;
            case 7:
                printString(" Nedozvoljena adresa upisa");
                break;
            default:
                printString(" Ostalo");
    80001718:	00006517          	auipc	a0,0x6
    8000171c:	99850513          	addi	a0,a0,-1640 # 800070b0 <CONSOLE_STATUS+0xa0>
    80001720:	00001097          	auipc	ra,0x1
    80001724:	fc0080e7          	jalr	-64(ra) # 800026e0 <_Z11printStringPKc>
                break;
        }
    }
    80001728:	0700006f          	j	80001798 <_ZN5Riscv23interruptRoutineHandlerEv+0x170>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    8000172c:	141027f3          	csrr	a5,sepc
    80001730:	fcf43023          	sd	a5,-64(s0)
    return sepc;
    80001734:	fc043783          	ld	a5,-64(s0)
        uint64 volatile sepc = r_sepc() + 4;    //prelazak na sledecu instrukciju; jer procesor ponavlja instr koja je izazvala prekid
    80001738:	00478793          	addi	a5,a5,4
    8000173c:	f8f43423          	sd	a5,-120(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001740:	100027f3          	csrr	a5,sstatus
    80001744:	faf43c23          	sd	a5,-72(s0)
    return sstatus;
    80001748:	fb843783          	ld	a5,-72(s0)
        uint64 volatile sstatus = r_sstatus();
    8000174c:	f8f43823          	sd	a5,-112(s0)
        switch(fcode){
    80001750:	fd843783          	ld	a5,-40(s0)
    80001754:	04100713          	li	a4,65
    80001758:	02f76863          	bltu	a4,a5,80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
    8000175c:	00279793          	slli	a5,a5,0x2
    80001760:	00006717          	auipc	a4,0x6
    80001764:	95870713          	addi	a4,a4,-1704 # 800070b8 <CONSOLE_STATUS+0xa8>
    80001768:	00e787b3          	add	a5,a5,a4
    8000176c:	0007a783          	lw	a5,0(a5)
    80001770:	00e787b3          	add	a5,a5,a4
    80001774:	00078067          	jr	a5
                asm volatile("mv %0, a1" : "=r" (size));
    80001778:	00058513          	mv	a0,a1
                ret = MemoryAllocator::mem_alloc(size);
    8000177c:	00000097          	auipc	ra,0x0
    80001780:	d08080e7          	jalr	-760(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
                asm volatile("mv a0, %0" : : "r" (ret));
    80001784:	00050513          	mv	a0,a0
        w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
    80001788:	f8843783          	ld	a5,-120(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    8000178c:	14179073          	csrw	sepc,a5
        w_sstatus(sstatus);
    80001790:	f9043783          	ld	a5,-112(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80001794:	10079073          	csrw	sstatus,a5
    80001798:	07813083          	ld	ra,120(sp)
    8000179c:	07013403          	ld	s0,112(sp)
    800017a0:	06813483          	ld	s1,104(sp)
    800017a4:	08010113          	addi	sp,sp,128
    800017a8:	00008067          	ret
                asm volatile("mv %0, a1" : "=r" (p));
    800017ac:	00058513          	mv	a0,a1
                retval = MemoryAllocator::mem_free(p);
    800017b0:	00000097          	auipc	ra,0x0
    800017b4:	d9c080e7          	jalr	-612(ra) # 8000154c <_ZN15MemoryAllocator8mem_freeEPv>
                asm volatile("mv a0, %0" : : "r" (retval));
    800017b8:	00050513          	mv	a0,a0
                break;
    800017bc:	fcdff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
                asm volatile("mv %0, a1" : "=r" (handle));    //thread_t* handle
    800017c0:	00058793          	mv	a5,a1
    800017c4:	f8f43c23          	sd	a5,-104(s0)
                asm volatile("mv %0, a2" : "=r" (start_routine));    //void (*function)(void*)
    800017c8:	00060793          	mv	a5,a2
    800017cc:	faf43023          	sd	a5,-96(s0)
                asm volatile("mv %0, a3" : "=r" (arg));
    800017d0:	00068793          	mv	a5,a3
    800017d4:	faf43423          	sd	a5,-88(s0)
                uint64 *stack_space = new uint64[DEFAULT_STACK_SIZE];
    800017d8:	00008537          	lui	a0,0x8
    800017dc:	00000097          	auipc	ra,0x0
    800017e0:	a8c080e7          	jalr	-1396(ra) # 80001268 <_Znam>
    800017e4:	00050693          	mv	a3,a0
                retval = _thread::create_thread((thread_t *) handle, (_thread::Body) start_routine, (void *) arg,
    800017e8:	f9843503          	ld	a0,-104(s0)
    800017ec:	fa043583          	ld	a1,-96(s0)
    800017f0:	fa843603          	ld	a2,-88(s0)
    800017f4:	00000097          	auipc	ra,0x0
    800017f8:	380080e7          	jalr	896(ra) # 80001b74 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>
                asm volatile("mv a0, %0" : : "r" (retval));
    800017fc:	00050513          	mv	a0,a0
                break;
    80001800:	f89ff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
                retval = _thread::thread_exit();
    80001804:	00000097          	auipc	ra,0x0
    80001808:	520080e7          	jalr	1312(ra) # 80001d24 <_ZN7_thread11thread_exitEv>
                asm volatile("mv a0, %0" : : "r" (retval));
    8000180c:	00050513          	mv	a0,a0
                break;
    80001810:	f79ff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
                _thread::thread_dispatch();
    80001814:	00000097          	auipc	ra,0x0
    80001818:	44c080e7          	jalr	1100(ra) # 80001c60 <_ZN7_thread15thread_dispatchEv>
                break;
    8000181c:	f6dff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001820:	00058513          	mv	a0,a1
                asm volatile("mv %0, a2" : "=r" (init));
    80001824:	00060593          	mv	a1,a2
                retval = _sem::open_sem((sem_t*)(handle), init);
    80001828:	0005859b          	sext.w	a1,a1
    8000182c:	00000097          	auipc	ra,0x0
    80001830:	0c4080e7          	jalr	196(ra) # 800018f0 <_ZN4_sem8open_semEPPS_j>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001834:	00050513          	mv	a0,a0
                break;
    80001838:	f51ff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
                asm volatile("mv %0, a1" : "=r" (handle));
    8000183c:	00058513          	mv	a0,a1
                retval = _sem::close_sem((sem_t)handle);
    80001840:	00000097          	auipc	ra,0x0
    80001844:	114080e7          	jalr	276(ra) # 80001954 <_ZN4_sem9close_semEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001848:	00050513          	mv	a0,a0
                break;
    8000184c:	f3dff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001850:	00058513          	mv	a0,a1
                retval = _sem::sem_wait((sem_t)handle);
    80001854:	00000097          	auipc	ra,0x0
    80001858:	214080e7          	jalr	532(ra) # 80001a68 <_ZN4_sem8sem_waitEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    8000185c:	00050513          	mv	a0,a0
                break;
    80001860:	f29ff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001864:	00058513          	mv	a0,a1
                retval = _sem::sem_signal((sem_t)handle);
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	174080e7          	jalr	372(ra) # 800019dc <_ZN4_sem10sem_signalEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001870:	00050513          	mv	a0,a0
                break;
    80001874:	f15ff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
                asm volatile("mv %0, a1" : "=r" (handle));
    80001878:	00058513          	mv	a0,a1
                retval = _sem::sem_trywait((sem_t)handle);
    8000187c:	00000097          	auipc	ra,0x0
    80001880:	2a8080e7          	jalr	680(ra) # 80001b24 <_ZN4_sem11sem_trywaitEPS_>
                asm volatile("mv a0, %0" : : "r" (retval));
    80001884:	00050513          	mv	a0,a0
                break;
    80001888:	f01ff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
                char ch = __getc();
    8000188c:	00005097          	auipc	ra,0x5
    80001890:	28c080e7          	jalr	652(ra) # 80006b18 <__getc>
                asm volatile("mv a0, %0" : : "r" (ch));
    80001894:	00050513          	mv	a0,a0
                break;
    80001898:	ef1ff06f          	j	80001788 <_ZN5Riscv23interruptRoutineHandlerEv+0x160>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    8000189c:	00200793          	li	a5,2
    800018a0:	1447b073          	csrc	sip,a5
}
    800018a4:	ef5ff06f          	j	80001798 <_ZN5Riscv23interruptRoutineHandlerEv+0x170>
        console_handler();
    800018a8:	00005097          	auipc	ra,0x5
    800018ac:	2a8080e7          	jalr	680(ra) # 80006b50 <console_handler>
    800018b0:	ee9ff06f          	j	80001798 <_ZN5Riscv23interruptRoutineHandlerEv+0x170>
                printString(" Nelegelna instrukcija");
    800018b4:	00005517          	auipc	a0,0x5
    800018b8:	7a450513          	addi	a0,a0,1956 # 80007058 <CONSOLE_STATUS+0x48>
    800018bc:	00001097          	auipc	ra,0x1
    800018c0:	e24080e7          	jalr	-476(ra) # 800026e0 <_Z11printStringPKc>
                break;
    800018c4:	ed5ff06f          	j	80001798 <_ZN5Riscv23interruptRoutineHandlerEv+0x170>
                printString(" Nedozvoljena adresa citanja");
    800018c8:	00005517          	auipc	a0,0x5
    800018cc:	7a850513          	addi	a0,a0,1960 # 80007070 <CONSOLE_STATUS+0x60>
    800018d0:	00001097          	auipc	ra,0x1
    800018d4:	e10080e7          	jalr	-496(ra) # 800026e0 <_Z11printStringPKc>
                break;
    800018d8:	ec1ff06f          	j	80001798 <_ZN5Riscv23interruptRoutineHandlerEv+0x170>
                printString(" Nedozvoljena adresa upisa");
    800018dc:	00005517          	auipc	a0,0x5
    800018e0:	7b450513          	addi	a0,a0,1972 # 80007090 <CONSOLE_STATUS+0x80>
    800018e4:	00001097          	auipc	ra,0x1
    800018e8:	dfc080e7          	jalr	-516(ra) # 800026e0 <_Z11printStringPKc>
                break;
    800018ec:	eadff06f          	j	80001798 <_ZN5Riscv23interruptRoutineHandlerEv+0x170>

00000000800018f0 <_ZN4_sem8open_semEPPS_j>:
//

#include "../h/_sem.hpp"


int _sem::open_sem(sem_t* handle, unsigned init){
    800018f0:	fe010113          	addi	sp,sp,-32
    800018f4:	00113c23          	sd	ra,24(sp)
    800018f8:	00813823          	sd	s0,16(sp)
    800018fc:	00913423          	sd	s1,8(sp)
    80001900:	01213023          	sd	s2,0(sp)
    80001904:	02010413          	addi	s0,sp,32
    80001908:	00050493          	mv	s1,a0
    8000190c:	00058913          	mv	s2,a1
    *handle = new _sem(init);
    80001910:	01800513          	li	a0,24
    80001914:	00000097          	auipc	ra,0x0
    80001918:	92c080e7          	jalr	-1748(ra) # 80001240 <_Znwm>
    static int close_sem(sem_t id);
    static int sem_wait(sem_t id);
    static int sem_trywait(sem_t id);
    static int sem_signal(sem_t id);
private:
    _sem(unsigned v):val(v){ }//mozda ce trebati new blocked
    8000191c:	01252023          	sw	s2,0(a0)
    List() : head(0), tail(0) {}
    80001920:	00053423          	sd	zero,8(a0)
    80001924:	00053823          	sd	zero,16(a0)
    80001928:	00a4b023          	sd	a0,0(s1)
    if(*handle != nullptr) return 0;
    8000192c:	02050063          	beqz	a0,8000194c <_ZN4_sem8open_semEPPS_j+0x5c>
    80001930:	00000513          	li	a0,0
    return -1;
}
    80001934:	01813083          	ld	ra,24(sp)
    80001938:	01013403          	ld	s0,16(sp)
    8000193c:	00813483          	ld	s1,8(sp)
    80001940:	00013903          	ld	s2,0(sp)
    80001944:	02010113          	addi	sp,sp,32
    80001948:	00008067          	ret
    return -1;
    8000194c:	fff00513          	li	a0,-1
    80001950:	fe5ff06f          	j	80001934 <_ZN4_sem8open_semEPPS_j+0x44>

0000000080001954 <_ZN4_sem9close_semEPS_>:

int _sem::close_sem(sem_t id) {
    80001954:	fe010113          	addi	sp,sp,-32
    80001958:	00113c23          	sd	ra,24(sp)
    8000195c:	00813823          	sd	s0,16(sp)
    80001960:	00913423          	sd	s1,8(sp)
    80001964:	01213023          	sd	s2,0(sp)
    80001968:	02010413          	addi	s0,sp,32
    8000196c:	00050493          	mv	s1,a0
    if(id==nullptr) return -1;
    80001970:	02051463          	bnez	a0,80001998 <_ZN4_sem9close_semEPS_+0x44>
    80001974:	fff00513          	li	a0,-1
    80001978:	0440006f          	j	800019bc <_ZN4_sem9close_semEPS_+0x68>
        if (!head) { tail = 0; }
    8000197c:	0004b823          	sd	zero,16(s1)
        T *ret = elem->data;
    80001980:	00053903          	ld	s2,0(a0)
        delete elem;
    80001984:	00000097          	auipc	ra,0x0
    80001988:	90c080e7          	jalr	-1780(ra) # 80001290 <_ZdlPv>
    while(!id->blocked.empty()){
        Scheduler::put(id->blocked.get());
    8000198c:	00090513          	mv	a0,s2
    80001990:	00000097          	auipc	ra,0x0
    80001994:	9f8080e7          	jalr	-1544(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
        return ret;
    }

    T *peekFirst()
    {
        if (!head) { return 0; }
    80001998:	0084b503          	ld	a0,8(s1)
    8000199c:	00050e63          	beqz	a0,800019b8 <_ZN4_sem9close_semEPS_+0x64>
        return head->data;
    800019a0:	00053783          	ld	a5,0(a0)
    while(!id->blocked.empty()){
    800019a4:	02078863          	beqz	a5,800019d4 <_ZN4_sem9close_semEPS_+0x80>
        head = head->next;
    800019a8:	00853783          	ld	a5,8(a0)
    800019ac:	00f4b423          	sd	a5,8(s1)
        if (!head) { tail = 0; }
    800019b0:	fc0798e3          	bnez	a5,80001980 <_ZN4_sem9close_semEPS_+0x2c>
    800019b4:	fc9ff06f          	j	8000197c <_ZN4_sem9close_semEPS_+0x28>
    }
  //  delete id;
    id=nullptr;
    return 0;
    800019b8:	00000513          	li	a0,0
}
    800019bc:	01813083          	ld	ra,24(sp)
    800019c0:	01013403          	ld	s0,16(sp)
    800019c4:	00813483          	ld	s1,8(sp)
    800019c8:	00013903          	ld	s2,0(sp)
    800019cc:	02010113          	addi	sp,sp,32
    800019d0:	00008067          	ret
    return 0;
    800019d4:	00000513          	li	a0,0
    800019d8:	fe5ff06f          	j	800019bc <_ZN4_sem9close_semEPS_+0x68>

00000000800019dc <_ZN4_sem10sem_signalEPS_>:

int _sem::sem_signal(sem_t id) {
    if(id==nullptr) return -1;
    800019dc:	08050263          	beqz	a0,80001a60 <_ZN4_sem10sem_signalEPS_+0x84>
    800019e0:	00050793          	mv	a5,a0
        if (!head) { return 0; }
    800019e4:	00853503          	ld	a0,8(a0)
    800019e8:	06050263          	beqz	a0,80001a4c <_ZN4_sem10sem_signalEPS_+0x70>
        return head->data;
    800019ec:	00053703          	ld	a4,0(a0)
    if (!id->blocked.empty()){
    800019f0:	04070e63          	beqz	a4,80001a4c <_ZN4_sem10sem_signalEPS_+0x70>
int _sem::sem_signal(sem_t id) {
    800019f4:	fe010113          	addi	sp,sp,-32
    800019f8:	00113c23          	sd	ra,24(sp)
    800019fc:	00813823          	sd	s0,16(sp)
    80001a00:	00913423          	sd	s1,8(sp)
    80001a04:	02010413          	addi	s0,sp,32
        head = head->next;
    80001a08:	00853703          	ld	a4,8(a0)
    80001a0c:	00e7b423          	sd	a4,8(a5)
        if (!head) { tail = 0; }
    80001a10:	02070a63          	beqz	a4,80001a44 <_ZN4_sem10sem_signalEPS_+0x68>
        T *ret = elem->data;
    80001a14:	00053483          	ld	s1,0(a0)
        delete elem;
    80001a18:	00000097          	auipc	ra,0x0
    80001a1c:	878080e7          	jalr	-1928(ra) # 80001290 <_ZdlPv>
        Scheduler::put(id->blocked.get());
    80001a20:	00048513          	mv	a0,s1
    80001a24:	00000097          	auipc	ra,0x0
    80001a28:	964080e7          	jalr	-1692(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    }
    else id->val++;
    return 0;
    80001a2c:	00000513          	li	a0,0
}
    80001a30:	01813083          	ld	ra,24(sp)
    80001a34:	01013403          	ld	s0,16(sp)
    80001a38:	00813483          	ld	s1,8(sp)
    80001a3c:	02010113          	addi	sp,sp,32
    80001a40:	00008067          	ret
        if (!head) { tail = 0; }
    80001a44:	0007b823          	sd	zero,16(a5)
    80001a48:	fcdff06f          	j	80001a14 <_ZN4_sem10sem_signalEPS_+0x38>
    else id->val++;
    80001a4c:	0007a703          	lw	a4,0(a5)
    80001a50:	0017071b          	addiw	a4,a4,1
    80001a54:	00e7a023          	sw	a4,0(a5)
    return 0;
    80001a58:	00000513          	li	a0,0
    80001a5c:	00008067          	ret
    if(id==nullptr) return -1;
    80001a60:	fff00513          	li	a0,-1
}
    80001a64:	00008067          	ret

0000000080001a68 <_ZN4_sem8sem_waitEPS_>:

int _sem::sem_wait(sem_t id) {
    if(id==nullptr) return -1;
    80001a68:	0a050a63          	beqz	a0,80001b1c <_ZN4_sem8sem_waitEPS_+0xb4>
int _sem::sem_wait(sem_t id) {
    80001a6c:	fe010113          	addi	sp,sp,-32
    80001a70:	00113c23          	sd	ra,24(sp)
    80001a74:	00813823          	sd	s0,16(sp)
    80001a78:	00913423          	sd	s1,8(sp)
    80001a7c:	01213023          	sd	s2,0(sp)
    80001a80:	02010413          	addi	s0,sp,32
    80001a84:	00050493          	mv	s1,a0
    _thread *old = _thread::running;
    80001a88:	00007917          	auipc	s2,0x7
    80001a8c:	2c093903          	ld	s2,704(s2) # 80008d48 <_ZN7_thread7runningE>
    if (id->val>0) id->val--;
    80001a90:	00052783          	lw	a5,0(a0)
    80001a94:	02078463          	beqz	a5,80001abc <_ZN4_sem8sem_waitEPS_+0x54>
    80001a98:	fff7879b          	addiw	a5,a5,-1
    80001a9c:	00f52023          	sw	a5,0(a0)
    }

    if (!id){
        return -1;
    }
    else return 0;
    80001aa0:	00000513          	li	a0,0
}
    80001aa4:	01813083          	ld	ra,24(sp)
    80001aa8:	01013403          	ld	s0,16(sp)
    80001aac:	00813483          	ld	s1,8(sp)
    80001ab0:	00013903          	ld	s2,0(sp)
    80001ab4:	02010113          	addi	sp,sp,32
    80001ab8:	00008067          	ret

    using Body = void (*)(void(*)); //pokazivac na funkciju koja nema argumente ni povratnu vrednost

    ~_thread() {delete[] stack;}

    bool isFinished() const { return finished; }
    80001abc:	02894783          	lbu	a5,40(s2)
        if(!old->isFinished()){
    80001ac0:	02078463          	beqz	a5,80001ae8 <_ZN4_sem8sem_waitEPS_+0x80>
        _thread::running = Scheduler::get();
    80001ac4:	00000097          	auipc	ra,0x0
    80001ac8:	85c080e7          	jalr	-1956(ra) # 80001320 <_ZN9Scheduler3getEv>
    80001acc:	00007797          	auipc	a5,0x7
    80001ad0:	26a7be23          	sd	a0,636(a5) # 80008d48 <_ZN7_thread7runningE>
        _thread::contextSwitch(&old->context, &_thread::running->context);
    80001ad4:	01050593          	addi	a1,a0,16
    80001ad8:	01090513          	addi	a0,s2,16
    80001adc:	fffff097          	auipc	ra,0xfffff
    80001ae0:	63c080e7          	jalr	1596(ra) # 80001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
    80001ae4:	fbdff06f          	j	80001aa0 <_ZN4_sem8sem_waitEPS_+0x38>
        Elem *elem = new Elem(data, 0);
    80001ae8:	01000513          	li	a0,16
    80001aec:	fffff097          	auipc	ra,0xfffff
    80001af0:	754080e7          	jalr	1876(ra) # 80001240 <_Znwm>
        Elem(T *data, Elem *next) : data(data), next(next) {}
    80001af4:	01253023          	sd	s2,0(a0)
    80001af8:	00053423          	sd	zero,8(a0)
        if (tail)
    80001afc:	0104b783          	ld	a5,16(s1)
    80001b00:	00078863          	beqz	a5,80001b10 <_ZN4_sem8sem_waitEPS_+0xa8>
            tail->next = elem;
    80001b04:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    80001b08:	00a4b823          	sd	a0,16(s1)
    80001b0c:	fb9ff06f          	j	80001ac4 <_ZN4_sem8sem_waitEPS_+0x5c>
            head = tail = elem;
    80001b10:	00a4b823          	sd	a0,16(s1)
    80001b14:	00a4b423          	sd	a0,8(s1)
    80001b18:	fadff06f          	j	80001ac4 <_ZN4_sem8sem_waitEPS_+0x5c>
    if(id==nullptr) return -1;
    80001b1c:	fff00513          	li	a0,-1
}
    80001b20:	00008067          	ret

0000000080001b24 <_ZN4_sem11sem_trywaitEPS_>:

int _sem::sem_trywait(sem_t id) {
    80001b24:	ff010113          	addi	sp,sp,-16
    80001b28:	00813423          	sd	s0,8(sp)
    80001b2c:	01010413          	addi	s0,sp,16
    if(id==nullptr) return -1;
    80001b30:	02050263          	beqz	a0,80001b54 <_ZN4_sem11sem_trywaitEPS_+0x30>
    if (id->val>0) {
    80001b34:	00052783          	lw	a5,0(a0)
    80001b38:	02078263          	beqz	a5,80001b5c <_ZN4_sem11sem_trywaitEPS_+0x38>
        id->val--;
    80001b3c:	fff7879b          	addiw	a5,a5,-1
    80001b40:	0007871b          	sext.w	a4,a5
    80001b44:	00f52023          	sw	a5,0(a0)
        if (id->val > 0) return 0;
    80001b48:	02071263          	bnez	a4,80001b6c <_ZN4_sem11sem_trywaitEPS_+0x48>
    }
    return 1;
    80001b4c:	00100513          	li	a0,1
    80001b50:	0100006f          	j	80001b60 <_ZN4_sem11sem_trywaitEPS_+0x3c>
    if(id==nullptr) return -1;
    80001b54:	fff00513          	li	a0,-1
    80001b58:	0080006f          	j	80001b60 <_ZN4_sem11sem_trywaitEPS_+0x3c>
    return 1;
    80001b5c:	00100513          	li	a0,1
    80001b60:	00813403          	ld	s0,8(sp)
    80001b64:	01010113          	addi	sp,sp,16
    80001b68:	00008067          	ret
        if (id->val > 0) return 0;
    80001b6c:	00000513          	li	a0,0
    80001b70:	ff1ff06f          	j	80001b60 <_ZN4_sem11sem_trywaitEPS_+0x3c>

0000000080001b74 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>:
#include "../h/_thread.hpp"
#include "../h/riscv.hpp"

_thread* _thread::running = nullptr;

int _thread::create_thread(thread_t* handle, Body body, void* arg, void* stack_space){
    80001b74:	fc010113          	addi	sp,sp,-64
    80001b78:	02113c23          	sd	ra,56(sp)
    80001b7c:	02813823          	sd	s0,48(sp)
    80001b80:	02913423          	sd	s1,40(sp)
    80001b84:	03213023          	sd	s2,32(sp)
    80001b88:	01313c23          	sd	s3,24(sp)
    80001b8c:	01413823          	sd	s4,16(sp)
    80001b90:	01513423          	sd	s5,8(sp)
    80001b94:	04010413          	addi	s0,sp,64
    80001b98:	00050a13          	mv	s4,a0
    80001b9c:	00058993          	mv	s3,a1
    80001ba0:	00060a93          	mv	s5,a2
    80001ba4:	00068913          	mv	s2,a3

    *handle = new _thread(body, arg, stack_space);
    80001ba8:	03000513          	li	a0,48
    80001bac:	fffff097          	auipc	ra,0xfffff
    80001bb0:	694080e7          	jalr	1684(ra) # 80001240 <_Znwm>
    80001bb4:	00050493          	mv	s1,a0
            (uint64) &threadWrapper,//uvek izvrsavanje krece od tredVrepera kada zapocne neka nit
                                        // da se izvrsava treba da krene u kontekst svicu, tako sto se u ra umesto pocetka funkcije upisuje adresa threadWrapera
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
        }),
        arg(arg),
        finished(false){
    80001bb8:	01353023          	sd	s3,0(a0)
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    80001bbc:	04098063          	beqz	s3,80001bfc <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x88>
        finished(false){
    80001bc0:	0124b423          	sd	s2,8(s1)
    80001bc4:	00000797          	auipc	a5,0x0
    80001bc8:	10478793          	addi	a5,a5,260 # 80001cc8 <_ZN7_thread13threadWrapperEv>
    80001bcc:	00f4b823          	sd	a5,16(s1)
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001bd0:	02090a63          	beqz	s2,80001c04 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x90>
    80001bd4:	000086b7          	lui	a3,0x8
    80001bd8:	00d90933          	add	s2,s2,a3
        finished(false){
    80001bdc:	0124bc23          	sd	s2,24(s1)
    80001be0:	0354b023          	sd	s5,32(s1)
    80001be4:	02048423          	sb	zero,40(s1)
        if (body != nullptr) { Scheduler::put(this); } //zbog maina da ne bi opet ubaciovao u skedzuler i ovde i prvi kontekst svicu kad svakako
    80001be8:	02098263          	beqz	s3,80001c0c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
    80001bec:	00048513          	mv	a0,s1
    80001bf0:	fffff097          	auipc	ra,0xfffff
    80001bf4:	798080e7          	jalr	1944(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    80001bf8:	0140006f          	j	80001c0c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    80001bfc:	00000913          	li	s2,0
    80001c00:	fc1ff06f          	j	80001bc0 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x4c>
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001c04:	00000913          	li	s2,0
    80001c08:	fd5ff06f          	j	80001bdc <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x68>
    80001c0c:	009a3023          	sd	s1,0(s4)
    if(*handle != nullptr) return 0;
    80001c10:	02048663          	beqz	s1,80001c3c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xc8>
    80001c14:	00000513          	li	a0,0
    return -1;
}
    80001c18:	03813083          	ld	ra,56(sp)
    80001c1c:	03013403          	ld	s0,48(sp)
    80001c20:	02813483          	ld	s1,40(sp)
    80001c24:	02013903          	ld	s2,32(sp)
    80001c28:	01813983          	ld	s3,24(sp)
    80001c2c:	01013a03          	ld	s4,16(sp)
    80001c30:	00813a83          	ld	s5,8(sp)
    80001c34:	04010113          	addi	sp,sp,64
    80001c38:	00008067          	ret
    return -1;
    80001c3c:	fff00513          	li	a0,-1
    80001c40:	fd9ff06f          	j	80001c18 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xa4>
    80001c44:	00050913          	mv	s2,a0
    *handle = new _thread(body, arg, stack_space);
    80001c48:	00048513          	mv	a0,s1
    80001c4c:	fffff097          	auipc	ra,0xfffff
    80001c50:	644080e7          	jalr	1604(ra) # 80001290 <_ZdlPv>
    80001c54:	00090513          	mv	a0,s2
    80001c58:	00008097          	auipc	ra,0x8
    80001c5c:	240080e7          	jalr	576(ra) # 80009e98 <_Unwind_Resume>

0000000080001c60 <_ZN7_thread15thread_dispatchEv>:


void _thread::thread_dispatch(){
    80001c60:	fe010113          	addi	sp,sp,-32
    80001c64:	00113c23          	sd	ra,24(sp)
    80001c68:	00813823          	sd	s0,16(sp)
    80001c6c:	00913423          	sd	s1,8(sp)
    80001c70:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80001c74:	00007497          	auipc	s1,0x7
    80001c78:	0d44b483          	ld	s1,212(s1) # 80008d48 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80001c7c:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished() ){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001c80:	02078c63          	beqz	a5,80001cb8 <_ZN7_thread15thread_dispatchEv+0x58>
    running = Scheduler::get();
    80001c84:	fffff097          	auipc	ra,0xfffff
    80001c88:	69c080e7          	jalr	1692(ra) # 80001320 <_ZN9Scheduler3getEv>
    80001c8c:	00007797          	auipc	a5,0x7
    80001c90:	0aa7be23          	sd	a0,188(a5) # 80008d48 <_ZN7_thread7runningE>

    //trenutni ra cuvam u old->context, a novi ra uzimam iz running->context i stavljam u ra registar
    _thread::contextSwitch(&old->context, &running->context);
    80001c94:	01050593          	addi	a1,a0,16
    80001c98:	01048513          	addi	a0,s1,16
    80001c9c:	fffff097          	auipc	ra,0xfffff
    80001ca0:	47c080e7          	jalr	1148(ra) # 80001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    80001ca4:	01813083          	ld	ra,24(sp)
    80001ca8:	01013403          	ld	s0,16(sp)
    80001cac:	00813483          	ld	s1,8(sp)
    80001cb0:	02010113          	addi	sp,sp,32
    80001cb4:	00008067          	ret
    if(!old->isFinished() ){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001cb8:	00048513          	mv	a0,s1
    80001cbc:	fffff097          	auipc	ra,0xfffff
    80001cc0:	6cc080e7          	jalr	1740(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    80001cc4:	fc1ff06f          	j	80001c84 <_ZN7_thread15thread_dispatchEv+0x24>

0000000080001cc8 <_ZN7_thread13threadWrapperEv>:
    //delete _thread::running;
    _thread::thread_dispatch();
    return 1;
}

void _thread::threadWrapper() {
    80001cc8:	fe010113          	addi	sp,sp,-32
    80001ccc:	00113c23          	sd	ra,24(sp)
    80001cd0:	00813823          	sd	s0,16(sp)
    80001cd4:	00913423          	sd	s1,8(sp)
    80001cd8:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    80001cdc:	00000097          	auipc	ra,0x0
    80001ce0:	92c080e7          	jalr	-1748(ra) # 80001608 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    80001ce4:	00007497          	auipc	s1,0x7
    80001ce8:	06448493          	addi	s1,s1,100 # 80008d48 <_ZN7_thread7runningE>
    80001cec:	0004b783          	ld	a5,0(s1)
    80001cf0:	0007b703          	ld	a4,0(a5)
    80001cf4:	0207b503          	ld	a0,32(a5)
    80001cf8:	000700e7          	jalr	a4
    running->setFinished(true);//kada se sve zavrsi postavi da je kraj
    80001cfc:	0004b783          	ld	a5,0(s1)
    void setFinished(bool fin) { _thread::finished = fin; }
    80001d00:	00100713          	li	a4,1
    80001d04:	02e78423          	sb	a4,40(a5)
    _thread::thread_dispatch();
    80001d08:	00000097          	auipc	ra,0x0
    80001d0c:	f58080e7          	jalr	-168(ra) # 80001c60 <_ZN7_thread15thread_dispatchEv>
}
    80001d10:	01813083          	ld	ra,24(sp)
    80001d14:	01013403          	ld	s0,16(sp)
    80001d18:	00813483          	ld	s1,8(sp)
    80001d1c:	02010113          	addi	sp,sp,32
    80001d20:	00008067          	ret

0000000080001d24 <_ZN7_thread11thread_exitEv>:
int _thread::thread_exit() {
    80001d24:	ff010113          	addi	sp,sp,-16
    80001d28:	00813423          	sd	s0,8(sp)
    80001d2c:	01010413          	addi	s0,sp,16
    80001d30:	00007797          	auipc	a5,0x7
    80001d34:	0187b783          	ld	a5,24(a5) # 80008d48 <_ZN7_thread7runningE>
    80001d38:	00100713          	li	a4,1
    80001d3c:	02e78423          	sb	a4,40(a5)
}
    80001d40:	fff00513          	li	a0,-1
    80001d44:	00813403          	ld	s0,8(sp)
    80001d48:	01010113          	addi	sp,sp,16
    80001d4c:	00008067          	ret

0000000080001d50 <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    80001d50:	fe010113          	addi	sp,sp,-32
    80001d54:	00113c23          	sd	ra,24(sp)
    80001d58:	00813823          	sd	s0,16(sp)
    80001d5c:	00913423          	sd	s1,8(sp)
    80001d60:	01213023          	sd	s2,0(sp)
    80001d64:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    80001d68:	00005517          	auipc	a0,0x5
    80001d6c:	45850513          	addi	a0,a0,1112 # 800071c0 <CONSOLE_STATUS+0x1b0>
    80001d70:	00001097          	auipc	ra,0x1
    80001d74:	970080e7          	jalr	-1680(ra) # 800026e0 <_Z11printStringPKc>
    int test = getc() - '0';
    80001d78:	00000097          	auipc	ra,0x0
    80001d7c:	330080e7          	jalr	816(ra) # 800020a8 <_Z4getcv>
    80001d80:	00050913          	mv	s2,a0
    80001d84:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    80001d88:	00000097          	auipc	ra,0x0
    80001d8c:	320080e7          	jalr	800(ra) # 800020a8 <_Z4getcv>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    80001d90:	fcb9091b          	addiw	s2,s2,-53
    80001d94:	00100793          	li	a5,1
    80001d98:	0327f463          	bgeu	a5,s2,80001dc0 <_Z8userMainv+0x70>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80001d9c:	00700793          	li	a5,7
    80001da0:	0c97ee63          	bltu	a5,s1,80001e7c <_Z8userMainv+0x12c>
    80001da4:	00249493          	slli	s1,s1,0x2
    80001da8:	00005717          	auipc	a4,0x5
    80001dac:	64c70713          	addi	a4,a4,1612 # 800073f4 <CONSOLE_STATUS+0x3e4>
    80001db0:	00e484b3          	add	s1,s1,a4
    80001db4:	0004a783          	lw	a5,0(s1)
    80001db8:	00e787b3          	add	a5,a5,a4
    80001dbc:	00078067          	jr	a5
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80001dc0:	00005517          	auipc	a0,0x5
    80001dc4:	42050513          	addi	a0,a0,1056 # 800071e0 <CONSOLE_STATUS+0x1d0>
    80001dc8:	00001097          	auipc	ra,0x1
    80001dcc:	918080e7          	jalr	-1768(ra) # 800026e0 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
}
    80001dd0:	01813083          	ld	ra,24(sp)
    80001dd4:	01013403          	ld	s0,16(sp)
    80001dd8:	00813483          	ld	s1,8(sp)
    80001ddc:	00013903          	ld	s2,0(sp)
    80001de0:	02010113          	addi	sp,sp,32
    80001de4:	00008067          	ret
            Threads_C_API_test();
    80001de8:	00002097          	auipc	ra,0x2
    80001dec:	1ec080e7          	jalr	492(ra) # 80003fd4 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    80001df0:	00005517          	auipc	a0,0x5
    80001df4:	42050513          	addi	a0,a0,1056 # 80007210 <CONSOLE_STATUS+0x200>
    80001df8:	00001097          	auipc	ra,0x1
    80001dfc:	8e8080e7          	jalr	-1816(ra) # 800026e0 <_Z11printStringPKc>
            break;
    80001e00:	fd1ff06f          	j	80001dd0 <_Z8userMainv+0x80>
            Threads_CPP_API_test();
    80001e04:	00002097          	auipc	ra,0x2
    80001e08:	7a8080e7          	jalr	1960(ra) # 800045ac <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    80001e0c:	00005517          	auipc	a0,0x5
    80001e10:	44450513          	addi	a0,a0,1092 # 80007250 <CONSOLE_STATUS+0x240>
    80001e14:	00001097          	auipc	ra,0x1
    80001e18:	8cc080e7          	jalr	-1844(ra) # 800026e0 <_Z11printStringPKc>
            break;
    80001e1c:	fb5ff06f          	j	80001dd0 <_Z8userMainv+0x80>
            producerConsumer_C_API();
    80001e20:	00000097          	auipc	ra,0x0
    80001e24:	5f4080e7          	jalr	1524(ra) # 80002414 <_Z22producerConsumer_C_APIv>
            printString("TEST 3 (zadatak 3., kompletan C API sa semaforima, sinhrona promena konteksta)\n");
    80001e28:	00005517          	auipc	a0,0x5
    80001e2c:	46850513          	addi	a0,a0,1128 # 80007290 <CONSOLE_STATUS+0x280>
    80001e30:	00001097          	auipc	ra,0x1
    80001e34:	8b0080e7          	jalr	-1872(ra) # 800026e0 <_Z11printStringPKc>
            break;
    80001e38:	f99ff06f          	j	80001dd0 <_Z8userMainv+0x80>
            producerConsumer_CPP_Sync_API();
    80001e3c:	00001097          	auipc	ra,0x1
    80001e40:	2b8080e7          	jalr	696(ra) # 800030f4 <_Z29producerConsumer_CPP_Sync_APIv>
            printString("TEST 4 (zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta)\n");
    80001e44:	00005517          	auipc	a0,0x5
    80001e48:	49c50513          	addi	a0,a0,1180 # 800072e0 <CONSOLE_STATUS+0x2d0>
    80001e4c:	00001097          	auipc	ra,0x1
    80001e50:	894080e7          	jalr	-1900(ra) # 800026e0 <_Z11printStringPKc>
            break;
    80001e54:	f7dff06f          	j	80001dd0 <_Z8userMainv+0x80>
            printString("Test se nije uspesno zavrsio\n");
    80001e58:	00005517          	auipc	a0,0x5
    80001e5c:	4e050513          	addi	a0,a0,1248 # 80007338 <CONSOLE_STATUS+0x328>
    80001e60:	00001097          	auipc	ra,0x1
    80001e64:	880080e7          	jalr	-1920(ra) # 800026e0 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80001e68:	00005517          	auipc	a0,0x5
    80001e6c:	4f050513          	addi	a0,a0,1264 # 80007358 <CONSOLE_STATUS+0x348>
    80001e70:	00001097          	auipc	ra,0x1
    80001e74:	870080e7          	jalr	-1936(ra) # 800026e0 <_Z11printStringPKc>
            break;
    80001e78:	f59ff06f          	j	80001dd0 <_Z8userMainv+0x80>
            printString("Niste uneli odgovarajuci broj za test\n");
    80001e7c:	00005517          	auipc	a0,0x5
    80001e80:	53450513          	addi	a0,a0,1332 # 800073b0 <CONSOLE_STATUS+0x3a0>
    80001e84:	00001097          	auipc	ra,0x1
    80001e88:	85c080e7          	jalr	-1956(ra) # 800026e0 <_Z11printStringPKc>
    80001e8c:	f45ff06f          	j	80001dd0 <_Z8userMainv+0x80>

0000000080001e90 <_Z7wrapperPv>:





void wrapper(void* arg){
    80001e90:	ff010113          	addi	sp,sp,-16
    80001e94:	00113423          	sd	ra,8(sp)
    80001e98:	00813023          	sd	s0,0(sp)
    80001e9c:	01010413          	addi	s0,sp,16
    80001ea0:	00c0006f          	j	80001eac <_Z7wrapperPv+0x1c>

    while(!nitA->isFinished() || !nitB->isFinished() || !nitC->isFinished()){
        thread_dispatch();
    80001ea4:	00000097          	auipc	ra,0x0
    80001ea8:	1b4080e7          	jalr	436(ra) # 80002058 <_Z15thread_dispatchv>
    while(!nitA->isFinished() || !nitB->isFinished() || !nitC->isFinished()){
    80001eac:	00007797          	auipc	a5,0x7
    80001eb0:	eb47b783          	ld	a5,-332(a5) # 80008d60 <nitA>
    bool isFinished() const { return finished; }
    80001eb4:	0287c783          	lbu	a5,40(a5)
    80001eb8:	fe0786e3          	beqz	a5,80001ea4 <_Z7wrapperPv+0x14>
    80001ebc:	00007797          	auipc	a5,0x7
    80001ec0:	e9c7b783          	ld	a5,-356(a5) # 80008d58 <nitB>
    80001ec4:	0287c783          	lbu	a5,40(a5)
    80001ec8:	fc078ee3          	beqz	a5,80001ea4 <_Z7wrapperPv+0x14>
    80001ecc:	00007797          	auipc	a5,0x7
    80001ed0:	e847b783          	ld	a5,-380(a5) # 80008d50 <nitC>
    80001ed4:	0287c783          	lbu	a5,40(a5)
    80001ed8:	fc0786e3          	beqz	a5,80001ea4 <_Z7wrapperPv+0x14>
    }

    printString("ZAVRSENA JE WRAPPER FJA\n");
    80001edc:	00005517          	auipc	a0,0x5
    80001ee0:	4fc50513          	addi	a0,a0,1276 # 800073d8 <CONSOLE_STATUS+0x3c8>
    80001ee4:	00000097          	auipc	ra,0x0
    80001ee8:	7fc080e7          	jalr	2044(ra) # 800026e0 <_Z11printStringPKc>
    void setFinished(bool fin) { _thread::finished = fin; }
    80001eec:	00007797          	auipc	a5,0x7
    80001ef0:	e5c7b783          	ld	a5,-420(a5) # 80008d48 <_ZN7_thread7runningE>
    80001ef4:	00100713          	li	a4,1
    80001ef8:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    80001efc:	00000097          	auipc	ra,0x0
    80001f00:	15c080e7          	jalr	348(ra) # 80002058 <_Z15thread_dispatchv>
}
    80001f04:	00813083          	ld	ra,8(sp)
    80001f08:	00013403          	ld	s0,0(sp)
    80001f0c:	01010113          	addi	sp,sp,16
    80001f10:	00008067          	ret

0000000080001f14 <main>:

int main()
{
    80001f14:	fe010113          	addi	sp,sp,-32
    80001f18:	00113c23          	sd	ra,24(sp)
    80001f1c:	00813823          	sd	s0,16(sp)
    80001f20:	02010413          	addi	s0,sp,32
    static void* mem_alloc(size_t size);

    static int mem_free(void*);

    static void init_mem(){
        free_Block = (Mem_Block*)HEAP_START_ADDR;
    80001f24:	00007797          	auipc	a5,0x7
    80001f28:	c5c7b783          	ld	a5,-932(a5) # 80008b80 <HEAP_START_ADDR>
    80001f2c:	00007697          	auipc	a3,0x7
    80001f30:	e1468693          	addi	a3,a3,-492 # 80008d40 <_ZN15MemoryAllocator10free_BlockE>
    80001f34:	00f6b023          	sd	a5,0(a3)
        free_Block->size = (size_t)HEAP_END_ADDR - (size_t)HEAP_START_ADDR;
    80001f38:	00007717          	auipc	a4,0x7
    80001f3c:	c4073703          	ld	a4,-960(a4) # 80008b78 <HEAP_END_ADDR>
    80001f40:	40f70733          	sub	a4,a4,a5
    80001f44:	00e7b823          	sd	a4,16(a5)
        free_Block->next = nullptr;
    80001f48:	0007b023          	sd	zero,0(a5)
        free_Block->prev = nullptr;
    80001f4c:	0006b783          	ld	a5,0(a3)
    80001f50:	0007b423          	sd	zero,8(a5)
    MemoryAllocator::init_mem();
    Riscv::w_stvec((uint64) &Riscv::interruptRoutine);    //upisuje adresu prekidne rutine
    80001f54:	fffff797          	auipc	a5,0xfffff
    80001f58:	1dc78793          	addi	a5,a5,476 # 80001130 <_ZN5Riscv16interruptRoutineEv>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001f5c:	10579073          	csrw	stvec,a5
    //Riscv: :ms_sstatus (Riscv:: SSTATUS_SIE);
    thread_t thread1;
   // mem_alloc(52);
    //idle nit(nit koja nema fju koja treba da izvrsava)
    thread_create(&thread1, nullptr, nullptr);
    80001f60:	00000613          	li	a2,0
    80001f64:	00000593          	li	a1,0
    80001f68:	fe840513          	addi	a0,s0,-24
    80001f6c:	00000097          	auipc	ra,0x0
    80001f70:	0b4080e7          	jalr	180(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = thread1;
    80001f74:	fe843783          	ld	a5,-24(s0)
    80001f78:	00007717          	auipc	a4,0x7
    80001f7c:	dcf73823          	sd	a5,-560(a4) # 80008d48 <_ZN7_thread7runningE>
    thread_t thread2;
    thread_create(&thread2, reinterpret_cast<void (*)(void *)>(userMain), nullptr);
    80001f80:	00000613          	li	a2,0
    80001f84:	00000597          	auipc	a1,0x0
    80001f88:	dcc58593          	addi	a1,a1,-564 # 80001d50 <_Z8userMainv>
    80001f8c:	fe040513          	addi	a0,s0,-32
    80001f90:	00000097          	auipc	ra,0x0
    80001f94:	090080e7          	jalr	144(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>

    while (!(thread2->isFinished())) {
    80001f98:	fe043783          	ld	a5,-32(s0)
    bool isFinished() const { return finished; }
    80001f9c:	0287c783          	lbu	a5,40(a5)
    80001fa0:	00079863          	bnez	a5,80001fb0 <main+0x9c>
        thread_dispatch();
    80001fa4:	00000097          	auipc	ra,0x0
    80001fa8:	0b4080e7          	jalr	180(ra) # 80002058 <_Z15thread_dispatchv>
    80001fac:	fedff06f          	j	80001f98 <main+0x84>
    }

    return 0;
}
    80001fb0:	00000513          	li	a0,0
    80001fb4:	01813083          	ld	ra,24(sp)
    80001fb8:	01013403          	ld	s0,16(sp)
    80001fbc:	02010113          	addi	sp,sp,32
    80001fc0:	00008067          	ret

0000000080001fc4 <_Z9mem_allocm>:
#include "../lib/console.h"
#include "../h/syscall_c.hpp"



void* mem_alloc(size_t size){
    80001fc4:	ff010113          	addi	sp,sp,-16
    80001fc8:	00813423          	sd	s0,8(sp)
    80001fcc:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x01;
    void* retval;
    __asm__ volatile("mv a1, %0" : : "r"(size));
    80001fd0:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001fd4:	00100793          	li	a5,1
    80001fd8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001fdc:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80001fe0:	00050513          	mv	a0,a0
    return retval;
}
    80001fe4:	00813403          	ld	s0,8(sp)
    80001fe8:	01010113          	addi	sp,sp,16
    80001fec:	00008067          	ret

0000000080001ff0 <_Z8mem_freem>:

int mem_free(size_t size){
    80001ff0:	ff010113          	addi	sp,sp,-16
    80001ff4:	00813423          	sd	s0,8(sp)
    80001ff8:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x02;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(size));
    80001ffc:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002000:	00200793          	li	a5,2
    80002004:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002008:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval));
    8000200c:	00050513          	mv	a0,a0
    return retval;

}
    80002010:	0005051b          	sext.w	a0,a0
    80002014:	00813403          	ld	s0,8(sp)
    80002018:	01010113          	addi	sp,sp,16
    8000201c:	00008067          	ret

0000000080002020 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80002020:	ff010113          	addi	sp,sp,-16
    80002024:	00813423          	sd	s0,8(sp)
    80002028:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x11;
    int retval;
    __asm__ volatile("mv a3, %0" : : "r"(arg));
    8000202c:	00060693          	mv	a3,a2
    __asm__ volatile("mv a2, %0" : : "r"(start_routine));
    80002030:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80002034:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002038:	01100793          	li	a5,17
    8000203c:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002040:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    80002044:	00050513          	mv	a0,a0
    return retval;//PROVERITI DA LI JE UREDU

    //dodati promenljivu za povratnu vrednost
}
    80002048:	0005051b          	sext.w	a0,a0
    8000204c:	00813403          	ld	s0,8(sp)
    80002050:	01010113          	addi	sp,sp,16
    80002054:	00008067          	ret

0000000080002058 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80002058:	ff010113          	addi	sp,sp,-16
    8000205c:	00813423          	sd	s0,8(sp)
    80002060:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x13;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002064:	01300793          	li	a5,19
    80002068:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    8000206c:	00000073          	ecall
}
    80002070:	00813403          	ld	s0,8(sp)
    80002074:	01010113          	addi	sp,sp,16
    80002078:	00008067          	ret

000000008000207c <_Z11thread_exitv>:

int thread_exit(){
    8000207c:	ff010113          	addi	sp,sp,-16
    80002080:	00813423          	sd	s0,8(sp)
    80002084:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x12;
    int retval;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002088:	01200793          	li	a5,18
    8000208c:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002090:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval));
    80002094:	00050513          	mv	a0,a0
    return retval;
}
    80002098:	0005051b          	sext.w	a0,a0
    8000209c:	00813403          	ld	s0,8(sp)
    800020a0:	01010113          	addi	sp,sp,16
    800020a4:	00008067          	ret

00000000800020a8 <_Z4getcv>:

char getc(){
    800020a8:	ff010113          	addi	sp,sp,-16
    800020ac:	00813423          	sd	s0,8(sp)
    800020b0:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x41;
    char ch;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    800020b4:	04100793          	li	a5,65
    800020b8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800020bc:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (ch));
    800020c0:	00050513          	mv	a0,a0
    return ch;
}
    800020c4:	0ff57513          	andi	a0,a0,255
    800020c8:	00813403          	ld	s0,8(sp)
    800020cc:	01010113          	addi	sp,sp,16
    800020d0:	00008067          	ret

00000000800020d4 <_Z4putcc>:

void putc(char c){
    800020d4:	ff010113          	addi	sp,sp,-16
    800020d8:	00113423          	sd	ra,8(sp)
    800020dc:	00813023          	sd	s0,0(sp)
    800020e0:	01010413          	addi	s0,sp,16
    __putc(c);
    800020e4:	00005097          	auipc	ra,0x5
    800020e8:	9f8080e7          	jalr	-1544(ra) # 80006adc <__putc>
}
    800020ec:	00813083          	ld	ra,8(sp)
    800020f0:	00013403          	ld	s0,0(sp)
    800020f4:	01010113          	addi	sp,sp,16
    800020f8:	00008067          	ret

00000000800020fc <_Z8sem_openPP4_semj>:

int sem_open(sem_t* handle, unsigned init){
    800020fc:	ff010113          	addi	sp,sp,-16
    80002100:	00813423          	sd	s0,8(sp)
    80002104:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x21;
    int retval;
    __asm__ volatile("mv a2, %0" : : "r"(init));
    80002108:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    8000210c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002110:	02100793          	li	a5,33
    80002114:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002118:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    8000211c:	00050513          	mv	a0,a0
    return retval;
}
    80002120:	0005051b          	sext.w	a0,a0
    80002124:	00813403          	ld	s0,8(sp)
    80002128:	01010113          	addi	sp,sp,16
    8000212c:	00008067          	ret

0000000080002130 <_Z9sem_closeP4_sem>:

int sem_close(sem_t handle){
    80002130:	ff010113          	addi	sp,sp,-16
    80002134:	00813423          	sd	s0,8(sp)
    80002138:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x22;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    8000213c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002140:	02200793          	li	a5,34
    80002144:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002148:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    8000214c:	00050513          	mv	a0,a0
    return retval;
}
    80002150:	0005051b          	sext.w	a0,a0
    80002154:	00813403          	ld	s0,8(sp)
    80002158:	01010113          	addi	sp,sp,16
    8000215c:	00008067          	ret

0000000080002160 <_Z8sem_waitP4_sem>:

int sem_wait(sem_t handle){
    80002160:	ff010113          	addi	sp,sp,-16
    80002164:	00813423          	sd	s0,8(sp)
    80002168:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x23;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    8000216c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80002170:	02300793          	li	a5,35
    80002174:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80002178:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    8000217c:	00050513          	mv	a0,a0
    return retval;
}
    80002180:	0005051b          	sext.w	a0,a0
    80002184:	00813403          	ld	s0,8(sp)
    80002188:	01010113          	addi	sp,sp,16
    8000218c:	00008067          	ret

0000000080002190 <_Z10sem_signalP4_sem>:

int sem_signal(sem_t handle){
    80002190:	ff010113          	addi	sp,sp,-16
    80002194:	00813423          	sd	s0,8(sp)
    80002198:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x24;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    8000219c:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    800021a0:	02400793          	li	a5,36
    800021a4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800021a8:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    800021ac:	00050513          	mv	a0,a0
    return retval;
}
    800021b0:	0005051b          	sext.w	a0,a0
    800021b4:	00813403          	ld	s0,8(sp)
    800021b8:	01010113          	addi	sp,sp,16
    800021bc:	00008067          	ret

00000000800021c0 <_Z11sem_trywaitP4_sem>:

int sem_trywait(sem_t handle){
    800021c0:	ff010113          	addi	sp,sp,-16
    800021c4:	00813423          	sd	s0,8(sp)
    800021c8:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x26;
    int retval;
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    800021cc:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    800021d0:	02600793          	li	a5,38
    800021d4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    800021d8:	00000073          	ecall
    asm volatile("mv %0, a0" : "=r" (retval)); // c <- a0
    800021dc:	00050513          	mv	a0,a0
    return retval;
}
    800021e0:	0005051b          	sext.w	a0,a0
    800021e4:	00813403          	ld	s0,8(sp)
    800021e8:	01010113          	addi	sp,sp,16
    800021ec:	00008067          	ret

00000000800021f0 <_ZL16producerKeyboardPv>:
    sem_t wait;
};

static volatile int threadEnd = 0;

static void producerKeyboard(void *arg) {
    800021f0:	fe010113          	addi	sp,sp,-32
    800021f4:	00113c23          	sd	ra,24(sp)
    800021f8:	00813823          	sd	s0,16(sp)
    800021fc:	00913423          	sd	s1,8(sp)
    80002200:	01213023          	sd	s2,0(sp)
    80002204:	02010413          	addi	s0,sp,32
    80002208:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    8000220c:	00000913          	li	s2,0
    80002210:	00c0006f          	j	8000221c <_ZL16producerKeyboardPv+0x2c>
    while ((key = getc()) != 0x1b) {
        data->buffer->put(key);
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    80002214:	00000097          	auipc	ra,0x0
    80002218:	e44080e7          	jalr	-444(ra) # 80002058 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    8000221c:	00000097          	auipc	ra,0x0
    80002220:	e8c080e7          	jalr	-372(ra) # 800020a8 <_Z4getcv>
    80002224:	0005059b          	sext.w	a1,a0
    80002228:	01b00793          	li	a5,27
    8000222c:	02f58a63          	beq	a1,a5,80002260 <_ZL16producerKeyboardPv+0x70>
        data->buffer->put(key);
    80002230:	0084b503          	ld	a0,8(s1)
    80002234:	00001097          	auipc	ra,0x1
    80002238:	640080e7          	jalr	1600(ra) # 80003874 <_ZN6Buffer3putEi>
        i++;
    8000223c:	0019071b          	addiw	a4,s2,1
    80002240:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    80002244:	0004a683          	lw	a3,0(s1)
    80002248:	0026979b          	slliw	a5,a3,0x2
    8000224c:	00d787bb          	addw	a5,a5,a3
    80002250:	0017979b          	slliw	a5,a5,0x1
    80002254:	02f767bb          	remw	a5,a4,a5
    80002258:	fc0792e3          	bnez	a5,8000221c <_ZL16producerKeyboardPv+0x2c>
    8000225c:	fb9ff06f          	j	80002214 <_ZL16producerKeyboardPv+0x24>
        }
    }

    threadEnd = 1;
    80002260:	00100793          	li	a5,1
    80002264:	00007717          	auipc	a4,0x7
    80002268:	b0f72223          	sw	a5,-1276(a4) # 80008d68 <_ZL9threadEnd>
    data->buffer->put('!');
    8000226c:	02100593          	li	a1,33
    80002270:	0084b503          	ld	a0,8(s1)
    80002274:	00001097          	auipc	ra,0x1
    80002278:	600080e7          	jalr	1536(ra) # 80003874 <_ZN6Buffer3putEi>

    sem_signal(data->wait);
    8000227c:	0104b503          	ld	a0,16(s1)
    80002280:	00000097          	auipc	ra,0x0
    80002284:	f10080e7          	jalr	-240(ra) # 80002190 <_Z10sem_signalP4_sem>
}
    80002288:	01813083          	ld	ra,24(sp)
    8000228c:	01013403          	ld	s0,16(sp)
    80002290:	00813483          	ld	s1,8(sp)
    80002294:	00013903          	ld	s2,0(sp)
    80002298:	02010113          	addi	sp,sp,32
    8000229c:	00008067          	ret

00000000800022a0 <_ZL8producerPv>:

static void producer(void *arg) {
    800022a0:	fe010113          	addi	sp,sp,-32
    800022a4:	00113c23          	sd	ra,24(sp)
    800022a8:	00813823          	sd	s0,16(sp)
    800022ac:	00913423          	sd	s1,8(sp)
    800022b0:	01213023          	sd	s2,0(sp)
    800022b4:	02010413          	addi	s0,sp,32
    800022b8:	00050493          	mv	s1,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    800022bc:	00000913          	li	s2,0
    800022c0:	00c0006f          	j	800022cc <_ZL8producerPv+0x2c>
    while (!threadEnd) {
        data->buffer->put(data->id + '0');
        i++;

        if (i % (10 * data->id) == 0) {
            thread_dispatch();
    800022c4:	00000097          	auipc	ra,0x0
    800022c8:	d94080e7          	jalr	-620(ra) # 80002058 <_Z15thread_dispatchv>
    while (!threadEnd) {
    800022cc:	00007797          	auipc	a5,0x7
    800022d0:	a9c7a783          	lw	a5,-1380(a5) # 80008d68 <_ZL9threadEnd>
    800022d4:	02079e63          	bnez	a5,80002310 <_ZL8producerPv+0x70>
        data->buffer->put(data->id + '0');
    800022d8:	0004a583          	lw	a1,0(s1)
    800022dc:	0305859b          	addiw	a1,a1,48
    800022e0:	0084b503          	ld	a0,8(s1)
    800022e4:	00001097          	auipc	ra,0x1
    800022e8:	590080e7          	jalr	1424(ra) # 80003874 <_ZN6Buffer3putEi>
        i++;
    800022ec:	0019071b          	addiw	a4,s2,1
    800022f0:	0007091b          	sext.w	s2,a4
        if (i % (10 * data->id) == 0) {
    800022f4:	0004a683          	lw	a3,0(s1)
    800022f8:	0026979b          	slliw	a5,a3,0x2
    800022fc:	00d787bb          	addw	a5,a5,a3
    80002300:	0017979b          	slliw	a5,a5,0x1
    80002304:	02f767bb          	remw	a5,a4,a5
    80002308:	fc0792e3          	bnez	a5,800022cc <_ZL8producerPv+0x2c>
    8000230c:	fb9ff06f          	j	800022c4 <_ZL8producerPv+0x24>
        }
    }

    sem_signal(data->wait);
    80002310:	0104b503          	ld	a0,16(s1)
    80002314:	00000097          	auipc	ra,0x0
    80002318:	e7c080e7          	jalr	-388(ra) # 80002190 <_Z10sem_signalP4_sem>
}
    8000231c:	01813083          	ld	ra,24(sp)
    80002320:	01013403          	ld	s0,16(sp)
    80002324:	00813483          	ld	s1,8(sp)
    80002328:	00013903          	ld	s2,0(sp)
    8000232c:	02010113          	addi	sp,sp,32
    80002330:	00008067          	ret

0000000080002334 <_ZL8consumerPv>:

static void consumer(void *arg) {
    80002334:	fd010113          	addi	sp,sp,-48
    80002338:	02113423          	sd	ra,40(sp)
    8000233c:	02813023          	sd	s0,32(sp)
    80002340:	00913c23          	sd	s1,24(sp)
    80002344:	01213823          	sd	s2,16(sp)
    80002348:	01313423          	sd	s3,8(sp)
    8000234c:	03010413          	addi	s0,sp,48
    80002350:	00050913          	mv	s2,a0
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002354:	00000993          	li	s3,0
    80002358:	01c0006f          	j	80002374 <_ZL8consumerPv+0x40>
        i++;

        putc(key);

        if (i % (5 * data->id) == 0) {
            thread_dispatch();
    8000235c:	00000097          	auipc	ra,0x0
    80002360:	cfc080e7          	jalr	-772(ra) # 80002058 <_Z15thread_dispatchv>
    80002364:	0500006f          	j	800023b4 <_ZL8consumerPv+0x80>
        }

        if (i % 80 == 0) {
            putc('\n');
    80002368:	00a00513          	li	a0,10
    8000236c:	00000097          	auipc	ra,0x0
    80002370:	d68080e7          	jalr	-664(ra) # 800020d4 <_Z4putcc>
    while (!threadEnd) {
    80002374:	00007797          	auipc	a5,0x7
    80002378:	9f47a783          	lw	a5,-1548(a5) # 80008d68 <_ZL9threadEnd>
    8000237c:	06079063          	bnez	a5,800023dc <_ZL8consumerPv+0xa8>
        int key = data->buffer->get();
    80002380:	00893503          	ld	a0,8(s2)
    80002384:	00001097          	auipc	ra,0x1
    80002388:	580080e7          	jalr	1408(ra) # 80003904 <_ZN6Buffer3getEv>
        i++;
    8000238c:	0019849b          	addiw	s1,s3,1
    80002390:	0004899b          	sext.w	s3,s1
        putc(key);
    80002394:	0ff57513          	andi	a0,a0,255
    80002398:	00000097          	auipc	ra,0x0
    8000239c:	d3c080e7          	jalr	-708(ra) # 800020d4 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    800023a0:	00092703          	lw	a4,0(s2)
    800023a4:	0027179b          	slliw	a5,a4,0x2
    800023a8:	00e787bb          	addw	a5,a5,a4
    800023ac:	02f4e7bb          	remw	a5,s1,a5
    800023b0:	fa0786e3          	beqz	a5,8000235c <_ZL8consumerPv+0x28>
        if (i % 80 == 0) {
    800023b4:	05000793          	li	a5,80
    800023b8:	02f4e4bb          	remw	s1,s1,a5
    800023bc:	fa049ce3          	bnez	s1,80002374 <_ZL8consumerPv+0x40>
    800023c0:	fa9ff06f          	j	80002368 <_ZL8consumerPv+0x34>
        }
    }

    while (data->buffer->getCnt() > 0) {
        int key = data->buffer->get();
    800023c4:	00893503          	ld	a0,8(s2)
    800023c8:	00001097          	auipc	ra,0x1
    800023cc:	53c080e7          	jalr	1340(ra) # 80003904 <_ZN6Buffer3getEv>
        putc(key);
    800023d0:	0ff57513          	andi	a0,a0,255
    800023d4:	00000097          	auipc	ra,0x0
    800023d8:	d00080e7          	jalr	-768(ra) # 800020d4 <_Z4putcc>
    while (data->buffer->getCnt() > 0) {
    800023dc:	00893503          	ld	a0,8(s2)
    800023e0:	00001097          	auipc	ra,0x1
    800023e4:	5b0080e7          	jalr	1456(ra) # 80003990 <_ZN6Buffer6getCntEv>
    800023e8:	fca04ee3          	bgtz	a0,800023c4 <_ZL8consumerPv+0x90>
    }

    sem_signal(data->wait);
    800023ec:	01093503          	ld	a0,16(s2)
    800023f0:	00000097          	auipc	ra,0x0
    800023f4:	da0080e7          	jalr	-608(ra) # 80002190 <_Z10sem_signalP4_sem>
}
    800023f8:	02813083          	ld	ra,40(sp)
    800023fc:	02013403          	ld	s0,32(sp)
    80002400:	01813483          	ld	s1,24(sp)
    80002404:	01013903          	ld	s2,16(sp)
    80002408:	00813983          	ld	s3,8(sp)
    8000240c:	03010113          	addi	sp,sp,48
    80002410:	00008067          	ret

0000000080002414 <_Z22producerConsumer_C_APIv>:

void producerConsumer_C_API() {
    80002414:	f9010113          	addi	sp,sp,-112
    80002418:	06113423          	sd	ra,104(sp)
    8000241c:	06813023          	sd	s0,96(sp)
    80002420:	04913c23          	sd	s1,88(sp)
    80002424:	05213823          	sd	s2,80(sp)
    80002428:	05313423          	sd	s3,72(sp)
    8000242c:	05413023          	sd	s4,64(sp)
    80002430:	03513c23          	sd	s5,56(sp)
    80002434:	03613823          	sd	s6,48(sp)
    80002438:	07010413          	addi	s0,sp,112
        sem_wait(waitForAll);
    }

    sem_close(waitForAll);

    delete buffer;
    8000243c:	00010b13          	mv	s6,sp
    printString("Unesite broj proizvodjaca?\n");
    80002440:	00005517          	auipc	a0,0x5
    80002444:	fd850513          	addi	a0,a0,-40 # 80007418 <CONSOLE_STATUS+0x408>
    80002448:	00000097          	auipc	ra,0x0
    8000244c:	298080e7          	jalr	664(ra) # 800026e0 <_Z11printStringPKc>
    getString(input, 30);
    80002450:	01e00593          	li	a1,30
    80002454:	fa040513          	addi	a0,s0,-96
    80002458:	00000097          	auipc	ra,0x0
    8000245c:	310080e7          	jalr	784(ra) # 80002768 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80002460:	fa040513          	addi	a0,s0,-96
    80002464:	00000097          	auipc	ra,0x0
    80002468:	3dc080e7          	jalr	988(ra) # 80002840 <_Z11stringToIntPKc>
    8000246c:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80002470:	00005517          	auipc	a0,0x5
    80002474:	fc850513          	addi	a0,a0,-56 # 80007438 <CONSOLE_STATUS+0x428>
    80002478:	00000097          	auipc	ra,0x0
    8000247c:	268080e7          	jalr	616(ra) # 800026e0 <_Z11printStringPKc>
    getString(input, 30);
    80002480:	01e00593          	li	a1,30
    80002484:	fa040513          	addi	a0,s0,-96
    80002488:	00000097          	auipc	ra,0x0
    8000248c:	2e0080e7          	jalr	736(ra) # 80002768 <_Z9getStringPci>
    n = stringToInt(input);
    80002490:	fa040513          	addi	a0,s0,-96
    80002494:	00000097          	auipc	ra,0x0
    80002498:	3ac080e7          	jalr	940(ra) # 80002840 <_Z11stringToIntPKc>
    8000249c:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    800024a0:	00005517          	auipc	a0,0x5
    800024a4:	fb850513          	addi	a0,a0,-72 # 80007458 <CONSOLE_STATUS+0x448>
    800024a8:	00000097          	auipc	ra,0x0
    800024ac:	238080e7          	jalr	568(ra) # 800026e0 <_Z11printStringPKc>
    800024b0:	00000613          	li	a2,0
    800024b4:	00a00593          	li	a1,10
    800024b8:	00090513          	mv	a0,s2
    800024bc:	00000097          	auipc	ra,0x0
    800024c0:	3d4080e7          	jalr	980(ra) # 80002890 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    800024c4:	00005517          	auipc	a0,0x5
    800024c8:	fac50513          	addi	a0,a0,-84 # 80007470 <CONSOLE_STATUS+0x460>
    800024cc:	00000097          	auipc	ra,0x0
    800024d0:	214080e7          	jalr	532(ra) # 800026e0 <_Z11printStringPKc>
    800024d4:	00000613          	li	a2,0
    800024d8:	00a00593          	li	a1,10
    800024dc:	00048513          	mv	a0,s1
    800024e0:	00000097          	auipc	ra,0x0
    800024e4:	3b0080e7          	jalr	944(ra) # 80002890 <_Z8printIntiii>
    printString(".\n");
    800024e8:	00005517          	auipc	a0,0x5
    800024ec:	fa050513          	addi	a0,a0,-96 # 80007488 <CONSOLE_STATUS+0x478>
    800024f0:	00000097          	auipc	ra,0x0
    800024f4:	1f0080e7          	jalr	496(ra) # 800026e0 <_Z11printStringPKc>
    if(threadNum > n) {
    800024f8:	0324c463          	blt	s1,s2,80002520 <_Z22producerConsumer_C_APIv+0x10c>
    } else if (threadNum < 1) {
    800024fc:	03205c63          	blez	s2,80002534 <_Z22producerConsumer_C_APIv+0x120>
    Buffer *buffer = new Buffer(n);
    80002500:	03800513          	li	a0,56
    80002504:	fffff097          	auipc	ra,0xfffff
    80002508:	d3c080e7          	jalr	-708(ra) # 80001240 <_Znwm>
    8000250c:	00050a13          	mv	s4,a0
    80002510:	00048593          	mv	a1,s1
    80002514:	00001097          	auipc	ra,0x1
    80002518:	2c4080e7          	jalr	708(ra) # 800037d8 <_ZN6BufferC1Ei>
    8000251c:	0300006f          	j	8000254c <_Z22producerConsumer_C_APIv+0x138>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80002520:	00005517          	auipc	a0,0x5
    80002524:	f7050513          	addi	a0,a0,-144 # 80007490 <CONSOLE_STATUS+0x480>
    80002528:	00000097          	auipc	ra,0x0
    8000252c:	1b8080e7          	jalr	440(ra) # 800026e0 <_Z11printStringPKc>
        return;
    80002530:	0140006f          	j	80002544 <_Z22producerConsumer_C_APIv+0x130>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    80002534:	00005517          	auipc	a0,0x5
    80002538:	f9c50513          	addi	a0,a0,-100 # 800074d0 <CONSOLE_STATUS+0x4c0>
    8000253c:	00000097          	auipc	ra,0x0
    80002540:	1a4080e7          	jalr	420(ra) # 800026e0 <_Z11printStringPKc>
        return;
    80002544:	000b0113          	mv	sp,s6
    80002548:	1500006f          	j	80002698 <_Z22producerConsumer_C_APIv+0x284>
    sem_open(&waitForAll, 0);
    8000254c:	00000593          	li	a1,0
    80002550:	00007517          	auipc	a0,0x7
    80002554:	82050513          	addi	a0,a0,-2016 # 80008d70 <_ZL10waitForAll>
    80002558:	00000097          	auipc	ra,0x0
    8000255c:	ba4080e7          	jalr	-1116(ra) # 800020fc <_Z8sem_openPP4_semj>
    thread_t threads[threadNum];
    80002560:	00391793          	slli	a5,s2,0x3
    80002564:	00f78793          	addi	a5,a5,15
    80002568:	ff07f793          	andi	a5,a5,-16
    8000256c:	40f10133          	sub	sp,sp,a5
    80002570:	00010a93          	mv	s5,sp
    struct thread_data data[threadNum + 1];
    80002574:	0019071b          	addiw	a4,s2,1
    80002578:	00171793          	slli	a5,a4,0x1
    8000257c:	00e787b3          	add	a5,a5,a4
    80002580:	00379793          	slli	a5,a5,0x3
    80002584:	00f78793          	addi	a5,a5,15
    80002588:	ff07f793          	andi	a5,a5,-16
    8000258c:	40f10133          	sub	sp,sp,a5
    80002590:	00010993          	mv	s3,sp
    data[threadNum].id = threadNum;
    80002594:	00191613          	slli	a2,s2,0x1
    80002598:	012607b3          	add	a5,a2,s2
    8000259c:	00379793          	slli	a5,a5,0x3
    800025a0:	00f987b3          	add	a5,s3,a5
    800025a4:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800025a8:	0147b423          	sd	s4,8(a5)
    data[threadNum].wait = waitForAll;
    800025ac:	00006717          	auipc	a4,0x6
    800025b0:	7c473703          	ld	a4,1988(a4) # 80008d70 <_ZL10waitForAll>
    800025b4:	00e7b823          	sd	a4,16(a5)
    thread_create(&consumerThread, consumer, data + threadNum);
    800025b8:	00078613          	mv	a2,a5
    800025bc:	00000597          	auipc	a1,0x0
    800025c0:	d7858593          	addi	a1,a1,-648 # 80002334 <_ZL8consumerPv>
    800025c4:	f9840513          	addi	a0,s0,-104
    800025c8:	00000097          	auipc	ra,0x0
    800025cc:	a58080e7          	jalr	-1448(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800025d0:	00000493          	li	s1,0
    800025d4:	0280006f          	j	800025fc <_Z22producerConsumer_C_APIv+0x1e8>
        thread_create(threads + i,
    800025d8:	00000597          	auipc	a1,0x0
    800025dc:	c1858593          	addi	a1,a1,-1000 # 800021f0 <_ZL16producerKeyboardPv>
                      data + i);
    800025e0:	00179613          	slli	a2,a5,0x1
    800025e4:	00f60633          	add	a2,a2,a5
    800025e8:	00361613          	slli	a2,a2,0x3
        thread_create(threads + i,
    800025ec:	00c98633          	add	a2,s3,a2
    800025f0:	00000097          	auipc	ra,0x0
    800025f4:	a30080e7          	jalr	-1488(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    800025f8:	0014849b          	addiw	s1,s1,1
    800025fc:	0524d263          	bge	s1,s2,80002640 <_Z22producerConsumer_C_APIv+0x22c>
        data[i].id = i;
    80002600:	00149793          	slli	a5,s1,0x1
    80002604:	009787b3          	add	a5,a5,s1
    80002608:	00379793          	slli	a5,a5,0x3
    8000260c:	00f987b3          	add	a5,s3,a5
    80002610:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    80002614:	0147b423          	sd	s4,8(a5)
        data[i].wait = waitForAll;
    80002618:	00006717          	auipc	a4,0x6
    8000261c:	75873703          	ld	a4,1880(a4) # 80008d70 <_ZL10waitForAll>
    80002620:	00e7b823          	sd	a4,16(a5)
        thread_create(threads + i,
    80002624:	00048793          	mv	a5,s1
    80002628:	00349513          	slli	a0,s1,0x3
    8000262c:	00aa8533          	add	a0,s5,a0
    80002630:	fa9054e3          	blez	s1,800025d8 <_Z22producerConsumer_C_APIv+0x1c4>
    80002634:	00000597          	auipc	a1,0x0
    80002638:	c6c58593          	addi	a1,a1,-916 # 800022a0 <_ZL8producerPv>
    8000263c:	fa5ff06f          	j	800025e0 <_Z22producerConsumer_C_APIv+0x1cc>
    thread_dispatch();
    80002640:	00000097          	auipc	ra,0x0
    80002644:	a18080e7          	jalr	-1512(ra) # 80002058 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    80002648:	00000493          	li	s1,0
    8000264c:	00994e63          	blt	s2,s1,80002668 <_Z22producerConsumer_C_APIv+0x254>
        sem_wait(waitForAll);
    80002650:	00006517          	auipc	a0,0x6
    80002654:	72053503          	ld	a0,1824(a0) # 80008d70 <_ZL10waitForAll>
    80002658:	00000097          	auipc	ra,0x0
    8000265c:	b08080e7          	jalr	-1272(ra) # 80002160 <_Z8sem_waitP4_sem>
    for (int i = 0; i <= threadNum; i++) {
    80002660:	0014849b          	addiw	s1,s1,1
    80002664:	fe9ff06f          	j	8000264c <_Z22producerConsumer_C_APIv+0x238>
    sem_close(waitForAll);
    80002668:	00006517          	auipc	a0,0x6
    8000266c:	70853503          	ld	a0,1800(a0) # 80008d70 <_ZL10waitForAll>
    80002670:	00000097          	auipc	ra,0x0
    80002674:	ac0080e7          	jalr	-1344(ra) # 80002130 <_Z9sem_closeP4_sem>
    delete buffer;
    80002678:	000a0e63          	beqz	s4,80002694 <_Z22producerConsumer_C_APIv+0x280>
    8000267c:	000a0513          	mv	a0,s4
    80002680:	00001097          	auipc	ra,0x1
    80002684:	398080e7          	jalr	920(ra) # 80003a18 <_ZN6BufferD1Ev>
    80002688:	000a0513          	mv	a0,s4
    8000268c:	fffff097          	auipc	ra,0xfffff
    80002690:	c04080e7          	jalr	-1020(ra) # 80001290 <_ZdlPv>
    80002694:	000b0113          	mv	sp,s6

}
    80002698:	f9040113          	addi	sp,s0,-112
    8000269c:	06813083          	ld	ra,104(sp)
    800026a0:	06013403          	ld	s0,96(sp)
    800026a4:	05813483          	ld	s1,88(sp)
    800026a8:	05013903          	ld	s2,80(sp)
    800026ac:	04813983          	ld	s3,72(sp)
    800026b0:	04013a03          	ld	s4,64(sp)
    800026b4:	03813a83          	ld	s5,56(sp)
    800026b8:	03013b03          	ld	s6,48(sp)
    800026bc:	07010113          	addi	sp,sp,112
    800026c0:	00008067          	ret
    800026c4:	00050493          	mv	s1,a0
    Buffer *buffer = new Buffer(n);
    800026c8:	000a0513          	mv	a0,s4
    800026cc:	fffff097          	auipc	ra,0xfffff
    800026d0:	bc4080e7          	jalr	-1084(ra) # 80001290 <_ZdlPv>
    800026d4:	00048513          	mv	a0,s1
    800026d8:	00007097          	auipc	ra,0x7
    800026dc:	7c0080e7          	jalr	1984(ra) # 80009e98 <_Unwind_Resume>

00000000800026e0 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    800026e0:	fe010113          	addi	sp,sp,-32
    800026e4:	00113c23          	sd	ra,24(sp)
    800026e8:	00813823          	sd	s0,16(sp)
    800026ec:	00913423          	sd	s1,8(sp)
    800026f0:	02010413          	addi	s0,sp,32
    800026f4:	00050493          	mv	s1,a0
    LOCK();
    800026f8:	00100613          	li	a2,1
    800026fc:	00000593          	li	a1,0
    80002700:	00006517          	auipc	a0,0x6
    80002704:	67850513          	addi	a0,a0,1656 # 80008d78 <lockPrint>
    80002708:	fffff097          	auipc	ra,0xfffff
    8000270c:	8f8080e7          	jalr	-1800(ra) # 80001000 <copy_and_swap>
    80002710:	00050863          	beqz	a0,80002720 <_Z11printStringPKc+0x40>
    80002714:	00000097          	auipc	ra,0x0
    80002718:	944080e7          	jalr	-1724(ra) # 80002058 <_Z15thread_dispatchv>
    8000271c:	fddff06f          	j	800026f8 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80002720:	0004c503          	lbu	a0,0(s1)
    80002724:	00050a63          	beqz	a0,80002738 <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80002728:	00000097          	auipc	ra,0x0
    8000272c:	9ac080e7          	jalr	-1620(ra) # 800020d4 <_Z4putcc>
        string++;
    80002730:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80002734:	fedff06f          	j	80002720 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80002738:	00000613          	li	a2,0
    8000273c:	00100593          	li	a1,1
    80002740:	00006517          	auipc	a0,0x6
    80002744:	63850513          	addi	a0,a0,1592 # 80008d78 <lockPrint>
    80002748:	fffff097          	auipc	ra,0xfffff
    8000274c:	8b8080e7          	jalr	-1864(ra) # 80001000 <copy_and_swap>
    80002750:	fe0514e3          	bnez	a0,80002738 <_Z11printStringPKc+0x58>
}
    80002754:	01813083          	ld	ra,24(sp)
    80002758:	01013403          	ld	s0,16(sp)
    8000275c:	00813483          	ld	s1,8(sp)
    80002760:	02010113          	addi	sp,sp,32
    80002764:	00008067          	ret

0000000080002768 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80002768:	fd010113          	addi	sp,sp,-48
    8000276c:	02113423          	sd	ra,40(sp)
    80002770:	02813023          	sd	s0,32(sp)
    80002774:	00913c23          	sd	s1,24(sp)
    80002778:	01213823          	sd	s2,16(sp)
    8000277c:	01313423          	sd	s3,8(sp)
    80002780:	01413023          	sd	s4,0(sp)
    80002784:	03010413          	addi	s0,sp,48
    80002788:	00050993          	mv	s3,a0
    8000278c:	00058a13          	mv	s4,a1
    LOCK();
    80002790:	00100613          	li	a2,1
    80002794:	00000593          	li	a1,0
    80002798:	00006517          	auipc	a0,0x6
    8000279c:	5e050513          	addi	a0,a0,1504 # 80008d78 <lockPrint>
    800027a0:	fffff097          	auipc	ra,0xfffff
    800027a4:	860080e7          	jalr	-1952(ra) # 80001000 <copy_and_swap>
    800027a8:	00050863          	beqz	a0,800027b8 <_Z9getStringPci+0x50>
    800027ac:	00000097          	auipc	ra,0x0
    800027b0:	8ac080e7          	jalr	-1876(ra) # 80002058 <_Z15thread_dispatchv>
    800027b4:	fddff06f          	j	80002790 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    800027b8:	00000913          	li	s2,0
    800027bc:	00090493          	mv	s1,s2
    800027c0:	0019091b          	addiw	s2,s2,1
    800027c4:	03495a63          	bge	s2,s4,800027f8 <_Z9getStringPci+0x90>
        cc = getc();
    800027c8:	00000097          	auipc	ra,0x0
    800027cc:	8e0080e7          	jalr	-1824(ra) # 800020a8 <_Z4getcv>
        if(cc < 1)
    800027d0:	02050463          	beqz	a0,800027f8 <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    800027d4:	009984b3          	add	s1,s3,s1
    800027d8:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    800027dc:	00a00793          	li	a5,10
    800027e0:	00f50a63          	beq	a0,a5,800027f4 <_Z9getStringPci+0x8c>
    800027e4:	00d00793          	li	a5,13
    800027e8:	fcf51ae3          	bne	a0,a5,800027bc <_Z9getStringPci+0x54>
        buf[i++] = c;
    800027ec:	00090493          	mv	s1,s2
    800027f0:	0080006f          	j	800027f8 <_Z9getStringPci+0x90>
    800027f4:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    800027f8:	009984b3          	add	s1,s3,s1
    800027fc:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80002800:	00000613          	li	a2,0
    80002804:	00100593          	li	a1,1
    80002808:	00006517          	auipc	a0,0x6
    8000280c:	57050513          	addi	a0,a0,1392 # 80008d78 <lockPrint>
    80002810:	ffffe097          	auipc	ra,0xffffe
    80002814:	7f0080e7          	jalr	2032(ra) # 80001000 <copy_and_swap>
    80002818:	fe0514e3          	bnez	a0,80002800 <_Z9getStringPci+0x98>
    return buf;
}
    8000281c:	00098513          	mv	a0,s3
    80002820:	02813083          	ld	ra,40(sp)
    80002824:	02013403          	ld	s0,32(sp)
    80002828:	01813483          	ld	s1,24(sp)
    8000282c:	01013903          	ld	s2,16(sp)
    80002830:	00813983          	ld	s3,8(sp)
    80002834:	00013a03          	ld	s4,0(sp)
    80002838:	03010113          	addi	sp,sp,48
    8000283c:	00008067          	ret

0000000080002840 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80002840:	ff010113          	addi	sp,sp,-16
    80002844:	00813423          	sd	s0,8(sp)
    80002848:	01010413          	addi	s0,sp,16
    8000284c:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80002850:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80002854:	0006c603          	lbu	a2,0(a3)
    80002858:	fd06071b          	addiw	a4,a2,-48
    8000285c:	0ff77713          	andi	a4,a4,255
    80002860:	00900793          	li	a5,9
    80002864:	02e7e063          	bltu	a5,a4,80002884 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80002868:	0025179b          	slliw	a5,a0,0x2
    8000286c:	00a787bb          	addw	a5,a5,a0
    80002870:	0017979b          	slliw	a5,a5,0x1
    80002874:	00168693          	addi	a3,a3,1
    80002878:	00c787bb          	addw	a5,a5,a2
    8000287c:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80002880:	fd5ff06f          	j	80002854 <_Z11stringToIntPKc+0x14>
    return n;
}
    80002884:	00813403          	ld	s0,8(sp)
    80002888:	01010113          	addi	sp,sp,16
    8000288c:	00008067          	ret

0000000080002890 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80002890:	fc010113          	addi	sp,sp,-64
    80002894:	02113c23          	sd	ra,56(sp)
    80002898:	02813823          	sd	s0,48(sp)
    8000289c:	02913423          	sd	s1,40(sp)
    800028a0:	03213023          	sd	s2,32(sp)
    800028a4:	01313c23          	sd	s3,24(sp)
    800028a8:	04010413          	addi	s0,sp,64
    800028ac:	00050493          	mv	s1,a0
    800028b0:	00058913          	mv	s2,a1
    800028b4:	00060993          	mv	s3,a2
    LOCK();
    800028b8:	00100613          	li	a2,1
    800028bc:	00000593          	li	a1,0
    800028c0:	00006517          	auipc	a0,0x6
    800028c4:	4b850513          	addi	a0,a0,1208 # 80008d78 <lockPrint>
    800028c8:	ffffe097          	auipc	ra,0xffffe
    800028cc:	738080e7          	jalr	1848(ra) # 80001000 <copy_and_swap>
    800028d0:	00050863          	beqz	a0,800028e0 <_Z8printIntiii+0x50>
    800028d4:	fffff097          	auipc	ra,0xfffff
    800028d8:	784080e7          	jalr	1924(ra) # 80002058 <_Z15thread_dispatchv>
    800028dc:	fddff06f          	j	800028b8 <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    800028e0:	00098463          	beqz	s3,800028e8 <_Z8printIntiii+0x58>
    800028e4:	0804c463          	bltz	s1,8000296c <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    800028e8:	0004851b          	sext.w	a0,s1
    neg = 0;
    800028ec:	00000593          	li	a1,0
    }

    i = 0;
    800028f0:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    800028f4:	0009079b          	sext.w	a5,s2
    800028f8:	0325773b          	remuw	a4,a0,s2
    800028fc:	00048613          	mv	a2,s1
    80002900:	0014849b          	addiw	s1,s1,1
    80002904:	02071693          	slli	a3,a4,0x20
    80002908:	0206d693          	srli	a3,a3,0x20
    8000290c:	00006717          	auipc	a4,0x6
    80002910:	28470713          	addi	a4,a4,644 # 80008b90 <digits>
    80002914:	00d70733          	add	a4,a4,a3
    80002918:	00074683          	lbu	a3,0(a4)
    8000291c:	fd040713          	addi	a4,s0,-48
    80002920:	00c70733          	add	a4,a4,a2
    80002924:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80002928:	0005071b          	sext.w	a4,a0
    8000292c:	0325553b          	divuw	a0,a0,s2
    80002930:	fcf772e3          	bgeu	a4,a5,800028f4 <_Z8printIntiii+0x64>
    if(neg)
    80002934:	00058c63          	beqz	a1,8000294c <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80002938:	fd040793          	addi	a5,s0,-48
    8000293c:	009784b3          	add	s1,a5,s1
    80002940:	02d00793          	li	a5,45
    80002944:	fef48823          	sb	a5,-16(s1)
    80002948:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    8000294c:	fff4849b          	addiw	s1,s1,-1
    80002950:	0204c463          	bltz	s1,80002978 <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80002954:	fd040793          	addi	a5,s0,-48
    80002958:	009787b3          	add	a5,a5,s1
    8000295c:	ff07c503          	lbu	a0,-16(a5)
    80002960:	fffff097          	auipc	ra,0xfffff
    80002964:	774080e7          	jalr	1908(ra) # 800020d4 <_Z4putcc>
    80002968:	fe5ff06f          	j	8000294c <_Z8printIntiii+0xbc>
        x = -xx;
    8000296c:	4090053b          	negw	a0,s1
        neg = 1;
    80002970:	00100593          	li	a1,1
        x = -xx;
    80002974:	f7dff06f          	j	800028f0 <_Z8printIntiii+0x60>

    UNLOCK();
    80002978:	00000613          	li	a2,0
    8000297c:	00100593          	li	a1,1
    80002980:	00006517          	auipc	a0,0x6
    80002984:	3f850513          	addi	a0,a0,1016 # 80008d78 <lockPrint>
    80002988:	ffffe097          	auipc	ra,0xffffe
    8000298c:	678080e7          	jalr	1656(ra) # 80001000 <copy_and_swap>
    80002990:	fe0514e3          	bnez	a0,80002978 <_Z8printIntiii+0xe8>
    80002994:	03813083          	ld	ra,56(sp)
    80002998:	03013403          	ld	s0,48(sp)
    8000299c:	02813483          	ld	s1,40(sp)
    800029a0:	02013903          	ld	s2,32(sp)
    800029a4:	01813983          	ld	s3,24(sp)
    800029a8:	04010113          	addi	sp,sp,64
    800029ac:	00008067          	ret

00000000800029b0 <_ZN9BufferCPPC1Ei>:
#include "buffer_CPP_API.hpp"

BufferCPP::BufferCPP(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800029b0:	fd010113          	addi	sp,sp,-48
    800029b4:	02113423          	sd	ra,40(sp)
    800029b8:	02813023          	sd	s0,32(sp)
    800029bc:	00913c23          	sd	s1,24(sp)
    800029c0:	01213823          	sd	s2,16(sp)
    800029c4:	01313423          	sd	s3,8(sp)
    800029c8:	03010413          	addi	s0,sp,48
    800029cc:	00050493          	mv	s1,a0
    800029d0:	00058993          	mv	s3,a1
    800029d4:	0015879b          	addiw	a5,a1,1
    800029d8:	0007851b          	sext.w	a0,a5
    800029dc:	00f4a023          	sw	a5,0(s1)
    800029e0:	0004a823          	sw	zero,16(s1)
    800029e4:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)MemoryAllocator::mem_alloc(sizeof(int) * cap);
    800029e8:	00251513          	slli	a0,a0,0x2
    800029ec:	fffff097          	auipc	ra,0xfffff
    800029f0:	a98080e7          	jalr	-1384(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
    800029f4:	00a4b423          	sd	a0,8(s1)
    itemAvailable = new Semaphore(0);
    800029f8:	01000513          	li	a0,16
    800029fc:	fffff097          	auipc	ra,0xfffff
    80002a00:	844080e7          	jalr	-1980(ra) # 80001240 <_Znwm>
    80002a04:	00050913          	mv	s2,a0
};


class Semaphore{
public:
    Semaphore(unsigned init=1){
    80002a08:	00005797          	auipc	a5,0x5
    80002a0c:	b2078793          	addi	a5,a5,-1248 # 80007528 <_ZTV9Semaphore+0x10>
    80002a10:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80002a14:	00000593          	li	a1,0
    80002a18:	00850513          	addi	a0,a0,8
    80002a1c:	fffff097          	auipc	ra,0xfffff
    80002a20:	6e0080e7          	jalr	1760(ra) # 800020fc <_Z8sem_openPP4_semj>
    80002a24:	0324b023          	sd	s2,32(s1)
    spaceAvailable = new Semaphore(_cap);
    80002a28:	01000513          	li	a0,16
    80002a2c:	fffff097          	auipc	ra,0xfffff
    80002a30:	814080e7          	jalr	-2028(ra) # 80001240 <_Znwm>
    80002a34:	00050913          	mv	s2,a0
    Semaphore(unsigned init=1){
    80002a38:	00005797          	auipc	a5,0x5
    80002a3c:	af078793          	addi	a5,a5,-1296 # 80007528 <_ZTV9Semaphore+0x10>
    80002a40:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80002a44:	00098593          	mv	a1,s3
    80002a48:	00850513          	addi	a0,a0,8
    80002a4c:	fffff097          	auipc	ra,0xfffff
    80002a50:	6b0080e7          	jalr	1712(ra) # 800020fc <_Z8sem_openPP4_semj>
    80002a54:	0124bc23          	sd	s2,24(s1)
    mutexHead = new Semaphore(1);
    80002a58:	01000513          	li	a0,16
    80002a5c:	ffffe097          	auipc	ra,0xffffe
    80002a60:	7e4080e7          	jalr	2020(ra) # 80001240 <_Znwm>
    80002a64:	00050913          	mv	s2,a0
    Semaphore(unsigned init=1){
    80002a68:	00005797          	auipc	a5,0x5
    80002a6c:	ac078793          	addi	a5,a5,-1344 # 80007528 <_ZTV9Semaphore+0x10>
    80002a70:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80002a74:	00100593          	li	a1,1
    80002a78:	00850513          	addi	a0,a0,8
    80002a7c:	fffff097          	auipc	ra,0xfffff
    80002a80:	680080e7          	jalr	1664(ra) # 800020fc <_Z8sem_openPP4_semj>
    80002a84:	0324b423          	sd	s2,40(s1)
    mutexTail = new Semaphore(1);
    80002a88:	01000513          	li	a0,16
    80002a8c:	ffffe097          	auipc	ra,0xffffe
    80002a90:	7b4080e7          	jalr	1972(ra) # 80001240 <_Znwm>
    80002a94:	00050913          	mv	s2,a0
    Semaphore(unsigned init=1){
    80002a98:	00005797          	auipc	a5,0x5
    80002a9c:	a9078793          	addi	a5,a5,-1392 # 80007528 <_ZTV9Semaphore+0x10>
    80002aa0:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80002aa4:	00100593          	li	a1,1
    80002aa8:	00850513          	addi	a0,a0,8
    80002aac:	fffff097          	auipc	ra,0xfffff
    80002ab0:	650080e7          	jalr	1616(ra) # 800020fc <_Z8sem_openPP4_semj>
    80002ab4:	0324b823          	sd	s2,48(s1)
}
    80002ab8:	02813083          	ld	ra,40(sp)
    80002abc:	02013403          	ld	s0,32(sp)
    80002ac0:	01813483          	ld	s1,24(sp)
    80002ac4:	01013903          	ld	s2,16(sp)
    80002ac8:	00813983          	ld	s3,8(sp)
    80002acc:	03010113          	addi	sp,sp,48
    80002ad0:	00008067          	ret
    80002ad4:	00050493          	mv	s1,a0
    itemAvailable = new Semaphore(0);
    80002ad8:	00090513          	mv	a0,s2
    80002adc:	ffffe097          	auipc	ra,0xffffe
    80002ae0:	7b4080e7          	jalr	1972(ra) # 80001290 <_ZdlPv>
    80002ae4:	00048513          	mv	a0,s1
    80002ae8:	00007097          	auipc	ra,0x7
    80002aec:	3b0080e7          	jalr	944(ra) # 80009e98 <_Unwind_Resume>
    80002af0:	00050493          	mv	s1,a0
    spaceAvailable = new Semaphore(_cap);
    80002af4:	00090513          	mv	a0,s2
    80002af8:	ffffe097          	auipc	ra,0xffffe
    80002afc:	798080e7          	jalr	1944(ra) # 80001290 <_ZdlPv>
    80002b00:	00048513          	mv	a0,s1
    80002b04:	00007097          	auipc	ra,0x7
    80002b08:	394080e7          	jalr	916(ra) # 80009e98 <_Unwind_Resume>
    80002b0c:	00050493          	mv	s1,a0
    mutexHead = new Semaphore(1);
    80002b10:	00090513          	mv	a0,s2
    80002b14:	ffffe097          	auipc	ra,0xffffe
    80002b18:	77c080e7          	jalr	1916(ra) # 80001290 <_ZdlPv>
    80002b1c:	00048513          	mv	a0,s1
    80002b20:	00007097          	auipc	ra,0x7
    80002b24:	378080e7          	jalr	888(ra) # 80009e98 <_Unwind_Resume>
    80002b28:	00050493          	mv	s1,a0
    mutexTail = new Semaphore(1);
    80002b2c:	00090513          	mv	a0,s2
    80002b30:	ffffe097          	auipc	ra,0xffffe
    80002b34:	760080e7          	jalr	1888(ra) # 80001290 <_ZdlPv>
    80002b38:	00048513          	mv	a0,s1
    80002b3c:	00007097          	auipc	ra,0x7
    80002b40:	35c080e7          	jalr	860(ra) # 80009e98 <_Unwind_Resume>

0000000080002b44 <_ZN9BufferCPP3putEi>:
    delete mutexTail;
    delete mutexHead;

}

void BufferCPP::put(int val) {
    80002b44:	fe010113          	addi	sp,sp,-32
    80002b48:	00113c23          	sd	ra,24(sp)
    80002b4c:	00813823          	sd	s0,16(sp)
    80002b50:	00913423          	sd	s1,8(sp)
    80002b54:	01213023          	sd	s2,0(sp)
    80002b58:	02010413          	addi	s0,sp,32
    80002b5c:	00050493          	mv	s1,a0
    80002b60:	00058913          	mv	s2,a1
    spaceAvailable->wait();
    80002b64:	01853783          	ld	a5,24(a0)
    virtual ~Semaphore(){
        sem_close(myHandle);
    };

    int wait(){
        return sem_wait(myHandle);
    80002b68:	0087b503          	ld	a0,8(a5)
    80002b6c:	fffff097          	auipc	ra,0xfffff
    80002b70:	5f4080e7          	jalr	1524(ra) # 80002160 <_Z8sem_waitP4_sem>

    mutexTail->wait();
    80002b74:	0304b783          	ld	a5,48(s1)
    80002b78:	0087b503          	ld	a0,8(a5)
    80002b7c:	fffff097          	auipc	ra,0xfffff
    80002b80:	5e4080e7          	jalr	1508(ra) # 80002160 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    80002b84:	0084b783          	ld	a5,8(s1)
    80002b88:	0144a703          	lw	a4,20(s1)
    80002b8c:	00271713          	slli	a4,a4,0x2
    80002b90:	00e787b3          	add	a5,a5,a4
    80002b94:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    80002b98:	0144a783          	lw	a5,20(s1)
    80002b9c:	0017879b          	addiw	a5,a5,1
    80002ba0:	0004a703          	lw	a4,0(s1)
    80002ba4:	02e7e7bb          	remw	a5,a5,a4
    80002ba8:	00f4aa23          	sw	a5,20(s1)
    mutexTail->signal();
    80002bac:	0304b783          	ld	a5,48(s1)
    }
    int signal(){
        return sem_signal(myHandle);
    80002bb0:	0087b503          	ld	a0,8(a5)
    80002bb4:	fffff097          	auipc	ra,0xfffff
    80002bb8:	5dc080e7          	jalr	1500(ra) # 80002190 <_Z10sem_signalP4_sem>

    itemAvailable->signal();
    80002bbc:	0204b783          	ld	a5,32(s1)
    80002bc0:	0087b503          	ld	a0,8(a5)
    80002bc4:	fffff097          	auipc	ra,0xfffff
    80002bc8:	5cc080e7          	jalr	1484(ra) # 80002190 <_Z10sem_signalP4_sem>

}
    80002bcc:	01813083          	ld	ra,24(sp)
    80002bd0:	01013403          	ld	s0,16(sp)
    80002bd4:	00813483          	ld	s1,8(sp)
    80002bd8:	00013903          	ld	s2,0(sp)
    80002bdc:	02010113          	addi	sp,sp,32
    80002be0:	00008067          	ret

0000000080002be4 <_ZN9BufferCPP3getEv>:

int BufferCPP::get() {
    80002be4:	fe010113          	addi	sp,sp,-32
    80002be8:	00113c23          	sd	ra,24(sp)
    80002bec:	00813823          	sd	s0,16(sp)
    80002bf0:	00913423          	sd	s1,8(sp)
    80002bf4:	01213023          	sd	s2,0(sp)
    80002bf8:	02010413          	addi	s0,sp,32
    80002bfc:	00050493          	mv	s1,a0
    itemAvailable->wait();
    80002c00:	02053783          	ld	a5,32(a0)
        return sem_wait(myHandle);
    80002c04:	0087b503          	ld	a0,8(a5)
    80002c08:	fffff097          	auipc	ra,0xfffff
    80002c0c:	558080e7          	jalr	1368(ra) # 80002160 <_Z8sem_waitP4_sem>

    mutexHead->wait();
    80002c10:	0284b783          	ld	a5,40(s1)
    80002c14:	0087b503          	ld	a0,8(a5)
    80002c18:	fffff097          	auipc	ra,0xfffff
    80002c1c:	548080e7          	jalr	1352(ra) # 80002160 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80002c20:	0084b703          	ld	a4,8(s1)
    80002c24:	0104a783          	lw	a5,16(s1)
    80002c28:	00279693          	slli	a3,a5,0x2
    80002c2c:	00d70733          	add	a4,a4,a3
    80002c30:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    80002c34:	0017879b          	addiw	a5,a5,1
    80002c38:	0004a703          	lw	a4,0(s1)
    80002c3c:	02e7e7bb          	remw	a5,a5,a4
    80002c40:	00f4a823          	sw	a5,16(s1)
    mutexHead->signal();
    80002c44:	0284b783          	ld	a5,40(s1)
        return sem_signal(myHandle);
    80002c48:	0087b503          	ld	a0,8(a5)
    80002c4c:	fffff097          	auipc	ra,0xfffff
    80002c50:	544080e7          	jalr	1348(ra) # 80002190 <_Z10sem_signalP4_sem>

    spaceAvailable->signal();
    80002c54:	0184b783          	ld	a5,24(s1)
    80002c58:	0087b503          	ld	a0,8(a5)
    80002c5c:	fffff097          	auipc	ra,0xfffff
    80002c60:	534080e7          	jalr	1332(ra) # 80002190 <_Z10sem_signalP4_sem>

    return ret;
}
    80002c64:	00090513          	mv	a0,s2
    80002c68:	01813083          	ld	ra,24(sp)
    80002c6c:	01013403          	ld	s0,16(sp)
    80002c70:	00813483          	ld	s1,8(sp)
    80002c74:	00013903          	ld	s2,0(sp)
    80002c78:	02010113          	addi	sp,sp,32
    80002c7c:	00008067          	ret

0000000080002c80 <_ZN9BufferCPP6getCntEv>:

int BufferCPP::getCnt() {
    80002c80:	fe010113          	addi	sp,sp,-32
    80002c84:	00113c23          	sd	ra,24(sp)
    80002c88:	00813823          	sd	s0,16(sp)
    80002c8c:	00913423          	sd	s1,8(sp)
    80002c90:	01213023          	sd	s2,0(sp)
    80002c94:	02010413          	addi	s0,sp,32
    80002c98:	00050493          	mv	s1,a0
    int ret;

    mutexHead->wait();
    80002c9c:	02853783          	ld	a5,40(a0)
        return sem_wait(myHandle);
    80002ca0:	0087b503          	ld	a0,8(a5)
    80002ca4:	fffff097          	auipc	ra,0xfffff
    80002ca8:	4bc080e7          	jalr	1212(ra) # 80002160 <_Z8sem_waitP4_sem>
    mutexTail->wait();
    80002cac:	0304b783          	ld	a5,48(s1)
    80002cb0:	0087b503          	ld	a0,8(a5)
    80002cb4:	fffff097          	auipc	ra,0xfffff
    80002cb8:	4ac080e7          	jalr	1196(ra) # 80002160 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    80002cbc:	0144a783          	lw	a5,20(s1)
    80002cc0:	0104a903          	lw	s2,16(s1)
    80002cc4:	0527c263          	blt	a5,s2,80002d08 <_ZN9BufferCPP6getCntEv+0x88>
        ret = tail - head;
    80002cc8:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    mutexTail->signal();
    80002ccc:	0304b783          	ld	a5,48(s1)
        return sem_signal(myHandle);
    80002cd0:	0087b503          	ld	a0,8(a5)
    80002cd4:	fffff097          	auipc	ra,0xfffff
    80002cd8:	4bc080e7          	jalr	1212(ra) # 80002190 <_Z10sem_signalP4_sem>
    mutexHead->signal();
    80002cdc:	0284b783          	ld	a5,40(s1)
    80002ce0:	0087b503          	ld	a0,8(a5)
    80002ce4:	fffff097          	auipc	ra,0xfffff
    80002ce8:	4ac080e7          	jalr	1196(ra) # 80002190 <_Z10sem_signalP4_sem>

    return ret;
}
    80002cec:	00090513          	mv	a0,s2
    80002cf0:	01813083          	ld	ra,24(sp)
    80002cf4:	01013403          	ld	s0,16(sp)
    80002cf8:	00813483          	ld	s1,8(sp)
    80002cfc:	00013903          	ld	s2,0(sp)
    80002d00:	02010113          	addi	sp,sp,32
    80002d04:	00008067          	ret
        ret = cap - head + tail;
    80002d08:	0004a703          	lw	a4,0(s1)
    80002d0c:	4127093b          	subw	s2,a4,s2
    80002d10:	00f9093b          	addw	s2,s2,a5
    80002d14:	fb9ff06f          	j	80002ccc <_ZN9BufferCPP6getCntEv+0x4c>

0000000080002d18 <_ZN9BufferCPPD1Ev>:
BufferCPP::~BufferCPP() {
    80002d18:	fe010113          	addi	sp,sp,-32
    80002d1c:	00113c23          	sd	ra,24(sp)
    80002d20:	00813823          	sd	s0,16(sp)
    80002d24:	00913423          	sd	s1,8(sp)
    80002d28:	02010413          	addi	s0,sp,32
    80002d2c:	00050493          	mv	s1,a0
    putc('\n');
    80002d30:	00a00513          	li	a0,10
    80002d34:	fffff097          	auipc	ra,0xfffff
    80002d38:	3a0080e7          	jalr	928(ra) # 800020d4 <_Z4putcc>
    printString("Buffer deleted!\n");
    80002d3c:	00004517          	auipc	a0,0x4
    80002d40:	7c450513          	addi	a0,a0,1988 # 80007500 <CONSOLE_STATUS+0x4f0>
    80002d44:	00000097          	auipc	ra,0x0
    80002d48:	99c080e7          	jalr	-1636(ra) # 800026e0 <_Z11printStringPKc>
    while (getCnt()) {
    80002d4c:	00048513          	mv	a0,s1
    80002d50:	00000097          	auipc	ra,0x0
    80002d54:	f30080e7          	jalr	-208(ra) # 80002c80 <_ZN9BufferCPP6getCntEv>
    80002d58:	02050c63          	beqz	a0,80002d90 <_ZN9BufferCPPD1Ev+0x78>
        char ch = buffer[head];
    80002d5c:	0084b783          	ld	a5,8(s1)
    80002d60:	0104a703          	lw	a4,16(s1)
    80002d64:	00271713          	slli	a4,a4,0x2
    80002d68:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80002d6c:	0007c503          	lbu	a0,0(a5)
    80002d70:	fffff097          	auipc	ra,0xfffff
    80002d74:	364080e7          	jalr	868(ra) # 800020d4 <_Z4putcc>
        head = (head + 1) % cap;
    80002d78:	0104a783          	lw	a5,16(s1)
    80002d7c:	0017879b          	addiw	a5,a5,1
    80002d80:	0004a703          	lw	a4,0(s1)
    80002d84:	02e7e7bb          	remw	a5,a5,a4
    80002d88:	00f4a823          	sw	a5,16(s1)
    while (getCnt()) {
    80002d8c:	fc1ff06f          	j	80002d4c <_ZN9BufferCPPD1Ev+0x34>
    putc('!');
    80002d90:	02100513          	li	a0,33
    80002d94:	fffff097          	auipc	ra,0xfffff
    80002d98:	340080e7          	jalr	832(ra) # 800020d4 <_Z4putcc>
    putc('\n');
    80002d9c:	00a00513          	li	a0,10
    80002da0:	fffff097          	auipc	ra,0xfffff
    80002da4:	334080e7          	jalr	820(ra) # 800020d4 <_Z4putcc>
    MemoryAllocator::mem_free(buffer);
    80002da8:	0084b503          	ld	a0,8(s1)
    80002dac:	ffffe097          	auipc	ra,0xffffe
    80002db0:	7a0080e7          	jalr	1952(ra) # 8000154c <_ZN15MemoryAllocator8mem_freeEPv>
    delete itemAvailable;
    80002db4:	0204b503          	ld	a0,32(s1)
    80002db8:	00050863          	beqz	a0,80002dc8 <_ZN9BufferCPPD1Ev+0xb0>
    80002dbc:	00053783          	ld	a5,0(a0)
    80002dc0:	0087b783          	ld	a5,8(a5)
    80002dc4:	000780e7          	jalr	a5
    delete spaceAvailable;
    80002dc8:	0184b503          	ld	a0,24(s1)
    80002dcc:	00050863          	beqz	a0,80002ddc <_ZN9BufferCPPD1Ev+0xc4>
    80002dd0:	00053783          	ld	a5,0(a0)
    80002dd4:	0087b783          	ld	a5,8(a5)
    80002dd8:	000780e7          	jalr	a5
    delete mutexTail;
    80002ddc:	0304b503          	ld	a0,48(s1)
    80002de0:	00050863          	beqz	a0,80002df0 <_ZN9BufferCPPD1Ev+0xd8>
    80002de4:	00053783          	ld	a5,0(a0)
    80002de8:	0087b783          	ld	a5,8(a5)
    80002dec:	000780e7          	jalr	a5
    delete mutexHead;
    80002df0:	0284b503          	ld	a0,40(s1)
    80002df4:	00050863          	beqz	a0,80002e04 <_ZN9BufferCPPD1Ev+0xec>
    80002df8:	00053783          	ld	a5,0(a0)
    80002dfc:	0087b783          	ld	a5,8(a5)
    80002e00:	000780e7          	jalr	a5
}
    80002e04:	01813083          	ld	ra,24(sp)
    80002e08:	01013403          	ld	s0,16(sp)
    80002e0c:	00813483          	ld	s1,8(sp)
    80002e10:	02010113          	addi	sp,sp,32
    80002e14:	00008067          	ret

0000000080002e18 <_ZN9SemaphoreD1Ev>:
    virtual ~Semaphore(){
    80002e18:	ff010113          	addi	sp,sp,-16
    80002e1c:	00113423          	sd	ra,8(sp)
    80002e20:	00813023          	sd	s0,0(sp)
    80002e24:	01010413          	addi	s0,sp,16
    80002e28:	00004797          	auipc	a5,0x4
    80002e2c:	70078793          	addi	a5,a5,1792 # 80007528 <_ZTV9Semaphore+0x10>
    80002e30:	00f53023          	sd	a5,0(a0)
        sem_close(myHandle);
    80002e34:	00853503          	ld	a0,8(a0)
    80002e38:	fffff097          	auipc	ra,0xfffff
    80002e3c:	2f8080e7          	jalr	760(ra) # 80002130 <_Z9sem_closeP4_sem>
    };
    80002e40:	00813083          	ld	ra,8(sp)
    80002e44:	00013403          	ld	s0,0(sp)
    80002e48:	01010113          	addi	sp,sp,16
    80002e4c:	00008067          	ret

0000000080002e50 <_ZN9SemaphoreD0Ev>:
    virtual ~Semaphore(){
    80002e50:	fe010113          	addi	sp,sp,-32
    80002e54:	00113c23          	sd	ra,24(sp)
    80002e58:	00813823          	sd	s0,16(sp)
    80002e5c:	00913423          	sd	s1,8(sp)
    80002e60:	02010413          	addi	s0,sp,32
    80002e64:	00050493          	mv	s1,a0
    80002e68:	00004797          	auipc	a5,0x4
    80002e6c:	6c078793          	addi	a5,a5,1728 # 80007528 <_ZTV9Semaphore+0x10>
    80002e70:	00f53023          	sd	a5,0(a0)
        sem_close(myHandle);
    80002e74:	00853503          	ld	a0,8(a0)
    80002e78:	fffff097          	auipc	ra,0xfffff
    80002e7c:	2b8080e7          	jalr	696(ra) # 80002130 <_Z9sem_closeP4_sem>
    };
    80002e80:	00048513          	mv	a0,s1
    80002e84:	ffffe097          	auipc	ra,0xffffe
    80002e88:	40c080e7          	jalr	1036(ra) # 80001290 <_ZdlPv>
    80002e8c:	01813083          	ld	ra,24(sp)
    80002e90:	01013403          	ld	s0,16(sp)
    80002e94:	00813483          	ld	s1,8(sp)
    80002e98:	02010113          	addi	sp,sp,32
    80002e9c:	00008067          	ret

0000000080002ea0 <_ZN16ProducerKeyboard16producerKeyboardEPv>:
    void run() override {
        producerKeyboard(td);
    }
};

void ProducerKeyboard::producerKeyboard(void *arg) {
    80002ea0:	fd010113          	addi	sp,sp,-48
    80002ea4:	02113423          	sd	ra,40(sp)
    80002ea8:	02813023          	sd	s0,32(sp)
    80002eac:	00913c23          	sd	s1,24(sp)
    80002eb0:	01213823          	sd	s2,16(sp)
    80002eb4:	01313423          	sd	s3,8(sp)
    80002eb8:	03010413          	addi	s0,sp,48
    80002ebc:	00050993          	mv	s3,a0
    80002ec0:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int key;
    int i = 0;
    80002ec4:	00000913          	li	s2,0
    80002ec8:	00c0006f          	j	80002ed4 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    static void dispatch() {thread_dispatch();}
    80002ecc:	fffff097          	auipc	ra,0xfffff
    80002ed0:	18c080e7          	jalr	396(ra) # 80002058 <_Z15thread_dispatchv>
    while ((key = getc()) != 0x1b) {
    80002ed4:	fffff097          	auipc	ra,0xfffff
    80002ed8:	1d4080e7          	jalr	468(ra) # 800020a8 <_Z4getcv>
    80002edc:	0005059b          	sext.w	a1,a0
    80002ee0:	01b00793          	li	a5,27
    80002ee4:	02f58a63          	beq	a1,a5,80002f18 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x78>
        data->buffer->put(key);
    80002ee8:	0084b503          	ld	a0,8(s1)
    80002eec:	00000097          	auipc	ra,0x0
    80002ef0:	c58080e7          	jalr	-936(ra) # 80002b44 <_ZN9BufferCPP3putEi>
        i++;
    80002ef4:	0019071b          	addiw	a4,s2,1
    80002ef8:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80002efc:	0004a683          	lw	a3,0(s1)
    80002f00:	0026979b          	slliw	a5,a3,0x2
    80002f04:	00d787bb          	addw	a5,a5,a3
    80002f08:	0017979b          	slliw	a5,a5,0x1
    80002f0c:	02f767bb          	remw	a5,a4,a5
    80002f10:	fc0792e3          	bnez	a5,80002ed4 <_ZN16ProducerKeyboard16producerKeyboardEPv+0x34>
    80002f14:	fb9ff06f          	j	80002ecc <_ZN16ProducerKeyboard16producerKeyboardEPv+0x2c>
            Thread::dispatch();
        }
    }

    threadEnd = 1;
    80002f18:	00100793          	li	a5,1
    80002f1c:	00006717          	auipc	a4,0x6
    80002f20:	e6f72223          	sw	a5,-412(a4) # 80008d80 <_ZL9threadEnd>
    td->buffer->put('!');
    80002f24:	0209b783          	ld	a5,32(s3)
    80002f28:	02100593          	li	a1,33
    80002f2c:	0087b503          	ld	a0,8(a5)
    80002f30:	00000097          	auipc	ra,0x0
    80002f34:	c14080e7          	jalr	-1004(ra) # 80002b44 <_ZN9BufferCPP3putEi>

    data->wait->signal();
    80002f38:	0104b783          	ld	a5,16(s1)
        return sem_signal(myHandle);
    80002f3c:	0087b503          	ld	a0,8(a5)
    80002f40:	fffff097          	auipc	ra,0xfffff
    80002f44:	250080e7          	jalr	592(ra) # 80002190 <_Z10sem_signalP4_sem>
}
    80002f48:	02813083          	ld	ra,40(sp)
    80002f4c:	02013403          	ld	s0,32(sp)
    80002f50:	01813483          	ld	s1,24(sp)
    80002f54:	01013903          	ld	s2,16(sp)
    80002f58:	00813983          	ld	s3,8(sp)
    80002f5c:	03010113          	addi	sp,sp,48
    80002f60:	00008067          	ret

0000000080002f64 <_ZN12ProducerSync8producerEPv>:
    void run() override {
        producer(td);
    }
};

void ProducerSync::producer(void *arg) {
    80002f64:	fe010113          	addi	sp,sp,-32
    80002f68:	00113c23          	sd	ra,24(sp)
    80002f6c:	00813823          	sd	s0,16(sp)
    80002f70:	00913423          	sd	s1,8(sp)
    80002f74:	01213023          	sd	s2,0(sp)
    80002f78:	02010413          	addi	s0,sp,32
    80002f7c:	00058493          	mv	s1,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80002f80:	00000913          	li	s2,0
    80002f84:	00c0006f          	j	80002f90 <_ZN12ProducerSync8producerEPv+0x2c>
    static void dispatch() {thread_dispatch();}
    80002f88:	fffff097          	auipc	ra,0xfffff
    80002f8c:	0d0080e7          	jalr	208(ra) # 80002058 <_Z15thread_dispatchv>
    while (!threadEnd) {
    80002f90:	00006797          	auipc	a5,0x6
    80002f94:	df07a783          	lw	a5,-528(a5) # 80008d80 <_ZL9threadEnd>
    80002f98:	02079e63          	bnez	a5,80002fd4 <_ZN12ProducerSync8producerEPv+0x70>
        data->buffer->put(data->id + '0');
    80002f9c:	0004a583          	lw	a1,0(s1)
    80002fa0:	0305859b          	addiw	a1,a1,48
    80002fa4:	0084b503          	ld	a0,8(s1)
    80002fa8:	00000097          	auipc	ra,0x0
    80002fac:	b9c080e7          	jalr	-1124(ra) # 80002b44 <_ZN9BufferCPP3putEi>
        i++;
    80002fb0:	0019071b          	addiw	a4,s2,1
    80002fb4:	0007091b          	sext.w	s2,a4

        if (i % (10 * data->id) == 0) {
    80002fb8:	0004a683          	lw	a3,0(s1)
    80002fbc:	0026979b          	slliw	a5,a3,0x2
    80002fc0:	00d787bb          	addw	a5,a5,a3
    80002fc4:	0017979b          	slliw	a5,a5,0x1
    80002fc8:	02f767bb          	remw	a5,a4,a5
    80002fcc:	fc0792e3          	bnez	a5,80002f90 <_ZN12ProducerSync8producerEPv+0x2c>
    80002fd0:	fb9ff06f          	j	80002f88 <_ZN12ProducerSync8producerEPv+0x24>
            Thread::dispatch();
        }
    }

    data->wait->signal();
    80002fd4:	0104b783          	ld	a5,16(s1)
        return sem_signal(myHandle);
    80002fd8:	0087b503          	ld	a0,8(a5)
    80002fdc:	fffff097          	auipc	ra,0xfffff
    80002fe0:	1b4080e7          	jalr	436(ra) # 80002190 <_Z10sem_signalP4_sem>
}
    80002fe4:	01813083          	ld	ra,24(sp)
    80002fe8:	01013403          	ld	s0,16(sp)
    80002fec:	00813483          	ld	s1,8(sp)
    80002ff0:	00013903          	ld	s2,0(sp)
    80002ff4:	02010113          	addi	sp,sp,32
    80002ff8:	00008067          	ret

0000000080002ffc <_ZN12ConsumerSync8consumerEPv>:
    void run() override {
        consumer(td);
    }
};

void ConsumerSync::consumer(void *arg) {
    80002ffc:	fd010113          	addi	sp,sp,-48
    80003000:	02113423          	sd	ra,40(sp)
    80003004:	02813023          	sd	s0,32(sp)
    80003008:	00913c23          	sd	s1,24(sp)
    8000300c:	01213823          	sd	s2,16(sp)
    80003010:	01313423          	sd	s3,8(sp)
    80003014:	01413023          	sd	s4,0(sp)
    80003018:	03010413          	addi	s0,sp,48
    8000301c:	00050993          	mv	s3,a0
    80003020:	00058913          	mv	s2,a1
    struct thread_data *data = (struct thread_data *) arg;

    int i = 0;
    80003024:	00000a13          	li	s4,0
    80003028:	01c0006f          	j	80003044 <_ZN12ConsumerSync8consumerEPv+0x48>
    static void dispatch() {thread_dispatch();}
    8000302c:	fffff097          	auipc	ra,0xfffff
    80003030:	02c080e7          	jalr	44(ra) # 80002058 <_Z15thread_dispatchv>
    80003034:	0500006f          	j	80003084 <_ZN12ConsumerSync8consumerEPv+0x88>
        if (i % (5 * data->id) == 0) {
            Thread::dispatch();
        }

        if (i % 80 == 0) {
            putc('\n');
    80003038:	00a00513          	li	a0,10
    8000303c:	fffff097          	auipc	ra,0xfffff
    80003040:	098080e7          	jalr	152(ra) # 800020d4 <_Z4putcc>
    while (!threadEnd) {
    80003044:	00006797          	auipc	a5,0x6
    80003048:	d3c7a783          	lw	a5,-708(a5) # 80008d80 <_ZL9threadEnd>
    8000304c:	06079263          	bnez	a5,800030b0 <_ZN12ConsumerSync8consumerEPv+0xb4>
        int key = data->buffer->get();
    80003050:	00893503          	ld	a0,8(s2)
    80003054:	00000097          	auipc	ra,0x0
    80003058:	b90080e7          	jalr	-1136(ra) # 80002be4 <_ZN9BufferCPP3getEv>
        i++;
    8000305c:	001a049b          	addiw	s1,s4,1
    80003060:	00048a1b          	sext.w	s4,s1
        putc(key);
    80003064:	0ff57513          	andi	a0,a0,255
    80003068:	fffff097          	auipc	ra,0xfffff
    8000306c:	06c080e7          	jalr	108(ra) # 800020d4 <_Z4putcc>
        if (i % (5 * data->id) == 0) {
    80003070:	00092703          	lw	a4,0(s2)
    80003074:	0027179b          	slliw	a5,a4,0x2
    80003078:	00e787bb          	addw	a5,a5,a4
    8000307c:	02f4e7bb          	remw	a5,s1,a5
    80003080:	fa0786e3          	beqz	a5,8000302c <_ZN12ConsumerSync8consumerEPv+0x30>
        if (i % 80 == 0) {
    80003084:	05000793          	li	a5,80
    80003088:	02f4e4bb          	remw	s1,s1,a5
    8000308c:	fa049ce3          	bnez	s1,80003044 <_ZN12ConsumerSync8consumerEPv+0x48>
    80003090:	fa9ff06f          	j	80003038 <_ZN12ConsumerSync8consumerEPv+0x3c>
        }
    }


    while (td->buffer->getCnt() > 0) {
        int key = td->buffer->get();
    80003094:	0209b783          	ld	a5,32(s3)
    80003098:	0087b503          	ld	a0,8(a5)
    8000309c:	00000097          	auipc	ra,0x0
    800030a0:	b48080e7          	jalr	-1208(ra) # 80002be4 <_ZN9BufferCPP3getEv>
        //Console::putc(key);
        putc(key);
    800030a4:	0ff57513          	andi	a0,a0,255
    800030a8:	fffff097          	auipc	ra,0xfffff
    800030ac:	02c080e7          	jalr	44(ra) # 800020d4 <_Z4putcc>
    while (td->buffer->getCnt() > 0) {
    800030b0:	0209b783          	ld	a5,32(s3)
    800030b4:	0087b503          	ld	a0,8(a5)
    800030b8:	00000097          	auipc	ra,0x0
    800030bc:	bc8080e7          	jalr	-1080(ra) # 80002c80 <_ZN9BufferCPP6getCntEv>
    800030c0:	fca04ae3          	bgtz	a0,80003094 <_ZN12ConsumerSync8consumerEPv+0x98>
    }

    data->wait->signal();
    800030c4:	01093783          	ld	a5,16(s2)
        return sem_signal(myHandle);
    800030c8:	0087b503          	ld	a0,8(a5)
    800030cc:	fffff097          	auipc	ra,0xfffff
    800030d0:	0c4080e7          	jalr	196(ra) # 80002190 <_Z10sem_signalP4_sem>
}
    800030d4:	02813083          	ld	ra,40(sp)
    800030d8:	02013403          	ld	s0,32(sp)
    800030dc:	01813483          	ld	s1,24(sp)
    800030e0:	01013903          	ld	s2,16(sp)
    800030e4:	00813983          	ld	s3,8(sp)
    800030e8:	00013a03          	ld	s4,0(sp)
    800030ec:	03010113          	addi	sp,sp,48
    800030f0:	00008067          	ret

00000000800030f4 <_Z29producerConsumer_CPP_Sync_APIv>:

void producerConsumer_CPP_Sync_API() {
    800030f4:	f9010113          	addi	sp,sp,-112
    800030f8:	06113423          	sd	ra,104(sp)
    800030fc:	06813023          	sd	s0,96(sp)
    80003100:	04913c23          	sd	s1,88(sp)
    80003104:	05213823          	sd	s2,80(sp)
    80003108:	05313423          	sd	s3,72(sp)
    8000310c:	05413023          	sd	s4,64(sp)
    80003110:	03513c23          	sd	s5,56(sp)
    80003114:	03613823          	sd	s6,48(sp)
    80003118:	03713423          	sd	s7,40(sp)
    8000311c:	03813023          	sd	s8,32(sp)
    80003120:	07010413          	addi	s0,sp,112
    for (int i = 0; i < threadNum; i++) {
        delete threads[i];
    }
    delete consumerThread;
    delete waitForAll;
    delete buffer;
    80003124:	00010b93          	mv	s7,sp
    printString("Unesite broj proizvodjaca?\n");
    80003128:	00004517          	auipc	a0,0x4
    8000312c:	2f050513          	addi	a0,a0,752 # 80007418 <CONSOLE_STATUS+0x408>
    80003130:	fffff097          	auipc	ra,0xfffff
    80003134:	5b0080e7          	jalr	1456(ra) # 800026e0 <_Z11printStringPKc>
    getString(input, 30);
    80003138:	01e00593          	li	a1,30
    8000313c:	f9040513          	addi	a0,s0,-112
    80003140:	fffff097          	auipc	ra,0xfffff
    80003144:	628080e7          	jalr	1576(ra) # 80002768 <_Z9getStringPci>
    threadNum = stringToInt(input);
    80003148:	f9040513          	addi	a0,s0,-112
    8000314c:	fffff097          	auipc	ra,0xfffff
    80003150:	6f4080e7          	jalr	1780(ra) # 80002840 <_Z11stringToIntPKc>
    80003154:	00050913          	mv	s2,a0
    printString("Unesite velicinu bafera?\n");
    80003158:	00004517          	auipc	a0,0x4
    8000315c:	2e050513          	addi	a0,a0,736 # 80007438 <CONSOLE_STATUS+0x428>
    80003160:	fffff097          	auipc	ra,0xfffff
    80003164:	580080e7          	jalr	1408(ra) # 800026e0 <_Z11printStringPKc>
    getString(input, 30);
    80003168:	01e00593          	li	a1,30
    8000316c:	f9040513          	addi	a0,s0,-112
    80003170:	fffff097          	auipc	ra,0xfffff
    80003174:	5f8080e7          	jalr	1528(ra) # 80002768 <_Z9getStringPci>
    n = stringToInt(input);
    80003178:	f9040513          	addi	a0,s0,-112
    8000317c:	fffff097          	auipc	ra,0xfffff
    80003180:	6c4080e7          	jalr	1732(ra) # 80002840 <_Z11stringToIntPKc>
    80003184:	00050493          	mv	s1,a0
    printString("Broj proizvodjaca "); printInt(threadNum);
    80003188:	00004517          	auipc	a0,0x4
    8000318c:	2d050513          	addi	a0,a0,720 # 80007458 <CONSOLE_STATUS+0x448>
    80003190:	fffff097          	auipc	ra,0xfffff
    80003194:	550080e7          	jalr	1360(ra) # 800026e0 <_Z11printStringPKc>
    80003198:	00000613          	li	a2,0
    8000319c:	00a00593          	li	a1,10
    800031a0:	00090513          	mv	a0,s2
    800031a4:	fffff097          	auipc	ra,0xfffff
    800031a8:	6ec080e7          	jalr	1772(ra) # 80002890 <_Z8printIntiii>
    printString(" i velicina bafera "); printInt(n);
    800031ac:	00004517          	auipc	a0,0x4
    800031b0:	2c450513          	addi	a0,a0,708 # 80007470 <CONSOLE_STATUS+0x460>
    800031b4:	fffff097          	auipc	ra,0xfffff
    800031b8:	52c080e7          	jalr	1324(ra) # 800026e0 <_Z11printStringPKc>
    800031bc:	00000613          	li	a2,0
    800031c0:	00a00593          	li	a1,10
    800031c4:	00048513          	mv	a0,s1
    800031c8:	fffff097          	auipc	ra,0xfffff
    800031cc:	6c8080e7          	jalr	1736(ra) # 80002890 <_Z8printIntiii>
    printString(".\n");
    800031d0:	00004517          	auipc	a0,0x4
    800031d4:	2b850513          	addi	a0,a0,696 # 80007488 <CONSOLE_STATUS+0x478>
    800031d8:	fffff097          	auipc	ra,0xfffff
    800031dc:	508080e7          	jalr	1288(ra) # 800026e0 <_Z11printStringPKc>
    if(threadNum > n) {
    800031e0:	0324c463          	blt	s1,s2,80003208 <_Z29producerConsumer_CPP_Sync_APIv+0x114>
    } else if (threadNum < 1) {
    800031e4:	03205c63          	blez	s2,8000321c <_Z29producerConsumer_CPP_Sync_APIv+0x128>
    BufferCPP *buffer = new BufferCPP(n);
    800031e8:	03800513          	li	a0,56
    800031ec:	ffffe097          	auipc	ra,0xffffe
    800031f0:	054080e7          	jalr	84(ra) # 80001240 <_Znwm>
    800031f4:	00050a93          	mv	s5,a0
    800031f8:	00048593          	mv	a1,s1
    800031fc:	fffff097          	auipc	ra,0xfffff
    80003200:	7b4080e7          	jalr	1972(ra) # 800029b0 <_ZN9BufferCPPC1Ei>
    80003204:	0300006f          	j	80003234 <_Z29producerConsumer_CPP_Sync_APIv+0x140>
        printString("Broj proizvodjaca ne sme biti manji od velicine bafera!\n");
    80003208:	00004517          	auipc	a0,0x4
    8000320c:	28850513          	addi	a0,a0,648 # 80007490 <CONSOLE_STATUS+0x480>
    80003210:	fffff097          	auipc	ra,0xfffff
    80003214:	4d0080e7          	jalr	1232(ra) # 800026e0 <_Z11printStringPKc>
        return;
    80003218:	0140006f          	j	8000322c <_Z29producerConsumer_CPP_Sync_APIv+0x138>
        printString("Broj proizvodjaca mora biti veci od nula!\n");
    8000321c:	00004517          	auipc	a0,0x4
    80003220:	2b450513          	addi	a0,a0,692 # 800074d0 <CONSOLE_STATUS+0x4c0>
    80003224:	fffff097          	auipc	ra,0xfffff
    80003228:	4bc080e7          	jalr	1212(ra) # 800026e0 <_Z11printStringPKc>
        return;
    8000322c:	000b8113          	mv	sp,s7
    80003230:	26c0006f          	j	8000349c <_Z29producerConsumer_CPP_Sync_APIv+0x3a8>
    waitForAll = new Semaphore(0);
    80003234:	01000513          	li	a0,16
    80003238:	ffffe097          	auipc	ra,0xffffe
    8000323c:	008080e7          	jalr	8(ra) # 80001240 <_Znwm>
    80003240:	00050493          	mv	s1,a0
    Semaphore(unsigned init=1){
    80003244:	00004797          	auipc	a5,0x4
    80003248:	2e478793          	addi	a5,a5,740 # 80007528 <_ZTV9Semaphore+0x10>
    8000324c:	00f53023          	sd	a5,0(a0)
        sem_open(&myHandle, init);
    80003250:	00000593          	li	a1,0
    80003254:	00850513          	addi	a0,a0,8
    80003258:	fffff097          	auipc	ra,0xfffff
    8000325c:	ea4080e7          	jalr	-348(ra) # 800020fc <_Z8sem_openPP4_semj>
    80003260:	00006797          	auipc	a5,0x6
    80003264:	b297b423          	sd	s1,-1240(a5) # 80008d88 <_ZL10waitForAll>
    Thread* threads[threadNum];
    80003268:	00391793          	slli	a5,s2,0x3
    8000326c:	00f78793          	addi	a5,a5,15
    80003270:	ff07f793          	andi	a5,a5,-16
    80003274:	40f10133          	sub	sp,sp,a5
    80003278:	00010993          	mv	s3,sp
    struct thread_data data[threadNum + 1];
    8000327c:	0019071b          	addiw	a4,s2,1
    80003280:	00171793          	slli	a5,a4,0x1
    80003284:	00e787b3          	add	a5,a5,a4
    80003288:	00379793          	slli	a5,a5,0x3
    8000328c:	00f78793          	addi	a5,a5,15
    80003290:	ff07f793          	andi	a5,a5,-16
    80003294:	40f10133          	sub	sp,sp,a5
    80003298:	00010a13          	mv	s4,sp
    data[threadNum].id = threadNum;
    8000329c:	00191c13          	slli	s8,s2,0x1
    800032a0:	012c07b3          	add	a5,s8,s2
    800032a4:	00379793          	slli	a5,a5,0x3
    800032a8:	00fa07b3          	add	a5,s4,a5
    800032ac:	0127a023          	sw	s2,0(a5)
    data[threadNum].buffer = buffer;
    800032b0:	0157b423          	sd	s5,8(a5)
    data[threadNum].wait = waitForAll;
    800032b4:	0097b823          	sd	s1,16(a5)
    consumerThread = new ConsumerSync(data+threadNum);
    800032b8:	02800513          	li	a0,40
    800032bc:	ffffe097          	auipc	ra,0xffffe
    800032c0:	f84080e7          	jalr	-124(ra) # 80001240 <_Znwm>
    800032c4:	00050b13          	mv	s6,a0
    800032c8:	012c0c33          	add	s8,s8,s2
    800032cc:	003c1c13          	slli	s8,s8,0x3
    800032d0:	018a0c33          	add	s8,s4,s8
    Thread(){};
    800032d4:	00053823          	sd	zero,16(a0)
    ConsumerSync(thread_data* _td):Thread(), td(_td) {}
    800032d8:	00004797          	auipc	a5,0x4
    800032dc:	2e878793          	addi	a5,a5,744 # 800075c0 <_ZTV12ConsumerSync+0x10>
    800032e0:	00f53023          	sd	a5,0(a0)
    800032e4:	03853023          	sd	s8,32(a0)
            thread_create(&myhandle, &threadWrapper,this);
    800032e8:	00050613          	mv	a2,a0
    800032ec:	00000597          	auipc	a1,0x0
    800032f0:	23458593          	addi	a1,a1,564 # 80003520 <_ZN6Thread13threadWrapperEPv>
    800032f4:	00850513          	addi	a0,a0,8
    800032f8:	fffff097          	auipc	ra,0xfffff
    800032fc:	d28080e7          	jalr	-728(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80003300:	00000493          	li	s1,0
        return 0;
    80003304:	0600006f          	j	80003364 <_Z29producerConsumer_CPP_Sync_APIv+0x270>
            threads[i] = new ProducerKeyboard(data+i);
    80003308:	02800513          	li	a0,40
    8000330c:	ffffe097          	auipc	ra,0xffffe
    80003310:	f34080e7          	jalr	-204(ra) # 80001240 <_Znwm>
    80003314:	00149793          	slli	a5,s1,0x1
    80003318:	009787b3          	add	a5,a5,s1
    8000331c:	00379793          	slli	a5,a5,0x3
    80003320:	00fa07b3          	add	a5,s4,a5
    Thread(){};
    80003324:	00053823          	sd	zero,16(a0)
    ProducerKeyboard(thread_data* _td):Thread(), td(_td) {}
    80003328:	00004717          	auipc	a4,0x4
    8000332c:	24870713          	addi	a4,a4,584 # 80007570 <_ZTV16ProducerKeyboard+0x10>
    80003330:	00e53023          	sd	a4,0(a0)
    80003334:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerKeyboard(data+i);
    80003338:	00349793          	slli	a5,s1,0x3
    8000333c:	00f987b3          	add	a5,s3,a5
    80003340:	00a7b023          	sd	a0,0(a5)
    80003344:	0880006f          	j	800033cc <_Z29producerConsumer_CPP_Sync_APIv+0x2d8>
            thread_create(&myhandle, &threadWrapper,this);
    80003348:	00050613          	mv	a2,a0
    8000334c:	00000597          	auipc	a1,0x0
    80003350:	1d458593          	addi	a1,a1,468 # 80003520 <_ZN6Thread13threadWrapperEPv>
    80003354:	00850513          	addi	a0,a0,8
    80003358:	fffff097          	auipc	ra,0xfffff
    8000335c:	cc8080e7          	jalr	-824(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    for (int i = 0; i < threadNum; i++) {
    80003360:	0014849b          	addiw	s1,s1,1
    80003364:	0924d863          	bge	s1,s2,800033f4 <_Z29producerConsumer_CPP_Sync_APIv+0x300>
        data[i].id = i;
    80003368:	00149793          	slli	a5,s1,0x1
    8000336c:	009787b3          	add	a5,a5,s1
    80003370:	00379793          	slli	a5,a5,0x3
    80003374:	00fa07b3          	add	a5,s4,a5
    80003378:	0097a023          	sw	s1,0(a5)
        data[i].buffer = buffer;
    8000337c:	0157b423          	sd	s5,8(a5)
        data[i].wait = waitForAll;
    80003380:	00006717          	auipc	a4,0x6
    80003384:	a0873703          	ld	a4,-1528(a4) # 80008d88 <_ZL10waitForAll>
    80003388:	00e7b823          	sd	a4,16(a5)
        if(i>0) {
    8000338c:	f6905ee3          	blez	s1,80003308 <_Z29producerConsumer_CPP_Sync_APIv+0x214>
            threads[i] = new ProducerSync(data+i);
    80003390:	02800513          	li	a0,40
    80003394:	ffffe097          	auipc	ra,0xffffe
    80003398:	eac080e7          	jalr	-340(ra) # 80001240 <_Znwm>
    8000339c:	00149793          	slli	a5,s1,0x1
    800033a0:	009787b3          	add	a5,a5,s1
    800033a4:	00379793          	slli	a5,a5,0x3
    800033a8:	00fa07b3          	add	a5,s4,a5
    Thread(){};
    800033ac:	00053823          	sd	zero,16(a0)
    ProducerSync(thread_data* _td):Thread(), td(_td) {}
    800033b0:	00004717          	auipc	a4,0x4
    800033b4:	1e870713          	addi	a4,a4,488 # 80007598 <_ZTV12ProducerSync+0x10>
    800033b8:	00e53023          	sd	a4,0(a0)
    800033bc:	02f53023          	sd	a5,32(a0)
            threads[i] = new ProducerSync(data+i);
    800033c0:	00349793          	slli	a5,s1,0x3
    800033c4:	00f987b3          	add	a5,s3,a5
    800033c8:	00a7b023          	sd	a0,0(a5)
        threads[i]->start();
    800033cc:	00349793          	slli	a5,s1,0x3
    800033d0:	00f987b3          	add	a5,s3,a5
    800033d4:	0007b503          	ld	a0,0(a5)
        if (body == nullptr){
    800033d8:	01053583          	ld	a1,16(a0)
    800033dc:	f60586e3          	beqz	a1,80003348 <_Z29producerConsumer_CPP_Sync_APIv+0x254>
            thread_create(&myhandle, body,arg);
    800033e0:	01853603          	ld	a2,24(a0)
    800033e4:	00850513          	addi	a0,a0,8
    800033e8:	fffff097          	auipc	ra,0xfffff
    800033ec:	c38080e7          	jalr	-968(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    800033f0:	f71ff06f          	j	80003360 <_Z29producerConsumer_CPP_Sync_APIv+0x26c>
    static void dispatch() {thread_dispatch();}
    800033f4:	fffff097          	auipc	ra,0xfffff
    800033f8:	c64080e7          	jalr	-924(ra) # 80002058 <_Z15thread_dispatchv>
    for (int i = 0; i <= threadNum; i++) {
    800033fc:	00000493          	li	s1,0
    80003400:	02994063          	blt	s2,s1,80003420 <_Z29producerConsumer_CPP_Sync_APIv+0x32c>
        return sem_wait(myHandle);
    80003404:	00006797          	auipc	a5,0x6
    80003408:	9847b783          	ld	a5,-1660(a5) # 80008d88 <_ZL10waitForAll>
    8000340c:	0087b503          	ld	a0,8(a5)
    80003410:	fffff097          	auipc	ra,0xfffff
    80003414:	d50080e7          	jalr	-688(ra) # 80002160 <_Z8sem_waitP4_sem>
    80003418:	0014849b          	addiw	s1,s1,1
    8000341c:	fe5ff06f          	j	80003400 <_Z29producerConsumer_CPP_Sync_APIv+0x30c>
    for (int i = 0; i < threadNum; i++) {
    80003420:	00000493          	li	s1,0
    80003424:	0080006f          	j	8000342c <_Z29producerConsumer_CPP_Sync_APIv+0x338>
    80003428:	0014849b          	addiw	s1,s1,1
    8000342c:	0324d263          	bge	s1,s2,80003450 <_Z29producerConsumer_CPP_Sync_APIv+0x35c>
        delete threads[i];
    80003430:	00349793          	slli	a5,s1,0x3
    80003434:	00f987b3          	add	a5,s3,a5
    80003438:	0007b503          	ld	a0,0(a5)
    8000343c:	fe0506e3          	beqz	a0,80003428 <_Z29producerConsumer_CPP_Sync_APIv+0x334>
    80003440:	00053783          	ld	a5,0(a0)
    80003444:	0087b783          	ld	a5,8(a5)
    80003448:	000780e7          	jalr	a5
    8000344c:	fddff06f          	j	80003428 <_Z29producerConsumer_CPP_Sync_APIv+0x334>
    delete consumerThread;
    80003450:	000b0a63          	beqz	s6,80003464 <_Z29producerConsumer_CPP_Sync_APIv+0x370>
    80003454:	000b3783          	ld	a5,0(s6)
    80003458:	0087b783          	ld	a5,8(a5)
    8000345c:	000b0513          	mv	a0,s6
    80003460:	000780e7          	jalr	a5
    delete waitForAll;
    80003464:	00006517          	auipc	a0,0x6
    80003468:	92453503          	ld	a0,-1756(a0) # 80008d88 <_ZL10waitForAll>
    8000346c:	00050863          	beqz	a0,8000347c <_Z29producerConsumer_CPP_Sync_APIv+0x388>
    80003470:	00053783          	ld	a5,0(a0)
    80003474:	0087b783          	ld	a5,8(a5)
    80003478:	000780e7          	jalr	a5
    delete buffer;
    8000347c:	000a8e63          	beqz	s5,80003498 <_Z29producerConsumer_CPP_Sync_APIv+0x3a4>
    80003480:	000a8513          	mv	a0,s5
    80003484:	00000097          	auipc	ra,0x0
    80003488:	894080e7          	jalr	-1900(ra) # 80002d18 <_ZN9BufferCPPD1Ev>
    8000348c:	000a8513          	mv	a0,s5
    80003490:	ffffe097          	auipc	ra,0xffffe
    80003494:	e00080e7          	jalr	-512(ra) # 80001290 <_ZdlPv>
    80003498:	000b8113          	mv	sp,s7

}
    8000349c:	f9040113          	addi	sp,s0,-112
    800034a0:	06813083          	ld	ra,104(sp)
    800034a4:	06013403          	ld	s0,96(sp)
    800034a8:	05813483          	ld	s1,88(sp)
    800034ac:	05013903          	ld	s2,80(sp)
    800034b0:	04813983          	ld	s3,72(sp)
    800034b4:	04013a03          	ld	s4,64(sp)
    800034b8:	03813a83          	ld	s5,56(sp)
    800034bc:	03013b03          	ld	s6,48(sp)
    800034c0:	02813b83          	ld	s7,40(sp)
    800034c4:	02013c03          	ld	s8,32(sp)
    800034c8:	07010113          	addi	sp,sp,112
    800034cc:	00008067          	ret
    800034d0:	00050493          	mv	s1,a0
    BufferCPP *buffer = new BufferCPP(n);
    800034d4:	000a8513          	mv	a0,s5
    800034d8:	ffffe097          	auipc	ra,0xffffe
    800034dc:	db8080e7          	jalr	-584(ra) # 80001290 <_ZdlPv>
    800034e0:	00048513          	mv	a0,s1
    800034e4:	00007097          	auipc	ra,0x7
    800034e8:	9b4080e7          	jalr	-1612(ra) # 80009e98 <_Unwind_Resume>
    800034ec:	00050913          	mv	s2,a0
    waitForAll = new Semaphore(0);
    800034f0:	00048513          	mv	a0,s1
    800034f4:	ffffe097          	auipc	ra,0xffffe
    800034f8:	d9c080e7          	jalr	-612(ra) # 80001290 <_ZdlPv>
    800034fc:	00090513          	mv	a0,s2
    80003500:	00007097          	auipc	ra,0x7
    80003504:	998080e7          	jalr	-1640(ra) # 80009e98 <_Unwind_Resume>

0000000080003508 <_ZN6Thread3runEv>:
    virtual void run(){}
    80003508:	ff010113          	addi	sp,sp,-16
    8000350c:	00813423          	sd	s0,8(sp)
    80003510:	01010413          	addi	s0,sp,16
    80003514:	00813403          	ld	s0,8(sp)
    80003518:	01010113          	addi	sp,sp,16
    8000351c:	00008067          	ret

0000000080003520 <_ZN6Thread13threadWrapperEPv>:
        if (thr) thr->run();
    80003520:	02050863          	beqz	a0,80003550 <_ZN6Thread13threadWrapperEPv+0x30>
    static void threadWrapper(void* p){
    80003524:	ff010113          	addi	sp,sp,-16
    80003528:	00113423          	sd	ra,8(sp)
    8000352c:	00813023          	sd	s0,0(sp)
    80003530:	01010413          	addi	s0,sp,16
        if (thr) thr->run();
    80003534:	00053783          	ld	a5,0(a0)
    80003538:	0107b783          	ld	a5,16(a5)
    8000353c:	000780e7          	jalr	a5
    }
    80003540:	00813083          	ld	ra,8(sp)
    80003544:	00013403          	ld	s0,0(sp)
    80003548:	01010113          	addi	sp,sp,16
    8000354c:	00008067          	ret
    80003550:	00008067          	ret

0000000080003554 <_ZN6ThreadD1Ev>:
    virtual ~Thread() { thread_exit();}
    80003554:	ff010113          	addi	sp,sp,-16
    80003558:	00113423          	sd	ra,8(sp)
    8000355c:	00813023          	sd	s0,0(sp)
    80003560:	01010413          	addi	s0,sp,16
    80003564:	00004797          	auipc	a5,0x4
    80003568:	fe478793          	addi	a5,a5,-28 # 80007548 <_ZTV6Thread+0x10>
    8000356c:	00f53023          	sd	a5,0(a0)
    80003570:	fffff097          	auipc	ra,0xfffff
    80003574:	b0c080e7          	jalr	-1268(ra) # 8000207c <_Z11thread_exitv>
    80003578:	00813083          	ld	ra,8(sp)
    8000357c:	00013403          	ld	s0,0(sp)
    80003580:	01010113          	addi	sp,sp,16
    80003584:	00008067          	ret

0000000080003588 <_ZN6ThreadD0Ev>:
    80003588:	fe010113          	addi	sp,sp,-32
    8000358c:	00113c23          	sd	ra,24(sp)
    80003590:	00813823          	sd	s0,16(sp)
    80003594:	00913423          	sd	s1,8(sp)
    80003598:	02010413          	addi	s0,sp,32
    8000359c:	00050493          	mv	s1,a0
    800035a0:	00004797          	auipc	a5,0x4
    800035a4:	fa878793          	addi	a5,a5,-88 # 80007548 <_ZTV6Thread+0x10>
    800035a8:	00f53023          	sd	a5,0(a0)
    800035ac:	fffff097          	auipc	ra,0xfffff
    800035b0:	ad0080e7          	jalr	-1328(ra) # 8000207c <_Z11thread_exitv>
    800035b4:	00048513          	mv	a0,s1
    800035b8:	ffffe097          	auipc	ra,0xffffe
    800035bc:	cd8080e7          	jalr	-808(ra) # 80001290 <_ZdlPv>
    800035c0:	01813083          	ld	ra,24(sp)
    800035c4:	01013403          	ld	s0,16(sp)
    800035c8:	00813483          	ld	s1,8(sp)
    800035cc:	02010113          	addi	sp,sp,32
    800035d0:	00008067          	ret

00000000800035d4 <_ZN12ConsumerSyncD1Ev>:
class ConsumerSync:public Thread {
    800035d4:	ff010113          	addi	sp,sp,-16
    800035d8:	00113423          	sd	ra,8(sp)
    800035dc:	00813023          	sd	s0,0(sp)
    800035e0:	01010413          	addi	s0,sp,16
    800035e4:	00004797          	auipc	a5,0x4
    800035e8:	f6478793          	addi	a5,a5,-156 # 80007548 <_ZTV6Thread+0x10>
    800035ec:	00f53023          	sd	a5,0(a0)
    800035f0:	fffff097          	auipc	ra,0xfffff
    800035f4:	a8c080e7          	jalr	-1396(ra) # 8000207c <_Z11thread_exitv>
    800035f8:	00813083          	ld	ra,8(sp)
    800035fc:	00013403          	ld	s0,0(sp)
    80003600:	01010113          	addi	sp,sp,16
    80003604:	00008067          	ret

0000000080003608 <_ZN12ConsumerSyncD0Ev>:
    80003608:	fe010113          	addi	sp,sp,-32
    8000360c:	00113c23          	sd	ra,24(sp)
    80003610:	00813823          	sd	s0,16(sp)
    80003614:	00913423          	sd	s1,8(sp)
    80003618:	02010413          	addi	s0,sp,32
    8000361c:	00050493          	mv	s1,a0
    80003620:	00004797          	auipc	a5,0x4
    80003624:	f2878793          	addi	a5,a5,-216 # 80007548 <_ZTV6Thread+0x10>
    80003628:	00f53023          	sd	a5,0(a0)
    8000362c:	fffff097          	auipc	ra,0xfffff
    80003630:	a50080e7          	jalr	-1456(ra) # 8000207c <_Z11thread_exitv>
    80003634:	00048513          	mv	a0,s1
    80003638:	ffffe097          	auipc	ra,0xffffe
    8000363c:	c58080e7          	jalr	-936(ra) # 80001290 <_ZdlPv>
    80003640:	01813083          	ld	ra,24(sp)
    80003644:	01013403          	ld	s0,16(sp)
    80003648:	00813483          	ld	s1,8(sp)
    8000364c:	02010113          	addi	sp,sp,32
    80003650:	00008067          	ret

0000000080003654 <_ZN12ProducerSyncD1Ev>:
class ProducerSync:public Thread {
    80003654:	ff010113          	addi	sp,sp,-16
    80003658:	00113423          	sd	ra,8(sp)
    8000365c:	00813023          	sd	s0,0(sp)
    80003660:	01010413          	addi	s0,sp,16
    80003664:	00004797          	auipc	a5,0x4
    80003668:	ee478793          	addi	a5,a5,-284 # 80007548 <_ZTV6Thread+0x10>
    8000366c:	00f53023          	sd	a5,0(a0)
    80003670:	fffff097          	auipc	ra,0xfffff
    80003674:	a0c080e7          	jalr	-1524(ra) # 8000207c <_Z11thread_exitv>
    80003678:	00813083          	ld	ra,8(sp)
    8000367c:	00013403          	ld	s0,0(sp)
    80003680:	01010113          	addi	sp,sp,16
    80003684:	00008067          	ret

0000000080003688 <_ZN12ProducerSyncD0Ev>:
    80003688:	fe010113          	addi	sp,sp,-32
    8000368c:	00113c23          	sd	ra,24(sp)
    80003690:	00813823          	sd	s0,16(sp)
    80003694:	00913423          	sd	s1,8(sp)
    80003698:	02010413          	addi	s0,sp,32
    8000369c:	00050493          	mv	s1,a0
    800036a0:	00004797          	auipc	a5,0x4
    800036a4:	ea878793          	addi	a5,a5,-344 # 80007548 <_ZTV6Thread+0x10>
    800036a8:	00f53023          	sd	a5,0(a0)
    800036ac:	fffff097          	auipc	ra,0xfffff
    800036b0:	9d0080e7          	jalr	-1584(ra) # 8000207c <_Z11thread_exitv>
    800036b4:	00048513          	mv	a0,s1
    800036b8:	ffffe097          	auipc	ra,0xffffe
    800036bc:	bd8080e7          	jalr	-1064(ra) # 80001290 <_ZdlPv>
    800036c0:	01813083          	ld	ra,24(sp)
    800036c4:	01013403          	ld	s0,16(sp)
    800036c8:	00813483          	ld	s1,8(sp)
    800036cc:	02010113          	addi	sp,sp,32
    800036d0:	00008067          	ret

00000000800036d4 <_ZN16ProducerKeyboardD1Ev>:
class ProducerKeyboard:public Thread {
    800036d4:	ff010113          	addi	sp,sp,-16
    800036d8:	00113423          	sd	ra,8(sp)
    800036dc:	00813023          	sd	s0,0(sp)
    800036e0:	01010413          	addi	s0,sp,16
    800036e4:	00004797          	auipc	a5,0x4
    800036e8:	e6478793          	addi	a5,a5,-412 # 80007548 <_ZTV6Thread+0x10>
    800036ec:	00f53023          	sd	a5,0(a0)
    800036f0:	fffff097          	auipc	ra,0xfffff
    800036f4:	98c080e7          	jalr	-1652(ra) # 8000207c <_Z11thread_exitv>
    800036f8:	00813083          	ld	ra,8(sp)
    800036fc:	00013403          	ld	s0,0(sp)
    80003700:	01010113          	addi	sp,sp,16
    80003704:	00008067          	ret

0000000080003708 <_ZN16ProducerKeyboardD0Ev>:
    80003708:	fe010113          	addi	sp,sp,-32
    8000370c:	00113c23          	sd	ra,24(sp)
    80003710:	00813823          	sd	s0,16(sp)
    80003714:	00913423          	sd	s1,8(sp)
    80003718:	02010413          	addi	s0,sp,32
    8000371c:	00050493          	mv	s1,a0
    80003720:	00004797          	auipc	a5,0x4
    80003724:	e2878793          	addi	a5,a5,-472 # 80007548 <_ZTV6Thread+0x10>
    80003728:	00f53023          	sd	a5,0(a0)
    8000372c:	fffff097          	auipc	ra,0xfffff
    80003730:	950080e7          	jalr	-1712(ra) # 8000207c <_Z11thread_exitv>
    80003734:	00048513          	mv	a0,s1
    80003738:	ffffe097          	auipc	ra,0xffffe
    8000373c:	b58080e7          	jalr	-1192(ra) # 80001290 <_ZdlPv>
    80003740:	01813083          	ld	ra,24(sp)
    80003744:	01013403          	ld	s0,16(sp)
    80003748:	00813483          	ld	s1,8(sp)
    8000374c:	02010113          	addi	sp,sp,32
    80003750:	00008067          	ret

0000000080003754 <_ZN16ProducerKeyboard3runEv>:
    void run() override {
    80003754:	ff010113          	addi	sp,sp,-16
    80003758:	00113423          	sd	ra,8(sp)
    8000375c:	00813023          	sd	s0,0(sp)
    80003760:	01010413          	addi	s0,sp,16
        producerKeyboard(td);
    80003764:	02053583          	ld	a1,32(a0)
    80003768:	fffff097          	auipc	ra,0xfffff
    8000376c:	738080e7          	jalr	1848(ra) # 80002ea0 <_ZN16ProducerKeyboard16producerKeyboardEPv>
    }
    80003770:	00813083          	ld	ra,8(sp)
    80003774:	00013403          	ld	s0,0(sp)
    80003778:	01010113          	addi	sp,sp,16
    8000377c:	00008067          	ret

0000000080003780 <_ZN12ProducerSync3runEv>:
    void run() override {
    80003780:	ff010113          	addi	sp,sp,-16
    80003784:	00113423          	sd	ra,8(sp)
    80003788:	00813023          	sd	s0,0(sp)
    8000378c:	01010413          	addi	s0,sp,16
        producer(td);
    80003790:	02053583          	ld	a1,32(a0)
    80003794:	fffff097          	auipc	ra,0xfffff
    80003798:	7d0080e7          	jalr	2000(ra) # 80002f64 <_ZN12ProducerSync8producerEPv>
    }
    8000379c:	00813083          	ld	ra,8(sp)
    800037a0:	00013403          	ld	s0,0(sp)
    800037a4:	01010113          	addi	sp,sp,16
    800037a8:	00008067          	ret

00000000800037ac <_ZN12ConsumerSync3runEv>:
    void run() override {
    800037ac:	ff010113          	addi	sp,sp,-16
    800037b0:	00113423          	sd	ra,8(sp)
    800037b4:	00813023          	sd	s0,0(sp)
    800037b8:	01010413          	addi	s0,sp,16
        consumer(td);
    800037bc:	02053583          	ld	a1,32(a0)
    800037c0:	00000097          	auipc	ra,0x0
    800037c4:	83c080e7          	jalr	-1988(ra) # 80002ffc <_ZN12ConsumerSync8consumerEPv>
    }
    800037c8:	00813083          	ld	ra,8(sp)
    800037cc:	00013403          	ld	s0,0(sp)
    800037d0:	01010113          	addi	sp,sp,16
    800037d4:	00008067          	ret

00000000800037d8 <_ZN6BufferC1Ei>:
#include "buffer.hpp"

Buffer::Buffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    800037d8:	fe010113          	addi	sp,sp,-32
    800037dc:	00113c23          	sd	ra,24(sp)
    800037e0:	00813823          	sd	s0,16(sp)
    800037e4:	00913423          	sd	s1,8(sp)
    800037e8:	01213023          	sd	s2,0(sp)
    800037ec:	02010413          	addi	s0,sp,32
    800037f0:	00050493          	mv	s1,a0
    800037f4:	00058913          	mv	s2,a1
    800037f8:	0015879b          	addiw	a5,a1,1
    800037fc:	0007851b          	sext.w	a0,a5
    80003800:	00f4a023          	sw	a5,0(s1)
    80003804:	0004a823          	sw	zero,16(s1)
    80003808:	0004aa23          	sw	zero,20(s1)
    buffer = (int *)MemoryAllocator::mem_alloc(sizeof(int) * cap);
    8000380c:	00251513          	slli	a0,a0,0x2
    80003810:	ffffe097          	auipc	ra,0xffffe
    80003814:	c74080e7          	jalr	-908(ra) # 80001484 <_ZN15MemoryAllocator9mem_allocEm>
    80003818:	00a4b423          	sd	a0,8(s1)
    sem_open(&itemAvailable, 0);
    8000381c:	00000593          	li	a1,0
    80003820:	02048513          	addi	a0,s1,32
    80003824:	fffff097          	auipc	ra,0xfffff
    80003828:	8d8080e7          	jalr	-1832(ra) # 800020fc <_Z8sem_openPP4_semj>
    sem_open(&spaceAvailable, _cap);
    8000382c:	00090593          	mv	a1,s2
    80003830:	01848513          	addi	a0,s1,24
    80003834:	fffff097          	auipc	ra,0xfffff
    80003838:	8c8080e7          	jalr	-1848(ra) # 800020fc <_Z8sem_openPP4_semj>
    sem_open(&mutexHead, 1);
    8000383c:	00100593          	li	a1,1
    80003840:	02848513          	addi	a0,s1,40
    80003844:	fffff097          	auipc	ra,0xfffff
    80003848:	8b8080e7          	jalr	-1864(ra) # 800020fc <_Z8sem_openPP4_semj>
    sem_open(&mutexTail, 1);
    8000384c:	00100593          	li	a1,1
    80003850:	03048513          	addi	a0,s1,48
    80003854:	fffff097          	auipc	ra,0xfffff
    80003858:	8a8080e7          	jalr	-1880(ra) # 800020fc <_Z8sem_openPP4_semj>
}
    8000385c:	01813083          	ld	ra,24(sp)
    80003860:	01013403          	ld	s0,16(sp)
    80003864:	00813483          	ld	s1,8(sp)
    80003868:	00013903          	ld	s2,0(sp)
    8000386c:	02010113          	addi	sp,sp,32
    80003870:	00008067          	ret

0000000080003874 <_ZN6Buffer3putEi>:
    sem_close(spaceAvailable);
    sem_close(mutexTail);
    sem_close(mutexHead);
}

void Buffer::put(int val) {
    80003874:	fe010113          	addi	sp,sp,-32
    80003878:	00113c23          	sd	ra,24(sp)
    8000387c:	00813823          	sd	s0,16(sp)
    80003880:	00913423          	sd	s1,8(sp)
    80003884:	01213023          	sd	s2,0(sp)
    80003888:	02010413          	addi	s0,sp,32
    8000388c:	00050493          	mv	s1,a0
    80003890:	00058913          	mv	s2,a1
    sem_wait(spaceAvailable);
    80003894:	01853503          	ld	a0,24(a0)
    80003898:	fffff097          	auipc	ra,0xfffff
    8000389c:	8c8080e7          	jalr	-1848(ra) # 80002160 <_Z8sem_waitP4_sem>

    sem_wait(mutexTail);
    800038a0:	0304b503          	ld	a0,48(s1)
    800038a4:	fffff097          	auipc	ra,0xfffff
    800038a8:	8bc080e7          	jalr	-1860(ra) # 80002160 <_Z8sem_waitP4_sem>
    buffer[tail] = val;
    800038ac:	0084b783          	ld	a5,8(s1)
    800038b0:	0144a703          	lw	a4,20(s1)
    800038b4:	00271713          	slli	a4,a4,0x2
    800038b8:	00e787b3          	add	a5,a5,a4
    800038bc:	0127a023          	sw	s2,0(a5)
    tail = (tail + 1) % cap;
    800038c0:	0144a783          	lw	a5,20(s1)
    800038c4:	0017879b          	addiw	a5,a5,1
    800038c8:	0004a703          	lw	a4,0(s1)
    800038cc:	02e7e7bb          	remw	a5,a5,a4
    800038d0:	00f4aa23          	sw	a5,20(s1)
    sem_signal(mutexTail);
    800038d4:	0304b503          	ld	a0,48(s1)
    800038d8:	fffff097          	auipc	ra,0xfffff
    800038dc:	8b8080e7          	jalr	-1864(ra) # 80002190 <_Z10sem_signalP4_sem>

    sem_signal(itemAvailable);
    800038e0:	0204b503          	ld	a0,32(s1)
    800038e4:	fffff097          	auipc	ra,0xfffff
    800038e8:	8ac080e7          	jalr	-1876(ra) # 80002190 <_Z10sem_signalP4_sem>

}
    800038ec:	01813083          	ld	ra,24(sp)
    800038f0:	01013403          	ld	s0,16(sp)
    800038f4:	00813483          	ld	s1,8(sp)
    800038f8:	00013903          	ld	s2,0(sp)
    800038fc:	02010113          	addi	sp,sp,32
    80003900:	00008067          	ret

0000000080003904 <_ZN6Buffer3getEv>:

int Buffer::get() {
    80003904:	fe010113          	addi	sp,sp,-32
    80003908:	00113c23          	sd	ra,24(sp)
    8000390c:	00813823          	sd	s0,16(sp)
    80003910:	00913423          	sd	s1,8(sp)
    80003914:	01213023          	sd	s2,0(sp)
    80003918:	02010413          	addi	s0,sp,32
    8000391c:	00050493          	mv	s1,a0
    sem_wait(itemAvailable);
    80003920:	02053503          	ld	a0,32(a0)
    80003924:	fffff097          	auipc	ra,0xfffff
    80003928:	83c080e7          	jalr	-1988(ra) # 80002160 <_Z8sem_waitP4_sem>

    sem_wait(mutexHead);
    8000392c:	0284b503          	ld	a0,40(s1)
    80003930:	fffff097          	auipc	ra,0xfffff
    80003934:	830080e7          	jalr	-2000(ra) # 80002160 <_Z8sem_waitP4_sem>

    int ret = buffer[head];
    80003938:	0084b703          	ld	a4,8(s1)
    8000393c:	0104a783          	lw	a5,16(s1)
    80003940:	00279693          	slli	a3,a5,0x2
    80003944:	00d70733          	add	a4,a4,a3
    80003948:	00072903          	lw	s2,0(a4)
    head = (head + 1) % cap;
    8000394c:	0017879b          	addiw	a5,a5,1
    80003950:	0004a703          	lw	a4,0(s1)
    80003954:	02e7e7bb          	remw	a5,a5,a4
    80003958:	00f4a823          	sw	a5,16(s1)
    sem_signal(mutexHead);
    8000395c:	0284b503          	ld	a0,40(s1)
    80003960:	fffff097          	auipc	ra,0xfffff
    80003964:	830080e7          	jalr	-2000(ra) # 80002190 <_Z10sem_signalP4_sem>

    sem_signal(spaceAvailable);
    80003968:	0184b503          	ld	a0,24(s1)
    8000396c:	fffff097          	auipc	ra,0xfffff
    80003970:	824080e7          	jalr	-2012(ra) # 80002190 <_Z10sem_signalP4_sem>

    return ret;
}
    80003974:	00090513          	mv	a0,s2
    80003978:	01813083          	ld	ra,24(sp)
    8000397c:	01013403          	ld	s0,16(sp)
    80003980:	00813483          	ld	s1,8(sp)
    80003984:	00013903          	ld	s2,0(sp)
    80003988:	02010113          	addi	sp,sp,32
    8000398c:	00008067          	ret

0000000080003990 <_ZN6Buffer6getCntEv>:

int Buffer::getCnt() {
    80003990:	fe010113          	addi	sp,sp,-32
    80003994:	00113c23          	sd	ra,24(sp)
    80003998:	00813823          	sd	s0,16(sp)
    8000399c:	00913423          	sd	s1,8(sp)
    800039a0:	01213023          	sd	s2,0(sp)
    800039a4:	02010413          	addi	s0,sp,32
    800039a8:	00050493          	mv	s1,a0
    int ret;

    sem_wait(mutexHead);
    800039ac:	02853503          	ld	a0,40(a0)
    800039b0:	ffffe097          	auipc	ra,0xffffe
    800039b4:	7b0080e7          	jalr	1968(ra) # 80002160 <_Z8sem_waitP4_sem>
    sem_wait(mutexTail);
    800039b8:	0304b503          	ld	a0,48(s1)
    800039bc:	ffffe097          	auipc	ra,0xffffe
    800039c0:	7a4080e7          	jalr	1956(ra) # 80002160 <_Z8sem_waitP4_sem>

    if (tail >= head) {
    800039c4:	0144a783          	lw	a5,20(s1)
    800039c8:	0104a903          	lw	s2,16(s1)
    800039cc:	0327ce63          	blt	a5,s2,80003a08 <_ZN6Buffer6getCntEv+0x78>
        ret = tail - head;
    800039d0:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    sem_signal(mutexTail);
    800039d4:	0304b503          	ld	a0,48(s1)
    800039d8:	ffffe097          	auipc	ra,0xffffe
    800039dc:	7b8080e7          	jalr	1976(ra) # 80002190 <_Z10sem_signalP4_sem>
    sem_signal(mutexHead);
    800039e0:	0284b503          	ld	a0,40(s1)
    800039e4:	ffffe097          	auipc	ra,0xffffe
    800039e8:	7ac080e7          	jalr	1964(ra) # 80002190 <_Z10sem_signalP4_sem>

    return ret;
}
    800039ec:	00090513          	mv	a0,s2
    800039f0:	01813083          	ld	ra,24(sp)
    800039f4:	01013403          	ld	s0,16(sp)
    800039f8:	00813483          	ld	s1,8(sp)
    800039fc:	00013903          	ld	s2,0(sp)
    80003a00:	02010113          	addi	sp,sp,32
    80003a04:	00008067          	ret
        ret = cap - head + tail;
    80003a08:	0004a703          	lw	a4,0(s1)
    80003a0c:	4127093b          	subw	s2,a4,s2
    80003a10:	00f9093b          	addw	s2,s2,a5
    80003a14:	fc1ff06f          	j	800039d4 <_ZN6Buffer6getCntEv+0x44>

0000000080003a18 <_ZN6BufferD1Ev>:
Buffer::~Buffer() {
    80003a18:	fe010113          	addi	sp,sp,-32
    80003a1c:	00113c23          	sd	ra,24(sp)
    80003a20:	00813823          	sd	s0,16(sp)
    80003a24:	00913423          	sd	s1,8(sp)
    80003a28:	02010413          	addi	s0,sp,32
    80003a2c:	00050493          	mv	s1,a0
    putc('\n');
    80003a30:	00a00513          	li	a0,10
    80003a34:	ffffe097          	auipc	ra,0xffffe
    80003a38:	6a0080e7          	jalr	1696(ra) # 800020d4 <_Z4putcc>
    printString("Buffer deleted!\n");
    80003a3c:	00004517          	auipc	a0,0x4
    80003a40:	ac450513          	addi	a0,a0,-1340 # 80007500 <CONSOLE_STATUS+0x4f0>
    80003a44:	fffff097          	auipc	ra,0xfffff
    80003a48:	c9c080e7          	jalr	-868(ra) # 800026e0 <_Z11printStringPKc>
    while (getCnt() > 0) {
    80003a4c:	00048513          	mv	a0,s1
    80003a50:	00000097          	auipc	ra,0x0
    80003a54:	f40080e7          	jalr	-192(ra) # 80003990 <_ZN6Buffer6getCntEv>
    80003a58:	02a05c63          	blez	a0,80003a90 <_ZN6BufferD1Ev+0x78>
        char ch = buffer[head];
    80003a5c:	0084b783          	ld	a5,8(s1)
    80003a60:	0104a703          	lw	a4,16(s1)
    80003a64:	00271713          	slli	a4,a4,0x2
    80003a68:	00e787b3          	add	a5,a5,a4
        putc(ch);
    80003a6c:	0007c503          	lbu	a0,0(a5)
    80003a70:	ffffe097          	auipc	ra,0xffffe
    80003a74:	664080e7          	jalr	1636(ra) # 800020d4 <_Z4putcc>
        head = (head + 1) % cap;
    80003a78:	0104a783          	lw	a5,16(s1)
    80003a7c:	0017879b          	addiw	a5,a5,1
    80003a80:	0004a703          	lw	a4,0(s1)
    80003a84:	02e7e7bb          	remw	a5,a5,a4
    80003a88:	00f4a823          	sw	a5,16(s1)
    while (getCnt() > 0) {
    80003a8c:	fc1ff06f          	j	80003a4c <_ZN6BufferD1Ev+0x34>
    putc('!');
    80003a90:	02100513          	li	a0,33
    80003a94:	ffffe097          	auipc	ra,0xffffe
    80003a98:	640080e7          	jalr	1600(ra) # 800020d4 <_Z4putcc>
    putc('\n');
    80003a9c:	00a00513          	li	a0,10
    80003aa0:	ffffe097          	auipc	ra,0xffffe
    80003aa4:	634080e7          	jalr	1588(ra) # 800020d4 <_Z4putcc>
    MemoryAllocator::mem_free(buffer);
    80003aa8:	0084b503          	ld	a0,8(s1)
    80003aac:	ffffe097          	auipc	ra,0xffffe
    80003ab0:	aa0080e7          	jalr	-1376(ra) # 8000154c <_ZN15MemoryAllocator8mem_freeEPv>
    sem_close(itemAvailable);
    80003ab4:	0204b503          	ld	a0,32(s1)
    80003ab8:	ffffe097          	auipc	ra,0xffffe
    80003abc:	678080e7          	jalr	1656(ra) # 80002130 <_Z9sem_closeP4_sem>
    sem_close(spaceAvailable);
    80003ac0:	0184b503          	ld	a0,24(s1)
    80003ac4:	ffffe097          	auipc	ra,0xffffe
    80003ac8:	66c080e7          	jalr	1644(ra) # 80002130 <_Z9sem_closeP4_sem>
    sem_close(mutexTail);
    80003acc:	0304b503          	ld	a0,48(s1)
    80003ad0:	ffffe097          	auipc	ra,0xffffe
    80003ad4:	660080e7          	jalr	1632(ra) # 80002130 <_Z9sem_closeP4_sem>
    sem_close(mutexHead);
    80003ad8:	0284b503          	ld	a0,40(s1)
    80003adc:	ffffe097          	auipc	ra,0xffffe
    80003ae0:	654080e7          	jalr	1620(ra) # 80002130 <_Z9sem_closeP4_sem>
}
    80003ae4:	01813083          	ld	ra,24(sp)
    80003ae8:	01013403          	ld	s0,16(sp)
    80003aec:	00813483          	ld	s1,8(sp)
    80003af0:	02010113          	addi	sp,sp,32
    80003af4:	00008067          	ret

0000000080003af8 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80003af8:	fe010113          	addi	sp,sp,-32
    80003afc:	00113c23          	sd	ra,24(sp)
    80003b00:	00813823          	sd	s0,16(sp)
    80003b04:	00913423          	sd	s1,8(sp)
    80003b08:	01213023          	sd	s2,0(sp)
    80003b0c:	02010413          	addi	s0,sp,32
    80003b10:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80003b14:	00100793          	li	a5,1
    80003b18:	02a7f863          	bgeu	a5,a0,80003b48 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80003b1c:	00a00793          	li	a5,10
    80003b20:	02f577b3          	remu	a5,a0,a5
    80003b24:	02078e63          	beqz	a5,80003b60 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80003b28:	fff48513          	addi	a0,s1,-1
    80003b2c:	00000097          	auipc	ra,0x0
    80003b30:	fcc080e7          	jalr	-52(ra) # 80003af8 <_ZL9fibonaccim>
    80003b34:	00050913          	mv	s2,a0
    80003b38:	ffe48513          	addi	a0,s1,-2
    80003b3c:	00000097          	auipc	ra,0x0
    80003b40:	fbc080e7          	jalr	-68(ra) # 80003af8 <_ZL9fibonaccim>
    80003b44:	00a90533          	add	a0,s2,a0
}
    80003b48:	01813083          	ld	ra,24(sp)
    80003b4c:	01013403          	ld	s0,16(sp)
    80003b50:	00813483          	ld	s1,8(sp)
    80003b54:	00013903          	ld	s2,0(sp)
    80003b58:	02010113          	addi	sp,sp,32
    80003b5c:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80003b60:	ffffe097          	auipc	ra,0xffffe
    80003b64:	4f8080e7          	jalr	1272(ra) # 80002058 <_Z15thread_dispatchv>
    80003b68:	fc1ff06f          	j	80003b28 <_ZL9fibonaccim+0x30>

0000000080003b6c <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80003b6c:	fe010113          	addi	sp,sp,-32
    80003b70:	00113c23          	sd	ra,24(sp)
    80003b74:	00813823          	sd	s0,16(sp)
    80003b78:	00913423          	sd	s1,8(sp)
    80003b7c:	01213023          	sd	s2,0(sp)
    80003b80:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    80003b84:	00a00493          	li	s1,10
    80003b88:	0400006f          	j	80003bc8 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003b8c:	00004517          	auipc	a0,0x4
    80003b90:	a4c50513          	addi	a0,a0,-1460 # 800075d8 <_ZTV12ConsumerSync+0x28>
    80003b94:	fffff097          	auipc	ra,0xfffff
    80003b98:	b4c080e7          	jalr	-1204(ra) # 800026e0 <_Z11printStringPKc>
    80003b9c:	00000613          	li	a2,0
    80003ba0:	00a00593          	li	a1,10
    80003ba4:	00048513          	mv	a0,s1
    80003ba8:	fffff097          	auipc	ra,0xfffff
    80003bac:	ce8080e7          	jalr	-792(ra) # 80002890 <_Z8printIntiii>
    80003bb0:	00003517          	auipc	a0,0x3
    80003bb4:	78050513          	addi	a0,a0,1920 # 80007330 <CONSOLE_STATUS+0x320>
    80003bb8:	fffff097          	auipc	ra,0xfffff
    80003bbc:	b28080e7          	jalr	-1240(ra) # 800026e0 <_Z11printStringPKc>
    for (; i < 13; i++) {
    80003bc0:	0014849b          	addiw	s1,s1,1
    80003bc4:	0ff4f493          	andi	s1,s1,255
    80003bc8:	00c00793          	li	a5,12
    80003bcc:	fc97f0e3          	bgeu	a5,s1,80003b8c <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    80003bd0:	00004517          	auipc	a0,0x4
    80003bd4:	a1050513          	addi	a0,a0,-1520 # 800075e0 <_ZTV12ConsumerSync+0x30>
    80003bd8:	fffff097          	auipc	ra,0xfffff
    80003bdc:	b08080e7          	jalr	-1272(ra) # 800026e0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80003be0:	00500313          	li	t1,5
    thread_dispatch();
    80003be4:	ffffe097          	auipc	ra,0xffffe
    80003be8:	474080e7          	jalr	1140(ra) # 80002058 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80003bec:	01000513          	li	a0,16
    80003bf0:	00000097          	auipc	ra,0x0
    80003bf4:	f08080e7          	jalr	-248(ra) # 80003af8 <_ZL9fibonaccim>
    80003bf8:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80003bfc:	00004517          	auipc	a0,0x4
    80003c00:	9f450513          	addi	a0,a0,-1548 # 800075f0 <_ZTV12ConsumerSync+0x40>
    80003c04:	fffff097          	auipc	ra,0xfffff
    80003c08:	adc080e7          	jalr	-1316(ra) # 800026e0 <_Z11printStringPKc>
    80003c0c:	00000613          	li	a2,0
    80003c10:	00a00593          	li	a1,10
    80003c14:	0009051b          	sext.w	a0,s2
    80003c18:	fffff097          	auipc	ra,0xfffff
    80003c1c:	c78080e7          	jalr	-904(ra) # 80002890 <_Z8printIntiii>
    80003c20:	00003517          	auipc	a0,0x3
    80003c24:	71050513          	addi	a0,a0,1808 # 80007330 <CONSOLE_STATUS+0x320>
    80003c28:	fffff097          	auipc	ra,0xfffff
    80003c2c:	ab8080e7          	jalr	-1352(ra) # 800026e0 <_Z11printStringPKc>
    80003c30:	0400006f          	j	80003c70 <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80003c34:	00004517          	auipc	a0,0x4
    80003c38:	9a450513          	addi	a0,a0,-1628 # 800075d8 <_ZTV12ConsumerSync+0x28>
    80003c3c:	fffff097          	auipc	ra,0xfffff
    80003c40:	aa4080e7          	jalr	-1372(ra) # 800026e0 <_Z11printStringPKc>
    80003c44:	00000613          	li	a2,0
    80003c48:	00a00593          	li	a1,10
    80003c4c:	00048513          	mv	a0,s1
    80003c50:	fffff097          	auipc	ra,0xfffff
    80003c54:	c40080e7          	jalr	-960(ra) # 80002890 <_Z8printIntiii>
    80003c58:	00003517          	auipc	a0,0x3
    80003c5c:	6d850513          	addi	a0,a0,1752 # 80007330 <CONSOLE_STATUS+0x320>
    80003c60:	fffff097          	auipc	ra,0xfffff
    80003c64:	a80080e7          	jalr	-1408(ra) # 800026e0 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80003c68:	0014849b          	addiw	s1,s1,1
    80003c6c:	0ff4f493          	andi	s1,s1,255
    80003c70:	00f00793          	li	a5,15
    80003c74:	fc97f0e3          	bgeu	a5,s1,80003c34 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    80003c78:	00004517          	auipc	a0,0x4
    80003c7c:	98850513          	addi	a0,a0,-1656 # 80007600 <_ZTV12ConsumerSync+0x50>
    80003c80:	fffff097          	auipc	ra,0xfffff
    80003c84:	a60080e7          	jalr	-1440(ra) # 800026e0 <_Z11printStringPKc>
    finishedD = true;
    80003c88:	00100793          	li	a5,1
    80003c8c:	00005717          	auipc	a4,0x5
    80003c90:	10f70223          	sb	a5,260(a4) # 80008d90 <_ZL9finishedD>
    thread_dispatch();
    80003c94:	ffffe097          	auipc	ra,0xffffe
    80003c98:	3c4080e7          	jalr	964(ra) # 80002058 <_Z15thread_dispatchv>
}
    80003c9c:	01813083          	ld	ra,24(sp)
    80003ca0:	01013403          	ld	s0,16(sp)
    80003ca4:	00813483          	ld	s1,8(sp)
    80003ca8:	00013903          	ld	s2,0(sp)
    80003cac:	02010113          	addi	sp,sp,32
    80003cb0:	00008067          	ret

0000000080003cb4 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    80003cb4:	fe010113          	addi	sp,sp,-32
    80003cb8:	00113c23          	sd	ra,24(sp)
    80003cbc:	00813823          	sd	s0,16(sp)
    80003cc0:	00913423          	sd	s1,8(sp)
    80003cc4:	01213023          	sd	s2,0(sp)
    80003cc8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80003ccc:	00000493          	li	s1,0
    80003cd0:	0400006f          	j	80003d10 <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80003cd4:	00004517          	auipc	a0,0x4
    80003cd8:	93c50513          	addi	a0,a0,-1732 # 80007610 <_ZTV12ConsumerSync+0x60>
    80003cdc:	fffff097          	auipc	ra,0xfffff
    80003ce0:	a04080e7          	jalr	-1532(ra) # 800026e0 <_Z11printStringPKc>
    80003ce4:	00000613          	li	a2,0
    80003ce8:	00a00593          	li	a1,10
    80003cec:	00048513          	mv	a0,s1
    80003cf0:	fffff097          	auipc	ra,0xfffff
    80003cf4:	ba0080e7          	jalr	-1120(ra) # 80002890 <_Z8printIntiii>
    80003cf8:	00003517          	auipc	a0,0x3
    80003cfc:	63850513          	addi	a0,a0,1592 # 80007330 <CONSOLE_STATUS+0x320>
    80003d00:	fffff097          	auipc	ra,0xfffff
    80003d04:	9e0080e7          	jalr	-1568(ra) # 800026e0 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80003d08:	0014849b          	addiw	s1,s1,1
    80003d0c:	0ff4f493          	andi	s1,s1,255
    80003d10:	00200793          	li	a5,2
    80003d14:	fc97f0e3          	bgeu	a5,s1,80003cd4 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80003d18:	00004517          	auipc	a0,0x4
    80003d1c:	90050513          	addi	a0,a0,-1792 # 80007618 <_ZTV12ConsumerSync+0x68>
    80003d20:	fffff097          	auipc	ra,0xfffff
    80003d24:	9c0080e7          	jalr	-1600(ra) # 800026e0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80003d28:	00700313          	li	t1,7
    thread_dispatch();
    80003d2c:	ffffe097          	auipc	ra,0xffffe
    80003d30:	32c080e7          	jalr	812(ra) # 80002058 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80003d34:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80003d38:	00004517          	auipc	a0,0x4
    80003d3c:	8f050513          	addi	a0,a0,-1808 # 80007628 <_ZTV12ConsumerSync+0x78>
    80003d40:	fffff097          	auipc	ra,0xfffff
    80003d44:	9a0080e7          	jalr	-1632(ra) # 800026e0 <_Z11printStringPKc>
    80003d48:	00000613          	li	a2,0
    80003d4c:	00a00593          	li	a1,10
    80003d50:	0009051b          	sext.w	a0,s2
    80003d54:	fffff097          	auipc	ra,0xfffff
    80003d58:	b3c080e7          	jalr	-1220(ra) # 80002890 <_Z8printIntiii>
    80003d5c:	00003517          	auipc	a0,0x3
    80003d60:	5d450513          	addi	a0,a0,1492 # 80007330 <CONSOLE_STATUS+0x320>
    80003d64:	fffff097          	auipc	ra,0xfffff
    80003d68:	97c080e7          	jalr	-1668(ra) # 800026e0 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80003d6c:	00c00513          	li	a0,12
    80003d70:	00000097          	auipc	ra,0x0
    80003d74:	d88080e7          	jalr	-632(ra) # 80003af8 <_ZL9fibonaccim>
    80003d78:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    80003d7c:	00004517          	auipc	a0,0x4
    80003d80:	8b450513          	addi	a0,a0,-1868 # 80007630 <_ZTV12ConsumerSync+0x80>
    80003d84:	fffff097          	auipc	ra,0xfffff
    80003d88:	95c080e7          	jalr	-1700(ra) # 800026e0 <_Z11printStringPKc>
    80003d8c:	00000613          	li	a2,0
    80003d90:	00a00593          	li	a1,10
    80003d94:	0009051b          	sext.w	a0,s2
    80003d98:	fffff097          	auipc	ra,0xfffff
    80003d9c:	af8080e7          	jalr	-1288(ra) # 80002890 <_Z8printIntiii>
    80003da0:	00003517          	auipc	a0,0x3
    80003da4:	59050513          	addi	a0,a0,1424 # 80007330 <CONSOLE_STATUS+0x320>
    80003da8:	fffff097          	auipc	ra,0xfffff
    80003dac:	938080e7          	jalr	-1736(ra) # 800026e0 <_Z11printStringPKc>
    80003db0:	0400006f          	j	80003df0 <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    80003db4:	00004517          	auipc	a0,0x4
    80003db8:	85c50513          	addi	a0,a0,-1956 # 80007610 <_ZTV12ConsumerSync+0x60>
    80003dbc:	fffff097          	auipc	ra,0xfffff
    80003dc0:	924080e7          	jalr	-1756(ra) # 800026e0 <_Z11printStringPKc>
    80003dc4:	00000613          	li	a2,0
    80003dc8:	00a00593          	li	a1,10
    80003dcc:	00048513          	mv	a0,s1
    80003dd0:	fffff097          	auipc	ra,0xfffff
    80003dd4:	ac0080e7          	jalr	-1344(ra) # 80002890 <_Z8printIntiii>
    80003dd8:	00003517          	auipc	a0,0x3
    80003ddc:	55850513          	addi	a0,a0,1368 # 80007330 <CONSOLE_STATUS+0x320>
    80003de0:	fffff097          	auipc	ra,0xfffff
    80003de4:	900080e7          	jalr	-1792(ra) # 800026e0 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80003de8:	0014849b          	addiw	s1,s1,1
    80003dec:	0ff4f493          	andi	s1,s1,255
    80003df0:	00500793          	li	a5,5
    80003df4:	fc97f0e3          	bgeu	a5,s1,80003db4 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80003df8:	00004517          	auipc	a0,0x4
    80003dfc:	84850513          	addi	a0,a0,-1976 # 80007640 <_ZTV12ConsumerSync+0x90>
    80003e00:	fffff097          	auipc	ra,0xfffff
    80003e04:	8e0080e7          	jalr	-1824(ra) # 800026e0 <_Z11printStringPKc>
    finishedC = true;
    80003e08:	00100793          	li	a5,1
    80003e0c:	00005717          	auipc	a4,0x5
    80003e10:	f8f702a3          	sb	a5,-123(a4) # 80008d91 <_ZL9finishedC>
    thread_dispatch();
    80003e14:	ffffe097          	auipc	ra,0xffffe
    80003e18:	244080e7          	jalr	580(ra) # 80002058 <_Z15thread_dispatchv>
}
    80003e1c:	01813083          	ld	ra,24(sp)
    80003e20:	01013403          	ld	s0,16(sp)
    80003e24:	00813483          	ld	s1,8(sp)
    80003e28:	00013903          	ld	s2,0(sp)
    80003e2c:	02010113          	addi	sp,sp,32
    80003e30:	00008067          	ret

0000000080003e34 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80003e34:	fe010113          	addi	sp,sp,-32
    80003e38:	00113c23          	sd	ra,24(sp)
    80003e3c:	00813823          	sd	s0,16(sp)
    80003e40:	00913423          	sd	s1,8(sp)
    80003e44:	01213023          	sd	s2,0(sp)
    80003e48:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80003e4c:	00000913          	li	s2,0
    80003e50:	0380006f          	j	80003e88 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80003e54:	ffffe097          	auipc	ra,0xffffe
    80003e58:	204080e7          	jalr	516(ra) # 80002058 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003e5c:	00148493          	addi	s1,s1,1
    80003e60:	000027b7          	lui	a5,0x2
    80003e64:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003e68:	0097ee63          	bltu	a5,s1,80003e84 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003e6c:	00000713          	li	a4,0
    80003e70:	000077b7          	lui	a5,0x7
    80003e74:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003e78:	fce7eee3          	bltu	a5,a4,80003e54 <_ZL11workerBodyBPv+0x20>
    80003e7c:	00170713          	addi	a4,a4,1
    80003e80:	ff1ff06f          	j	80003e70 <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80003e84:	00190913          	addi	s2,s2,1
    80003e88:	00f00793          	li	a5,15
    80003e8c:	0527e063          	bltu	a5,s2,80003ecc <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80003e90:	00003517          	auipc	a0,0x3
    80003e94:	7c050513          	addi	a0,a0,1984 # 80007650 <_ZTV12ConsumerSync+0xa0>
    80003e98:	fffff097          	auipc	ra,0xfffff
    80003e9c:	848080e7          	jalr	-1976(ra) # 800026e0 <_Z11printStringPKc>
    80003ea0:	00000613          	li	a2,0
    80003ea4:	00a00593          	li	a1,10
    80003ea8:	0009051b          	sext.w	a0,s2
    80003eac:	fffff097          	auipc	ra,0xfffff
    80003eb0:	9e4080e7          	jalr	-1564(ra) # 80002890 <_Z8printIntiii>
    80003eb4:	00003517          	auipc	a0,0x3
    80003eb8:	47c50513          	addi	a0,a0,1148 # 80007330 <CONSOLE_STATUS+0x320>
    80003ebc:	fffff097          	auipc	ra,0xfffff
    80003ec0:	824080e7          	jalr	-2012(ra) # 800026e0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003ec4:	00000493          	li	s1,0
    80003ec8:	f99ff06f          	j	80003e60 <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    80003ecc:	00003517          	auipc	a0,0x3
    80003ed0:	78c50513          	addi	a0,a0,1932 # 80007658 <_ZTV12ConsumerSync+0xa8>
    80003ed4:	fffff097          	auipc	ra,0xfffff
    80003ed8:	80c080e7          	jalr	-2036(ra) # 800026e0 <_Z11printStringPKc>
    finishedB = true;
    80003edc:	00100793          	li	a5,1
    80003ee0:	00005717          	auipc	a4,0x5
    80003ee4:	eaf70923          	sb	a5,-334(a4) # 80008d92 <_ZL9finishedB>
    thread_dispatch();
    80003ee8:	ffffe097          	auipc	ra,0xffffe
    80003eec:	170080e7          	jalr	368(ra) # 80002058 <_Z15thread_dispatchv>
}
    80003ef0:	01813083          	ld	ra,24(sp)
    80003ef4:	01013403          	ld	s0,16(sp)
    80003ef8:	00813483          	ld	s1,8(sp)
    80003efc:	00013903          	ld	s2,0(sp)
    80003f00:	02010113          	addi	sp,sp,32
    80003f04:	00008067          	ret

0000000080003f08 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80003f08:	fe010113          	addi	sp,sp,-32
    80003f0c:	00113c23          	sd	ra,24(sp)
    80003f10:	00813823          	sd	s0,16(sp)
    80003f14:	00913423          	sd	s1,8(sp)
    80003f18:	01213023          	sd	s2,0(sp)
    80003f1c:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80003f20:	00000913          	li	s2,0
    80003f24:	0380006f          	j	80003f5c <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80003f28:	ffffe097          	auipc	ra,0xffffe
    80003f2c:	130080e7          	jalr	304(ra) # 80002058 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80003f30:	00148493          	addi	s1,s1,1
    80003f34:	000027b7          	lui	a5,0x2
    80003f38:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80003f3c:	0097ee63          	bltu	a5,s1,80003f58 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80003f40:	00000713          	li	a4,0
    80003f44:	000077b7          	lui	a5,0x7
    80003f48:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80003f4c:	fce7eee3          	bltu	a5,a4,80003f28 <_ZL11workerBodyAPv+0x20>
    80003f50:	00170713          	addi	a4,a4,1
    80003f54:	ff1ff06f          	j	80003f44 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80003f58:	00190913          	addi	s2,s2,1
    80003f5c:	00900793          	li	a5,9
    80003f60:	0527e063          	bltu	a5,s2,80003fa0 <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80003f64:	00003517          	auipc	a0,0x3
    80003f68:	70450513          	addi	a0,a0,1796 # 80007668 <_ZTV12ConsumerSync+0xb8>
    80003f6c:	ffffe097          	auipc	ra,0xffffe
    80003f70:	774080e7          	jalr	1908(ra) # 800026e0 <_Z11printStringPKc>
    80003f74:	00000613          	li	a2,0
    80003f78:	00a00593          	li	a1,10
    80003f7c:	0009051b          	sext.w	a0,s2
    80003f80:	fffff097          	auipc	ra,0xfffff
    80003f84:	910080e7          	jalr	-1776(ra) # 80002890 <_Z8printIntiii>
    80003f88:	00003517          	auipc	a0,0x3
    80003f8c:	3a850513          	addi	a0,a0,936 # 80007330 <CONSOLE_STATUS+0x320>
    80003f90:	ffffe097          	auipc	ra,0xffffe
    80003f94:	750080e7          	jalr	1872(ra) # 800026e0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80003f98:	00000493          	li	s1,0
    80003f9c:	f99ff06f          	j	80003f34 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    80003fa0:	00003517          	auipc	a0,0x3
    80003fa4:	6a050513          	addi	a0,a0,1696 # 80007640 <_ZTV12ConsumerSync+0x90>
    80003fa8:	ffffe097          	auipc	ra,0xffffe
    80003fac:	738080e7          	jalr	1848(ra) # 800026e0 <_Z11printStringPKc>
    finishedA = true;
    80003fb0:	00100793          	li	a5,1
    80003fb4:	00005717          	auipc	a4,0x5
    80003fb8:	dcf70fa3          	sb	a5,-545(a4) # 80008d93 <_ZL9finishedA>
}
    80003fbc:	01813083          	ld	ra,24(sp)
    80003fc0:	01013403          	ld	s0,16(sp)
    80003fc4:	00813483          	ld	s1,8(sp)
    80003fc8:	00013903          	ld	s2,0(sp)
    80003fcc:	02010113          	addi	sp,sp,32
    80003fd0:	00008067          	ret

0000000080003fd4 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80003fd4:	fd010113          	addi	sp,sp,-48
    80003fd8:	02113423          	sd	ra,40(sp)
    80003fdc:	02813023          	sd	s0,32(sp)
    80003fe0:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80003fe4:	00000613          	li	a2,0
    80003fe8:	00000597          	auipc	a1,0x0
    80003fec:	f2058593          	addi	a1,a1,-224 # 80003f08 <_ZL11workerBodyAPv>
    80003ff0:	fd040513          	addi	a0,s0,-48
    80003ff4:	ffffe097          	auipc	ra,0xffffe
    80003ff8:	02c080e7          	jalr	44(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80003ffc:	00003517          	auipc	a0,0x3
    80004000:	67450513          	addi	a0,a0,1652 # 80007670 <_ZTV12ConsumerSync+0xc0>
    80004004:	ffffe097          	auipc	ra,0xffffe
    80004008:	6dc080e7          	jalr	1756(ra) # 800026e0 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    8000400c:	00000613          	li	a2,0
    80004010:	00000597          	auipc	a1,0x0
    80004014:	e2458593          	addi	a1,a1,-476 # 80003e34 <_ZL11workerBodyBPv>
    80004018:	fd840513          	addi	a0,s0,-40
    8000401c:	ffffe097          	auipc	ra,0xffffe
    80004020:	004080e7          	jalr	4(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80004024:	00003517          	auipc	a0,0x3
    80004028:	66450513          	addi	a0,a0,1636 # 80007688 <_ZTV12ConsumerSync+0xd8>
    8000402c:	ffffe097          	auipc	ra,0xffffe
    80004030:	6b4080e7          	jalr	1716(ra) # 800026e0 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80004034:	00000613          	li	a2,0
    80004038:	00000597          	auipc	a1,0x0
    8000403c:	c7c58593          	addi	a1,a1,-900 # 80003cb4 <_ZL11workerBodyCPv>
    80004040:	fe040513          	addi	a0,s0,-32
    80004044:	ffffe097          	auipc	ra,0xffffe
    80004048:	fdc080e7          	jalr	-36(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    8000404c:	00003517          	auipc	a0,0x3
    80004050:	65450513          	addi	a0,a0,1620 # 800076a0 <_ZTV12ConsumerSync+0xf0>
    80004054:	ffffe097          	auipc	ra,0xffffe
    80004058:	68c080e7          	jalr	1676(ra) # 800026e0 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    8000405c:	00000613          	li	a2,0
    80004060:	00000597          	auipc	a1,0x0
    80004064:	b0c58593          	addi	a1,a1,-1268 # 80003b6c <_ZL11workerBodyDPv>
    80004068:	fe840513          	addi	a0,s0,-24
    8000406c:	ffffe097          	auipc	ra,0xffffe
    80004070:	fb4080e7          	jalr	-76(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    80004074:	00003517          	auipc	a0,0x3
    80004078:	64450513          	addi	a0,a0,1604 # 800076b8 <_ZTV12ConsumerSync+0x108>
    8000407c:	ffffe097          	auipc	ra,0xffffe
    80004080:	664080e7          	jalr	1636(ra) # 800026e0 <_Z11printStringPKc>
    80004084:	00c0006f          	j	80004090 <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    80004088:	ffffe097          	auipc	ra,0xffffe
    8000408c:	fd0080e7          	jalr	-48(ra) # 80002058 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80004090:	00005797          	auipc	a5,0x5
    80004094:	d037c783          	lbu	a5,-765(a5) # 80008d93 <_ZL9finishedA>
    80004098:	fe0788e3          	beqz	a5,80004088 <_Z18Threads_C_API_testv+0xb4>
    8000409c:	00005797          	auipc	a5,0x5
    800040a0:	cf67c783          	lbu	a5,-778(a5) # 80008d92 <_ZL9finishedB>
    800040a4:	fe0782e3          	beqz	a5,80004088 <_Z18Threads_C_API_testv+0xb4>
    800040a8:	00005797          	auipc	a5,0x5
    800040ac:	ce97c783          	lbu	a5,-791(a5) # 80008d91 <_ZL9finishedC>
    800040b0:	fc078ce3          	beqz	a5,80004088 <_Z18Threads_C_API_testv+0xb4>
    800040b4:	00005797          	auipc	a5,0x5
    800040b8:	cdc7c783          	lbu	a5,-804(a5) # 80008d90 <_ZL9finishedD>
    800040bc:	fc0786e3          	beqz	a5,80004088 <_Z18Threads_C_API_testv+0xb4>
    }

}
    800040c0:	02813083          	ld	ra,40(sp)
    800040c4:	02013403          	ld	s0,32(sp)
    800040c8:	03010113          	addi	sp,sp,48
    800040cc:	00008067          	ret

00000000800040d0 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800040d0:	fe010113          	addi	sp,sp,-32
    800040d4:	00113c23          	sd	ra,24(sp)
    800040d8:	00813823          	sd	s0,16(sp)
    800040dc:	00913423          	sd	s1,8(sp)
    800040e0:	01213023          	sd	s2,0(sp)
    800040e4:	02010413          	addi	s0,sp,32
    800040e8:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    800040ec:	00100793          	li	a5,1
    800040f0:	02a7f863          	bgeu	a5,a0,80004120 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    800040f4:	00a00793          	li	a5,10
    800040f8:	02f577b3          	remu	a5,a0,a5
    800040fc:	02078e63          	beqz	a5,80004138 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80004100:	fff48513          	addi	a0,s1,-1
    80004104:	00000097          	auipc	ra,0x0
    80004108:	fcc080e7          	jalr	-52(ra) # 800040d0 <_ZL9fibonaccim>
    8000410c:	00050913          	mv	s2,a0
    80004110:	ffe48513          	addi	a0,s1,-2
    80004114:	00000097          	auipc	ra,0x0
    80004118:	fbc080e7          	jalr	-68(ra) # 800040d0 <_ZL9fibonaccim>
    8000411c:	00a90533          	add	a0,s2,a0
}
    80004120:	01813083          	ld	ra,24(sp)
    80004124:	01013403          	ld	s0,16(sp)
    80004128:	00813483          	ld	s1,8(sp)
    8000412c:	00013903          	ld	s2,0(sp)
    80004130:	02010113          	addi	sp,sp,32
    80004134:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80004138:	ffffe097          	auipc	ra,0xffffe
    8000413c:	f20080e7          	jalr	-224(ra) # 80002058 <_Z15thread_dispatchv>
    80004140:	fc1ff06f          	j	80004100 <_ZL9fibonaccim+0x30>

0000000080004144 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80004144:	fe010113          	addi	sp,sp,-32
    80004148:	00113c23          	sd	ra,24(sp)
    8000414c:	00813823          	sd	s0,16(sp)
    80004150:	00913423          	sd	s1,8(sp)
    80004154:	01213023          	sd	s2,0(sp)
    80004158:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000415c:	00000913          	li	s2,0
    80004160:	0380006f          	j	80004198 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004164:	ffffe097          	auipc	ra,0xffffe
    80004168:	ef4080e7          	jalr	-268(ra) # 80002058 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000416c:	00148493          	addi	s1,s1,1
    80004170:	000027b7          	lui	a5,0x2
    80004174:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004178:	0097ee63          	bltu	a5,s1,80004194 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000417c:	00000713          	li	a4,0
    80004180:	000077b7          	lui	a5,0x7
    80004184:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004188:	fce7eee3          	bltu	a5,a4,80004164 <_ZN7WorkerA11workerBodyAEPv+0x20>
    8000418c:	00170713          	addi	a4,a4,1
    80004190:	ff1ff06f          	j	80004180 <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80004194:	00190913          	addi	s2,s2,1
    80004198:	00900793          	li	a5,9
    8000419c:	0527e063          	bltu	a5,s2,800041dc <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800041a0:	00003517          	auipc	a0,0x3
    800041a4:	4c850513          	addi	a0,a0,1224 # 80007668 <_ZTV12ConsumerSync+0xb8>
    800041a8:	ffffe097          	auipc	ra,0xffffe
    800041ac:	538080e7          	jalr	1336(ra) # 800026e0 <_Z11printStringPKc>
    800041b0:	00000613          	li	a2,0
    800041b4:	00a00593          	li	a1,10
    800041b8:	0009051b          	sext.w	a0,s2
    800041bc:	ffffe097          	auipc	ra,0xffffe
    800041c0:	6d4080e7          	jalr	1748(ra) # 80002890 <_Z8printIntiii>
    800041c4:	00003517          	auipc	a0,0x3
    800041c8:	16c50513          	addi	a0,a0,364 # 80007330 <CONSOLE_STATUS+0x320>
    800041cc:	ffffe097          	auipc	ra,0xffffe
    800041d0:	514080e7          	jalr	1300(ra) # 800026e0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800041d4:	00000493          	li	s1,0
    800041d8:	f99ff06f          	j	80004170 <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    800041dc:	00003517          	auipc	a0,0x3
    800041e0:	46450513          	addi	a0,a0,1124 # 80007640 <_ZTV12ConsumerSync+0x90>
    800041e4:	ffffe097          	auipc	ra,0xffffe
    800041e8:	4fc080e7          	jalr	1276(ra) # 800026e0 <_Z11printStringPKc>
    finishedA = true;
    800041ec:	00100793          	li	a5,1
    800041f0:	00005717          	auipc	a4,0x5
    800041f4:	baf703a3          	sb	a5,-1113(a4) # 80008d97 <_ZL9finishedA>
}
    800041f8:	01813083          	ld	ra,24(sp)
    800041fc:	01013403          	ld	s0,16(sp)
    80004200:	00813483          	ld	s1,8(sp)
    80004204:	00013903          	ld	s2,0(sp)
    80004208:	02010113          	addi	sp,sp,32
    8000420c:	00008067          	ret

0000000080004210 <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    80004210:	fe010113          	addi	sp,sp,-32
    80004214:	00113c23          	sd	ra,24(sp)
    80004218:	00813823          	sd	s0,16(sp)
    8000421c:	00913423          	sd	s1,8(sp)
    80004220:	01213023          	sd	s2,0(sp)
    80004224:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80004228:	00000913          	li	s2,0
    8000422c:	0380006f          	j	80004264 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80004230:	ffffe097          	auipc	ra,0xffffe
    80004234:	e28080e7          	jalr	-472(ra) # 80002058 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80004238:	00148493          	addi	s1,s1,1
    8000423c:	000027b7          	lui	a5,0x2
    80004240:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80004244:	0097ee63          	bltu	a5,s1,80004260 <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80004248:	00000713          	li	a4,0
    8000424c:	000077b7          	lui	a5,0x7
    80004250:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80004254:	fce7eee3          	bltu	a5,a4,80004230 <_ZN7WorkerB11workerBodyBEPv+0x20>
    80004258:	00170713          	addi	a4,a4,1
    8000425c:	ff1ff06f          	j	8000424c <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    80004260:	00190913          	addi	s2,s2,1
    80004264:	00f00793          	li	a5,15
    80004268:	0527e063          	bltu	a5,s2,800042a8 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    8000426c:	00003517          	auipc	a0,0x3
    80004270:	3e450513          	addi	a0,a0,996 # 80007650 <_ZTV12ConsumerSync+0xa0>
    80004274:	ffffe097          	auipc	ra,0xffffe
    80004278:	46c080e7          	jalr	1132(ra) # 800026e0 <_Z11printStringPKc>
    8000427c:	00000613          	li	a2,0
    80004280:	00a00593          	li	a1,10
    80004284:	0009051b          	sext.w	a0,s2
    80004288:	ffffe097          	auipc	ra,0xffffe
    8000428c:	608080e7          	jalr	1544(ra) # 80002890 <_Z8printIntiii>
    80004290:	00003517          	auipc	a0,0x3
    80004294:	0a050513          	addi	a0,a0,160 # 80007330 <CONSOLE_STATUS+0x320>
    80004298:	ffffe097          	auipc	ra,0xffffe
    8000429c:	448080e7          	jalr	1096(ra) # 800026e0 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800042a0:	00000493          	li	s1,0
    800042a4:	f99ff06f          	j	8000423c <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    800042a8:	00003517          	auipc	a0,0x3
    800042ac:	3b050513          	addi	a0,a0,944 # 80007658 <_ZTV12ConsumerSync+0xa8>
    800042b0:	ffffe097          	auipc	ra,0xffffe
    800042b4:	430080e7          	jalr	1072(ra) # 800026e0 <_Z11printStringPKc>
    finishedB = true;
    800042b8:	00100793          	li	a5,1
    800042bc:	00005717          	auipc	a4,0x5
    800042c0:	acf70d23          	sb	a5,-1318(a4) # 80008d96 <_ZL9finishedB>
    thread_dispatch();
    800042c4:	ffffe097          	auipc	ra,0xffffe
    800042c8:	d94080e7          	jalr	-620(ra) # 80002058 <_Z15thread_dispatchv>
}
    800042cc:	01813083          	ld	ra,24(sp)
    800042d0:	01013403          	ld	s0,16(sp)
    800042d4:	00813483          	ld	s1,8(sp)
    800042d8:	00013903          	ld	s2,0(sp)
    800042dc:	02010113          	addi	sp,sp,32
    800042e0:	00008067          	ret

00000000800042e4 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    800042e4:	fe010113          	addi	sp,sp,-32
    800042e8:	00113c23          	sd	ra,24(sp)
    800042ec:	00813823          	sd	s0,16(sp)
    800042f0:	00913423          	sd	s1,8(sp)
    800042f4:	01213023          	sd	s2,0(sp)
    800042f8:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800042fc:	00000493          	li	s1,0
    80004300:	0400006f          	j	80004340 <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80004304:	00003517          	auipc	a0,0x3
    80004308:	30c50513          	addi	a0,a0,780 # 80007610 <_ZTV12ConsumerSync+0x60>
    8000430c:	ffffe097          	auipc	ra,0xffffe
    80004310:	3d4080e7          	jalr	980(ra) # 800026e0 <_Z11printStringPKc>
    80004314:	00000613          	li	a2,0
    80004318:	00a00593          	li	a1,10
    8000431c:	00048513          	mv	a0,s1
    80004320:	ffffe097          	auipc	ra,0xffffe
    80004324:	570080e7          	jalr	1392(ra) # 80002890 <_Z8printIntiii>
    80004328:	00003517          	auipc	a0,0x3
    8000432c:	00850513          	addi	a0,a0,8 # 80007330 <CONSOLE_STATUS+0x320>
    80004330:	ffffe097          	auipc	ra,0xffffe
    80004334:	3b0080e7          	jalr	944(ra) # 800026e0 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80004338:	0014849b          	addiw	s1,s1,1
    8000433c:	0ff4f493          	andi	s1,s1,255
    80004340:	00200793          	li	a5,2
    80004344:	fc97f0e3          	bgeu	a5,s1,80004304 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80004348:	00003517          	auipc	a0,0x3
    8000434c:	2d050513          	addi	a0,a0,720 # 80007618 <_ZTV12ConsumerSync+0x68>
    80004350:	ffffe097          	auipc	ra,0xffffe
    80004354:	390080e7          	jalr	912(ra) # 800026e0 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80004358:	00700313          	li	t1,7
    thread_dispatch();
    8000435c:	ffffe097          	auipc	ra,0xffffe
    80004360:	cfc080e7          	jalr	-772(ra) # 80002058 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80004364:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80004368:	00003517          	auipc	a0,0x3
    8000436c:	2c050513          	addi	a0,a0,704 # 80007628 <_ZTV12ConsumerSync+0x78>
    80004370:	ffffe097          	auipc	ra,0xffffe
    80004374:	370080e7          	jalr	880(ra) # 800026e0 <_Z11printStringPKc>
    80004378:	00000613          	li	a2,0
    8000437c:	00a00593          	li	a1,10
    80004380:	0009051b          	sext.w	a0,s2
    80004384:	ffffe097          	auipc	ra,0xffffe
    80004388:	50c080e7          	jalr	1292(ra) # 80002890 <_Z8printIntiii>
    8000438c:	00003517          	auipc	a0,0x3
    80004390:	fa450513          	addi	a0,a0,-92 # 80007330 <CONSOLE_STATUS+0x320>
    80004394:	ffffe097          	auipc	ra,0xffffe
    80004398:	34c080e7          	jalr	844(ra) # 800026e0 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    8000439c:	00c00513          	li	a0,12
    800043a0:	00000097          	auipc	ra,0x0
    800043a4:	d30080e7          	jalr	-720(ra) # 800040d0 <_ZL9fibonaccim>
    800043a8:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800043ac:	00003517          	auipc	a0,0x3
    800043b0:	28450513          	addi	a0,a0,644 # 80007630 <_ZTV12ConsumerSync+0x80>
    800043b4:	ffffe097          	auipc	ra,0xffffe
    800043b8:	32c080e7          	jalr	812(ra) # 800026e0 <_Z11printStringPKc>
    800043bc:	00000613          	li	a2,0
    800043c0:	00a00593          	li	a1,10
    800043c4:	0009051b          	sext.w	a0,s2
    800043c8:	ffffe097          	auipc	ra,0xffffe
    800043cc:	4c8080e7          	jalr	1224(ra) # 80002890 <_Z8printIntiii>
    800043d0:	00003517          	auipc	a0,0x3
    800043d4:	f6050513          	addi	a0,a0,-160 # 80007330 <CONSOLE_STATUS+0x320>
    800043d8:	ffffe097          	auipc	ra,0xffffe
    800043dc:	308080e7          	jalr	776(ra) # 800026e0 <_Z11printStringPKc>
    800043e0:	0400006f          	j	80004420 <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    800043e4:	00003517          	auipc	a0,0x3
    800043e8:	22c50513          	addi	a0,a0,556 # 80007610 <_ZTV12ConsumerSync+0x60>
    800043ec:	ffffe097          	auipc	ra,0xffffe
    800043f0:	2f4080e7          	jalr	756(ra) # 800026e0 <_Z11printStringPKc>
    800043f4:	00000613          	li	a2,0
    800043f8:	00a00593          	li	a1,10
    800043fc:	00048513          	mv	a0,s1
    80004400:	ffffe097          	auipc	ra,0xffffe
    80004404:	490080e7          	jalr	1168(ra) # 80002890 <_Z8printIntiii>
    80004408:	00003517          	auipc	a0,0x3
    8000440c:	f2850513          	addi	a0,a0,-216 # 80007330 <CONSOLE_STATUS+0x320>
    80004410:	ffffe097          	auipc	ra,0xffffe
    80004414:	2d0080e7          	jalr	720(ra) # 800026e0 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80004418:	0014849b          	addiw	s1,s1,1
    8000441c:	0ff4f493          	andi	s1,s1,255
    80004420:	00500793          	li	a5,5
    80004424:	fc97f0e3          	bgeu	a5,s1,800043e4 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80004428:	00003517          	auipc	a0,0x3
    8000442c:	21850513          	addi	a0,a0,536 # 80007640 <_ZTV12ConsumerSync+0x90>
    80004430:	ffffe097          	auipc	ra,0xffffe
    80004434:	2b0080e7          	jalr	688(ra) # 800026e0 <_Z11printStringPKc>
    finishedC = true;
    80004438:	00100793          	li	a5,1
    8000443c:	00005717          	auipc	a4,0x5
    80004440:	94f70ca3          	sb	a5,-1703(a4) # 80008d95 <_ZL9finishedC>
    thread_dispatch();
    80004444:	ffffe097          	auipc	ra,0xffffe
    80004448:	c14080e7          	jalr	-1004(ra) # 80002058 <_Z15thread_dispatchv>
}
    8000444c:	01813083          	ld	ra,24(sp)
    80004450:	01013403          	ld	s0,16(sp)
    80004454:	00813483          	ld	s1,8(sp)
    80004458:	00013903          	ld	s2,0(sp)
    8000445c:	02010113          	addi	sp,sp,32
    80004460:	00008067          	ret

0000000080004464 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80004464:	fe010113          	addi	sp,sp,-32
    80004468:	00113c23          	sd	ra,24(sp)
    8000446c:	00813823          	sd	s0,16(sp)
    80004470:	00913423          	sd	s1,8(sp)
    80004474:	01213023          	sd	s2,0(sp)
    80004478:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    8000447c:	00a00493          	li	s1,10
    80004480:	0400006f          	j	800044c0 <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80004484:	00003517          	auipc	a0,0x3
    80004488:	15450513          	addi	a0,a0,340 # 800075d8 <_ZTV12ConsumerSync+0x28>
    8000448c:	ffffe097          	auipc	ra,0xffffe
    80004490:	254080e7          	jalr	596(ra) # 800026e0 <_Z11printStringPKc>
    80004494:	00000613          	li	a2,0
    80004498:	00a00593          	li	a1,10
    8000449c:	00048513          	mv	a0,s1
    800044a0:	ffffe097          	auipc	ra,0xffffe
    800044a4:	3f0080e7          	jalr	1008(ra) # 80002890 <_Z8printIntiii>
    800044a8:	00003517          	auipc	a0,0x3
    800044ac:	e8850513          	addi	a0,a0,-376 # 80007330 <CONSOLE_STATUS+0x320>
    800044b0:	ffffe097          	auipc	ra,0xffffe
    800044b4:	230080e7          	jalr	560(ra) # 800026e0 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800044b8:	0014849b          	addiw	s1,s1,1
    800044bc:	0ff4f493          	andi	s1,s1,255
    800044c0:	00c00793          	li	a5,12
    800044c4:	fc97f0e3          	bgeu	a5,s1,80004484 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    800044c8:	00003517          	auipc	a0,0x3
    800044cc:	11850513          	addi	a0,a0,280 # 800075e0 <_ZTV12ConsumerSync+0x30>
    800044d0:	ffffe097          	auipc	ra,0xffffe
    800044d4:	210080e7          	jalr	528(ra) # 800026e0 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    800044d8:	00500313          	li	t1,5
    thread_dispatch();
    800044dc:	ffffe097          	auipc	ra,0xffffe
    800044e0:	b7c080e7          	jalr	-1156(ra) # 80002058 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    800044e4:	01000513          	li	a0,16
    800044e8:	00000097          	auipc	ra,0x0
    800044ec:	be8080e7          	jalr	-1048(ra) # 800040d0 <_ZL9fibonaccim>
    800044f0:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    800044f4:	00003517          	auipc	a0,0x3
    800044f8:	0fc50513          	addi	a0,a0,252 # 800075f0 <_ZTV12ConsumerSync+0x40>
    800044fc:	ffffe097          	auipc	ra,0xffffe
    80004500:	1e4080e7          	jalr	484(ra) # 800026e0 <_Z11printStringPKc>
    80004504:	00000613          	li	a2,0
    80004508:	00a00593          	li	a1,10
    8000450c:	0009051b          	sext.w	a0,s2
    80004510:	ffffe097          	auipc	ra,0xffffe
    80004514:	380080e7          	jalr	896(ra) # 80002890 <_Z8printIntiii>
    80004518:	00003517          	auipc	a0,0x3
    8000451c:	e1850513          	addi	a0,a0,-488 # 80007330 <CONSOLE_STATUS+0x320>
    80004520:	ffffe097          	auipc	ra,0xffffe
    80004524:	1c0080e7          	jalr	448(ra) # 800026e0 <_Z11printStringPKc>
    80004528:	0400006f          	j	80004568 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    8000452c:	00003517          	auipc	a0,0x3
    80004530:	0ac50513          	addi	a0,a0,172 # 800075d8 <_ZTV12ConsumerSync+0x28>
    80004534:	ffffe097          	auipc	ra,0xffffe
    80004538:	1ac080e7          	jalr	428(ra) # 800026e0 <_Z11printStringPKc>
    8000453c:	00000613          	li	a2,0
    80004540:	00a00593          	li	a1,10
    80004544:	00048513          	mv	a0,s1
    80004548:	ffffe097          	auipc	ra,0xffffe
    8000454c:	348080e7          	jalr	840(ra) # 80002890 <_Z8printIntiii>
    80004550:	00003517          	auipc	a0,0x3
    80004554:	de050513          	addi	a0,a0,-544 # 80007330 <CONSOLE_STATUS+0x320>
    80004558:	ffffe097          	auipc	ra,0xffffe
    8000455c:	188080e7          	jalr	392(ra) # 800026e0 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80004560:	0014849b          	addiw	s1,s1,1
    80004564:	0ff4f493          	andi	s1,s1,255
    80004568:	00f00793          	li	a5,15
    8000456c:	fc97f0e3          	bgeu	a5,s1,8000452c <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80004570:	00003517          	auipc	a0,0x3
    80004574:	09050513          	addi	a0,a0,144 # 80007600 <_ZTV12ConsumerSync+0x50>
    80004578:	ffffe097          	auipc	ra,0xffffe
    8000457c:	168080e7          	jalr	360(ra) # 800026e0 <_Z11printStringPKc>
    finishedD = true;
    80004580:	00100793          	li	a5,1
    80004584:	00005717          	auipc	a4,0x5
    80004588:	80f70823          	sb	a5,-2032(a4) # 80008d94 <_ZL9finishedD>
    thread_dispatch();
    8000458c:	ffffe097          	auipc	ra,0xffffe
    80004590:	acc080e7          	jalr	-1332(ra) # 80002058 <_Z15thread_dispatchv>
}
    80004594:	01813083          	ld	ra,24(sp)
    80004598:	01013403          	ld	s0,16(sp)
    8000459c:	00813483          	ld	s1,8(sp)
    800045a0:	00013903          	ld	s2,0(sp)
    800045a4:	02010113          	addi	sp,sp,32
    800045a8:	00008067          	ret

00000000800045ac <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    800045ac:	fc010113          	addi	sp,sp,-64
    800045b0:	02113c23          	sd	ra,56(sp)
    800045b4:	02813823          	sd	s0,48(sp)
    800045b8:	02913423          	sd	s1,40(sp)
    800045bc:	03213023          	sd	s2,32(sp)
    800045c0:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    800045c4:	02000513          	li	a0,32
    800045c8:	ffffd097          	auipc	ra,0xffffd
    800045cc:	c78080e7          	jalr	-904(ra) # 80001240 <_Znwm>
    Thread(){};
    800045d0:	00053823          	sd	zero,16(a0)
    WorkerA():Thread() {}
    800045d4:	00003797          	auipc	a5,0x3
    800045d8:	11c78793          	addi	a5,a5,284 # 800076f0 <_ZTV7WorkerA+0x10>
    800045dc:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    800045e0:	fca43023          	sd	a0,-64(s0)
    printString("ThreadA created\n");
    800045e4:	00003517          	auipc	a0,0x3
    800045e8:	08c50513          	addi	a0,a0,140 # 80007670 <_ZTV12ConsumerSync+0xc0>
    800045ec:	ffffe097          	auipc	ra,0xffffe
    800045f0:	0f4080e7          	jalr	244(ra) # 800026e0 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    800045f4:	02000513          	li	a0,32
    800045f8:	ffffd097          	auipc	ra,0xffffd
    800045fc:	c48080e7          	jalr	-952(ra) # 80001240 <_Znwm>
    80004600:	00053823          	sd	zero,16(a0)
    WorkerB():Thread() {}
    80004604:	00003797          	auipc	a5,0x3
    80004608:	11478793          	addi	a5,a5,276 # 80007718 <_ZTV7WorkerB+0x10>
    8000460c:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    80004610:	fca43423          	sd	a0,-56(s0)
    printString("ThreadB created\n");
    80004614:	00003517          	auipc	a0,0x3
    80004618:	07450513          	addi	a0,a0,116 # 80007688 <_ZTV12ConsumerSync+0xd8>
    8000461c:	ffffe097          	auipc	ra,0xffffe
    80004620:	0c4080e7          	jalr	196(ra) # 800026e0 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80004624:	02000513          	li	a0,32
    80004628:	ffffd097          	auipc	ra,0xffffd
    8000462c:	c18080e7          	jalr	-1000(ra) # 80001240 <_Znwm>
    80004630:	00053823          	sd	zero,16(a0)
    WorkerC():Thread() {}
    80004634:	00003797          	auipc	a5,0x3
    80004638:	10c78793          	addi	a5,a5,268 # 80007740 <_ZTV7WorkerC+0x10>
    8000463c:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    80004640:	fca43823          	sd	a0,-48(s0)
    printString("ThreadC created\n");
    80004644:	00003517          	auipc	a0,0x3
    80004648:	05c50513          	addi	a0,a0,92 # 800076a0 <_ZTV12ConsumerSync+0xf0>
    8000464c:	ffffe097          	auipc	ra,0xffffe
    80004650:	094080e7          	jalr	148(ra) # 800026e0 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80004654:	02000513          	li	a0,32
    80004658:	ffffd097          	auipc	ra,0xffffd
    8000465c:	be8080e7          	jalr	-1048(ra) # 80001240 <_Znwm>
    80004660:	00053823          	sd	zero,16(a0)
    WorkerD():Thread() {}
    80004664:	00003797          	auipc	a5,0x3
    80004668:	10478793          	addi	a5,a5,260 # 80007768 <_ZTV7WorkerD+0x10>
    8000466c:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    80004670:	fca43c23          	sd	a0,-40(s0)
    printString("ThreadD created\n");
    80004674:	00003517          	auipc	a0,0x3
    80004678:	04450513          	addi	a0,a0,68 # 800076b8 <_ZTV12ConsumerSync+0x108>
    8000467c:	ffffe097          	auipc	ra,0xffffe
    80004680:	064080e7          	jalr	100(ra) # 800026e0 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80004684:	00000493          	li	s1,0
    80004688:	0200006f          	j	800046a8 <_Z20Threads_CPP_API_testv+0xfc>
            thread_create(&myhandle, &threadWrapper,this);
    8000468c:	00050613          	mv	a2,a0
    80004690:	fffff597          	auipc	a1,0xfffff
    80004694:	e9058593          	addi	a1,a1,-368 # 80003520 <_ZN6Thread13threadWrapperEPv>
    80004698:	00850513          	addi	a0,a0,8
    8000469c:	ffffe097          	auipc	ra,0xffffe
    800046a0:	984080e7          	jalr	-1660(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    800046a4:	0014849b          	addiw	s1,s1,1
    800046a8:	00300793          	li	a5,3
    800046ac:	0297cc63          	blt	a5,s1,800046e4 <_Z20Threads_CPP_API_testv+0x138>
        threads[i]->start();
    800046b0:	00349793          	slli	a5,s1,0x3
    800046b4:	fe040713          	addi	a4,s0,-32
    800046b8:	00f707b3          	add	a5,a4,a5
    800046bc:	fe07b503          	ld	a0,-32(a5)
        if (body == nullptr){
    800046c0:	01053583          	ld	a1,16(a0)
    800046c4:	fc0584e3          	beqz	a1,8000468c <_Z20Threads_CPP_API_testv+0xe0>
            thread_create(&myhandle, body,arg);
    800046c8:	01853603          	ld	a2,24(a0)
    800046cc:	00850513          	addi	a0,a0,8
    800046d0:	ffffe097          	auipc	ra,0xffffe
    800046d4:	950080e7          	jalr	-1712(ra) # 80002020 <_Z13thread_createPP7_threadPFvPvES2_>
    800046d8:	fcdff06f          	j	800046a4 <_Z20Threads_CPP_API_testv+0xf8>
    static void dispatch() {thread_dispatch();}
    800046dc:	ffffe097          	auipc	ra,0xffffe
    800046e0:	97c080e7          	jalr	-1668(ra) # 80002058 <_Z15thread_dispatchv>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800046e4:	00004797          	auipc	a5,0x4
    800046e8:	6b37c783          	lbu	a5,1715(a5) # 80008d97 <_ZL9finishedA>
    800046ec:	fe0788e3          	beqz	a5,800046dc <_Z20Threads_CPP_API_testv+0x130>
    800046f0:	00004797          	auipc	a5,0x4
    800046f4:	6a67c783          	lbu	a5,1702(a5) # 80008d96 <_ZL9finishedB>
    800046f8:	fe0782e3          	beqz	a5,800046dc <_Z20Threads_CPP_API_testv+0x130>
    800046fc:	00004797          	auipc	a5,0x4
    80004700:	6997c783          	lbu	a5,1689(a5) # 80008d95 <_ZL9finishedC>
    80004704:	fc078ce3          	beqz	a5,800046dc <_Z20Threads_CPP_API_testv+0x130>
    80004708:	00004797          	auipc	a5,0x4
    8000470c:	68c7c783          	lbu	a5,1676(a5) # 80008d94 <_ZL9finishedD>
    80004710:	fc0786e3          	beqz	a5,800046dc <_Z20Threads_CPP_API_testv+0x130>
    80004714:	fc040493          	addi	s1,s0,-64
    80004718:	0080006f          	j	80004720 <_Z20Threads_CPP_API_testv+0x174>
        Thread::dispatch();
    }

    for (auto thread: threads) {  printString("Obrisao\n"); delete thread; }
    8000471c:	00848493          	addi	s1,s1,8
    80004720:	fe040793          	addi	a5,s0,-32
    80004724:	02f48863          	beq	s1,a5,80004754 <_Z20Threads_CPP_API_testv+0x1a8>
    80004728:	0004b903          	ld	s2,0(s1)
    8000472c:	00003517          	auipc	a0,0x3
    80004730:	fa450513          	addi	a0,a0,-92 # 800076d0 <_ZTV12ConsumerSync+0x120>
    80004734:	ffffe097          	auipc	ra,0xffffe
    80004738:	fac080e7          	jalr	-84(ra) # 800026e0 <_Z11printStringPKc>
    8000473c:	fe0900e3          	beqz	s2,8000471c <_Z20Threads_CPP_API_testv+0x170>
    80004740:	00093783          	ld	a5,0(s2)
    80004744:	0087b783          	ld	a5,8(a5)
    80004748:	00090513          	mv	a0,s2
    8000474c:	000780e7          	jalr	a5
    80004750:	fcdff06f          	j	8000471c <_Z20Threads_CPP_API_testv+0x170>
}
    80004754:	03813083          	ld	ra,56(sp)
    80004758:	03013403          	ld	s0,48(sp)
    8000475c:	02813483          	ld	s1,40(sp)
    80004760:	02013903          	ld	s2,32(sp)
    80004764:	04010113          	addi	sp,sp,64
    80004768:	00008067          	ret

000000008000476c <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    8000476c:	ff010113          	addi	sp,sp,-16
    80004770:	00113423          	sd	ra,8(sp)
    80004774:	00813023          	sd	s0,0(sp)
    80004778:	01010413          	addi	s0,sp,16
    virtual ~Thread() { thread_exit();}
    8000477c:	00003797          	auipc	a5,0x3
    80004780:	dcc78793          	addi	a5,a5,-564 # 80007548 <_ZTV6Thread+0x10>
    80004784:	00f53023          	sd	a5,0(a0)
    80004788:	ffffe097          	auipc	ra,0xffffe
    8000478c:	8f4080e7          	jalr	-1804(ra) # 8000207c <_Z11thread_exitv>
    80004790:	00813083          	ld	ra,8(sp)
    80004794:	00013403          	ld	s0,0(sp)
    80004798:	01010113          	addi	sp,sp,16
    8000479c:	00008067          	ret

00000000800047a0 <_ZN7WorkerAD0Ev>:
    800047a0:	fe010113          	addi	sp,sp,-32
    800047a4:	00113c23          	sd	ra,24(sp)
    800047a8:	00813823          	sd	s0,16(sp)
    800047ac:	00913423          	sd	s1,8(sp)
    800047b0:	02010413          	addi	s0,sp,32
    800047b4:	00050493          	mv	s1,a0
    800047b8:	00003797          	auipc	a5,0x3
    800047bc:	d9078793          	addi	a5,a5,-624 # 80007548 <_ZTV6Thread+0x10>
    800047c0:	00f53023          	sd	a5,0(a0)
    800047c4:	ffffe097          	auipc	ra,0xffffe
    800047c8:	8b8080e7          	jalr	-1864(ra) # 8000207c <_Z11thread_exitv>
    800047cc:	00048513          	mv	a0,s1
    800047d0:	ffffd097          	auipc	ra,0xffffd
    800047d4:	ac0080e7          	jalr	-1344(ra) # 80001290 <_ZdlPv>
    800047d8:	01813083          	ld	ra,24(sp)
    800047dc:	01013403          	ld	s0,16(sp)
    800047e0:	00813483          	ld	s1,8(sp)
    800047e4:	02010113          	addi	sp,sp,32
    800047e8:	00008067          	ret

00000000800047ec <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    800047ec:	ff010113          	addi	sp,sp,-16
    800047f0:	00113423          	sd	ra,8(sp)
    800047f4:	00813023          	sd	s0,0(sp)
    800047f8:	01010413          	addi	s0,sp,16
    800047fc:	00003797          	auipc	a5,0x3
    80004800:	d4c78793          	addi	a5,a5,-692 # 80007548 <_ZTV6Thread+0x10>
    80004804:	00f53023          	sd	a5,0(a0)
    80004808:	ffffe097          	auipc	ra,0xffffe
    8000480c:	874080e7          	jalr	-1932(ra) # 8000207c <_Z11thread_exitv>
    80004810:	00813083          	ld	ra,8(sp)
    80004814:	00013403          	ld	s0,0(sp)
    80004818:	01010113          	addi	sp,sp,16
    8000481c:	00008067          	ret

0000000080004820 <_ZN7WorkerBD0Ev>:
    80004820:	fe010113          	addi	sp,sp,-32
    80004824:	00113c23          	sd	ra,24(sp)
    80004828:	00813823          	sd	s0,16(sp)
    8000482c:	00913423          	sd	s1,8(sp)
    80004830:	02010413          	addi	s0,sp,32
    80004834:	00050493          	mv	s1,a0
    80004838:	00003797          	auipc	a5,0x3
    8000483c:	d1078793          	addi	a5,a5,-752 # 80007548 <_ZTV6Thread+0x10>
    80004840:	00f53023          	sd	a5,0(a0)
    80004844:	ffffe097          	auipc	ra,0xffffe
    80004848:	838080e7          	jalr	-1992(ra) # 8000207c <_Z11thread_exitv>
    8000484c:	00048513          	mv	a0,s1
    80004850:	ffffd097          	auipc	ra,0xffffd
    80004854:	a40080e7          	jalr	-1472(ra) # 80001290 <_ZdlPv>
    80004858:	01813083          	ld	ra,24(sp)
    8000485c:	01013403          	ld	s0,16(sp)
    80004860:	00813483          	ld	s1,8(sp)
    80004864:	02010113          	addi	sp,sp,32
    80004868:	00008067          	ret

000000008000486c <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    8000486c:	ff010113          	addi	sp,sp,-16
    80004870:	00113423          	sd	ra,8(sp)
    80004874:	00813023          	sd	s0,0(sp)
    80004878:	01010413          	addi	s0,sp,16
    8000487c:	00003797          	auipc	a5,0x3
    80004880:	ccc78793          	addi	a5,a5,-820 # 80007548 <_ZTV6Thread+0x10>
    80004884:	00f53023          	sd	a5,0(a0)
    80004888:	ffffd097          	auipc	ra,0xffffd
    8000488c:	7f4080e7          	jalr	2036(ra) # 8000207c <_Z11thread_exitv>
    80004890:	00813083          	ld	ra,8(sp)
    80004894:	00013403          	ld	s0,0(sp)
    80004898:	01010113          	addi	sp,sp,16
    8000489c:	00008067          	ret

00000000800048a0 <_ZN7WorkerCD0Ev>:
    800048a0:	fe010113          	addi	sp,sp,-32
    800048a4:	00113c23          	sd	ra,24(sp)
    800048a8:	00813823          	sd	s0,16(sp)
    800048ac:	00913423          	sd	s1,8(sp)
    800048b0:	02010413          	addi	s0,sp,32
    800048b4:	00050493          	mv	s1,a0
    800048b8:	00003797          	auipc	a5,0x3
    800048bc:	c9078793          	addi	a5,a5,-880 # 80007548 <_ZTV6Thread+0x10>
    800048c0:	00f53023          	sd	a5,0(a0)
    800048c4:	ffffd097          	auipc	ra,0xffffd
    800048c8:	7b8080e7          	jalr	1976(ra) # 8000207c <_Z11thread_exitv>
    800048cc:	00048513          	mv	a0,s1
    800048d0:	ffffd097          	auipc	ra,0xffffd
    800048d4:	9c0080e7          	jalr	-1600(ra) # 80001290 <_ZdlPv>
    800048d8:	01813083          	ld	ra,24(sp)
    800048dc:	01013403          	ld	s0,16(sp)
    800048e0:	00813483          	ld	s1,8(sp)
    800048e4:	02010113          	addi	sp,sp,32
    800048e8:	00008067          	ret

00000000800048ec <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    800048ec:	ff010113          	addi	sp,sp,-16
    800048f0:	00113423          	sd	ra,8(sp)
    800048f4:	00813023          	sd	s0,0(sp)
    800048f8:	01010413          	addi	s0,sp,16
    800048fc:	00003797          	auipc	a5,0x3
    80004900:	c4c78793          	addi	a5,a5,-948 # 80007548 <_ZTV6Thread+0x10>
    80004904:	00f53023          	sd	a5,0(a0)
    80004908:	ffffd097          	auipc	ra,0xffffd
    8000490c:	774080e7          	jalr	1908(ra) # 8000207c <_Z11thread_exitv>
    80004910:	00813083          	ld	ra,8(sp)
    80004914:	00013403          	ld	s0,0(sp)
    80004918:	01010113          	addi	sp,sp,16
    8000491c:	00008067          	ret

0000000080004920 <_ZN7WorkerDD0Ev>:
    80004920:	fe010113          	addi	sp,sp,-32
    80004924:	00113c23          	sd	ra,24(sp)
    80004928:	00813823          	sd	s0,16(sp)
    8000492c:	00913423          	sd	s1,8(sp)
    80004930:	02010413          	addi	s0,sp,32
    80004934:	00050493          	mv	s1,a0
    80004938:	00003797          	auipc	a5,0x3
    8000493c:	c1078793          	addi	a5,a5,-1008 # 80007548 <_ZTV6Thread+0x10>
    80004940:	00f53023          	sd	a5,0(a0)
    80004944:	ffffd097          	auipc	ra,0xffffd
    80004948:	738080e7          	jalr	1848(ra) # 8000207c <_Z11thread_exitv>
    8000494c:	00048513          	mv	a0,s1
    80004950:	ffffd097          	auipc	ra,0xffffd
    80004954:	940080e7          	jalr	-1728(ra) # 80001290 <_ZdlPv>
    80004958:	01813083          	ld	ra,24(sp)
    8000495c:	01013403          	ld	s0,16(sp)
    80004960:	00813483          	ld	s1,8(sp)
    80004964:	02010113          	addi	sp,sp,32
    80004968:	00008067          	ret

000000008000496c <_ZN7WorkerA3runEv>:
    void run() override {
    8000496c:	ff010113          	addi	sp,sp,-16
    80004970:	00113423          	sd	ra,8(sp)
    80004974:	00813023          	sd	s0,0(sp)
    80004978:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    8000497c:	00000593          	li	a1,0
    80004980:	fffff097          	auipc	ra,0xfffff
    80004984:	7c4080e7          	jalr	1988(ra) # 80004144 <_ZN7WorkerA11workerBodyAEPv>
    }
    80004988:	00813083          	ld	ra,8(sp)
    8000498c:	00013403          	ld	s0,0(sp)
    80004990:	01010113          	addi	sp,sp,16
    80004994:	00008067          	ret

0000000080004998 <_ZN7WorkerB3runEv>:
    void run() override {
    80004998:	ff010113          	addi	sp,sp,-16
    8000499c:	00113423          	sd	ra,8(sp)
    800049a0:	00813023          	sd	s0,0(sp)
    800049a4:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    800049a8:	00000593          	li	a1,0
    800049ac:	00000097          	auipc	ra,0x0
    800049b0:	864080e7          	jalr	-1948(ra) # 80004210 <_ZN7WorkerB11workerBodyBEPv>
    }
    800049b4:	00813083          	ld	ra,8(sp)
    800049b8:	00013403          	ld	s0,0(sp)
    800049bc:	01010113          	addi	sp,sp,16
    800049c0:	00008067          	ret

00000000800049c4 <_ZN7WorkerC3runEv>:
    void run() override {
    800049c4:	ff010113          	addi	sp,sp,-16
    800049c8:	00113423          	sd	ra,8(sp)
    800049cc:	00813023          	sd	s0,0(sp)
    800049d0:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    800049d4:	00000593          	li	a1,0
    800049d8:	00000097          	auipc	ra,0x0
    800049dc:	90c080e7          	jalr	-1780(ra) # 800042e4 <_ZN7WorkerC11workerBodyCEPv>
    }
    800049e0:	00813083          	ld	ra,8(sp)
    800049e4:	00013403          	ld	s0,0(sp)
    800049e8:	01010113          	addi	sp,sp,16
    800049ec:	00008067          	ret

00000000800049f0 <_ZN7WorkerD3runEv>:
    void run() override {
    800049f0:	ff010113          	addi	sp,sp,-16
    800049f4:	00113423          	sd	ra,8(sp)
    800049f8:	00813023          	sd	s0,0(sp)
    800049fc:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80004a00:	00000593          	li	a1,0
    80004a04:	00000097          	auipc	ra,0x0
    80004a08:	a60080e7          	jalr	-1440(ra) # 80004464 <_ZN7WorkerD11workerBodyDEPv>
    }
    80004a0c:	00813083          	ld	ra,8(sp)
    80004a10:	00013403          	ld	s0,0(sp)
    80004a14:	01010113          	addi	sp,sp,16
    80004a18:	00008067          	ret

0000000080004a1c <start>:
    80004a1c:	ff010113          	addi	sp,sp,-16
    80004a20:	00813423          	sd	s0,8(sp)
    80004a24:	01010413          	addi	s0,sp,16
    80004a28:	300027f3          	csrr	a5,mstatus
    80004a2c:	ffffe737          	lui	a4,0xffffe
    80004a30:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff47cf>
    80004a34:	00e7f7b3          	and	a5,a5,a4
    80004a38:	00001737          	lui	a4,0x1
    80004a3c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004a40:	00e7e7b3          	or	a5,a5,a4
    80004a44:	30079073          	csrw	mstatus,a5
    80004a48:	00000797          	auipc	a5,0x0
    80004a4c:	16078793          	addi	a5,a5,352 # 80004ba8 <system_main>
    80004a50:	34179073          	csrw	mepc,a5
    80004a54:	00000793          	li	a5,0
    80004a58:	18079073          	csrw	satp,a5
    80004a5c:	000107b7          	lui	a5,0x10
    80004a60:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004a64:	30279073          	csrw	medeleg,a5
    80004a68:	30379073          	csrw	mideleg,a5
    80004a6c:	104027f3          	csrr	a5,sie
    80004a70:	2227e793          	ori	a5,a5,546
    80004a74:	10479073          	csrw	sie,a5
    80004a78:	fff00793          	li	a5,-1
    80004a7c:	00a7d793          	srli	a5,a5,0xa
    80004a80:	3b079073          	csrw	pmpaddr0,a5
    80004a84:	00f00793          	li	a5,15
    80004a88:	3a079073          	csrw	pmpcfg0,a5
    80004a8c:	f14027f3          	csrr	a5,mhartid
    80004a90:	0200c737          	lui	a4,0x200c
    80004a94:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004a98:	0007869b          	sext.w	a3,a5
    80004a9c:	00269713          	slli	a4,a3,0x2
    80004aa0:	000f4637          	lui	a2,0xf4
    80004aa4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004aa8:	00d70733          	add	a4,a4,a3
    80004aac:	0037979b          	slliw	a5,a5,0x3
    80004ab0:	020046b7          	lui	a3,0x2004
    80004ab4:	00d787b3          	add	a5,a5,a3
    80004ab8:	00c585b3          	add	a1,a1,a2
    80004abc:	00371693          	slli	a3,a4,0x3
    80004ac0:	00004717          	auipc	a4,0x4
    80004ac4:	31070713          	addi	a4,a4,784 # 80008dd0 <timer_scratch>
    80004ac8:	00b7b023          	sd	a1,0(a5)
    80004acc:	00d70733          	add	a4,a4,a3
    80004ad0:	00f73c23          	sd	a5,24(a4)
    80004ad4:	02c73023          	sd	a2,32(a4)
    80004ad8:	34071073          	csrw	mscratch,a4
    80004adc:	00000797          	auipc	a5,0x0
    80004ae0:	6e478793          	addi	a5,a5,1764 # 800051c0 <timervec>
    80004ae4:	30579073          	csrw	mtvec,a5
    80004ae8:	300027f3          	csrr	a5,mstatus
    80004aec:	0087e793          	ori	a5,a5,8
    80004af0:	30079073          	csrw	mstatus,a5
    80004af4:	304027f3          	csrr	a5,mie
    80004af8:	0807e793          	ori	a5,a5,128
    80004afc:	30479073          	csrw	mie,a5
    80004b00:	f14027f3          	csrr	a5,mhartid
    80004b04:	0007879b          	sext.w	a5,a5
    80004b08:	00078213          	mv	tp,a5
    80004b0c:	30200073          	mret
    80004b10:	00813403          	ld	s0,8(sp)
    80004b14:	01010113          	addi	sp,sp,16
    80004b18:	00008067          	ret

0000000080004b1c <timerinit>:
    80004b1c:	ff010113          	addi	sp,sp,-16
    80004b20:	00813423          	sd	s0,8(sp)
    80004b24:	01010413          	addi	s0,sp,16
    80004b28:	f14027f3          	csrr	a5,mhartid
    80004b2c:	0200c737          	lui	a4,0x200c
    80004b30:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80004b34:	0007869b          	sext.w	a3,a5
    80004b38:	00269713          	slli	a4,a3,0x2
    80004b3c:	000f4637          	lui	a2,0xf4
    80004b40:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80004b44:	00d70733          	add	a4,a4,a3
    80004b48:	0037979b          	slliw	a5,a5,0x3
    80004b4c:	020046b7          	lui	a3,0x2004
    80004b50:	00d787b3          	add	a5,a5,a3
    80004b54:	00c585b3          	add	a1,a1,a2
    80004b58:	00371693          	slli	a3,a4,0x3
    80004b5c:	00004717          	auipc	a4,0x4
    80004b60:	27470713          	addi	a4,a4,628 # 80008dd0 <timer_scratch>
    80004b64:	00b7b023          	sd	a1,0(a5)
    80004b68:	00d70733          	add	a4,a4,a3
    80004b6c:	00f73c23          	sd	a5,24(a4)
    80004b70:	02c73023          	sd	a2,32(a4)
    80004b74:	34071073          	csrw	mscratch,a4
    80004b78:	00000797          	auipc	a5,0x0
    80004b7c:	64878793          	addi	a5,a5,1608 # 800051c0 <timervec>
    80004b80:	30579073          	csrw	mtvec,a5
    80004b84:	300027f3          	csrr	a5,mstatus
    80004b88:	0087e793          	ori	a5,a5,8
    80004b8c:	30079073          	csrw	mstatus,a5
    80004b90:	304027f3          	csrr	a5,mie
    80004b94:	0807e793          	ori	a5,a5,128
    80004b98:	30479073          	csrw	mie,a5
    80004b9c:	00813403          	ld	s0,8(sp)
    80004ba0:	01010113          	addi	sp,sp,16
    80004ba4:	00008067          	ret

0000000080004ba8 <system_main>:
    80004ba8:	fe010113          	addi	sp,sp,-32
    80004bac:	00813823          	sd	s0,16(sp)
    80004bb0:	00913423          	sd	s1,8(sp)
    80004bb4:	00113c23          	sd	ra,24(sp)
    80004bb8:	02010413          	addi	s0,sp,32
    80004bbc:	00000097          	auipc	ra,0x0
    80004bc0:	0c4080e7          	jalr	196(ra) # 80004c80 <cpuid>
    80004bc4:	00004497          	auipc	s1,0x4
    80004bc8:	1d448493          	addi	s1,s1,468 # 80008d98 <started>
    80004bcc:	02050263          	beqz	a0,80004bf0 <system_main+0x48>
    80004bd0:	0004a783          	lw	a5,0(s1)
    80004bd4:	0007879b          	sext.w	a5,a5
    80004bd8:	fe078ce3          	beqz	a5,80004bd0 <system_main+0x28>
    80004bdc:	0ff0000f          	fence
    80004be0:	00003517          	auipc	a0,0x3
    80004be4:	bd050513          	addi	a0,a0,-1072 # 800077b0 <_ZTV7WorkerD+0x58>
    80004be8:	00001097          	auipc	ra,0x1
    80004bec:	a74080e7          	jalr	-1420(ra) # 8000565c <panic>
    80004bf0:	00001097          	auipc	ra,0x1
    80004bf4:	9c8080e7          	jalr	-1592(ra) # 800055b8 <consoleinit>
    80004bf8:	00001097          	auipc	ra,0x1
    80004bfc:	154080e7          	jalr	340(ra) # 80005d4c <printfinit>
    80004c00:	00002517          	auipc	a0,0x2
    80004c04:	73050513          	addi	a0,a0,1840 # 80007330 <CONSOLE_STATUS+0x320>
    80004c08:	00001097          	auipc	ra,0x1
    80004c0c:	ab0080e7          	jalr	-1360(ra) # 800056b8 <__printf>
    80004c10:	00003517          	auipc	a0,0x3
    80004c14:	b7050513          	addi	a0,a0,-1168 # 80007780 <_ZTV7WorkerD+0x28>
    80004c18:	00001097          	auipc	ra,0x1
    80004c1c:	aa0080e7          	jalr	-1376(ra) # 800056b8 <__printf>
    80004c20:	00002517          	auipc	a0,0x2
    80004c24:	71050513          	addi	a0,a0,1808 # 80007330 <CONSOLE_STATUS+0x320>
    80004c28:	00001097          	auipc	ra,0x1
    80004c2c:	a90080e7          	jalr	-1392(ra) # 800056b8 <__printf>
    80004c30:	00001097          	auipc	ra,0x1
    80004c34:	4a8080e7          	jalr	1192(ra) # 800060d8 <kinit>
    80004c38:	00000097          	auipc	ra,0x0
    80004c3c:	148080e7          	jalr	328(ra) # 80004d80 <trapinit>
    80004c40:	00000097          	auipc	ra,0x0
    80004c44:	16c080e7          	jalr	364(ra) # 80004dac <trapinithart>
    80004c48:	00000097          	auipc	ra,0x0
    80004c4c:	5b8080e7          	jalr	1464(ra) # 80005200 <plicinit>
    80004c50:	00000097          	auipc	ra,0x0
    80004c54:	5d8080e7          	jalr	1496(ra) # 80005228 <plicinithart>
    80004c58:	00000097          	auipc	ra,0x0
    80004c5c:	078080e7          	jalr	120(ra) # 80004cd0 <userinit>
    80004c60:	0ff0000f          	fence
    80004c64:	00100793          	li	a5,1
    80004c68:	00003517          	auipc	a0,0x3
    80004c6c:	b3050513          	addi	a0,a0,-1232 # 80007798 <_ZTV7WorkerD+0x40>
    80004c70:	00f4a023          	sw	a5,0(s1)
    80004c74:	00001097          	auipc	ra,0x1
    80004c78:	a44080e7          	jalr	-1468(ra) # 800056b8 <__printf>
    80004c7c:	0000006f          	j	80004c7c <system_main+0xd4>

0000000080004c80 <cpuid>:
    80004c80:	ff010113          	addi	sp,sp,-16
    80004c84:	00813423          	sd	s0,8(sp)
    80004c88:	01010413          	addi	s0,sp,16
    80004c8c:	00020513          	mv	a0,tp
    80004c90:	00813403          	ld	s0,8(sp)
    80004c94:	0005051b          	sext.w	a0,a0
    80004c98:	01010113          	addi	sp,sp,16
    80004c9c:	00008067          	ret

0000000080004ca0 <mycpu>:
    80004ca0:	ff010113          	addi	sp,sp,-16
    80004ca4:	00813423          	sd	s0,8(sp)
    80004ca8:	01010413          	addi	s0,sp,16
    80004cac:	00020793          	mv	a5,tp
    80004cb0:	00813403          	ld	s0,8(sp)
    80004cb4:	0007879b          	sext.w	a5,a5
    80004cb8:	00779793          	slli	a5,a5,0x7
    80004cbc:	00005517          	auipc	a0,0x5
    80004cc0:	14450513          	addi	a0,a0,324 # 80009e00 <cpus>
    80004cc4:	00f50533          	add	a0,a0,a5
    80004cc8:	01010113          	addi	sp,sp,16
    80004ccc:	00008067          	ret

0000000080004cd0 <userinit>:
    80004cd0:	ff010113          	addi	sp,sp,-16
    80004cd4:	00813423          	sd	s0,8(sp)
    80004cd8:	01010413          	addi	s0,sp,16
    80004cdc:	00813403          	ld	s0,8(sp)
    80004ce0:	01010113          	addi	sp,sp,16
    80004ce4:	ffffd317          	auipc	t1,0xffffd
    80004ce8:	23030067          	jr	560(t1) # 80001f14 <main>

0000000080004cec <either_copyout>:
    80004cec:	ff010113          	addi	sp,sp,-16
    80004cf0:	00813023          	sd	s0,0(sp)
    80004cf4:	00113423          	sd	ra,8(sp)
    80004cf8:	01010413          	addi	s0,sp,16
    80004cfc:	02051663          	bnez	a0,80004d28 <either_copyout+0x3c>
    80004d00:	00058513          	mv	a0,a1
    80004d04:	00060593          	mv	a1,a2
    80004d08:	0006861b          	sext.w	a2,a3
    80004d0c:	00002097          	auipc	ra,0x2
    80004d10:	c58080e7          	jalr	-936(ra) # 80006964 <__memmove>
    80004d14:	00813083          	ld	ra,8(sp)
    80004d18:	00013403          	ld	s0,0(sp)
    80004d1c:	00000513          	li	a0,0
    80004d20:	01010113          	addi	sp,sp,16
    80004d24:	00008067          	ret
    80004d28:	00003517          	auipc	a0,0x3
    80004d2c:	ab050513          	addi	a0,a0,-1360 # 800077d8 <_ZTV7WorkerD+0x80>
    80004d30:	00001097          	auipc	ra,0x1
    80004d34:	92c080e7          	jalr	-1748(ra) # 8000565c <panic>

0000000080004d38 <either_copyin>:
    80004d38:	ff010113          	addi	sp,sp,-16
    80004d3c:	00813023          	sd	s0,0(sp)
    80004d40:	00113423          	sd	ra,8(sp)
    80004d44:	01010413          	addi	s0,sp,16
    80004d48:	02059463          	bnez	a1,80004d70 <either_copyin+0x38>
    80004d4c:	00060593          	mv	a1,a2
    80004d50:	0006861b          	sext.w	a2,a3
    80004d54:	00002097          	auipc	ra,0x2
    80004d58:	c10080e7          	jalr	-1008(ra) # 80006964 <__memmove>
    80004d5c:	00813083          	ld	ra,8(sp)
    80004d60:	00013403          	ld	s0,0(sp)
    80004d64:	00000513          	li	a0,0
    80004d68:	01010113          	addi	sp,sp,16
    80004d6c:	00008067          	ret
    80004d70:	00003517          	auipc	a0,0x3
    80004d74:	a9050513          	addi	a0,a0,-1392 # 80007800 <_ZTV7WorkerD+0xa8>
    80004d78:	00001097          	auipc	ra,0x1
    80004d7c:	8e4080e7          	jalr	-1820(ra) # 8000565c <panic>

0000000080004d80 <trapinit>:
    80004d80:	ff010113          	addi	sp,sp,-16
    80004d84:	00813423          	sd	s0,8(sp)
    80004d88:	01010413          	addi	s0,sp,16
    80004d8c:	00813403          	ld	s0,8(sp)
    80004d90:	00003597          	auipc	a1,0x3
    80004d94:	a9858593          	addi	a1,a1,-1384 # 80007828 <_ZTV7WorkerD+0xd0>
    80004d98:	00005517          	auipc	a0,0x5
    80004d9c:	0e850513          	addi	a0,a0,232 # 80009e80 <tickslock>
    80004da0:	01010113          	addi	sp,sp,16
    80004da4:	00001317          	auipc	t1,0x1
    80004da8:	5c430067          	jr	1476(t1) # 80006368 <initlock>

0000000080004dac <trapinithart>:
    80004dac:	ff010113          	addi	sp,sp,-16
    80004db0:	00813423          	sd	s0,8(sp)
    80004db4:	01010413          	addi	s0,sp,16
    80004db8:	00000797          	auipc	a5,0x0
    80004dbc:	2f878793          	addi	a5,a5,760 # 800050b0 <kernelvec>
    80004dc0:	10579073          	csrw	stvec,a5
    80004dc4:	00813403          	ld	s0,8(sp)
    80004dc8:	01010113          	addi	sp,sp,16
    80004dcc:	00008067          	ret

0000000080004dd0 <usertrap>:
    80004dd0:	ff010113          	addi	sp,sp,-16
    80004dd4:	00813423          	sd	s0,8(sp)
    80004dd8:	01010413          	addi	s0,sp,16
    80004ddc:	00813403          	ld	s0,8(sp)
    80004de0:	01010113          	addi	sp,sp,16
    80004de4:	00008067          	ret

0000000080004de8 <usertrapret>:
    80004de8:	ff010113          	addi	sp,sp,-16
    80004dec:	00813423          	sd	s0,8(sp)
    80004df0:	01010413          	addi	s0,sp,16
    80004df4:	00813403          	ld	s0,8(sp)
    80004df8:	01010113          	addi	sp,sp,16
    80004dfc:	00008067          	ret

0000000080004e00 <kerneltrap>:
    80004e00:	fe010113          	addi	sp,sp,-32
    80004e04:	00813823          	sd	s0,16(sp)
    80004e08:	00113c23          	sd	ra,24(sp)
    80004e0c:	00913423          	sd	s1,8(sp)
    80004e10:	02010413          	addi	s0,sp,32
    80004e14:	142025f3          	csrr	a1,scause
    80004e18:	100027f3          	csrr	a5,sstatus
    80004e1c:	0027f793          	andi	a5,a5,2
    80004e20:	10079c63          	bnez	a5,80004f38 <kerneltrap+0x138>
    80004e24:	142027f3          	csrr	a5,scause
    80004e28:	0207ce63          	bltz	a5,80004e64 <kerneltrap+0x64>
    80004e2c:	00003517          	auipc	a0,0x3
    80004e30:	a4450513          	addi	a0,a0,-1468 # 80007870 <_ZTV7WorkerD+0x118>
    80004e34:	00001097          	auipc	ra,0x1
    80004e38:	884080e7          	jalr	-1916(ra) # 800056b8 <__printf>
    80004e3c:	141025f3          	csrr	a1,sepc
    80004e40:	14302673          	csrr	a2,stval
    80004e44:	00003517          	auipc	a0,0x3
    80004e48:	a3c50513          	addi	a0,a0,-1476 # 80007880 <_ZTV7WorkerD+0x128>
    80004e4c:	00001097          	auipc	ra,0x1
    80004e50:	86c080e7          	jalr	-1940(ra) # 800056b8 <__printf>
    80004e54:	00003517          	auipc	a0,0x3
    80004e58:	a4450513          	addi	a0,a0,-1468 # 80007898 <_ZTV7WorkerD+0x140>
    80004e5c:	00001097          	auipc	ra,0x1
    80004e60:	800080e7          	jalr	-2048(ra) # 8000565c <panic>
    80004e64:	0ff7f713          	andi	a4,a5,255
    80004e68:	00900693          	li	a3,9
    80004e6c:	04d70063          	beq	a4,a3,80004eac <kerneltrap+0xac>
    80004e70:	fff00713          	li	a4,-1
    80004e74:	03f71713          	slli	a4,a4,0x3f
    80004e78:	00170713          	addi	a4,a4,1
    80004e7c:	fae798e3          	bne	a5,a4,80004e2c <kerneltrap+0x2c>
    80004e80:	00000097          	auipc	ra,0x0
    80004e84:	e00080e7          	jalr	-512(ra) # 80004c80 <cpuid>
    80004e88:	06050663          	beqz	a0,80004ef4 <kerneltrap+0xf4>
    80004e8c:	144027f3          	csrr	a5,sip
    80004e90:	ffd7f793          	andi	a5,a5,-3
    80004e94:	14479073          	csrw	sip,a5
    80004e98:	01813083          	ld	ra,24(sp)
    80004e9c:	01013403          	ld	s0,16(sp)
    80004ea0:	00813483          	ld	s1,8(sp)
    80004ea4:	02010113          	addi	sp,sp,32
    80004ea8:	00008067          	ret
    80004eac:	00000097          	auipc	ra,0x0
    80004eb0:	3c8080e7          	jalr	968(ra) # 80005274 <plic_claim>
    80004eb4:	00a00793          	li	a5,10
    80004eb8:	00050493          	mv	s1,a0
    80004ebc:	06f50863          	beq	a0,a5,80004f2c <kerneltrap+0x12c>
    80004ec0:	fc050ce3          	beqz	a0,80004e98 <kerneltrap+0x98>
    80004ec4:	00050593          	mv	a1,a0
    80004ec8:	00003517          	auipc	a0,0x3
    80004ecc:	98850513          	addi	a0,a0,-1656 # 80007850 <_ZTV7WorkerD+0xf8>
    80004ed0:	00000097          	auipc	ra,0x0
    80004ed4:	7e8080e7          	jalr	2024(ra) # 800056b8 <__printf>
    80004ed8:	01013403          	ld	s0,16(sp)
    80004edc:	01813083          	ld	ra,24(sp)
    80004ee0:	00048513          	mv	a0,s1
    80004ee4:	00813483          	ld	s1,8(sp)
    80004ee8:	02010113          	addi	sp,sp,32
    80004eec:	00000317          	auipc	t1,0x0
    80004ef0:	3c030067          	jr	960(t1) # 800052ac <plic_complete>
    80004ef4:	00005517          	auipc	a0,0x5
    80004ef8:	f8c50513          	addi	a0,a0,-116 # 80009e80 <tickslock>
    80004efc:	00001097          	auipc	ra,0x1
    80004f00:	490080e7          	jalr	1168(ra) # 8000638c <acquire>
    80004f04:	00004717          	auipc	a4,0x4
    80004f08:	e9870713          	addi	a4,a4,-360 # 80008d9c <ticks>
    80004f0c:	00072783          	lw	a5,0(a4)
    80004f10:	00005517          	auipc	a0,0x5
    80004f14:	f7050513          	addi	a0,a0,-144 # 80009e80 <tickslock>
    80004f18:	0017879b          	addiw	a5,a5,1
    80004f1c:	00f72023          	sw	a5,0(a4)
    80004f20:	00001097          	auipc	ra,0x1
    80004f24:	538080e7          	jalr	1336(ra) # 80006458 <release>
    80004f28:	f65ff06f          	j	80004e8c <kerneltrap+0x8c>
    80004f2c:	00001097          	auipc	ra,0x1
    80004f30:	094080e7          	jalr	148(ra) # 80005fc0 <uartintr>
    80004f34:	fa5ff06f          	j	80004ed8 <kerneltrap+0xd8>
    80004f38:	00003517          	auipc	a0,0x3
    80004f3c:	8f850513          	addi	a0,a0,-1800 # 80007830 <_ZTV7WorkerD+0xd8>
    80004f40:	00000097          	auipc	ra,0x0
    80004f44:	71c080e7          	jalr	1820(ra) # 8000565c <panic>

0000000080004f48 <clockintr>:
    80004f48:	fe010113          	addi	sp,sp,-32
    80004f4c:	00813823          	sd	s0,16(sp)
    80004f50:	00913423          	sd	s1,8(sp)
    80004f54:	00113c23          	sd	ra,24(sp)
    80004f58:	02010413          	addi	s0,sp,32
    80004f5c:	00005497          	auipc	s1,0x5
    80004f60:	f2448493          	addi	s1,s1,-220 # 80009e80 <tickslock>
    80004f64:	00048513          	mv	a0,s1
    80004f68:	00001097          	auipc	ra,0x1
    80004f6c:	424080e7          	jalr	1060(ra) # 8000638c <acquire>
    80004f70:	00004717          	auipc	a4,0x4
    80004f74:	e2c70713          	addi	a4,a4,-468 # 80008d9c <ticks>
    80004f78:	00072783          	lw	a5,0(a4)
    80004f7c:	01013403          	ld	s0,16(sp)
    80004f80:	01813083          	ld	ra,24(sp)
    80004f84:	00048513          	mv	a0,s1
    80004f88:	0017879b          	addiw	a5,a5,1
    80004f8c:	00813483          	ld	s1,8(sp)
    80004f90:	00f72023          	sw	a5,0(a4)
    80004f94:	02010113          	addi	sp,sp,32
    80004f98:	00001317          	auipc	t1,0x1
    80004f9c:	4c030067          	jr	1216(t1) # 80006458 <release>

0000000080004fa0 <devintr>:
    80004fa0:	142027f3          	csrr	a5,scause
    80004fa4:	00000513          	li	a0,0
    80004fa8:	0007c463          	bltz	a5,80004fb0 <devintr+0x10>
    80004fac:	00008067          	ret
    80004fb0:	fe010113          	addi	sp,sp,-32
    80004fb4:	00813823          	sd	s0,16(sp)
    80004fb8:	00113c23          	sd	ra,24(sp)
    80004fbc:	00913423          	sd	s1,8(sp)
    80004fc0:	02010413          	addi	s0,sp,32
    80004fc4:	0ff7f713          	andi	a4,a5,255
    80004fc8:	00900693          	li	a3,9
    80004fcc:	04d70c63          	beq	a4,a3,80005024 <devintr+0x84>
    80004fd0:	fff00713          	li	a4,-1
    80004fd4:	03f71713          	slli	a4,a4,0x3f
    80004fd8:	00170713          	addi	a4,a4,1
    80004fdc:	00e78c63          	beq	a5,a4,80004ff4 <devintr+0x54>
    80004fe0:	01813083          	ld	ra,24(sp)
    80004fe4:	01013403          	ld	s0,16(sp)
    80004fe8:	00813483          	ld	s1,8(sp)
    80004fec:	02010113          	addi	sp,sp,32
    80004ff0:	00008067          	ret
    80004ff4:	00000097          	auipc	ra,0x0
    80004ff8:	c8c080e7          	jalr	-884(ra) # 80004c80 <cpuid>
    80004ffc:	06050663          	beqz	a0,80005068 <devintr+0xc8>
    80005000:	144027f3          	csrr	a5,sip
    80005004:	ffd7f793          	andi	a5,a5,-3
    80005008:	14479073          	csrw	sip,a5
    8000500c:	01813083          	ld	ra,24(sp)
    80005010:	01013403          	ld	s0,16(sp)
    80005014:	00813483          	ld	s1,8(sp)
    80005018:	00200513          	li	a0,2
    8000501c:	02010113          	addi	sp,sp,32
    80005020:	00008067          	ret
    80005024:	00000097          	auipc	ra,0x0
    80005028:	250080e7          	jalr	592(ra) # 80005274 <plic_claim>
    8000502c:	00a00793          	li	a5,10
    80005030:	00050493          	mv	s1,a0
    80005034:	06f50663          	beq	a0,a5,800050a0 <devintr+0x100>
    80005038:	00100513          	li	a0,1
    8000503c:	fa0482e3          	beqz	s1,80004fe0 <devintr+0x40>
    80005040:	00048593          	mv	a1,s1
    80005044:	00003517          	auipc	a0,0x3
    80005048:	80c50513          	addi	a0,a0,-2036 # 80007850 <_ZTV7WorkerD+0xf8>
    8000504c:	00000097          	auipc	ra,0x0
    80005050:	66c080e7          	jalr	1644(ra) # 800056b8 <__printf>
    80005054:	00048513          	mv	a0,s1
    80005058:	00000097          	auipc	ra,0x0
    8000505c:	254080e7          	jalr	596(ra) # 800052ac <plic_complete>
    80005060:	00100513          	li	a0,1
    80005064:	f7dff06f          	j	80004fe0 <devintr+0x40>
    80005068:	00005517          	auipc	a0,0x5
    8000506c:	e1850513          	addi	a0,a0,-488 # 80009e80 <tickslock>
    80005070:	00001097          	auipc	ra,0x1
    80005074:	31c080e7          	jalr	796(ra) # 8000638c <acquire>
    80005078:	00004717          	auipc	a4,0x4
    8000507c:	d2470713          	addi	a4,a4,-732 # 80008d9c <ticks>
    80005080:	00072783          	lw	a5,0(a4)
    80005084:	00005517          	auipc	a0,0x5
    80005088:	dfc50513          	addi	a0,a0,-516 # 80009e80 <tickslock>
    8000508c:	0017879b          	addiw	a5,a5,1
    80005090:	00f72023          	sw	a5,0(a4)
    80005094:	00001097          	auipc	ra,0x1
    80005098:	3c4080e7          	jalr	964(ra) # 80006458 <release>
    8000509c:	f65ff06f          	j	80005000 <devintr+0x60>
    800050a0:	00001097          	auipc	ra,0x1
    800050a4:	f20080e7          	jalr	-224(ra) # 80005fc0 <uartintr>
    800050a8:	fadff06f          	j	80005054 <devintr+0xb4>
    800050ac:	0000                	unimp
	...

00000000800050b0 <kernelvec>:
    800050b0:	f0010113          	addi	sp,sp,-256
    800050b4:	00113023          	sd	ra,0(sp)
    800050b8:	00213423          	sd	sp,8(sp)
    800050bc:	00313823          	sd	gp,16(sp)
    800050c0:	00413c23          	sd	tp,24(sp)
    800050c4:	02513023          	sd	t0,32(sp)
    800050c8:	02613423          	sd	t1,40(sp)
    800050cc:	02713823          	sd	t2,48(sp)
    800050d0:	02813c23          	sd	s0,56(sp)
    800050d4:	04913023          	sd	s1,64(sp)
    800050d8:	04a13423          	sd	a0,72(sp)
    800050dc:	04b13823          	sd	a1,80(sp)
    800050e0:	04c13c23          	sd	a2,88(sp)
    800050e4:	06d13023          	sd	a3,96(sp)
    800050e8:	06e13423          	sd	a4,104(sp)
    800050ec:	06f13823          	sd	a5,112(sp)
    800050f0:	07013c23          	sd	a6,120(sp)
    800050f4:	09113023          	sd	a7,128(sp)
    800050f8:	09213423          	sd	s2,136(sp)
    800050fc:	09313823          	sd	s3,144(sp)
    80005100:	09413c23          	sd	s4,152(sp)
    80005104:	0b513023          	sd	s5,160(sp)
    80005108:	0b613423          	sd	s6,168(sp)
    8000510c:	0b713823          	sd	s7,176(sp)
    80005110:	0b813c23          	sd	s8,184(sp)
    80005114:	0d913023          	sd	s9,192(sp)
    80005118:	0da13423          	sd	s10,200(sp)
    8000511c:	0db13823          	sd	s11,208(sp)
    80005120:	0dc13c23          	sd	t3,216(sp)
    80005124:	0fd13023          	sd	t4,224(sp)
    80005128:	0fe13423          	sd	t5,232(sp)
    8000512c:	0ff13823          	sd	t6,240(sp)
    80005130:	cd1ff0ef          	jal	ra,80004e00 <kerneltrap>
    80005134:	00013083          	ld	ra,0(sp)
    80005138:	00813103          	ld	sp,8(sp)
    8000513c:	01013183          	ld	gp,16(sp)
    80005140:	02013283          	ld	t0,32(sp)
    80005144:	02813303          	ld	t1,40(sp)
    80005148:	03013383          	ld	t2,48(sp)
    8000514c:	03813403          	ld	s0,56(sp)
    80005150:	04013483          	ld	s1,64(sp)
    80005154:	04813503          	ld	a0,72(sp)
    80005158:	05013583          	ld	a1,80(sp)
    8000515c:	05813603          	ld	a2,88(sp)
    80005160:	06013683          	ld	a3,96(sp)
    80005164:	06813703          	ld	a4,104(sp)
    80005168:	07013783          	ld	a5,112(sp)
    8000516c:	07813803          	ld	a6,120(sp)
    80005170:	08013883          	ld	a7,128(sp)
    80005174:	08813903          	ld	s2,136(sp)
    80005178:	09013983          	ld	s3,144(sp)
    8000517c:	09813a03          	ld	s4,152(sp)
    80005180:	0a013a83          	ld	s5,160(sp)
    80005184:	0a813b03          	ld	s6,168(sp)
    80005188:	0b013b83          	ld	s7,176(sp)
    8000518c:	0b813c03          	ld	s8,184(sp)
    80005190:	0c013c83          	ld	s9,192(sp)
    80005194:	0c813d03          	ld	s10,200(sp)
    80005198:	0d013d83          	ld	s11,208(sp)
    8000519c:	0d813e03          	ld	t3,216(sp)
    800051a0:	0e013e83          	ld	t4,224(sp)
    800051a4:	0e813f03          	ld	t5,232(sp)
    800051a8:	0f013f83          	ld	t6,240(sp)
    800051ac:	10010113          	addi	sp,sp,256
    800051b0:	10200073          	sret
    800051b4:	00000013          	nop
    800051b8:	00000013          	nop
    800051bc:	00000013          	nop

00000000800051c0 <timervec>:
    800051c0:	34051573          	csrrw	a0,mscratch,a0
    800051c4:	00b53023          	sd	a1,0(a0)
    800051c8:	00c53423          	sd	a2,8(a0)
    800051cc:	00d53823          	sd	a3,16(a0)
    800051d0:	01853583          	ld	a1,24(a0)
    800051d4:	02053603          	ld	a2,32(a0)
    800051d8:	0005b683          	ld	a3,0(a1)
    800051dc:	00c686b3          	add	a3,a3,a2
    800051e0:	00d5b023          	sd	a3,0(a1)
    800051e4:	00200593          	li	a1,2
    800051e8:	14459073          	csrw	sip,a1
    800051ec:	01053683          	ld	a3,16(a0)
    800051f0:	00853603          	ld	a2,8(a0)
    800051f4:	00053583          	ld	a1,0(a0)
    800051f8:	34051573          	csrrw	a0,mscratch,a0
    800051fc:	30200073          	mret

0000000080005200 <plicinit>:
    80005200:	ff010113          	addi	sp,sp,-16
    80005204:	00813423          	sd	s0,8(sp)
    80005208:	01010413          	addi	s0,sp,16
    8000520c:	00813403          	ld	s0,8(sp)
    80005210:	0c0007b7          	lui	a5,0xc000
    80005214:	00100713          	li	a4,1
    80005218:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000521c:	00e7a223          	sw	a4,4(a5)
    80005220:	01010113          	addi	sp,sp,16
    80005224:	00008067          	ret

0000000080005228 <plicinithart>:
    80005228:	ff010113          	addi	sp,sp,-16
    8000522c:	00813023          	sd	s0,0(sp)
    80005230:	00113423          	sd	ra,8(sp)
    80005234:	01010413          	addi	s0,sp,16
    80005238:	00000097          	auipc	ra,0x0
    8000523c:	a48080e7          	jalr	-1464(ra) # 80004c80 <cpuid>
    80005240:	0085171b          	slliw	a4,a0,0x8
    80005244:	0c0027b7          	lui	a5,0xc002
    80005248:	00e787b3          	add	a5,a5,a4
    8000524c:	40200713          	li	a4,1026
    80005250:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80005254:	00813083          	ld	ra,8(sp)
    80005258:	00013403          	ld	s0,0(sp)
    8000525c:	00d5151b          	slliw	a0,a0,0xd
    80005260:	0c2017b7          	lui	a5,0xc201
    80005264:	00a78533          	add	a0,a5,a0
    80005268:	00052023          	sw	zero,0(a0)
    8000526c:	01010113          	addi	sp,sp,16
    80005270:	00008067          	ret

0000000080005274 <plic_claim>:
    80005274:	ff010113          	addi	sp,sp,-16
    80005278:	00813023          	sd	s0,0(sp)
    8000527c:	00113423          	sd	ra,8(sp)
    80005280:	01010413          	addi	s0,sp,16
    80005284:	00000097          	auipc	ra,0x0
    80005288:	9fc080e7          	jalr	-1540(ra) # 80004c80 <cpuid>
    8000528c:	00813083          	ld	ra,8(sp)
    80005290:	00013403          	ld	s0,0(sp)
    80005294:	00d5151b          	slliw	a0,a0,0xd
    80005298:	0c2017b7          	lui	a5,0xc201
    8000529c:	00a78533          	add	a0,a5,a0
    800052a0:	00452503          	lw	a0,4(a0)
    800052a4:	01010113          	addi	sp,sp,16
    800052a8:	00008067          	ret

00000000800052ac <plic_complete>:
    800052ac:	fe010113          	addi	sp,sp,-32
    800052b0:	00813823          	sd	s0,16(sp)
    800052b4:	00913423          	sd	s1,8(sp)
    800052b8:	00113c23          	sd	ra,24(sp)
    800052bc:	02010413          	addi	s0,sp,32
    800052c0:	00050493          	mv	s1,a0
    800052c4:	00000097          	auipc	ra,0x0
    800052c8:	9bc080e7          	jalr	-1604(ra) # 80004c80 <cpuid>
    800052cc:	01813083          	ld	ra,24(sp)
    800052d0:	01013403          	ld	s0,16(sp)
    800052d4:	00d5179b          	slliw	a5,a0,0xd
    800052d8:	0c201737          	lui	a4,0xc201
    800052dc:	00f707b3          	add	a5,a4,a5
    800052e0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800052e4:	00813483          	ld	s1,8(sp)
    800052e8:	02010113          	addi	sp,sp,32
    800052ec:	00008067          	ret

00000000800052f0 <consolewrite>:
    800052f0:	fb010113          	addi	sp,sp,-80
    800052f4:	04813023          	sd	s0,64(sp)
    800052f8:	04113423          	sd	ra,72(sp)
    800052fc:	02913c23          	sd	s1,56(sp)
    80005300:	03213823          	sd	s2,48(sp)
    80005304:	03313423          	sd	s3,40(sp)
    80005308:	03413023          	sd	s4,32(sp)
    8000530c:	01513c23          	sd	s5,24(sp)
    80005310:	05010413          	addi	s0,sp,80
    80005314:	06c05c63          	blez	a2,8000538c <consolewrite+0x9c>
    80005318:	00060993          	mv	s3,a2
    8000531c:	00050a13          	mv	s4,a0
    80005320:	00058493          	mv	s1,a1
    80005324:	00000913          	li	s2,0
    80005328:	fff00a93          	li	s5,-1
    8000532c:	01c0006f          	j	80005348 <consolewrite+0x58>
    80005330:	fbf44503          	lbu	a0,-65(s0)
    80005334:	0019091b          	addiw	s2,s2,1
    80005338:	00148493          	addi	s1,s1,1
    8000533c:	00001097          	auipc	ra,0x1
    80005340:	a9c080e7          	jalr	-1380(ra) # 80005dd8 <uartputc>
    80005344:	03298063          	beq	s3,s2,80005364 <consolewrite+0x74>
    80005348:	00048613          	mv	a2,s1
    8000534c:	00100693          	li	a3,1
    80005350:	000a0593          	mv	a1,s4
    80005354:	fbf40513          	addi	a0,s0,-65
    80005358:	00000097          	auipc	ra,0x0
    8000535c:	9e0080e7          	jalr	-1568(ra) # 80004d38 <either_copyin>
    80005360:	fd5518e3          	bne	a0,s5,80005330 <consolewrite+0x40>
    80005364:	04813083          	ld	ra,72(sp)
    80005368:	04013403          	ld	s0,64(sp)
    8000536c:	03813483          	ld	s1,56(sp)
    80005370:	02813983          	ld	s3,40(sp)
    80005374:	02013a03          	ld	s4,32(sp)
    80005378:	01813a83          	ld	s5,24(sp)
    8000537c:	00090513          	mv	a0,s2
    80005380:	03013903          	ld	s2,48(sp)
    80005384:	05010113          	addi	sp,sp,80
    80005388:	00008067          	ret
    8000538c:	00000913          	li	s2,0
    80005390:	fd5ff06f          	j	80005364 <consolewrite+0x74>

0000000080005394 <consoleread>:
    80005394:	f9010113          	addi	sp,sp,-112
    80005398:	06813023          	sd	s0,96(sp)
    8000539c:	04913c23          	sd	s1,88(sp)
    800053a0:	05213823          	sd	s2,80(sp)
    800053a4:	05313423          	sd	s3,72(sp)
    800053a8:	05413023          	sd	s4,64(sp)
    800053ac:	03513c23          	sd	s5,56(sp)
    800053b0:	03613823          	sd	s6,48(sp)
    800053b4:	03713423          	sd	s7,40(sp)
    800053b8:	03813023          	sd	s8,32(sp)
    800053bc:	06113423          	sd	ra,104(sp)
    800053c0:	01913c23          	sd	s9,24(sp)
    800053c4:	07010413          	addi	s0,sp,112
    800053c8:	00060b93          	mv	s7,a2
    800053cc:	00050913          	mv	s2,a0
    800053d0:	00058c13          	mv	s8,a1
    800053d4:	00060b1b          	sext.w	s6,a2
    800053d8:	00005497          	auipc	s1,0x5
    800053dc:	ad048493          	addi	s1,s1,-1328 # 80009ea8 <cons>
    800053e0:	00400993          	li	s3,4
    800053e4:	fff00a13          	li	s4,-1
    800053e8:	00a00a93          	li	s5,10
    800053ec:	05705e63          	blez	s7,80005448 <consoleread+0xb4>
    800053f0:	09c4a703          	lw	a4,156(s1)
    800053f4:	0984a783          	lw	a5,152(s1)
    800053f8:	0007071b          	sext.w	a4,a4
    800053fc:	08e78463          	beq	a5,a4,80005484 <consoleread+0xf0>
    80005400:	07f7f713          	andi	a4,a5,127
    80005404:	00e48733          	add	a4,s1,a4
    80005408:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    8000540c:	0017869b          	addiw	a3,a5,1
    80005410:	08d4ac23          	sw	a3,152(s1)
    80005414:	00070c9b          	sext.w	s9,a4
    80005418:	0b370663          	beq	a4,s3,800054c4 <consoleread+0x130>
    8000541c:	00100693          	li	a3,1
    80005420:	f9f40613          	addi	a2,s0,-97
    80005424:	000c0593          	mv	a1,s8
    80005428:	00090513          	mv	a0,s2
    8000542c:	f8e40fa3          	sb	a4,-97(s0)
    80005430:	00000097          	auipc	ra,0x0
    80005434:	8bc080e7          	jalr	-1860(ra) # 80004cec <either_copyout>
    80005438:	01450863          	beq	a0,s4,80005448 <consoleread+0xb4>
    8000543c:	001c0c13          	addi	s8,s8,1
    80005440:	fffb8b9b          	addiw	s7,s7,-1
    80005444:	fb5c94e3          	bne	s9,s5,800053ec <consoleread+0x58>
    80005448:	000b851b          	sext.w	a0,s7
    8000544c:	06813083          	ld	ra,104(sp)
    80005450:	06013403          	ld	s0,96(sp)
    80005454:	05813483          	ld	s1,88(sp)
    80005458:	05013903          	ld	s2,80(sp)
    8000545c:	04813983          	ld	s3,72(sp)
    80005460:	04013a03          	ld	s4,64(sp)
    80005464:	03813a83          	ld	s5,56(sp)
    80005468:	02813b83          	ld	s7,40(sp)
    8000546c:	02013c03          	ld	s8,32(sp)
    80005470:	01813c83          	ld	s9,24(sp)
    80005474:	40ab053b          	subw	a0,s6,a0
    80005478:	03013b03          	ld	s6,48(sp)
    8000547c:	07010113          	addi	sp,sp,112
    80005480:	00008067          	ret
    80005484:	00001097          	auipc	ra,0x1
    80005488:	1d8080e7          	jalr	472(ra) # 8000665c <push_on>
    8000548c:	0984a703          	lw	a4,152(s1)
    80005490:	09c4a783          	lw	a5,156(s1)
    80005494:	0007879b          	sext.w	a5,a5
    80005498:	fef70ce3          	beq	a4,a5,80005490 <consoleread+0xfc>
    8000549c:	00001097          	auipc	ra,0x1
    800054a0:	234080e7          	jalr	564(ra) # 800066d0 <pop_on>
    800054a4:	0984a783          	lw	a5,152(s1)
    800054a8:	07f7f713          	andi	a4,a5,127
    800054ac:	00e48733          	add	a4,s1,a4
    800054b0:	01874703          	lbu	a4,24(a4)
    800054b4:	0017869b          	addiw	a3,a5,1
    800054b8:	08d4ac23          	sw	a3,152(s1)
    800054bc:	00070c9b          	sext.w	s9,a4
    800054c0:	f5371ee3          	bne	a4,s3,8000541c <consoleread+0x88>
    800054c4:	000b851b          	sext.w	a0,s7
    800054c8:	f96bf2e3          	bgeu	s7,s6,8000544c <consoleread+0xb8>
    800054cc:	08f4ac23          	sw	a5,152(s1)
    800054d0:	f7dff06f          	j	8000544c <consoleread+0xb8>

00000000800054d4 <consputc>:
    800054d4:	10000793          	li	a5,256
    800054d8:	00f50663          	beq	a0,a5,800054e4 <consputc+0x10>
    800054dc:	00001317          	auipc	t1,0x1
    800054e0:	9f430067          	jr	-1548(t1) # 80005ed0 <uartputc_sync>
    800054e4:	ff010113          	addi	sp,sp,-16
    800054e8:	00113423          	sd	ra,8(sp)
    800054ec:	00813023          	sd	s0,0(sp)
    800054f0:	01010413          	addi	s0,sp,16
    800054f4:	00800513          	li	a0,8
    800054f8:	00001097          	auipc	ra,0x1
    800054fc:	9d8080e7          	jalr	-1576(ra) # 80005ed0 <uartputc_sync>
    80005500:	02000513          	li	a0,32
    80005504:	00001097          	auipc	ra,0x1
    80005508:	9cc080e7          	jalr	-1588(ra) # 80005ed0 <uartputc_sync>
    8000550c:	00013403          	ld	s0,0(sp)
    80005510:	00813083          	ld	ra,8(sp)
    80005514:	00800513          	li	a0,8
    80005518:	01010113          	addi	sp,sp,16
    8000551c:	00001317          	auipc	t1,0x1
    80005520:	9b430067          	jr	-1612(t1) # 80005ed0 <uartputc_sync>

0000000080005524 <consoleintr>:
    80005524:	fe010113          	addi	sp,sp,-32
    80005528:	00813823          	sd	s0,16(sp)
    8000552c:	00913423          	sd	s1,8(sp)
    80005530:	01213023          	sd	s2,0(sp)
    80005534:	00113c23          	sd	ra,24(sp)
    80005538:	02010413          	addi	s0,sp,32
    8000553c:	00005917          	auipc	s2,0x5
    80005540:	96c90913          	addi	s2,s2,-1684 # 80009ea8 <cons>
    80005544:	00050493          	mv	s1,a0
    80005548:	00090513          	mv	a0,s2
    8000554c:	00001097          	auipc	ra,0x1
    80005550:	e40080e7          	jalr	-448(ra) # 8000638c <acquire>
    80005554:	02048c63          	beqz	s1,8000558c <consoleintr+0x68>
    80005558:	0a092783          	lw	a5,160(s2)
    8000555c:	09892703          	lw	a4,152(s2)
    80005560:	07f00693          	li	a3,127
    80005564:	40e7873b          	subw	a4,a5,a4
    80005568:	02e6e263          	bltu	a3,a4,8000558c <consoleintr+0x68>
    8000556c:	00d00713          	li	a4,13
    80005570:	04e48063          	beq	s1,a4,800055b0 <consoleintr+0x8c>
    80005574:	07f7f713          	andi	a4,a5,127
    80005578:	00e90733          	add	a4,s2,a4
    8000557c:	0017879b          	addiw	a5,a5,1
    80005580:	0af92023          	sw	a5,160(s2)
    80005584:	00970c23          	sb	s1,24(a4)
    80005588:	08f92e23          	sw	a5,156(s2)
    8000558c:	01013403          	ld	s0,16(sp)
    80005590:	01813083          	ld	ra,24(sp)
    80005594:	00813483          	ld	s1,8(sp)
    80005598:	00013903          	ld	s2,0(sp)
    8000559c:	00005517          	auipc	a0,0x5
    800055a0:	90c50513          	addi	a0,a0,-1780 # 80009ea8 <cons>
    800055a4:	02010113          	addi	sp,sp,32
    800055a8:	00001317          	auipc	t1,0x1
    800055ac:	eb030067          	jr	-336(t1) # 80006458 <release>
    800055b0:	00a00493          	li	s1,10
    800055b4:	fc1ff06f          	j	80005574 <consoleintr+0x50>

00000000800055b8 <consoleinit>:
    800055b8:	fe010113          	addi	sp,sp,-32
    800055bc:	00113c23          	sd	ra,24(sp)
    800055c0:	00813823          	sd	s0,16(sp)
    800055c4:	00913423          	sd	s1,8(sp)
    800055c8:	02010413          	addi	s0,sp,32
    800055cc:	00005497          	auipc	s1,0x5
    800055d0:	8dc48493          	addi	s1,s1,-1828 # 80009ea8 <cons>
    800055d4:	00048513          	mv	a0,s1
    800055d8:	00002597          	auipc	a1,0x2
    800055dc:	2d058593          	addi	a1,a1,720 # 800078a8 <_ZTV7WorkerD+0x150>
    800055e0:	00001097          	auipc	ra,0x1
    800055e4:	d88080e7          	jalr	-632(ra) # 80006368 <initlock>
    800055e8:	00000097          	auipc	ra,0x0
    800055ec:	7ac080e7          	jalr	1964(ra) # 80005d94 <uartinit>
    800055f0:	01813083          	ld	ra,24(sp)
    800055f4:	01013403          	ld	s0,16(sp)
    800055f8:	00000797          	auipc	a5,0x0
    800055fc:	d9c78793          	addi	a5,a5,-612 # 80005394 <consoleread>
    80005600:	0af4bc23          	sd	a5,184(s1)
    80005604:	00000797          	auipc	a5,0x0
    80005608:	cec78793          	addi	a5,a5,-788 # 800052f0 <consolewrite>
    8000560c:	0cf4b023          	sd	a5,192(s1)
    80005610:	00813483          	ld	s1,8(sp)
    80005614:	02010113          	addi	sp,sp,32
    80005618:	00008067          	ret

000000008000561c <console_read>:
    8000561c:	ff010113          	addi	sp,sp,-16
    80005620:	00813423          	sd	s0,8(sp)
    80005624:	01010413          	addi	s0,sp,16
    80005628:	00813403          	ld	s0,8(sp)
    8000562c:	00005317          	auipc	t1,0x5
    80005630:	93433303          	ld	t1,-1740(t1) # 80009f60 <devsw+0x10>
    80005634:	01010113          	addi	sp,sp,16
    80005638:	00030067          	jr	t1

000000008000563c <console_write>:
    8000563c:	ff010113          	addi	sp,sp,-16
    80005640:	00813423          	sd	s0,8(sp)
    80005644:	01010413          	addi	s0,sp,16
    80005648:	00813403          	ld	s0,8(sp)
    8000564c:	00005317          	auipc	t1,0x5
    80005650:	91c33303          	ld	t1,-1764(t1) # 80009f68 <devsw+0x18>
    80005654:	01010113          	addi	sp,sp,16
    80005658:	00030067          	jr	t1

000000008000565c <panic>:
    8000565c:	fe010113          	addi	sp,sp,-32
    80005660:	00113c23          	sd	ra,24(sp)
    80005664:	00813823          	sd	s0,16(sp)
    80005668:	00913423          	sd	s1,8(sp)
    8000566c:	02010413          	addi	s0,sp,32
    80005670:	00050493          	mv	s1,a0
    80005674:	00002517          	auipc	a0,0x2
    80005678:	23c50513          	addi	a0,a0,572 # 800078b0 <_ZTV7WorkerD+0x158>
    8000567c:	00005797          	auipc	a5,0x5
    80005680:	9807a623          	sw	zero,-1652(a5) # 8000a008 <pr+0x18>
    80005684:	00000097          	auipc	ra,0x0
    80005688:	034080e7          	jalr	52(ra) # 800056b8 <__printf>
    8000568c:	00048513          	mv	a0,s1
    80005690:	00000097          	auipc	ra,0x0
    80005694:	028080e7          	jalr	40(ra) # 800056b8 <__printf>
    80005698:	00002517          	auipc	a0,0x2
    8000569c:	c9850513          	addi	a0,a0,-872 # 80007330 <CONSOLE_STATUS+0x320>
    800056a0:	00000097          	auipc	ra,0x0
    800056a4:	018080e7          	jalr	24(ra) # 800056b8 <__printf>
    800056a8:	00100793          	li	a5,1
    800056ac:	00003717          	auipc	a4,0x3
    800056b0:	6ef72a23          	sw	a5,1780(a4) # 80008da0 <panicked>
    800056b4:	0000006f          	j	800056b4 <panic+0x58>

00000000800056b8 <__printf>:
    800056b8:	f3010113          	addi	sp,sp,-208
    800056bc:	08813023          	sd	s0,128(sp)
    800056c0:	07313423          	sd	s3,104(sp)
    800056c4:	09010413          	addi	s0,sp,144
    800056c8:	05813023          	sd	s8,64(sp)
    800056cc:	08113423          	sd	ra,136(sp)
    800056d0:	06913c23          	sd	s1,120(sp)
    800056d4:	07213823          	sd	s2,112(sp)
    800056d8:	07413023          	sd	s4,96(sp)
    800056dc:	05513c23          	sd	s5,88(sp)
    800056e0:	05613823          	sd	s6,80(sp)
    800056e4:	05713423          	sd	s7,72(sp)
    800056e8:	03913c23          	sd	s9,56(sp)
    800056ec:	03a13823          	sd	s10,48(sp)
    800056f0:	03b13423          	sd	s11,40(sp)
    800056f4:	00005317          	auipc	t1,0x5
    800056f8:	8fc30313          	addi	t1,t1,-1796 # 80009ff0 <pr>
    800056fc:	01832c03          	lw	s8,24(t1)
    80005700:	00b43423          	sd	a1,8(s0)
    80005704:	00c43823          	sd	a2,16(s0)
    80005708:	00d43c23          	sd	a3,24(s0)
    8000570c:	02e43023          	sd	a4,32(s0)
    80005710:	02f43423          	sd	a5,40(s0)
    80005714:	03043823          	sd	a6,48(s0)
    80005718:	03143c23          	sd	a7,56(s0)
    8000571c:	00050993          	mv	s3,a0
    80005720:	4a0c1663          	bnez	s8,80005bcc <__printf+0x514>
    80005724:	60098c63          	beqz	s3,80005d3c <__printf+0x684>
    80005728:	0009c503          	lbu	a0,0(s3)
    8000572c:	00840793          	addi	a5,s0,8
    80005730:	f6f43c23          	sd	a5,-136(s0)
    80005734:	00000493          	li	s1,0
    80005738:	22050063          	beqz	a0,80005958 <__printf+0x2a0>
    8000573c:	00002a37          	lui	s4,0x2
    80005740:	00018ab7          	lui	s5,0x18
    80005744:	000f4b37          	lui	s6,0xf4
    80005748:	00989bb7          	lui	s7,0x989
    8000574c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80005750:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80005754:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80005758:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    8000575c:	00148c9b          	addiw	s9,s1,1
    80005760:	02500793          	li	a5,37
    80005764:	01998933          	add	s2,s3,s9
    80005768:	38f51263          	bne	a0,a5,80005aec <__printf+0x434>
    8000576c:	00094783          	lbu	a5,0(s2)
    80005770:	00078c9b          	sext.w	s9,a5
    80005774:	1e078263          	beqz	a5,80005958 <__printf+0x2a0>
    80005778:	0024849b          	addiw	s1,s1,2
    8000577c:	07000713          	li	a4,112
    80005780:	00998933          	add	s2,s3,s1
    80005784:	38e78a63          	beq	a5,a4,80005b18 <__printf+0x460>
    80005788:	20f76863          	bltu	a4,a5,80005998 <__printf+0x2e0>
    8000578c:	42a78863          	beq	a5,a0,80005bbc <__printf+0x504>
    80005790:	06400713          	li	a4,100
    80005794:	40e79663          	bne	a5,a4,80005ba0 <__printf+0x4e8>
    80005798:	f7843783          	ld	a5,-136(s0)
    8000579c:	0007a603          	lw	a2,0(a5)
    800057a0:	00878793          	addi	a5,a5,8
    800057a4:	f6f43c23          	sd	a5,-136(s0)
    800057a8:	42064a63          	bltz	a2,80005bdc <__printf+0x524>
    800057ac:	00a00713          	li	a4,10
    800057b0:	02e677bb          	remuw	a5,a2,a4
    800057b4:	00002d97          	auipc	s11,0x2
    800057b8:	124d8d93          	addi	s11,s11,292 # 800078d8 <digits>
    800057bc:	00900593          	li	a1,9
    800057c0:	0006051b          	sext.w	a0,a2
    800057c4:	00000c93          	li	s9,0
    800057c8:	02079793          	slli	a5,a5,0x20
    800057cc:	0207d793          	srli	a5,a5,0x20
    800057d0:	00fd87b3          	add	a5,s11,a5
    800057d4:	0007c783          	lbu	a5,0(a5)
    800057d8:	02e656bb          	divuw	a3,a2,a4
    800057dc:	f8f40023          	sb	a5,-128(s0)
    800057e0:	14c5d863          	bge	a1,a2,80005930 <__printf+0x278>
    800057e4:	06300593          	li	a1,99
    800057e8:	00100c93          	li	s9,1
    800057ec:	02e6f7bb          	remuw	a5,a3,a4
    800057f0:	02079793          	slli	a5,a5,0x20
    800057f4:	0207d793          	srli	a5,a5,0x20
    800057f8:	00fd87b3          	add	a5,s11,a5
    800057fc:	0007c783          	lbu	a5,0(a5)
    80005800:	02e6d73b          	divuw	a4,a3,a4
    80005804:	f8f400a3          	sb	a5,-127(s0)
    80005808:	12a5f463          	bgeu	a1,a0,80005930 <__printf+0x278>
    8000580c:	00a00693          	li	a3,10
    80005810:	00900593          	li	a1,9
    80005814:	02d777bb          	remuw	a5,a4,a3
    80005818:	02079793          	slli	a5,a5,0x20
    8000581c:	0207d793          	srli	a5,a5,0x20
    80005820:	00fd87b3          	add	a5,s11,a5
    80005824:	0007c503          	lbu	a0,0(a5)
    80005828:	02d757bb          	divuw	a5,a4,a3
    8000582c:	f8a40123          	sb	a0,-126(s0)
    80005830:	48e5f263          	bgeu	a1,a4,80005cb4 <__printf+0x5fc>
    80005834:	06300513          	li	a0,99
    80005838:	02d7f5bb          	remuw	a1,a5,a3
    8000583c:	02059593          	slli	a1,a1,0x20
    80005840:	0205d593          	srli	a1,a1,0x20
    80005844:	00bd85b3          	add	a1,s11,a1
    80005848:	0005c583          	lbu	a1,0(a1)
    8000584c:	02d7d7bb          	divuw	a5,a5,a3
    80005850:	f8b401a3          	sb	a1,-125(s0)
    80005854:	48e57263          	bgeu	a0,a4,80005cd8 <__printf+0x620>
    80005858:	3e700513          	li	a0,999
    8000585c:	02d7f5bb          	remuw	a1,a5,a3
    80005860:	02059593          	slli	a1,a1,0x20
    80005864:	0205d593          	srli	a1,a1,0x20
    80005868:	00bd85b3          	add	a1,s11,a1
    8000586c:	0005c583          	lbu	a1,0(a1)
    80005870:	02d7d7bb          	divuw	a5,a5,a3
    80005874:	f8b40223          	sb	a1,-124(s0)
    80005878:	46e57663          	bgeu	a0,a4,80005ce4 <__printf+0x62c>
    8000587c:	02d7f5bb          	remuw	a1,a5,a3
    80005880:	02059593          	slli	a1,a1,0x20
    80005884:	0205d593          	srli	a1,a1,0x20
    80005888:	00bd85b3          	add	a1,s11,a1
    8000588c:	0005c583          	lbu	a1,0(a1)
    80005890:	02d7d7bb          	divuw	a5,a5,a3
    80005894:	f8b402a3          	sb	a1,-123(s0)
    80005898:	46ea7863          	bgeu	s4,a4,80005d08 <__printf+0x650>
    8000589c:	02d7f5bb          	remuw	a1,a5,a3
    800058a0:	02059593          	slli	a1,a1,0x20
    800058a4:	0205d593          	srli	a1,a1,0x20
    800058a8:	00bd85b3          	add	a1,s11,a1
    800058ac:	0005c583          	lbu	a1,0(a1)
    800058b0:	02d7d7bb          	divuw	a5,a5,a3
    800058b4:	f8b40323          	sb	a1,-122(s0)
    800058b8:	3eeaf863          	bgeu	s5,a4,80005ca8 <__printf+0x5f0>
    800058bc:	02d7f5bb          	remuw	a1,a5,a3
    800058c0:	02059593          	slli	a1,a1,0x20
    800058c4:	0205d593          	srli	a1,a1,0x20
    800058c8:	00bd85b3          	add	a1,s11,a1
    800058cc:	0005c583          	lbu	a1,0(a1)
    800058d0:	02d7d7bb          	divuw	a5,a5,a3
    800058d4:	f8b403a3          	sb	a1,-121(s0)
    800058d8:	42eb7e63          	bgeu	s6,a4,80005d14 <__printf+0x65c>
    800058dc:	02d7f5bb          	remuw	a1,a5,a3
    800058e0:	02059593          	slli	a1,a1,0x20
    800058e4:	0205d593          	srli	a1,a1,0x20
    800058e8:	00bd85b3          	add	a1,s11,a1
    800058ec:	0005c583          	lbu	a1,0(a1)
    800058f0:	02d7d7bb          	divuw	a5,a5,a3
    800058f4:	f8b40423          	sb	a1,-120(s0)
    800058f8:	42ebfc63          	bgeu	s7,a4,80005d30 <__printf+0x678>
    800058fc:	02079793          	slli	a5,a5,0x20
    80005900:	0207d793          	srli	a5,a5,0x20
    80005904:	00fd8db3          	add	s11,s11,a5
    80005908:	000dc703          	lbu	a4,0(s11)
    8000590c:	00a00793          	li	a5,10
    80005910:	00900c93          	li	s9,9
    80005914:	f8e404a3          	sb	a4,-119(s0)
    80005918:	00065c63          	bgez	a2,80005930 <__printf+0x278>
    8000591c:	f9040713          	addi	a4,s0,-112
    80005920:	00f70733          	add	a4,a4,a5
    80005924:	02d00693          	li	a3,45
    80005928:	fed70823          	sb	a3,-16(a4)
    8000592c:	00078c93          	mv	s9,a5
    80005930:	f8040793          	addi	a5,s0,-128
    80005934:	01978cb3          	add	s9,a5,s9
    80005938:	f7f40d13          	addi	s10,s0,-129
    8000593c:	000cc503          	lbu	a0,0(s9)
    80005940:	fffc8c93          	addi	s9,s9,-1
    80005944:	00000097          	auipc	ra,0x0
    80005948:	b90080e7          	jalr	-1136(ra) # 800054d4 <consputc>
    8000594c:	ffac98e3          	bne	s9,s10,8000593c <__printf+0x284>
    80005950:	00094503          	lbu	a0,0(s2)
    80005954:	e00514e3          	bnez	a0,8000575c <__printf+0xa4>
    80005958:	1a0c1663          	bnez	s8,80005b04 <__printf+0x44c>
    8000595c:	08813083          	ld	ra,136(sp)
    80005960:	08013403          	ld	s0,128(sp)
    80005964:	07813483          	ld	s1,120(sp)
    80005968:	07013903          	ld	s2,112(sp)
    8000596c:	06813983          	ld	s3,104(sp)
    80005970:	06013a03          	ld	s4,96(sp)
    80005974:	05813a83          	ld	s5,88(sp)
    80005978:	05013b03          	ld	s6,80(sp)
    8000597c:	04813b83          	ld	s7,72(sp)
    80005980:	04013c03          	ld	s8,64(sp)
    80005984:	03813c83          	ld	s9,56(sp)
    80005988:	03013d03          	ld	s10,48(sp)
    8000598c:	02813d83          	ld	s11,40(sp)
    80005990:	0d010113          	addi	sp,sp,208
    80005994:	00008067          	ret
    80005998:	07300713          	li	a4,115
    8000599c:	1ce78a63          	beq	a5,a4,80005b70 <__printf+0x4b8>
    800059a0:	07800713          	li	a4,120
    800059a4:	1ee79e63          	bne	a5,a4,80005ba0 <__printf+0x4e8>
    800059a8:	f7843783          	ld	a5,-136(s0)
    800059ac:	0007a703          	lw	a4,0(a5)
    800059b0:	00878793          	addi	a5,a5,8
    800059b4:	f6f43c23          	sd	a5,-136(s0)
    800059b8:	28074263          	bltz	a4,80005c3c <__printf+0x584>
    800059bc:	00002d97          	auipc	s11,0x2
    800059c0:	f1cd8d93          	addi	s11,s11,-228 # 800078d8 <digits>
    800059c4:	00f77793          	andi	a5,a4,15
    800059c8:	00fd87b3          	add	a5,s11,a5
    800059cc:	0007c683          	lbu	a3,0(a5)
    800059d0:	00f00613          	li	a2,15
    800059d4:	0007079b          	sext.w	a5,a4
    800059d8:	f8d40023          	sb	a3,-128(s0)
    800059dc:	0047559b          	srliw	a1,a4,0x4
    800059e0:	0047569b          	srliw	a3,a4,0x4
    800059e4:	00000c93          	li	s9,0
    800059e8:	0ee65063          	bge	a2,a4,80005ac8 <__printf+0x410>
    800059ec:	00f6f693          	andi	a3,a3,15
    800059f0:	00dd86b3          	add	a3,s11,a3
    800059f4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    800059f8:	0087d79b          	srliw	a5,a5,0x8
    800059fc:	00100c93          	li	s9,1
    80005a00:	f8d400a3          	sb	a3,-127(s0)
    80005a04:	0cb67263          	bgeu	a2,a1,80005ac8 <__printf+0x410>
    80005a08:	00f7f693          	andi	a3,a5,15
    80005a0c:	00dd86b3          	add	a3,s11,a3
    80005a10:	0006c583          	lbu	a1,0(a3)
    80005a14:	00f00613          	li	a2,15
    80005a18:	0047d69b          	srliw	a3,a5,0x4
    80005a1c:	f8b40123          	sb	a1,-126(s0)
    80005a20:	0047d593          	srli	a1,a5,0x4
    80005a24:	28f67e63          	bgeu	a2,a5,80005cc0 <__printf+0x608>
    80005a28:	00f6f693          	andi	a3,a3,15
    80005a2c:	00dd86b3          	add	a3,s11,a3
    80005a30:	0006c503          	lbu	a0,0(a3)
    80005a34:	0087d813          	srli	a6,a5,0x8
    80005a38:	0087d69b          	srliw	a3,a5,0x8
    80005a3c:	f8a401a3          	sb	a0,-125(s0)
    80005a40:	28b67663          	bgeu	a2,a1,80005ccc <__printf+0x614>
    80005a44:	00f6f693          	andi	a3,a3,15
    80005a48:	00dd86b3          	add	a3,s11,a3
    80005a4c:	0006c583          	lbu	a1,0(a3)
    80005a50:	00c7d513          	srli	a0,a5,0xc
    80005a54:	00c7d69b          	srliw	a3,a5,0xc
    80005a58:	f8b40223          	sb	a1,-124(s0)
    80005a5c:	29067a63          	bgeu	a2,a6,80005cf0 <__printf+0x638>
    80005a60:	00f6f693          	andi	a3,a3,15
    80005a64:	00dd86b3          	add	a3,s11,a3
    80005a68:	0006c583          	lbu	a1,0(a3)
    80005a6c:	0107d813          	srli	a6,a5,0x10
    80005a70:	0107d69b          	srliw	a3,a5,0x10
    80005a74:	f8b402a3          	sb	a1,-123(s0)
    80005a78:	28a67263          	bgeu	a2,a0,80005cfc <__printf+0x644>
    80005a7c:	00f6f693          	andi	a3,a3,15
    80005a80:	00dd86b3          	add	a3,s11,a3
    80005a84:	0006c683          	lbu	a3,0(a3)
    80005a88:	0147d79b          	srliw	a5,a5,0x14
    80005a8c:	f8d40323          	sb	a3,-122(s0)
    80005a90:	21067663          	bgeu	a2,a6,80005c9c <__printf+0x5e4>
    80005a94:	02079793          	slli	a5,a5,0x20
    80005a98:	0207d793          	srli	a5,a5,0x20
    80005a9c:	00fd8db3          	add	s11,s11,a5
    80005aa0:	000dc683          	lbu	a3,0(s11)
    80005aa4:	00800793          	li	a5,8
    80005aa8:	00700c93          	li	s9,7
    80005aac:	f8d403a3          	sb	a3,-121(s0)
    80005ab0:	00075c63          	bgez	a4,80005ac8 <__printf+0x410>
    80005ab4:	f9040713          	addi	a4,s0,-112
    80005ab8:	00f70733          	add	a4,a4,a5
    80005abc:	02d00693          	li	a3,45
    80005ac0:	fed70823          	sb	a3,-16(a4)
    80005ac4:	00078c93          	mv	s9,a5
    80005ac8:	f8040793          	addi	a5,s0,-128
    80005acc:	01978cb3          	add	s9,a5,s9
    80005ad0:	f7f40d13          	addi	s10,s0,-129
    80005ad4:	000cc503          	lbu	a0,0(s9)
    80005ad8:	fffc8c93          	addi	s9,s9,-1
    80005adc:	00000097          	auipc	ra,0x0
    80005ae0:	9f8080e7          	jalr	-1544(ra) # 800054d4 <consputc>
    80005ae4:	ff9d18e3          	bne	s10,s9,80005ad4 <__printf+0x41c>
    80005ae8:	0100006f          	j	80005af8 <__printf+0x440>
    80005aec:	00000097          	auipc	ra,0x0
    80005af0:	9e8080e7          	jalr	-1560(ra) # 800054d4 <consputc>
    80005af4:	000c8493          	mv	s1,s9
    80005af8:	00094503          	lbu	a0,0(s2)
    80005afc:	c60510e3          	bnez	a0,8000575c <__printf+0xa4>
    80005b00:	e40c0ee3          	beqz	s8,8000595c <__printf+0x2a4>
    80005b04:	00004517          	auipc	a0,0x4
    80005b08:	4ec50513          	addi	a0,a0,1260 # 80009ff0 <pr>
    80005b0c:	00001097          	auipc	ra,0x1
    80005b10:	94c080e7          	jalr	-1716(ra) # 80006458 <release>
    80005b14:	e49ff06f          	j	8000595c <__printf+0x2a4>
    80005b18:	f7843783          	ld	a5,-136(s0)
    80005b1c:	03000513          	li	a0,48
    80005b20:	01000d13          	li	s10,16
    80005b24:	00878713          	addi	a4,a5,8
    80005b28:	0007bc83          	ld	s9,0(a5)
    80005b2c:	f6e43c23          	sd	a4,-136(s0)
    80005b30:	00000097          	auipc	ra,0x0
    80005b34:	9a4080e7          	jalr	-1628(ra) # 800054d4 <consputc>
    80005b38:	07800513          	li	a0,120
    80005b3c:	00000097          	auipc	ra,0x0
    80005b40:	998080e7          	jalr	-1640(ra) # 800054d4 <consputc>
    80005b44:	00002d97          	auipc	s11,0x2
    80005b48:	d94d8d93          	addi	s11,s11,-620 # 800078d8 <digits>
    80005b4c:	03ccd793          	srli	a5,s9,0x3c
    80005b50:	00fd87b3          	add	a5,s11,a5
    80005b54:	0007c503          	lbu	a0,0(a5)
    80005b58:	fffd0d1b          	addiw	s10,s10,-1
    80005b5c:	004c9c93          	slli	s9,s9,0x4
    80005b60:	00000097          	auipc	ra,0x0
    80005b64:	974080e7          	jalr	-1676(ra) # 800054d4 <consputc>
    80005b68:	fe0d12e3          	bnez	s10,80005b4c <__printf+0x494>
    80005b6c:	f8dff06f          	j	80005af8 <__printf+0x440>
    80005b70:	f7843783          	ld	a5,-136(s0)
    80005b74:	0007bc83          	ld	s9,0(a5)
    80005b78:	00878793          	addi	a5,a5,8
    80005b7c:	f6f43c23          	sd	a5,-136(s0)
    80005b80:	000c9a63          	bnez	s9,80005b94 <__printf+0x4dc>
    80005b84:	1080006f          	j	80005c8c <__printf+0x5d4>
    80005b88:	001c8c93          	addi	s9,s9,1
    80005b8c:	00000097          	auipc	ra,0x0
    80005b90:	948080e7          	jalr	-1720(ra) # 800054d4 <consputc>
    80005b94:	000cc503          	lbu	a0,0(s9)
    80005b98:	fe0518e3          	bnez	a0,80005b88 <__printf+0x4d0>
    80005b9c:	f5dff06f          	j	80005af8 <__printf+0x440>
    80005ba0:	02500513          	li	a0,37
    80005ba4:	00000097          	auipc	ra,0x0
    80005ba8:	930080e7          	jalr	-1744(ra) # 800054d4 <consputc>
    80005bac:	000c8513          	mv	a0,s9
    80005bb0:	00000097          	auipc	ra,0x0
    80005bb4:	924080e7          	jalr	-1756(ra) # 800054d4 <consputc>
    80005bb8:	f41ff06f          	j	80005af8 <__printf+0x440>
    80005bbc:	02500513          	li	a0,37
    80005bc0:	00000097          	auipc	ra,0x0
    80005bc4:	914080e7          	jalr	-1772(ra) # 800054d4 <consputc>
    80005bc8:	f31ff06f          	j	80005af8 <__printf+0x440>
    80005bcc:	00030513          	mv	a0,t1
    80005bd0:	00000097          	auipc	ra,0x0
    80005bd4:	7bc080e7          	jalr	1980(ra) # 8000638c <acquire>
    80005bd8:	b4dff06f          	j	80005724 <__printf+0x6c>
    80005bdc:	40c0053b          	negw	a0,a2
    80005be0:	00a00713          	li	a4,10
    80005be4:	02e576bb          	remuw	a3,a0,a4
    80005be8:	00002d97          	auipc	s11,0x2
    80005bec:	cf0d8d93          	addi	s11,s11,-784 # 800078d8 <digits>
    80005bf0:	ff700593          	li	a1,-9
    80005bf4:	02069693          	slli	a3,a3,0x20
    80005bf8:	0206d693          	srli	a3,a3,0x20
    80005bfc:	00dd86b3          	add	a3,s11,a3
    80005c00:	0006c683          	lbu	a3,0(a3)
    80005c04:	02e557bb          	divuw	a5,a0,a4
    80005c08:	f8d40023          	sb	a3,-128(s0)
    80005c0c:	10b65e63          	bge	a2,a1,80005d28 <__printf+0x670>
    80005c10:	06300593          	li	a1,99
    80005c14:	02e7f6bb          	remuw	a3,a5,a4
    80005c18:	02069693          	slli	a3,a3,0x20
    80005c1c:	0206d693          	srli	a3,a3,0x20
    80005c20:	00dd86b3          	add	a3,s11,a3
    80005c24:	0006c683          	lbu	a3,0(a3)
    80005c28:	02e7d73b          	divuw	a4,a5,a4
    80005c2c:	00200793          	li	a5,2
    80005c30:	f8d400a3          	sb	a3,-127(s0)
    80005c34:	bca5ece3          	bltu	a1,a0,8000580c <__printf+0x154>
    80005c38:	ce5ff06f          	j	8000591c <__printf+0x264>
    80005c3c:	40e007bb          	negw	a5,a4
    80005c40:	00002d97          	auipc	s11,0x2
    80005c44:	c98d8d93          	addi	s11,s11,-872 # 800078d8 <digits>
    80005c48:	00f7f693          	andi	a3,a5,15
    80005c4c:	00dd86b3          	add	a3,s11,a3
    80005c50:	0006c583          	lbu	a1,0(a3)
    80005c54:	ff100613          	li	a2,-15
    80005c58:	0047d69b          	srliw	a3,a5,0x4
    80005c5c:	f8b40023          	sb	a1,-128(s0)
    80005c60:	0047d59b          	srliw	a1,a5,0x4
    80005c64:	0ac75e63          	bge	a4,a2,80005d20 <__printf+0x668>
    80005c68:	00f6f693          	andi	a3,a3,15
    80005c6c:	00dd86b3          	add	a3,s11,a3
    80005c70:	0006c603          	lbu	a2,0(a3)
    80005c74:	00f00693          	li	a3,15
    80005c78:	0087d79b          	srliw	a5,a5,0x8
    80005c7c:	f8c400a3          	sb	a2,-127(s0)
    80005c80:	d8b6e4e3          	bltu	a3,a1,80005a08 <__printf+0x350>
    80005c84:	00200793          	li	a5,2
    80005c88:	e2dff06f          	j	80005ab4 <__printf+0x3fc>
    80005c8c:	00002c97          	auipc	s9,0x2
    80005c90:	c2cc8c93          	addi	s9,s9,-980 # 800078b8 <_ZTV7WorkerD+0x160>
    80005c94:	02800513          	li	a0,40
    80005c98:	ef1ff06f          	j	80005b88 <__printf+0x4d0>
    80005c9c:	00700793          	li	a5,7
    80005ca0:	00600c93          	li	s9,6
    80005ca4:	e0dff06f          	j	80005ab0 <__printf+0x3f8>
    80005ca8:	00700793          	li	a5,7
    80005cac:	00600c93          	li	s9,6
    80005cb0:	c69ff06f          	j	80005918 <__printf+0x260>
    80005cb4:	00300793          	li	a5,3
    80005cb8:	00200c93          	li	s9,2
    80005cbc:	c5dff06f          	j	80005918 <__printf+0x260>
    80005cc0:	00300793          	li	a5,3
    80005cc4:	00200c93          	li	s9,2
    80005cc8:	de9ff06f          	j	80005ab0 <__printf+0x3f8>
    80005ccc:	00400793          	li	a5,4
    80005cd0:	00300c93          	li	s9,3
    80005cd4:	dddff06f          	j	80005ab0 <__printf+0x3f8>
    80005cd8:	00400793          	li	a5,4
    80005cdc:	00300c93          	li	s9,3
    80005ce0:	c39ff06f          	j	80005918 <__printf+0x260>
    80005ce4:	00500793          	li	a5,5
    80005ce8:	00400c93          	li	s9,4
    80005cec:	c2dff06f          	j	80005918 <__printf+0x260>
    80005cf0:	00500793          	li	a5,5
    80005cf4:	00400c93          	li	s9,4
    80005cf8:	db9ff06f          	j	80005ab0 <__printf+0x3f8>
    80005cfc:	00600793          	li	a5,6
    80005d00:	00500c93          	li	s9,5
    80005d04:	dadff06f          	j	80005ab0 <__printf+0x3f8>
    80005d08:	00600793          	li	a5,6
    80005d0c:	00500c93          	li	s9,5
    80005d10:	c09ff06f          	j	80005918 <__printf+0x260>
    80005d14:	00800793          	li	a5,8
    80005d18:	00700c93          	li	s9,7
    80005d1c:	bfdff06f          	j	80005918 <__printf+0x260>
    80005d20:	00100793          	li	a5,1
    80005d24:	d91ff06f          	j	80005ab4 <__printf+0x3fc>
    80005d28:	00100793          	li	a5,1
    80005d2c:	bf1ff06f          	j	8000591c <__printf+0x264>
    80005d30:	00900793          	li	a5,9
    80005d34:	00800c93          	li	s9,8
    80005d38:	be1ff06f          	j	80005918 <__printf+0x260>
    80005d3c:	00002517          	auipc	a0,0x2
    80005d40:	b8450513          	addi	a0,a0,-1148 # 800078c0 <_ZTV7WorkerD+0x168>
    80005d44:	00000097          	auipc	ra,0x0
    80005d48:	918080e7          	jalr	-1768(ra) # 8000565c <panic>

0000000080005d4c <printfinit>:
    80005d4c:	fe010113          	addi	sp,sp,-32
    80005d50:	00813823          	sd	s0,16(sp)
    80005d54:	00913423          	sd	s1,8(sp)
    80005d58:	00113c23          	sd	ra,24(sp)
    80005d5c:	02010413          	addi	s0,sp,32
    80005d60:	00004497          	auipc	s1,0x4
    80005d64:	29048493          	addi	s1,s1,656 # 80009ff0 <pr>
    80005d68:	00048513          	mv	a0,s1
    80005d6c:	00002597          	auipc	a1,0x2
    80005d70:	b6458593          	addi	a1,a1,-1180 # 800078d0 <_ZTV7WorkerD+0x178>
    80005d74:	00000097          	auipc	ra,0x0
    80005d78:	5f4080e7          	jalr	1524(ra) # 80006368 <initlock>
    80005d7c:	01813083          	ld	ra,24(sp)
    80005d80:	01013403          	ld	s0,16(sp)
    80005d84:	0004ac23          	sw	zero,24(s1)
    80005d88:	00813483          	ld	s1,8(sp)
    80005d8c:	02010113          	addi	sp,sp,32
    80005d90:	00008067          	ret

0000000080005d94 <uartinit>:
    80005d94:	ff010113          	addi	sp,sp,-16
    80005d98:	00813423          	sd	s0,8(sp)
    80005d9c:	01010413          	addi	s0,sp,16
    80005da0:	100007b7          	lui	a5,0x10000
    80005da4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80005da8:	f8000713          	li	a4,-128
    80005dac:	00e781a3          	sb	a4,3(a5)
    80005db0:	00300713          	li	a4,3
    80005db4:	00e78023          	sb	a4,0(a5)
    80005db8:	000780a3          	sb	zero,1(a5)
    80005dbc:	00e781a3          	sb	a4,3(a5)
    80005dc0:	00700693          	li	a3,7
    80005dc4:	00d78123          	sb	a3,2(a5)
    80005dc8:	00e780a3          	sb	a4,1(a5)
    80005dcc:	00813403          	ld	s0,8(sp)
    80005dd0:	01010113          	addi	sp,sp,16
    80005dd4:	00008067          	ret

0000000080005dd8 <uartputc>:
    80005dd8:	00003797          	auipc	a5,0x3
    80005ddc:	fc87a783          	lw	a5,-56(a5) # 80008da0 <panicked>
    80005de0:	00078463          	beqz	a5,80005de8 <uartputc+0x10>
    80005de4:	0000006f          	j	80005de4 <uartputc+0xc>
    80005de8:	fd010113          	addi	sp,sp,-48
    80005dec:	02813023          	sd	s0,32(sp)
    80005df0:	00913c23          	sd	s1,24(sp)
    80005df4:	01213823          	sd	s2,16(sp)
    80005df8:	01313423          	sd	s3,8(sp)
    80005dfc:	02113423          	sd	ra,40(sp)
    80005e00:	03010413          	addi	s0,sp,48
    80005e04:	00003917          	auipc	s2,0x3
    80005e08:	fa490913          	addi	s2,s2,-92 # 80008da8 <uart_tx_r>
    80005e0c:	00093783          	ld	a5,0(s2)
    80005e10:	00003497          	auipc	s1,0x3
    80005e14:	fa048493          	addi	s1,s1,-96 # 80008db0 <uart_tx_w>
    80005e18:	0004b703          	ld	a4,0(s1)
    80005e1c:	02078693          	addi	a3,a5,32
    80005e20:	00050993          	mv	s3,a0
    80005e24:	02e69c63          	bne	a3,a4,80005e5c <uartputc+0x84>
    80005e28:	00001097          	auipc	ra,0x1
    80005e2c:	834080e7          	jalr	-1996(ra) # 8000665c <push_on>
    80005e30:	00093783          	ld	a5,0(s2)
    80005e34:	0004b703          	ld	a4,0(s1)
    80005e38:	02078793          	addi	a5,a5,32
    80005e3c:	00e79463          	bne	a5,a4,80005e44 <uartputc+0x6c>
    80005e40:	0000006f          	j	80005e40 <uartputc+0x68>
    80005e44:	00001097          	auipc	ra,0x1
    80005e48:	88c080e7          	jalr	-1908(ra) # 800066d0 <pop_on>
    80005e4c:	00093783          	ld	a5,0(s2)
    80005e50:	0004b703          	ld	a4,0(s1)
    80005e54:	02078693          	addi	a3,a5,32
    80005e58:	fce688e3          	beq	a3,a4,80005e28 <uartputc+0x50>
    80005e5c:	01f77693          	andi	a3,a4,31
    80005e60:	00004597          	auipc	a1,0x4
    80005e64:	1b058593          	addi	a1,a1,432 # 8000a010 <uart_tx_buf>
    80005e68:	00d586b3          	add	a3,a1,a3
    80005e6c:	00170713          	addi	a4,a4,1
    80005e70:	01368023          	sb	s3,0(a3)
    80005e74:	00e4b023          	sd	a4,0(s1)
    80005e78:	10000637          	lui	a2,0x10000
    80005e7c:	02f71063          	bne	a4,a5,80005e9c <uartputc+0xc4>
    80005e80:	0340006f          	j	80005eb4 <uartputc+0xdc>
    80005e84:	00074703          	lbu	a4,0(a4)
    80005e88:	00f93023          	sd	a5,0(s2)
    80005e8c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80005e90:	00093783          	ld	a5,0(s2)
    80005e94:	0004b703          	ld	a4,0(s1)
    80005e98:	00f70e63          	beq	a4,a5,80005eb4 <uartputc+0xdc>
    80005e9c:	00564683          	lbu	a3,5(a2)
    80005ea0:	01f7f713          	andi	a4,a5,31
    80005ea4:	00e58733          	add	a4,a1,a4
    80005ea8:	0206f693          	andi	a3,a3,32
    80005eac:	00178793          	addi	a5,a5,1
    80005eb0:	fc069ae3          	bnez	a3,80005e84 <uartputc+0xac>
    80005eb4:	02813083          	ld	ra,40(sp)
    80005eb8:	02013403          	ld	s0,32(sp)
    80005ebc:	01813483          	ld	s1,24(sp)
    80005ec0:	01013903          	ld	s2,16(sp)
    80005ec4:	00813983          	ld	s3,8(sp)
    80005ec8:	03010113          	addi	sp,sp,48
    80005ecc:	00008067          	ret

0000000080005ed0 <uartputc_sync>:
    80005ed0:	ff010113          	addi	sp,sp,-16
    80005ed4:	00813423          	sd	s0,8(sp)
    80005ed8:	01010413          	addi	s0,sp,16
    80005edc:	00003717          	auipc	a4,0x3
    80005ee0:	ec472703          	lw	a4,-316(a4) # 80008da0 <panicked>
    80005ee4:	02071663          	bnez	a4,80005f10 <uartputc_sync+0x40>
    80005ee8:	00050793          	mv	a5,a0
    80005eec:	100006b7          	lui	a3,0x10000
    80005ef0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80005ef4:	02077713          	andi	a4,a4,32
    80005ef8:	fe070ce3          	beqz	a4,80005ef0 <uartputc_sync+0x20>
    80005efc:	0ff7f793          	andi	a5,a5,255
    80005f00:	00f68023          	sb	a5,0(a3)
    80005f04:	00813403          	ld	s0,8(sp)
    80005f08:	01010113          	addi	sp,sp,16
    80005f0c:	00008067          	ret
    80005f10:	0000006f          	j	80005f10 <uartputc_sync+0x40>

0000000080005f14 <uartstart>:
    80005f14:	ff010113          	addi	sp,sp,-16
    80005f18:	00813423          	sd	s0,8(sp)
    80005f1c:	01010413          	addi	s0,sp,16
    80005f20:	00003617          	auipc	a2,0x3
    80005f24:	e8860613          	addi	a2,a2,-376 # 80008da8 <uart_tx_r>
    80005f28:	00003517          	auipc	a0,0x3
    80005f2c:	e8850513          	addi	a0,a0,-376 # 80008db0 <uart_tx_w>
    80005f30:	00063783          	ld	a5,0(a2)
    80005f34:	00053703          	ld	a4,0(a0)
    80005f38:	04f70263          	beq	a4,a5,80005f7c <uartstart+0x68>
    80005f3c:	100005b7          	lui	a1,0x10000
    80005f40:	00004817          	auipc	a6,0x4
    80005f44:	0d080813          	addi	a6,a6,208 # 8000a010 <uart_tx_buf>
    80005f48:	01c0006f          	j	80005f64 <uartstart+0x50>
    80005f4c:	0006c703          	lbu	a4,0(a3)
    80005f50:	00f63023          	sd	a5,0(a2)
    80005f54:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80005f58:	00063783          	ld	a5,0(a2)
    80005f5c:	00053703          	ld	a4,0(a0)
    80005f60:	00f70e63          	beq	a4,a5,80005f7c <uartstart+0x68>
    80005f64:	01f7f713          	andi	a4,a5,31
    80005f68:	00e806b3          	add	a3,a6,a4
    80005f6c:	0055c703          	lbu	a4,5(a1)
    80005f70:	00178793          	addi	a5,a5,1
    80005f74:	02077713          	andi	a4,a4,32
    80005f78:	fc071ae3          	bnez	a4,80005f4c <uartstart+0x38>
    80005f7c:	00813403          	ld	s0,8(sp)
    80005f80:	01010113          	addi	sp,sp,16
    80005f84:	00008067          	ret

0000000080005f88 <uartgetc>:
    80005f88:	ff010113          	addi	sp,sp,-16
    80005f8c:	00813423          	sd	s0,8(sp)
    80005f90:	01010413          	addi	s0,sp,16
    80005f94:	10000737          	lui	a4,0x10000
    80005f98:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005f9c:	0017f793          	andi	a5,a5,1
    80005fa0:	00078c63          	beqz	a5,80005fb8 <uartgetc+0x30>
    80005fa4:	00074503          	lbu	a0,0(a4)
    80005fa8:	0ff57513          	andi	a0,a0,255
    80005fac:	00813403          	ld	s0,8(sp)
    80005fb0:	01010113          	addi	sp,sp,16
    80005fb4:	00008067          	ret
    80005fb8:	fff00513          	li	a0,-1
    80005fbc:	ff1ff06f          	j	80005fac <uartgetc+0x24>

0000000080005fc0 <uartintr>:
    80005fc0:	100007b7          	lui	a5,0x10000
    80005fc4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80005fc8:	0017f793          	andi	a5,a5,1
    80005fcc:	0a078463          	beqz	a5,80006074 <uartintr+0xb4>
    80005fd0:	fe010113          	addi	sp,sp,-32
    80005fd4:	00813823          	sd	s0,16(sp)
    80005fd8:	00913423          	sd	s1,8(sp)
    80005fdc:	00113c23          	sd	ra,24(sp)
    80005fe0:	02010413          	addi	s0,sp,32
    80005fe4:	100004b7          	lui	s1,0x10000
    80005fe8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    80005fec:	0ff57513          	andi	a0,a0,255
    80005ff0:	fffff097          	auipc	ra,0xfffff
    80005ff4:	534080e7          	jalr	1332(ra) # 80005524 <consoleintr>
    80005ff8:	0054c783          	lbu	a5,5(s1)
    80005ffc:	0017f793          	andi	a5,a5,1
    80006000:	fe0794e3          	bnez	a5,80005fe8 <uartintr+0x28>
    80006004:	00003617          	auipc	a2,0x3
    80006008:	da460613          	addi	a2,a2,-604 # 80008da8 <uart_tx_r>
    8000600c:	00003517          	auipc	a0,0x3
    80006010:	da450513          	addi	a0,a0,-604 # 80008db0 <uart_tx_w>
    80006014:	00063783          	ld	a5,0(a2)
    80006018:	00053703          	ld	a4,0(a0)
    8000601c:	04f70263          	beq	a4,a5,80006060 <uartintr+0xa0>
    80006020:	100005b7          	lui	a1,0x10000
    80006024:	00004817          	auipc	a6,0x4
    80006028:	fec80813          	addi	a6,a6,-20 # 8000a010 <uart_tx_buf>
    8000602c:	01c0006f          	j	80006048 <uartintr+0x88>
    80006030:	0006c703          	lbu	a4,0(a3)
    80006034:	00f63023          	sd	a5,0(a2)
    80006038:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000603c:	00063783          	ld	a5,0(a2)
    80006040:	00053703          	ld	a4,0(a0)
    80006044:	00f70e63          	beq	a4,a5,80006060 <uartintr+0xa0>
    80006048:	01f7f713          	andi	a4,a5,31
    8000604c:	00e806b3          	add	a3,a6,a4
    80006050:	0055c703          	lbu	a4,5(a1)
    80006054:	00178793          	addi	a5,a5,1
    80006058:	02077713          	andi	a4,a4,32
    8000605c:	fc071ae3          	bnez	a4,80006030 <uartintr+0x70>
    80006060:	01813083          	ld	ra,24(sp)
    80006064:	01013403          	ld	s0,16(sp)
    80006068:	00813483          	ld	s1,8(sp)
    8000606c:	02010113          	addi	sp,sp,32
    80006070:	00008067          	ret
    80006074:	00003617          	auipc	a2,0x3
    80006078:	d3460613          	addi	a2,a2,-716 # 80008da8 <uart_tx_r>
    8000607c:	00003517          	auipc	a0,0x3
    80006080:	d3450513          	addi	a0,a0,-716 # 80008db0 <uart_tx_w>
    80006084:	00063783          	ld	a5,0(a2)
    80006088:	00053703          	ld	a4,0(a0)
    8000608c:	04f70263          	beq	a4,a5,800060d0 <uartintr+0x110>
    80006090:	100005b7          	lui	a1,0x10000
    80006094:	00004817          	auipc	a6,0x4
    80006098:	f7c80813          	addi	a6,a6,-132 # 8000a010 <uart_tx_buf>
    8000609c:	01c0006f          	j	800060b8 <uartintr+0xf8>
    800060a0:	0006c703          	lbu	a4,0(a3)
    800060a4:	00f63023          	sd	a5,0(a2)
    800060a8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800060ac:	00063783          	ld	a5,0(a2)
    800060b0:	00053703          	ld	a4,0(a0)
    800060b4:	02f70063          	beq	a4,a5,800060d4 <uartintr+0x114>
    800060b8:	01f7f713          	andi	a4,a5,31
    800060bc:	00e806b3          	add	a3,a6,a4
    800060c0:	0055c703          	lbu	a4,5(a1)
    800060c4:	00178793          	addi	a5,a5,1
    800060c8:	02077713          	andi	a4,a4,32
    800060cc:	fc071ae3          	bnez	a4,800060a0 <uartintr+0xe0>
    800060d0:	00008067          	ret
    800060d4:	00008067          	ret

00000000800060d8 <kinit>:
    800060d8:	fc010113          	addi	sp,sp,-64
    800060dc:	02913423          	sd	s1,40(sp)
    800060e0:	fffff7b7          	lui	a5,0xfffff
    800060e4:	00005497          	auipc	s1,0x5
    800060e8:	f4b48493          	addi	s1,s1,-181 # 8000b02f <end+0xfff>
    800060ec:	02813823          	sd	s0,48(sp)
    800060f0:	01313c23          	sd	s3,24(sp)
    800060f4:	00f4f4b3          	and	s1,s1,a5
    800060f8:	02113c23          	sd	ra,56(sp)
    800060fc:	03213023          	sd	s2,32(sp)
    80006100:	01413823          	sd	s4,16(sp)
    80006104:	01513423          	sd	s5,8(sp)
    80006108:	04010413          	addi	s0,sp,64
    8000610c:	000017b7          	lui	a5,0x1
    80006110:	01100993          	li	s3,17
    80006114:	00f487b3          	add	a5,s1,a5
    80006118:	01b99993          	slli	s3,s3,0x1b
    8000611c:	06f9e063          	bltu	s3,a5,8000617c <kinit+0xa4>
    80006120:	00004a97          	auipc	s5,0x4
    80006124:	f10a8a93          	addi	s5,s5,-240 # 8000a030 <end>
    80006128:	0754ec63          	bltu	s1,s5,800061a0 <kinit+0xc8>
    8000612c:	0734fa63          	bgeu	s1,s3,800061a0 <kinit+0xc8>
    80006130:	00088a37          	lui	s4,0x88
    80006134:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80006138:	00003917          	auipc	s2,0x3
    8000613c:	c8090913          	addi	s2,s2,-896 # 80008db8 <kmem>
    80006140:	00ca1a13          	slli	s4,s4,0xc
    80006144:	0140006f          	j	80006158 <kinit+0x80>
    80006148:	000017b7          	lui	a5,0x1
    8000614c:	00f484b3          	add	s1,s1,a5
    80006150:	0554e863          	bltu	s1,s5,800061a0 <kinit+0xc8>
    80006154:	0534f663          	bgeu	s1,s3,800061a0 <kinit+0xc8>
    80006158:	00001637          	lui	a2,0x1
    8000615c:	00100593          	li	a1,1
    80006160:	00048513          	mv	a0,s1
    80006164:	00000097          	auipc	ra,0x0
    80006168:	5e4080e7          	jalr	1508(ra) # 80006748 <__memset>
    8000616c:	00093783          	ld	a5,0(s2)
    80006170:	00f4b023          	sd	a5,0(s1)
    80006174:	00993023          	sd	s1,0(s2)
    80006178:	fd4498e3          	bne	s1,s4,80006148 <kinit+0x70>
    8000617c:	03813083          	ld	ra,56(sp)
    80006180:	03013403          	ld	s0,48(sp)
    80006184:	02813483          	ld	s1,40(sp)
    80006188:	02013903          	ld	s2,32(sp)
    8000618c:	01813983          	ld	s3,24(sp)
    80006190:	01013a03          	ld	s4,16(sp)
    80006194:	00813a83          	ld	s5,8(sp)
    80006198:	04010113          	addi	sp,sp,64
    8000619c:	00008067          	ret
    800061a0:	00001517          	auipc	a0,0x1
    800061a4:	75050513          	addi	a0,a0,1872 # 800078f0 <digits+0x18>
    800061a8:	fffff097          	auipc	ra,0xfffff
    800061ac:	4b4080e7          	jalr	1204(ra) # 8000565c <panic>

00000000800061b0 <freerange>:
    800061b0:	fc010113          	addi	sp,sp,-64
    800061b4:	000017b7          	lui	a5,0x1
    800061b8:	02913423          	sd	s1,40(sp)
    800061bc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800061c0:	009504b3          	add	s1,a0,s1
    800061c4:	fffff537          	lui	a0,0xfffff
    800061c8:	02813823          	sd	s0,48(sp)
    800061cc:	02113c23          	sd	ra,56(sp)
    800061d0:	03213023          	sd	s2,32(sp)
    800061d4:	01313c23          	sd	s3,24(sp)
    800061d8:	01413823          	sd	s4,16(sp)
    800061dc:	01513423          	sd	s5,8(sp)
    800061e0:	01613023          	sd	s6,0(sp)
    800061e4:	04010413          	addi	s0,sp,64
    800061e8:	00a4f4b3          	and	s1,s1,a0
    800061ec:	00f487b3          	add	a5,s1,a5
    800061f0:	06f5e463          	bltu	a1,a5,80006258 <freerange+0xa8>
    800061f4:	00004a97          	auipc	s5,0x4
    800061f8:	e3ca8a93          	addi	s5,s5,-452 # 8000a030 <end>
    800061fc:	0954e263          	bltu	s1,s5,80006280 <freerange+0xd0>
    80006200:	01100993          	li	s3,17
    80006204:	01b99993          	slli	s3,s3,0x1b
    80006208:	0734fc63          	bgeu	s1,s3,80006280 <freerange+0xd0>
    8000620c:	00058a13          	mv	s4,a1
    80006210:	00003917          	auipc	s2,0x3
    80006214:	ba890913          	addi	s2,s2,-1112 # 80008db8 <kmem>
    80006218:	00002b37          	lui	s6,0x2
    8000621c:	0140006f          	j	80006230 <freerange+0x80>
    80006220:	000017b7          	lui	a5,0x1
    80006224:	00f484b3          	add	s1,s1,a5
    80006228:	0554ec63          	bltu	s1,s5,80006280 <freerange+0xd0>
    8000622c:	0534fa63          	bgeu	s1,s3,80006280 <freerange+0xd0>
    80006230:	00001637          	lui	a2,0x1
    80006234:	00100593          	li	a1,1
    80006238:	00048513          	mv	a0,s1
    8000623c:	00000097          	auipc	ra,0x0
    80006240:	50c080e7          	jalr	1292(ra) # 80006748 <__memset>
    80006244:	00093703          	ld	a4,0(s2)
    80006248:	016487b3          	add	a5,s1,s6
    8000624c:	00e4b023          	sd	a4,0(s1)
    80006250:	00993023          	sd	s1,0(s2)
    80006254:	fcfa76e3          	bgeu	s4,a5,80006220 <freerange+0x70>
    80006258:	03813083          	ld	ra,56(sp)
    8000625c:	03013403          	ld	s0,48(sp)
    80006260:	02813483          	ld	s1,40(sp)
    80006264:	02013903          	ld	s2,32(sp)
    80006268:	01813983          	ld	s3,24(sp)
    8000626c:	01013a03          	ld	s4,16(sp)
    80006270:	00813a83          	ld	s5,8(sp)
    80006274:	00013b03          	ld	s6,0(sp)
    80006278:	04010113          	addi	sp,sp,64
    8000627c:	00008067          	ret
    80006280:	00001517          	auipc	a0,0x1
    80006284:	67050513          	addi	a0,a0,1648 # 800078f0 <digits+0x18>
    80006288:	fffff097          	auipc	ra,0xfffff
    8000628c:	3d4080e7          	jalr	980(ra) # 8000565c <panic>

0000000080006290 <kfree>:
    80006290:	fe010113          	addi	sp,sp,-32
    80006294:	00813823          	sd	s0,16(sp)
    80006298:	00113c23          	sd	ra,24(sp)
    8000629c:	00913423          	sd	s1,8(sp)
    800062a0:	02010413          	addi	s0,sp,32
    800062a4:	03451793          	slli	a5,a0,0x34
    800062a8:	04079c63          	bnez	a5,80006300 <kfree+0x70>
    800062ac:	00004797          	auipc	a5,0x4
    800062b0:	d8478793          	addi	a5,a5,-636 # 8000a030 <end>
    800062b4:	00050493          	mv	s1,a0
    800062b8:	04f56463          	bltu	a0,a5,80006300 <kfree+0x70>
    800062bc:	01100793          	li	a5,17
    800062c0:	01b79793          	slli	a5,a5,0x1b
    800062c4:	02f57e63          	bgeu	a0,a5,80006300 <kfree+0x70>
    800062c8:	00001637          	lui	a2,0x1
    800062cc:	00100593          	li	a1,1
    800062d0:	00000097          	auipc	ra,0x0
    800062d4:	478080e7          	jalr	1144(ra) # 80006748 <__memset>
    800062d8:	00003797          	auipc	a5,0x3
    800062dc:	ae078793          	addi	a5,a5,-1312 # 80008db8 <kmem>
    800062e0:	0007b703          	ld	a4,0(a5)
    800062e4:	01813083          	ld	ra,24(sp)
    800062e8:	01013403          	ld	s0,16(sp)
    800062ec:	00e4b023          	sd	a4,0(s1)
    800062f0:	0097b023          	sd	s1,0(a5)
    800062f4:	00813483          	ld	s1,8(sp)
    800062f8:	02010113          	addi	sp,sp,32
    800062fc:	00008067          	ret
    80006300:	00001517          	auipc	a0,0x1
    80006304:	5f050513          	addi	a0,a0,1520 # 800078f0 <digits+0x18>
    80006308:	fffff097          	auipc	ra,0xfffff
    8000630c:	354080e7          	jalr	852(ra) # 8000565c <panic>

0000000080006310 <kalloc>:
    80006310:	fe010113          	addi	sp,sp,-32
    80006314:	00813823          	sd	s0,16(sp)
    80006318:	00913423          	sd	s1,8(sp)
    8000631c:	00113c23          	sd	ra,24(sp)
    80006320:	02010413          	addi	s0,sp,32
    80006324:	00003797          	auipc	a5,0x3
    80006328:	a9478793          	addi	a5,a5,-1388 # 80008db8 <kmem>
    8000632c:	0007b483          	ld	s1,0(a5)
    80006330:	02048063          	beqz	s1,80006350 <kalloc+0x40>
    80006334:	0004b703          	ld	a4,0(s1)
    80006338:	00001637          	lui	a2,0x1
    8000633c:	00500593          	li	a1,5
    80006340:	00048513          	mv	a0,s1
    80006344:	00e7b023          	sd	a4,0(a5)
    80006348:	00000097          	auipc	ra,0x0
    8000634c:	400080e7          	jalr	1024(ra) # 80006748 <__memset>
    80006350:	01813083          	ld	ra,24(sp)
    80006354:	01013403          	ld	s0,16(sp)
    80006358:	00048513          	mv	a0,s1
    8000635c:	00813483          	ld	s1,8(sp)
    80006360:	02010113          	addi	sp,sp,32
    80006364:	00008067          	ret

0000000080006368 <initlock>:
    80006368:	ff010113          	addi	sp,sp,-16
    8000636c:	00813423          	sd	s0,8(sp)
    80006370:	01010413          	addi	s0,sp,16
    80006374:	00813403          	ld	s0,8(sp)
    80006378:	00b53423          	sd	a1,8(a0)
    8000637c:	00052023          	sw	zero,0(a0)
    80006380:	00053823          	sd	zero,16(a0)
    80006384:	01010113          	addi	sp,sp,16
    80006388:	00008067          	ret

000000008000638c <acquire>:
    8000638c:	fe010113          	addi	sp,sp,-32
    80006390:	00813823          	sd	s0,16(sp)
    80006394:	00913423          	sd	s1,8(sp)
    80006398:	00113c23          	sd	ra,24(sp)
    8000639c:	01213023          	sd	s2,0(sp)
    800063a0:	02010413          	addi	s0,sp,32
    800063a4:	00050493          	mv	s1,a0
    800063a8:	10002973          	csrr	s2,sstatus
    800063ac:	100027f3          	csrr	a5,sstatus
    800063b0:	ffd7f793          	andi	a5,a5,-3
    800063b4:	10079073          	csrw	sstatus,a5
    800063b8:	fffff097          	auipc	ra,0xfffff
    800063bc:	8e8080e7          	jalr	-1816(ra) # 80004ca0 <mycpu>
    800063c0:	07852783          	lw	a5,120(a0)
    800063c4:	06078e63          	beqz	a5,80006440 <acquire+0xb4>
    800063c8:	fffff097          	auipc	ra,0xfffff
    800063cc:	8d8080e7          	jalr	-1832(ra) # 80004ca0 <mycpu>
    800063d0:	07852783          	lw	a5,120(a0)
    800063d4:	0004a703          	lw	a4,0(s1)
    800063d8:	0017879b          	addiw	a5,a5,1
    800063dc:	06f52c23          	sw	a5,120(a0)
    800063e0:	04071063          	bnez	a4,80006420 <acquire+0x94>
    800063e4:	00100713          	li	a4,1
    800063e8:	00070793          	mv	a5,a4
    800063ec:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800063f0:	0007879b          	sext.w	a5,a5
    800063f4:	fe079ae3          	bnez	a5,800063e8 <acquire+0x5c>
    800063f8:	0ff0000f          	fence
    800063fc:	fffff097          	auipc	ra,0xfffff
    80006400:	8a4080e7          	jalr	-1884(ra) # 80004ca0 <mycpu>
    80006404:	01813083          	ld	ra,24(sp)
    80006408:	01013403          	ld	s0,16(sp)
    8000640c:	00a4b823          	sd	a0,16(s1)
    80006410:	00013903          	ld	s2,0(sp)
    80006414:	00813483          	ld	s1,8(sp)
    80006418:	02010113          	addi	sp,sp,32
    8000641c:	00008067          	ret
    80006420:	0104b903          	ld	s2,16(s1)
    80006424:	fffff097          	auipc	ra,0xfffff
    80006428:	87c080e7          	jalr	-1924(ra) # 80004ca0 <mycpu>
    8000642c:	faa91ce3          	bne	s2,a0,800063e4 <acquire+0x58>
    80006430:	00001517          	auipc	a0,0x1
    80006434:	4c850513          	addi	a0,a0,1224 # 800078f8 <digits+0x20>
    80006438:	fffff097          	auipc	ra,0xfffff
    8000643c:	224080e7          	jalr	548(ra) # 8000565c <panic>
    80006440:	00195913          	srli	s2,s2,0x1
    80006444:	fffff097          	auipc	ra,0xfffff
    80006448:	85c080e7          	jalr	-1956(ra) # 80004ca0 <mycpu>
    8000644c:	00197913          	andi	s2,s2,1
    80006450:	07252e23          	sw	s2,124(a0)
    80006454:	f75ff06f          	j	800063c8 <acquire+0x3c>

0000000080006458 <release>:
    80006458:	fe010113          	addi	sp,sp,-32
    8000645c:	00813823          	sd	s0,16(sp)
    80006460:	00113c23          	sd	ra,24(sp)
    80006464:	00913423          	sd	s1,8(sp)
    80006468:	01213023          	sd	s2,0(sp)
    8000646c:	02010413          	addi	s0,sp,32
    80006470:	00052783          	lw	a5,0(a0)
    80006474:	00079a63          	bnez	a5,80006488 <release+0x30>
    80006478:	00001517          	auipc	a0,0x1
    8000647c:	48850513          	addi	a0,a0,1160 # 80007900 <digits+0x28>
    80006480:	fffff097          	auipc	ra,0xfffff
    80006484:	1dc080e7          	jalr	476(ra) # 8000565c <panic>
    80006488:	01053903          	ld	s2,16(a0)
    8000648c:	00050493          	mv	s1,a0
    80006490:	fffff097          	auipc	ra,0xfffff
    80006494:	810080e7          	jalr	-2032(ra) # 80004ca0 <mycpu>
    80006498:	fea910e3          	bne	s2,a0,80006478 <release+0x20>
    8000649c:	0004b823          	sd	zero,16(s1)
    800064a0:	0ff0000f          	fence
    800064a4:	0f50000f          	fence	iorw,ow
    800064a8:	0804a02f          	amoswap.w	zero,zero,(s1)
    800064ac:	ffffe097          	auipc	ra,0xffffe
    800064b0:	7f4080e7          	jalr	2036(ra) # 80004ca0 <mycpu>
    800064b4:	100027f3          	csrr	a5,sstatus
    800064b8:	0027f793          	andi	a5,a5,2
    800064bc:	04079a63          	bnez	a5,80006510 <release+0xb8>
    800064c0:	07852783          	lw	a5,120(a0)
    800064c4:	02f05e63          	blez	a5,80006500 <release+0xa8>
    800064c8:	fff7871b          	addiw	a4,a5,-1
    800064cc:	06e52c23          	sw	a4,120(a0)
    800064d0:	00071c63          	bnez	a4,800064e8 <release+0x90>
    800064d4:	07c52783          	lw	a5,124(a0)
    800064d8:	00078863          	beqz	a5,800064e8 <release+0x90>
    800064dc:	100027f3          	csrr	a5,sstatus
    800064e0:	0027e793          	ori	a5,a5,2
    800064e4:	10079073          	csrw	sstatus,a5
    800064e8:	01813083          	ld	ra,24(sp)
    800064ec:	01013403          	ld	s0,16(sp)
    800064f0:	00813483          	ld	s1,8(sp)
    800064f4:	00013903          	ld	s2,0(sp)
    800064f8:	02010113          	addi	sp,sp,32
    800064fc:	00008067          	ret
    80006500:	00001517          	auipc	a0,0x1
    80006504:	42050513          	addi	a0,a0,1056 # 80007920 <digits+0x48>
    80006508:	fffff097          	auipc	ra,0xfffff
    8000650c:	154080e7          	jalr	340(ra) # 8000565c <panic>
    80006510:	00001517          	auipc	a0,0x1
    80006514:	3f850513          	addi	a0,a0,1016 # 80007908 <digits+0x30>
    80006518:	fffff097          	auipc	ra,0xfffff
    8000651c:	144080e7          	jalr	324(ra) # 8000565c <panic>

0000000080006520 <holding>:
    80006520:	00052783          	lw	a5,0(a0)
    80006524:	00079663          	bnez	a5,80006530 <holding+0x10>
    80006528:	00000513          	li	a0,0
    8000652c:	00008067          	ret
    80006530:	fe010113          	addi	sp,sp,-32
    80006534:	00813823          	sd	s0,16(sp)
    80006538:	00913423          	sd	s1,8(sp)
    8000653c:	00113c23          	sd	ra,24(sp)
    80006540:	02010413          	addi	s0,sp,32
    80006544:	01053483          	ld	s1,16(a0)
    80006548:	ffffe097          	auipc	ra,0xffffe
    8000654c:	758080e7          	jalr	1880(ra) # 80004ca0 <mycpu>
    80006550:	01813083          	ld	ra,24(sp)
    80006554:	01013403          	ld	s0,16(sp)
    80006558:	40a48533          	sub	a0,s1,a0
    8000655c:	00153513          	seqz	a0,a0
    80006560:	00813483          	ld	s1,8(sp)
    80006564:	02010113          	addi	sp,sp,32
    80006568:	00008067          	ret

000000008000656c <push_off>:
    8000656c:	fe010113          	addi	sp,sp,-32
    80006570:	00813823          	sd	s0,16(sp)
    80006574:	00113c23          	sd	ra,24(sp)
    80006578:	00913423          	sd	s1,8(sp)
    8000657c:	02010413          	addi	s0,sp,32
    80006580:	100024f3          	csrr	s1,sstatus
    80006584:	100027f3          	csrr	a5,sstatus
    80006588:	ffd7f793          	andi	a5,a5,-3
    8000658c:	10079073          	csrw	sstatus,a5
    80006590:	ffffe097          	auipc	ra,0xffffe
    80006594:	710080e7          	jalr	1808(ra) # 80004ca0 <mycpu>
    80006598:	07852783          	lw	a5,120(a0)
    8000659c:	02078663          	beqz	a5,800065c8 <push_off+0x5c>
    800065a0:	ffffe097          	auipc	ra,0xffffe
    800065a4:	700080e7          	jalr	1792(ra) # 80004ca0 <mycpu>
    800065a8:	07852783          	lw	a5,120(a0)
    800065ac:	01813083          	ld	ra,24(sp)
    800065b0:	01013403          	ld	s0,16(sp)
    800065b4:	0017879b          	addiw	a5,a5,1
    800065b8:	06f52c23          	sw	a5,120(a0)
    800065bc:	00813483          	ld	s1,8(sp)
    800065c0:	02010113          	addi	sp,sp,32
    800065c4:	00008067          	ret
    800065c8:	0014d493          	srli	s1,s1,0x1
    800065cc:	ffffe097          	auipc	ra,0xffffe
    800065d0:	6d4080e7          	jalr	1748(ra) # 80004ca0 <mycpu>
    800065d4:	0014f493          	andi	s1,s1,1
    800065d8:	06952e23          	sw	s1,124(a0)
    800065dc:	fc5ff06f          	j	800065a0 <push_off+0x34>

00000000800065e0 <pop_off>:
    800065e0:	ff010113          	addi	sp,sp,-16
    800065e4:	00813023          	sd	s0,0(sp)
    800065e8:	00113423          	sd	ra,8(sp)
    800065ec:	01010413          	addi	s0,sp,16
    800065f0:	ffffe097          	auipc	ra,0xffffe
    800065f4:	6b0080e7          	jalr	1712(ra) # 80004ca0 <mycpu>
    800065f8:	100027f3          	csrr	a5,sstatus
    800065fc:	0027f793          	andi	a5,a5,2
    80006600:	04079663          	bnez	a5,8000664c <pop_off+0x6c>
    80006604:	07852783          	lw	a5,120(a0)
    80006608:	02f05a63          	blez	a5,8000663c <pop_off+0x5c>
    8000660c:	fff7871b          	addiw	a4,a5,-1
    80006610:	06e52c23          	sw	a4,120(a0)
    80006614:	00071c63          	bnez	a4,8000662c <pop_off+0x4c>
    80006618:	07c52783          	lw	a5,124(a0)
    8000661c:	00078863          	beqz	a5,8000662c <pop_off+0x4c>
    80006620:	100027f3          	csrr	a5,sstatus
    80006624:	0027e793          	ori	a5,a5,2
    80006628:	10079073          	csrw	sstatus,a5
    8000662c:	00813083          	ld	ra,8(sp)
    80006630:	00013403          	ld	s0,0(sp)
    80006634:	01010113          	addi	sp,sp,16
    80006638:	00008067          	ret
    8000663c:	00001517          	auipc	a0,0x1
    80006640:	2e450513          	addi	a0,a0,740 # 80007920 <digits+0x48>
    80006644:	fffff097          	auipc	ra,0xfffff
    80006648:	018080e7          	jalr	24(ra) # 8000565c <panic>
    8000664c:	00001517          	auipc	a0,0x1
    80006650:	2bc50513          	addi	a0,a0,700 # 80007908 <digits+0x30>
    80006654:	fffff097          	auipc	ra,0xfffff
    80006658:	008080e7          	jalr	8(ra) # 8000565c <panic>

000000008000665c <push_on>:
    8000665c:	fe010113          	addi	sp,sp,-32
    80006660:	00813823          	sd	s0,16(sp)
    80006664:	00113c23          	sd	ra,24(sp)
    80006668:	00913423          	sd	s1,8(sp)
    8000666c:	02010413          	addi	s0,sp,32
    80006670:	100024f3          	csrr	s1,sstatus
    80006674:	100027f3          	csrr	a5,sstatus
    80006678:	0027e793          	ori	a5,a5,2
    8000667c:	10079073          	csrw	sstatus,a5
    80006680:	ffffe097          	auipc	ra,0xffffe
    80006684:	620080e7          	jalr	1568(ra) # 80004ca0 <mycpu>
    80006688:	07852783          	lw	a5,120(a0)
    8000668c:	02078663          	beqz	a5,800066b8 <push_on+0x5c>
    80006690:	ffffe097          	auipc	ra,0xffffe
    80006694:	610080e7          	jalr	1552(ra) # 80004ca0 <mycpu>
    80006698:	07852783          	lw	a5,120(a0)
    8000669c:	01813083          	ld	ra,24(sp)
    800066a0:	01013403          	ld	s0,16(sp)
    800066a4:	0017879b          	addiw	a5,a5,1
    800066a8:	06f52c23          	sw	a5,120(a0)
    800066ac:	00813483          	ld	s1,8(sp)
    800066b0:	02010113          	addi	sp,sp,32
    800066b4:	00008067          	ret
    800066b8:	0014d493          	srli	s1,s1,0x1
    800066bc:	ffffe097          	auipc	ra,0xffffe
    800066c0:	5e4080e7          	jalr	1508(ra) # 80004ca0 <mycpu>
    800066c4:	0014f493          	andi	s1,s1,1
    800066c8:	06952e23          	sw	s1,124(a0)
    800066cc:	fc5ff06f          	j	80006690 <push_on+0x34>

00000000800066d0 <pop_on>:
    800066d0:	ff010113          	addi	sp,sp,-16
    800066d4:	00813023          	sd	s0,0(sp)
    800066d8:	00113423          	sd	ra,8(sp)
    800066dc:	01010413          	addi	s0,sp,16
    800066e0:	ffffe097          	auipc	ra,0xffffe
    800066e4:	5c0080e7          	jalr	1472(ra) # 80004ca0 <mycpu>
    800066e8:	100027f3          	csrr	a5,sstatus
    800066ec:	0027f793          	andi	a5,a5,2
    800066f0:	04078463          	beqz	a5,80006738 <pop_on+0x68>
    800066f4:	07852783          	lw	a5,120(a0)
    800066f8:	02f05863          	blez	a5,80006728 <pop_on+0x58>
    800066fc:	fff7879b          	addiw	a5,a5,-1
    80006700:	06f52c23          	sw	a5,120(a0)
    80006704:	07853783          	ld	a5,120(a0)
    80006708:	00079863          	bnez	a5,80006718 <pop_on+0x48>
    8000670c:	100027f3          	csrr	a5,sstatus
    80006710:	ffd7f793          	andi	a5,a5,-3
    80006714:	10079073          	csrw	sstatus,a5
    80006718:	00813083          	ld	ra,8(sp)
    8000671c:	00013403          	ld	s0,0(sp)
    80006720:	01010113          	addi	sp,sp,16
    80006724:	00008067          	ret
    80006728:	00001517          	auipc	a0,0x1
    8000672c:	22050513          	addi	a0,a0,544 # 80007948 <digits+0x70>
    80006730:	fffff097          	auipc	ra,0xfffff
    80006734:	f2c080e7          	jalr	-212(ra) # 8000565c <panic>
    80006738:	00001517          	auipc	a0,0x1
    8000673c:	1f050513          	addi	a0,a0,496 # 80007928 <digits+0x50>
    80006740:	fffff097          	auipc	ra,0xfffff
    80006744:	f1c080e7          	jalr	-228(ra) # 8000565c <panic>

0000000080006748 <__memset>:
    80006748:	ff010113          	addi	sp,sp,-16
    8000674c:	00813423          	sd	s0,8(sp)
    80006750:	01010413          	addi	s0,sp,16
    80006754:	1a060e63          	beqz	a2,80006910 <__memset+0x1c8>
    80006758:	40a007b3          	neg	a5,a0
    8000675c:	0077f793          	andi	a5,a5,7
    80006760:	00778693          	addi	a3,a5,7
    80006764:	00b00813          	li	a6,11
    80006768:	0ff5f593          	andi	a1,a1,255
    8000676c:	fff6071b          	addiw	a4,a2,-1
    80006770:	1b06e663          	bltu	a3,a6,8000691c <__memset+0x1d4>
    80006774:	1cd76463          	bltu	a4,a3,8000693c <__memset+0x1f4>
    80006778:	1a078e63          	beqz	a5,80006934 <__memset+0x1ec>
    8000677c:	00b50023          	sb	a1,0(a0)
    80006780:	00100713          	li	a4,1
    80006784:	1ae78463          	beq	a5,a4,8000692c <__memset+0x1e4>
    80006788:	00b500a3          	sb	a1,1(a0)
    8000678c:	00200713          	li	a4,2
    80006790:	1ae78a63          	beq	a5,a4,80006944 <__memset+0x1fc>
    80006794:	00b50123          	sb	a1,2(a0)
    80006798:	00300713          	li	a4,3
    8000679c:	18e78463          	beq	a5,a4,80006924 <__memset+0x1dc>
    800067a0:	00b501a3          	sb	a1,3(a0)
    800067a4:	00400713          	li	a4,4
    800067a8:	1ae78263          	beq	a5,a4,8000694c <__memset+0x204>
    800067ac:	00b50223          	sb	a1,4(a0)
    800067b0:	00500713          	li	a4,5
    800067b4:	1ae78063          	beq	a5,a4,80006954 <__memset+0x20c>
    800067b8:	00b502a3          	sb	a1,5(a0)
    800067bc:	00700713          	li	a4,7
    800067c0:	18e79e63          	bne	a5,a4,8000695c <__memset+0x214>
    800067c4:	00b50323          	sb	a1,6(a0)
    800067c8:	00700e93          	li	t4,7
    800067cc:	00859713          	slli	a4,a1,0x8
    800067d0:	00e5e733          	or	a4,a1,a4
    800067d4:	01059e13          	slli	t3,a1,0x10
    800067d8:	01c76e33          	or	t3,a4,t3
    800067dc:	01859313          	slli	t1,a1,0x18
    800067e0:	006e6333          	or	t1,t3,t1
    800067e4:	02059893          	slli	a7,a1,0x20
    800067e8:	40f60e3b          	subw	t3,a2,a5
    800067ec:	011368b3          	or	a7,t1,a7
    800067f0:	02859813          	slli	a6,a1,0x28
    800067f4:	0108e833          	or	a6,a7,a6
    800067f8:	03059693          	slli	a3,a1,0x30
    800067fc:	003e589b          	srliw	a7,t3,0x3
    80006800:	00d866b3          	or	a3,a6,a3
    80006804:	03859713          	slli	a4,a1,0x38
    80006808:	00389813          	slli	a6,a7,0x3
    8000680c:	00f507b3          	add	a5,a0,a5
    80006810:	00e6e733          	or	a4,a3,a4
    80006814:	000e089b          	sext.w	a7,t3
    80006818:	00f806b3          	add	a3,a6,a5
    8000681c:	00e7b023          	sd	a4,0(a5)
    80006820:	00878793          	addi	a5,a5,8
    80006824:	fed79ce3          	bne	a5,a3,8000681c <__memset+0xd4>
    80006828:	ff8e7793          	andi	a5,t3,-8
    8000682c:	0007871b          	sext.w	a4,a5
    80006830:	01d787bb          	addw	a5,a5,t4
    80006834:	0ce88e63          	beq	a7,a4,80006910 <__memset+0x1c8>
    80006838:	00f50733          	add	a4,a0,a5
    8000683c:	00b70023          	sb	a1,0(a4)
    80006840:	0017871b          	addiw	a4,a5,1
    80006844:	0cc77663          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    80006848:	00e50733          	add	a4,a0,a4
    8000684c:	00b70023          	sb	a1,0(a4)
    80006850:	0027871b          	addiw	a4,a5,2
    80006854:	0ac77e63          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    80006858:	00e50733          	add	a4,a0,a4
    8000685c:	00b70023          	sb	a1,0(a4)
    80006860:	0037871b          	addiw	a4,a5,3
    80006864:	0ac77663          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    80006868:	00e50733          	add	a4,a0,a4
    8000686c:	00b70023          	sb	a1,0(a4)
    80006870:	0047871b          	addiw	a4,a5,4
    80006874:	08c77e63          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    80006878:	00e50733          	add	a4,a0,a4
    8000687c:	00b70023          	sb	a1,0(a4)
    80006880:	0057871b          	addiw	a4,a5,5
    80006884:	08c77663          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    80006888:	00e50733          	add	a4,a0,a4
    8000688c:	00b70023          	sb	a1,0(a4)
    80006890:	0067871b          	addiw	a4,a5,6
    80006894:	06c77e63          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    80006898:	00e50733          	add	a4,a0,a4
    8000689c:	00b70023          	sb	a1,0(a4)
    800068a0:	0077871b          	addiw	a4,a5,7
    800068a4:	06c77663          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    800068a8:	00e50733          	add	a4,a0,a4
    800068ac:	00b70023          	sb	a1,0(a4)
    800068b0:	0087871b          	addiw	a4,a5,8
    800068b4:	04c77e63          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    800068b8:	00e50733          	add	a4,a0,a4
    800068bc:	00b70023          	sb	a1,0(a4)
    800068c0:	0097871b          	addiw	a4,a5,9
    800068c4:	04c77663          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    800068c8:	00e50733          	add	a4,a0,a4
    800068cc:	00b70023          	sb	a1,0(a4)
    800068d0:	00a7871b          	addiw	a4,a5,10
    800068d4:	02c77e63          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    800068d8:	00e50733          	add	a4,a0,a4
    800068dc:	00b70023          	sb	a1,0(a4)
    800068e0:	00b7871b          	addiw	a4,a5,11
    800068e4:	02c77663          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    800068e8:	00e50733          	add	a4,a0,a4
    800068ec:	00b70023          	sb	a1,0(a4)
    800068f0:	00c7871b          	addiw	a4,a5,12
    800068f4:	00c77e63          	bgeu	a4,a2,80006910 <__memset+0x1c8>
    800068f8:	00e50733          	add	a4,a0,a4
    800068fc:	00b70023          	sb	a1,0(a4)
    80006900:	00d7879b          	addiw	a5,a5,13
    80006904:	00c7f663          	bgeu	a5,a2,80006910 <__memset+0x1c8>
    80006908:	00f507b3          	add	a5,a0,a5
    8000690c:	00b78023          	sb	a1,0(a5)
    80006910:	00813403          	ld	s0,8(sp)
    80006914:	01010113          	addi	sp,sp,16
    80006918:	00008067          	ret
    8000691c:	00b00693          	li	a3,11
    80006920:	e55ff06f          	j	80006774 <__memset+0x2c>
    80006924:	00300e93          	li	t4,3
    80006928:	ea5ff06f          	j	800067cc <__memset+0x84>
    8000692c:	00100e93          	li	t4,1
    80006930:	e9dff06f          	j	800067cc <__memset+0x84>
    80006934:	00000e93          	li	t4,0
    80006938:	e95ff06f          	j	800067cc <__memset+0x84>
    8000693c:	00000793          	li	a5,0
    80006940:	ef9ff06f          	j	80006838 <__memset+0xf0>
    80006944:	00200e93          	li	t4,2
    80006948:	e85ff06f          	j	800067cc <__memset+0x84>
    8000694c:	00400e93          	li	t4,4
    80006950:	e7dff06f          	j	800067cc <__memset+0x84>
    80006954:	00500e93          	li	t4,5
    80006958:	e75ff06f          	j	800067cc <__memset+0x84>
    8000695c:	00600e93          	li	t4,6
    80006960:	e6dff06f          	j	800067cc <__memset+0x84>

0000000080006964 <__memmove>:
    80006964:	ff010113          	addi	sp,sp,-16
    80006968:	00813423          	sd	s0,8(sp)
    8000696c:	01010413          	addi	s0,sp,16
    80006970:	0e060863          	beqz	a2,80006a60 <__memmove+0xfc>
    80006974:	fff6069b          	addiw	a3,a2,-1
    80006978:	0006881b          	sext.w	a6,a3
    8000697c:	0ea5e863          	bltu	a1,a0,80006a6c <__memmove+0x108>
    80006980:	00758713          	addi	a4,a1,7
    80006984:	00a5e7b3          	or	a5,a1,a0
    80006988:	40a70733          	sub	a4,a4,a0
    8000698c:	0077f793          	andi	a5,a5,7
    80006990:	00f73713          	sltiu	a4,a4,15
    80006994:	00174713          	xori	a4,a4,1
    80006998:	0017b793          	seqz	a5,a5
    8000699c:	00e7f7b3          	and	a5,a5,a4
    800069a0:	10078863          	beqz	a5,80006ab0 <__memmove+0x14c>
    800069a4:	00900793          	li	a5,9
    800069a8:	1107f463          	bgeu	a5,a6,80006ab0 <__memmove+0x14c>
    800069ac:	0036581b          	srliw	a6,a2,0x3
    800069b0:	fff8081b          	addiw	a6,a6,-1
    800069b4:	02081813          	slli	a6,a6,0x20
    800069b8:	01d85893          	srli	a7,a6,0x1d
    800069bc:	00858813          	addi	a6,a1,8
    800069c0:	00058793          	mv	a5,a1
    800069c4:	00050713          	mv	a4,a0
    800069c8:	01088833          	add	a6,a7,a6
    800069cc:	0007b883          	ld	a7,0(a5)
    800069d0:	00878793          	addi	a5,a5,8
    800069d4:	00870713          	addi	a4,a4,8
    800069d8:	ff173c23          	sd	a7,-8(a4)
    800069dc:	ff0798e3          	bne	a5,a6,800069cc <__memmove+0x68>
    800069e0:	ff867713          	andi	a4,a2,-8
    800069e4:	02071793          	slli	a5,a4,0x20
    800069e8:	0207d793          	srli	a5,a5,0x20
    800069ec:	00f585b3          	add	a1,a1,a5
    800069f0:	40e686bb          	subw	a3,a3,a4
    800069f4:	00f507b3          	add	a5,a0,a5
    800069f8:	06e60463          	beq	a2,a4,80006a60 <__memmove+0xfc>
    800069fc:	0005c703          	lbu	a4,0(a1)
    80006a00:	00e78023          	sb	a4,0(a5)
    80006a04:	04068e63          	beqz	a3,80006a60 <__memmove+0xfc>
    80006a08:	0015c603          	lbu	a2,1(a1)
    80006a0c:	00100713          	li	a4,1
    80006a10:	00c780a3          	sb	a2,1(a5)
    80006a14:	04e68663          	beq	a3,a4,80006a60 <__memmove+0xfc>
    80006a18:	0025c603          	lbu	a2,2(a1)
    80006a1c:	00200713          	li	a4,2
    80006a20:	00c78123          	sb	a2,2(a5)
    80006a24:	02e68e63          	beq	a3,a4,80006a60 <__memmove+0xfc>
    80006a28:	0035c603          	lbu	a2,3(a1)
    80006a2c:	00300713          	li	a4,3
    80006a30:	00c781a3          	sb	a2,3(a5)
    80006a34:	02e68663          	beq	a3,a4,80006a60 <__memmove+0xfc>
    80006a38:	0045c603          	lbu	a2,4(a1)
    80006a3c:	00400713          	li	a4,4
    80006a40:	00c78223          	sb	a2,4(a5)
    80006a44:	00e68e63          	beq	a3,a4,80006a60 <__memmove+0xfc>
    80006a48:	0055c603          	lbu	a2,5(a1)
    80006a4c:	00500713          	li	a4,5
    80006a50:	00c782a3          	sb	a2,5(a5)
    80006a54:	00e68663          	beq	a3,a4,80006a60 <__memmove+0xfc>
    80006a58:	0065c703          	lbu	a4,6(a1)
    80006a5c:	00e78323          	sb	a4,6(a5)
    80006a60:	00813403          	ld	s0,8(sp)
    80006a64:	01010113          	addi	sp,sp,16
    80006a68:	00008067          	ret
    80006a6c:	02061713          	slli	a4,a2,0x20
    80006a70:	02075713          	srli	a4,a4,0x20
    80006a74:	00e587b3          	add	a5,a1,a4
    80006a78:	f0f574e3          	bgeu	a0,a5,80006980 <__memmove+0x1c>
    80006a7c:	02069613          	slli	a2,a3,0x20
    80006a80:	02065613          	srli	a2,a2,0x20
    80006a84:	fff64613          	not	a2,a2
    80006a88:	00e50733          	add	a4,a0,a4
    80006a8c:	00c78633          	add	a2,a5,a2
    80006a90:	fff7c683          	lbu	a3,-1(a5)
    80006a94:	fff78793          	addi	a5,a5,-1
    80006a98:	fff70713          	addi	a4,a4,-1
    80006a9c:	00d70023          	sb	a3,0(a4)
    80006aa0:	fec798e3          	bne	a5,a2,80006a90 <__memmove+0x12c>
    80006aa4:	00813403          	ld	s0,8(sp)
    80006aa8:	01010113          	addi	sp,sp,16
    80006aac:	00008067          	ret
    80006ab0:	02069713          	slli	a4,a3,0x20
    80006ab4:	02075713          	srli	a4,a4,0x20
    80006ab8:	00170713          	addi	a4,a4,1
    80006abc:	00e50733          	add	a4,a0,a4
    80006ac0:	00050793          	mv	a5,a0
    80006ac4:	0005c683          	lbu	a3,0(a1)
    80006ac8:	00178793          	addi	a5,a5,1
    80006acc:	00158593          	addi	a1,a1,1
    80006ad0:	fed78fa3          	sb	a3,-1(a5)
    80006ad4:	fee798e3          	bne	a5,a4,80006ac4 <__memmove+0x160>
    80006ad8:	f89ff06f          	j	80006a60 <__memmove+0xfc>

0000000080006adc <__putc>:
    80006adc:	fe010113          	addi	sp,sp,-32
    80006ae0:	00813823          	sd	s0,16(sp)
    80006ae4:	00113c23          	sd	ra,24(sp)
    80006ae8:	02010413          	addi	s0,sp,32
    80006aec:	00050793          	mv	a5,a0
    80006af0:	fef40593          	addi	a1,s0,-17
    80006af4:	00100613          	li	a2,1
    80006af8:	00000513          	li	a0,0
    80006afc:	fef407a3          	sb	a5,-17(s0)
    80006b00:	fffff097          	auipc	ra,0xfffff
    80006b04:	b3c080e7          	jalr	-1220(ra) # 8000563c <console_write>
    80006b08:	01813083          	ld	ra,24(sp)
    80006b0c:	01013403          	ld	s0,16(sp)
    80006b10:	02010113          	addi	sp,sp,32
    80006b14:	00008067          	ret

0000000080006b18 <__getc>:
    80006b18:	fe010113          	addi	sp,sp,-32
    80006b1c:	00813823          	sd	s0,16(sp)
    80006b20:	00113c23          	sd	ra,24(sp)
    80006b24:	02010413          	addi	s0,sp,32
    80006b28:	fe840593          	addi	a1,s0,-24
    80006b2c:	00100613          	li	a2,1
    80006b30:	00000513          	li	a0,0
    80006b34:	fffff097          	auipc	ra,0xfffff
    80006b38:	ae8080e7          	jalr	-1304(ra) # 8000561c <console_read>
    80006b3c:	fe844503          	lbu	a0,-24(s0)
    80006b40:	01813083          	ld	ra,24(sp)
    80006b44:	01013403          	ld	s0,16(sp)
    80006b48:	02010113          	addi	sp,sp,32
    80006b4c:	00008067          	ret

0000000080006b50 <console_handler>:
    80006b50:	fe010113          	addi	sp,sp,-32
    80006b54:	00813823          	sd	s0,16(sp)
    80006b58:	00113c23          	sd	ra,24(sp)
    80006b5c:	00913423          	sd	s1,8(sp)
    80006b60:	02010413          	addi	s0,sp,32
    80006b64:	14202773          	csrr	a4,scause
    80006b68:	100027f3          	csrr	a5,sstatus
    80006b6c:	0027f793          	andi	a5,a5,2
    80006b70:	06079e63          	bnez	a5,80006bec <console_handler+0x9c>
    80006b74:	00074c63          	bltz	a4,80006b8c <console_handler+0x3c>
    80006b78:	01813083          	ld	ra,24(sp)
    80006b7c:	01013403          	ld	s0,16(sp)
    80006b80:	00813483          	ld	s1,8(sp)
    80006b84:	02010113          	addi	sp,sp,32
    80006b88:	00008067          	ret
    80006b8c:	0ff77713          	andi	a4,a4,255
    80006b90:	00900793          	li	a5,9
    80006b94:	fef712e3          	bne	a4,a5,80006b78 <console_handler+0x28>
    80006b98:	ffffe097          	auipc	ra,0xffffe
    80006b9c:	6dc080e7          	jalr	1756(ra) # 80005274 <plic_claim>
    80006ba0:	00a00793          	li	a5,10
    80006ba4:	00050493          	mv	s1,a0
    80006ba8:	02f50c63          	beq	a0,a5,80006be0 <console_handler+0x90>
    80006bac:	fc0506e3          	beqz	a0,80006b78 <console_handler+0x28>
    80006bb0:	00050593          	mv	a1,a0
    80006bb4:	00001517          	auipc	a0,0x1
    80006bb8:	c9c50513          	addi	a0,a0,-868 # 80007850 <_ZTV7WorkerD+0xf8>
    80006bbc:	fffff097          	auipc	ra,0xfffff
    80006bc0:	afc080e7          	jalr	-1284(ra) # 800056b8 <__printf>
    80006bc4:	01013403          	ld	s0,16(sp)
    80006bc8:	01813083          	ld	ra,24(sp)
    80006bcc:	00048513          	mv	a0,s1
    80006bd0:	00813483          	ld	s1,8(sp)
    80006bd4:	02010113          	addi	sp,sp,32
    80006bd8:	ffffe317          	auipc	t1,0xffffe
    80006bdc:	6d430067          	jr	1748(t1) # 800052ac <plic_complete>
    80006be0:	fffff097          	auipc	ra,0xfffff
    80006be4:	3e0080e7          	jalr	992(ra) # 80005fc0 <uartintr>
    80006be8:	fddff06f          	j	80006bc4 <console_handler+0x74>
    80006bec:	00001517          	auipc	a0,0x1
    80006bf0:	d6450513          	addi	a0,a0,-668 # 80007950 <digits+0x78>
    80006bf4:	fffff097          	auipc	ra,0xfffff
    80006bf8:	a68080e7          	jalr	-1432(ra) # 8000565c <panic>
	...
