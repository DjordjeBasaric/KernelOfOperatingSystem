
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	0d013103          	ld	sp,208(sp) # 800070d0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	7f9020ef          	jal	ra,80003014 <start>

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
    800011b0:	298000ef          	jal	ra,80001448 <_ZN5Riscv23interruptRoutineHandlerEv>

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
#include "../lib/mem.h"

using size_t = decltype(sizeof(0));

void *operator new(size_t n)
{
    80001240:	ff010113          	addi	sp,sp,-16
    80001244:	00113423          	sd	ra,8(sp)
    80001248:	00813023          	sd	s0,0(sp)
    8000124c:	01010413          	addi	s0,sp,16
    return __mem_alloc(n);
    80001250:	00004097          	auipc	ra,0x4
    80001254:	f58080e7          	jalr	-168(ra) # 800051a8 <__mem_alloc>
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
    return __mem_alloc(n);
    80001278:	00004097          	auipc	ra,0x4
    8000127c:	f30080e7          	jalr	-208(ra) # 800051a8 <__mem_alloc>
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
    __mem_free(p);
    800012a0:	00004097          	auipc	ra,0x4
    800012a4:	e3c080e7          	jalr	-452(ra) # 800050dc <__mem_free>
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
    __mem_free(p);
    800012c8:	00004097          	auipc	ra,0x4
    800012cc:	e14080e7          	jalr	-492(ra) # 800050dc <__mem_free>
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
    8000130c:	00006797          	auipc	a5,0x6
    80001310:	ea478793          	addi	a5,a5,-348 # 800071b0 <_ZN9Scheduler19readyCoroutineQueueE>
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
    80001334:	00006517          	auipc	a0,0x6
    80001338:	e7c53503          	ld	a0,-388(a0) # 800071b0 <_ZN9Scheduler19readyCoroutineQueueE>
    8000133c:	04050263          	beqz	a0,80001380 <_ZN9Scheduler3getEv+0x60>

        Elem *elem = head;
        head = head->next;
    80001340:	00853783          	ld	a5,8(a0)
    80001344:	00006717          	auipc	a4,0x6
    80001348:	e6f73623          	sd	a5,-404(a4) # 800071b0 <_ZN9Scheduler19readyCoroutineQueueE>
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
    80001374:	00006797          	auipc	a5,0x6
    80001378:	e407b223          	sd	zero,-444(a5) # 800071b8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
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
    800013b4:	00006797          	auipc	a5,0x6
    800013b8:	e047b783          	ld	a5,-508(a5) # 800071b8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013bc:	02078263          	beqz	a5,800013e0 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = elem;
    800013c0:	00a7b423          	sd	a0,8(a5)
            tail = elem;
    800013c4:	00006797          	auipc	a5,0x6
    800013c8:	dea7ba23          	sd	a0,-524(a5) # 800071b8 <_ZN9Scheduler19readyCoroutineQueueE+0x8>
    800013cc:	01813083          	ld	ra,24(sp)
    800013d0:	01013403          	ld	s0,16(sp)
    800013d4:	00813483          	ld	s1,8(sp)
    800013d8:	02010113          	addi	sp,sp,32
    800013dc:	00008067          	ret
            head = tail = elem;
    800013e0:	00006797          	auipc	a5,0x6
    800013e4:	dd078793          	addi	a5,a5,-560 # 800071b0 <_ZN9Scheduler19readyCoroutineQueueE>
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

0000000080001428 <_ZN5Riscv10popSppSpieEv>:
#include "../h/_thread.hpp"
#include "../test/printing.hpp"


void Riscv::popSppSpie()
{
    80001428:	ff010113          	addi	sp,sp,-16
    8000142c:	00813423          	sd	s0,8(sp)
    80001430:	01010413          	addi	s0,sp,16
    __asm__ volatile ("csrw sepc, ra"); // zato ovde upisujem da nas vrati tamo odakle je i ova funkcija bila i pozvana i zbog toga ova funckija nije inline
    80001434:	14109073          	csrw	sepc,ra
    __asm__ volatile ("sret"); //ovo sret ce vratiti tamo gde je sepc rekao, i to nam ne odgovara
    80001438:	10200073          	sret

}
    8000143c:	00813403          	ld	s0,8(sp)
    80001440:	01010113          	addi	sp,sp,16
    80001444:	00008067          	ret

0000000080001448 <_ZN5Riscv23interruptRoutineHandlerEv>:

void Riscv::interruptRoutineHandler(){
    80001448:	f8010113          	addi	sp,sp,-128
    8000144c:	06113c23          	sd	ra,120(sp)
    80001450:	06813823          	sd	s0,112(sp)
    80001454:	06913423          	sd	s1,104(sp)
    80001458:	08010413          	addi	s0,sp,128
    uint64 volatile fcode, handle, start_routine, arg;
    asm volatile("mv %0, a0" : "=r" (fcode));
    8000145c:	00050793          	mv	a5,a0
    80001460:	fcf43c23          	sd	a5,-40(s0)
    asm volatile("mv %0, a1" : "=r" (handle));    //thread_t* handle
    80001464:	00058793          	mv	a5,a1
    80001468:	fcf43823          	sd	a5,-48(s0)
    asm volatile("mv %0, a2" : "=r" (start_routine));    //void (*function)(void*)
    8000146c:	00060793          	mv	a5,a2
    80001470:	fcf43423          	sd	a5,-56(s0)
    asm volatile("mv %0, a3" : "=r" (arg));
    80001474:	00068793          	mv	a5,a3
    80001478:	fcf43023          	sd	a5,-64(s0)
};

inline uint64 Riscv::r_scause()
{
    uint64 volatile scause;
    __asm__ volatile ("csrr %[scause], scause" : [scause] "=r"(scause));
    8000147c:	142027f3          	csrr	a5,scause
    80001480:	f8f43c23          	sd	a5,-104(s0)
    return scause;
    80001484:	f9843483          	ld	s1,-104(s0)
    uint64 retval = 0;

    //r_scause -> read scause
    uint64 scause = r_scause(); // scause -> razlog prekida

    if (scause == 0x0000000000000008UL || scause == 0x0000000000000009UL){
    80001488:	ff848713          	addi	a4,s1,-8
    8000148c:	00100793          	li	a5,1
    80001490:	0ce7fa63          	bgeu	a5,a4,80001564 <_ZN5Riscv23interruptRoutineHandlerEv+0x11c>
        }

        w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
        w_sstatus(sstatus);
    }
    else if (scause == 0x8000000000000001UL){
    80001494:	fff00793          	li	a5,-1
    80001498:	03f79793          	slli	a5,a5,0x3f
    8000149c:	00178793          	addi	a5,a5,1
    800014a0:	18f48063          	beq	s1,a5,80001620 <_ZN5Riscv23interruptRoutineHandlerEv+0x1d8>
        mc_sip(SIP_SSIP);
    }
    else if (scause == 0x8000000000000009UL){
    800014a4:	fff00793          	li	a5,-1
    800014a8:	03f79793          	slli	a5,a5,0x3f
    800014ac:	00978793          	addi	a5,a5,9
    800014b0:	16f48e63          	beq	s1,a5,8000162c <_ZN5Riscv23interruptRoutineHandlerEv+0x1e4>
        console_handler();
    }
    else{
        printString("\nPc greske: ");
    800014b4:	00005517          	auipc	a0,0x5
    800014b8:	b4c50513          	addi	a0,a0,-1204 # 80006000 <kvmincrease+0xbe0>
    800014bc:	00001097          	auipc	ra,0x1
    800014c0:	898080e7          	jalr	-1896(ra) # 80001d54 <_Z11printStringPKc>
}

inline uint64 Riscv::r_sepc()
{
    uint64 volatile sepc;
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800014c4:	141027f3          	csrr	a5,sepc
    800014c8:	faf43c23          	sd	a5,-72(s0)
    return sepc;
    800014cc:	fb843503          	ld	a0,-72(s0)
        printInt(r_sepc());//cuva adresu na kooju se vracam posle prekidne rutine
    800014d0:	00000613          	li	a2,0
    800014d4:	00a00593          	li	a1,10
    800014d8:	0005051b          	sext.w	a0,a0
    800014dc:	00001097          	auipc	ra,0x1
    800014e0:	a28080e7          	jalr	-1496(ra) # 80001f04 <_Z8printIntiii>
        printString("\nStVal greske: ");
    800014e4:	00005517          	auipc	a0,0x5
    800014e8:	b2c50513          	addi	a0,a0,-1236 # 80006010 <kvmincrease+0xbf0>
    800014ec:	00001097          	auipc	ra,0x1
    800014f0:	868080e7          	jalr	-1944(ra) # 80001d54 <_Z11printStringPKc>
}

inline uint64 Riscv::r_stval()
{
    uint64 volatile stval;
    __asm__ volatile ("csrr %[stval], stval" : [stval] "=r"(stval));
    800014f4:	143027f3          	csrr	a5,stval
    800014f8:	faf43823          	sd	a5,-80(s0)
    return stval;
    800014fc:	fb043503          	ld	a0,-80(s0)
        printInt(r_stval());
    80001500:	00000613          	li	a2,0
    80001504:	00a00593          	li	a1,10
    80001508:	0005051b          	sext.w	a0,a0
    8000150c:	00001097          	auipc	ra,0x1
    80001510:	9f8080e7          	jalr	-1544(ra) # 80001f04 <_Z8printIntiii>
        printString("\nRazlog greske scause: ");
    80001514:	00005517          	auipc	a0,0x5
    80001518:	b0c50513          	addi	a0,a0,-1268 # 80006020 <kvmincrease+0xc00>
    8000151c:	00001097          	auipc	ra,0x1
    80001520:	838080e7          	jalr	-1992(ra) # 80001d54 <_Z11printStringPKc>
        printInt(scause);
    80001524:	00000613          	li	a2,0
    80001528:	00a00593          	li	a1,10
    8000152c:	0004851b          	sext.w	a0,s1
    80001530:	00001097          	auipc	ra,0x1
    80001534:	9d4080e7          	jalr	-1580(ra) # 80001f04 <_Z8printIntiii>
        switch(scause) {
    80001538:	00500793          	li	a5,5
    8000153c:	10f48863          	beq	s1,a5,8000164c <_ZN5Riscv23interruptRoutineHandlerEv+0x204>
    80001540:	00700793          	li	a5,7
    80001544:	10f48e63          	beq	s1,a5,80001660 <_ZN5Riscv23interruptRoutineHandlerEv+0x218>
    80001548:	00200793          	li	a5,2
    8000154c:	0ef48663          	beq	s1,a5,80001638 <_ZN5Riscv23interruptRoutineHandlerEv+0x1f0>
                break;
            case 7:
                printString(" Nedozvoljena adresa upisa");
                break;
            default:
                printString(" Ostalo");
    80001550:	00005517          	auipc	a0,0x5
    80001554:	b4050513          	addi	a0,a0,-1216 # 80006090 <kvmincrease+0xc70>
    80001558:	00000097          	auipc	ra,0x0
    8000155c:	7fc080e7          	jalr	2044(ra) # 80001d54 <_Z11printStringPKc>
                break;
        }
    }
    80001560:	0a00006f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
    __asm__ volatile ("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80001564:	141027f3          	csrr	a5,sepc
    80001568:	faf43423          	sd	a5,-88(s0)
    return sepc;
    8000156c:	fa843783          	ld	a5,-88(s0)
        uint64 volatile sepc = r_sepc() + 4;    //prelazak na sledecu instrukciju; jer procesor ponavlja instr koja je izazvala prekid
    80001570:	00478793          	addi	a5,a5,4
    80001574:	f8f43423          	sd	a5,-120(s0)
}

inline uint64 Riscv::r_sstatus()
{
    uint64 volatile sstatus;
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80001578:	100027f3          	csrr	a5,sstatus
    8000157c:	faf43023          	sd	a5,-96(s0)
    return sstatus;
    80001580:	fa043783          	ld	a5,-96(s0)
        uint64 volatile sstatus = r_sstatus();
    80001584:	f8f43823          	sd	a5,-112(s0)
        switch(fcode){
    80001588:	fd843783          	ld	a5,-40(s0)
    8000158c:	01300713          	li	a4,19
    80001590:	08e78263          	beq	a5,a4,80001614 <_ZN5Riscv23interruptRoutineHandlerEv+0x1cc>
    80001594:	02f76063          	bltu	a4,a5,800015b4 <_ZN5Riscv23interruptRoutineHandlerEv+0x16c>
    80001598:	01100713          	li	a4,17
    8000159c:	02e78663          	beq	a5,a4,800015c8 <_ZN5Riscv23interruptRoutineHandlerEv+0x180>
    800015a0:	01200713          	li	a4,18
    800015a4:	04e79663          	bne	a5,a4,800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
                _thread::thread_exit();
    800015a8:	00000097          	auipc	ra,0x0
    800015ac:	2a0080e7          	jalr	672(ra) # 80001848 <_ZN7_thread11thread_exitEv>
                break;
    800015b0:	0400006f          	j	800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
        switch(fcode){
    800015b4:	02000713          	li	a4,32
    800015b8:	02e79c63          	bne	a5,a4,800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
                __getc();
    800015bc:	00004097          	auipc	ra,0x4
    800015c0:	d80080e7          	jalr	-640(ra) # 8000533c <__getc>
    800015c4:	02c0006f          	j	800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
                uint64 *stack_space = new uint64[DEFAULT_STACK_SIZE];
    800015c8:	00008537          	lui	a0,0x8
    800015cc:	00000097          	auipc	ra,0x0
    800015d0:	c9c080e7          	jalr	-868(ra) # 80001268 <_Znam>
    800015d4:	00050693          	mv	a3,a0
                retval = _thread::create_thread((thread_t *) handle, (_thread::Body) start_routine, (void *) arg,
    800015d8:	fd043503          	ld	a0,-48(s0)
    800015dc:	fc843583          	ld	a1,-56(s0)
    800015e0:	fc043603          	ld	a2,-64(s0)
    800015e4:	00000097          	auipc	ra,0x0
    800015e8:	110080e7          	jalr	272(ra) # 800016f4 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>
                asm volatile("mv a0, %0" : : "r" (retval));
    800015ec:	00050513          	mv	a0,a0
        w_sepc(sepc); //ako je unutar dispacha promenjen pc ovde upisujem taj novi(sto je nekad sacuvan od neke druge niti)
    800015f0:	f8843783          	ld	a5,-120(s0)
    __asm__ volatile ("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    800015f4:	14179073          	csrw	sepc,a5
        w_sstatus(sstatus);
    800015f8:	f9043783          	ld	a5,-112(s0)
}

inline void Riscv::w_sstatus(uint64 sstatus)
{
    __asm__ volatile ("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    800015fc:	10079073          	csrw	sstatus,a5
    80001600:	07813083          	ld	ra,120(sp)
    80001604:	07013403          	ld	s0,112(sp)
    80001608:	06813483          	ld	s1,104(sp)
    8000160c:	08010113          	addi	sp,sp,128
    80001610:	00008067          	ret
                _thread::thread_dispatch();
    80001614:	00000097          	auipc	ra,0x0
    80001618:	1cc080e7          	jalr	460(ra) # 800017e0 <_ZN7_thread15thread_dispatchEv>
                break;
    8000161c:	fd5ff06f          	j	800015f0 <_ZN5Riscv23interruptRoutineHandlerEv+0x1a8>
    __asm__ volatile ("csrc sip, %[mask]" : : [mask] "r"(mask));
    80001620:	00200793          	li	a5,2
    80001624:	1447b073          	csrc	sip,a5
}
    80001628:	fd9ff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
        console_handler();
    8000162c:	00004097          	auipc	ra,0x4
    80001630:	d48080e7          	jalr	-696(ra) # 80005374 <console_handler>
    80001634:	fcdff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
                printString(" Nelegelna instrukcija");
    80001638:	00005517          	auipc	a0,0x5
    8000163c:	a0050513          	addi	a0,a0,-1536 # 80006038 <kvmincrease+0xc18>
    80001640:	00000097          	auipc	ra,0x0
    80001644:	714080e7          	jalr	1812(ra) # 80001d54 <_Z11printStringPKc>
                break;
    80001648:	fb9ff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
                printString(" Nedozvoljena adresa citanja");
    8000164c:	00005517          	auipc	a0,0x5
    80001650:	a0450513          	addi	a0,a0,-1532 # 80006050 <kvmincrease+0xc30>
    80001654:	00000097          	auipc	ra,0x0
    80001658:	700080e7          	jalr	1792(ra) # 80001d54 <_Z11printStringPKc>
                break;
    8000165c:	fa5ff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>
                printString(" Nedozvoljena adresa upisa");
    80001660:	00005517          	auipc	a0,0x5
    80001664:	a1050513          	addi	a0,a0,-1520 # 80006070 <kvmincrease+0xc50>
    80001668:	00000097          	auipc	ra,0x0
    8000166c:	6ec080e7          	jalr	1772(ra) # 80001d54 <_Z11printStringPKc>
                break;
    80001670:	f91ff06f          	j	80001600 <_ZN5Riscv23interruptRoutineHandlerEv+0x1b8>

0000000080001674 <_ZN7_thread5yieldEv>:
#include "../h/_thread.hpp"
#include "../h/riscv.hpp"

_thread* _thread::running = nullptr;

void _thread::yield(){
    80001674:	ff010113          	addi	sp,sp,-16
    80001678:	00813423          	sd	s0,8(sp)
    8000167c:	01010413          	addi	s0,sp,16
    uint64 fcode = 0x13;
    asm volatile("mv a0, %0" : : "r" (fcode));  //a0 <- 13
    80001680:	01300793          	li	a5,19
    80001684:	00078513          	mv	a0,a5
    asm volatile("ecall");
    80001688:	00000073          	ecall
}
    8000168c:	00813403          	ld	s0,8(sp)
    80001690:	01010113          	addi	sp,sp,16
    80001694:	00008067          	ret

0000000080001698 <_ZN7_thread13threadWrapperEv>:
    delete _thread::running;
    _thread::yield();
    return 0;
}

void _thread::threadWrapper() {
    80001698:	fe010113          	addi	sp,sp,-32
    8000169c:	00113c23          	sd	ra,24(sp)
    800016a0:	00813823          	sd	s0,16(sp)
    800016a4:	00913423          	sd	s1,8(sp)
    800016a8:	02010413          	addi	s0,sp,32
    Riscv::popSppSpie();
    800016ac:	00000097          	auipc	ra,0x0
    800016b0:	d7c080e7          	jalr	-644(ra) # 80001428 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    800016b4:	00006497          	auipc	s1,0x6
    800016b8:	a9c48493          	addi	s1,s1,-1380 # 80007150 <_ZN7_thread7runningE>
    800016bc:	0004b783          	ld	a5,0(s1)
    800016c0:	0007b703          	ld	a4,0(a5)
    800016c4:	0207b503          	ld	a0,32(a5)
    800016c8:	000700e7          	jalr	a4
    running->setFinished(true);//kada se sve zavrsi postavi da je kraj
    800016cc:	0004b783          	ld	a5,0(s1)

    ~_thread() {delete[] stack;}

    bool isFinished() const { return finished; }

    void setFinished(bool fin) { _thread::finished = fin; }
    800016d0:	00100713          	li	a4,1
    800016d4:	02e78423          	sb	a4,40(a5)
    _thread::yield();
    800016d8:	00000097          	auipc	ra,0x0
    800016dc:	f9c080e7          	jalr	-100(ra) # 80001674 <_ZN7_thread5yieldEv>
}
    800016e0:	01813083          	ld	ra,24(sp)
    800016e4:	01013403          	ld	s0,16(sp)
    800016e8:	00813483          	ld	s1,8(sp)
    800016ec:	02010113          	addi	sp,sp,32
    800016f0:	00008067          	ret

00000000800016f4 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_>:
int _thread::create_thread(thread_t* handle, Body body, void* arg, void* stack_space){
    800016f4:	fc010113          	addi	sp,sp,-64
    800016f8:	02113c23          	sd	ra,56(sp)
    800016fc:	02813823          	sd	s0,48(sp)
    80001700:	02913423          	sd	s1,40(sp)
    80001704:	03213023          	sd	s2,32(sp)
    80001708:	01313c23          	sd	s3,24(sp)
    8000170c:	01413823          	sd	s4,16(sp)
    80001710:	01513423          	sd	s5,8(sp)
    80001714:	04010413          	addi	s0,sp,64
    80001718:	00050a13          	mv	s4,a0
    8000171c:	00058993          	mv	s3,a1
    80001720:	00060a93          	mv	s5,a2
    80001724:	00068913          	mv	s2,a3
    *handle = new _thread(body, arg, stack_space);
    80001728:	03000513          	li	a0,48
    8000172c:	00000097          	auipc	ra,0x0
    80001730:	b14080e7          	jalr	-1260(ra) # 80001240 <_Znwm>
    80001734:	00050493          	mv	s1,a0
            (uint64) &threadWrapper,//uvek izvrsavanje krece od tredVrepera kada zapocne neka nit
                                        // da se izvrsava treba da krene u kontekst svicu, tako sto se u ra umesto pocetka funkcije upisuje adresa threadWrapera
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
        }),
        arg(arg),
        finished(false) {
    80001738:	01353023          	sd	s3,0(a0)
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    8000173c:	04098063          	beqz	s3,8000177c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x88>
        finished(false) {
    80001740:	0124b423          	sd	s2,8(s1)
    80001744:	00000797          	auipc	a5,0x0
    80001748:	f5478793          	addi	a5,a5,-172 # 80001698 <_ZN7_thread13threadWrapperEv>
    8000174c:	00f4b823          	sd	a5,16(s1)
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001750:	02090a63          	beqz	s2,80001784 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x90>
    80001754:	000086b7          	lui	a3,0x8
    80001758:	00d90933          	add	s2,s2,a3
        finished(false) {
    8000175c:	0124bc23          	sd	s2,24(s1)
    80001760:	0354b023          	sd	s5,32(s1)
    80001764:	02048423          	sb	zero,40(s1)
        if (body != nullptr) { Scheduler::put(this); } //zbog maina da ne bi opet ubaciovao u skedzuler i ovde i prvi kontekst svicu kad svakako
    80001768:	02098263          	beqz	s3,8000178c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
    8000176c:	00048513          	mv	a0,s1
    80001770:	00000097          	auipc	ra,0x0
    80001774:	c18080e7          	jalr	-1000(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    80001778:	0140006f          	j	8000178c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x98>
        stack(static_cast<uint64 *>(body != nullptr ? stack_space : nullptr)),
    8000177c:	00000913          	li	s2,0
    80001780:	fc1ff06f          	j	80001740 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x4c>
            stack != nullptr ? (uint64) &stack[DEFAULT_STACK_SIZE] : 0
    80001784:	00000913          	li	s2,0
    80001788:	fd5ff06f          	j	8000175c <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0x68>
    8000178c:	009a3023          	sd	s1,0(s4)
    if(*handle != nullptr) return 0;//mozda treba !=nullptr
    80001790:	02048663          	beqz	s1,800017bc <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xc8>
    80001794:	00000513          	li	a0,0
}
    80001798:	03813083          	ld	ra,56(sp)
    8000179c:	03013403          	ld	s0,48(sp)
    800017a0:	02813483          	ld	s1,40(sp)
    800017a4:	02013903          	ld	s2,32(sp)
    800017a8:	01813983          	ld	s3,24(sp)
    800017ac:	01013a03          	ld	s4,16(sp)
    800017b0:	00813a83          	ld	s5,8(sp)
    800017b4:	04010113          	addi	sp,sp,64
    800017b8:	00008067          	ret
    return -1;
    800017bc:	fff00513          	li	a0,-1
    800017c0:	fd9ff06f          	j	80001798 <_ZN7_thread13create_threadEPPS_PFvPvES2_S2_+0xa4>
    800017c4:	00050913          	mv	s2,a0
    *handle = new _thread(body, arg, stack_space);
    800017c8:	00048513          	mv	a0,s1
    800017cc:	00000097          	auipc	ra,0x0
    800017d0:	ac4080e7          	jalr	-1340(ra) # 80001290 <_ZdlPv>
    800017d4:	00090513          	mv	a0,s2
    800017d8:	00007097          	auipc	ra,0x7
    800017dc:	ab0080e7          	jalr	-1360(ra) # 80008288 <_Unwind_Resume>

00000000800017e0 <_ZN7_thread15thread_dispatchEv>:
void _thread::thread_dispatch(){
    800017e0:	fe010113          	addi	sp,sp,-32
    800017e4:	00113c23          	sd	ra,24(sp)
    800017e8:	00813823          	sd	s0,16(sp)
    800017ec:	00913423          	sd	s1,8(sp)
    800017f0:	02010413          	addi	s0,sp,32
    _thread *old = running;
    800017f4:	00006497          	auipc	s1,0x6
    800017f8:	95c4b483          	ld	s1,-1700(s1) # 80007150 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    800017fc:	0284c783          	lbu	a5,40(s1)
    if(!old->isFinished()){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001800:	02078c63          	beqz	a5,80001838 <_ZN7_thread15thread_dispatchEv+0x58>
    running = Scheduler::get();
    80001804:	00000097          	auipc	ra,0x0
    80001808:	b1c080e7          	jalr	-1252(ra) # 80001320 <_ZN9Scheduler3getEv>
    8000180c:	00006797          	auipc	a5,0x6
    80001810:	94a7b223          	sd	a0,-1724(a5) # 80007150 <_ZN7_thread7runningE>
    _thread::contextSwitch(&old->context, &running->context);
    80001814:	01050593          	addi	a1,a0,16
    80001818:	01048513          	addi	a0,s1,16
    8000181c:	00000097          	auipc	ra,0x0
    80001820:	8fc080e7          	jalr	-1796(ra) # 80001118 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    80001824:	01813083          	ld	ra,24(sp)
    80001828:	01013403          	ld	s0,16(sp)
    8000182c:	00813483          	ld	s1,8(sp)
    80001830:	02010113          	addi	sp,sp,32
    80001834:	00008067          	ret
    if(!old->isFinished()){ Scheduler::put(old);}//ako se menja a nije gotova stavljam u skedzuler
    80001838:	00048513          	mv	a0,s1
    8000183c:	00000097          	auipc	ra,0x0
    80001840:	b4c080e7          	jalr	-1204(ra) # 80001388 <_ZN9Scheduler3putEP7_thread>
    80001844:	fc1ff06f          	j	80001804 <_ZN7_thread15thread_dispatchEv+0x24>

0000000080001848 <_ZN7_thread11thread_exitEv>:
int _thread::thread_exit() {
    80001848:	fe010113          	addi	sp,sp,-32
    8000184c:	00113c23          	sd	ra,24(sp)
    80001850:	00813823          	sd	s0,16(sp)
    80001854:	00913423          	sd	s1,8(sp)
    80001858:	02010413          	addi	s0,sp,32
    _thread::running->setFinished(true);
    8000185c:	00006497          	auipc	s1,0x6
    80001860:	8f44b483          	ld	s1,-1804(s1) # 80007150 <_ZN7_thread7runningE>
    void setFinished(bool fin) { _thread::finished = fin; }
    80001864:	00100793          	li	a5,1
    80001868:	02f48423          	sb	a5,40(s1)
    delete _thread::running;
    8000186c:	02048063          	beqz	s1,8000188c <_ZN7_thread11thread_exitEv+0x44>
    ~_thread() {delete[] stack;}
    80001870:	0084b503          	ld	a0,8(s1)
    80001874:	00050663          	beqz	a0,80001880 <_ZN7_thread11thread_exitEv+0x38>
    80001878:	00000097          	auipc	ra,0x0
    8000187c:	a40080e7          	jalr	-1472(ra) # 800012b8 <_ZdaPv>
    80001880:	00048513          	mv	a0,s1
    80001884:	00000097          	auipc	ra,0x0
    80001888:	a0c080e7          	jalr	-1524(ra) # 80001290 <_ZdlPv>
    _thread::yield();
    8000188c:	00000097          	auipc	ra,0x0
    80001890:	de8080e7          	jalr	-536(ra) # 80001674 <_ZN7_thread5yieldEv>
}
    80001894:	00000513          	li	a0,0
    80001898:	01813083          	ld	ra,24(sp)
    8000189c:	01013403          	ld	s0,16(sp)
    800018a0:	00813483          	ld	s1,8(sp)
    800018a4:	02010113          	addi	sp,sp,32
    800018a8:	00008067          	ret

00000000800018ac <_Z8userMainv>:
#include "../test/ConsumerProducer_CPP_API_test.hpp"
#include "System_Mode_test.hpp"

#endif

void userMain() {
    800018ac:	fe010113          	addi	sp,sp,-32
    800018b0:	00113c23          	sd	ra,24(sp)
    800018b4:	00813823          	sd	s0,16(sp)
    800018b8:	00913423          	sd	s1,8(sp)
    800018bc:	01213023          	sd	s2,0(sp)
    800018c0:	02010413          	addi	s0,sp,32
    printString("Unesite broj testa? [1-7]\n");
    800018c4:	00004517          	auipc	a0,0x4
    800018c8:	7d450513          	addi	a0,a0,2004 # 80006098 <kvmincrease+0xc78>
    800018cc:	00000097          	auipc	ra,0x0
    800018d0:	488080e7          	jalr	1160(ra) # 80001d54 <_Z11printStringPKc>
    int test = getc() - '0';
    800018d4:	00000097          	auipc	ra,0x0
    800018d8:	434080e7          	jalr	1076(ra) # 80001d08 <_Z4getcv>
    800018dc:	0005091b          	sext.w	s2,a0
    800018e0:	fd05049b          	addiw	s1,a0,-48
    getc(); // Enter posle broja
    800018e4:	00000097          	auipc	ra,0x0
    800018e8:	424080e7          	jalr	1060(ra) # 80001d08 <_Z4getcv>
            printString("Nije navedeno da je zadatak 2 implementiran\n");
            return;
        }
    }

    if (test >= 3 && test <= 4) {
    800018ec:	fcd9071b          	addiw	a4,s2,-51
    800018f0:	00100793          	li	a5,1
    800018f4:	04e7f663          	bgeu	a5,a4,80001940 <_Z8userMainv+0x94>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
            return;
        }
    }

    if (test >= 5 && test <= 6) {
    800018f8:	fcb9091b          	addiw	s2,s2,-53
    800018fc:	00100793          	li	a5,1
    80001900:	0727f463          	bgeu	a5,s2,80001968 <_Z8userMainv+0xbc>
            printString("Nije navedeno da je zadatak 4 implementiran\n");
            return;
        }
    }

    switch (test) {
    80001904:	00600793          	li	a5,6
    80001908:	0697ca63          	blt	a5,s1,8000197c <_Z8userMainv+0xd0>
    8000190c:	00300793          	li	a5,3
    80001910:	04f4d063          	bge	s1,a5,80001950 <_Z8userMainv+0xa4>
    80001914:	00100793          	li	a5,1
    80001918:	08f48863          	beq	s1,a5,800019a8 <_Z8userMainv+0xfc>
    8000191c:	00200793          	li	a5,2
    80001920:	0af49263          	bne	s1,a5,800019c4 <_Z8userMainv+0x118>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
#endif
            break;
        case 2:
#if LEVEL_2_IMPLEMENTED == 1
            Threads_CPP_API_test();
    80001924:	00001097          	auipc	ra,0x1
    80001928:	1b4080e7          	jalr	436(ra) # 80002ad8 <_Z20Threads_CPP_API_testv>
            printString("TEST 2 (zadatak 2., niti CPP API i sinhrona promena konteksta)\n");
    8000192c:	00005517          	auipc	a0,0x5
    80001930:	82c50513          	addi	a0,a0,-2004 # 80006158 <kvmincrease+0xd38>
    80001934:	00000097          	auipc	ra,0x0
    80001938:	420080e7          	jalr	1056(ra) # 80001d54 <_Z11printStringPKc>
#endif
            break;
    8000193c:	0140006f          	j	80001950 <_Z8userMainv+0xa4>
            printString("Nije navedeno da je zadatak 3 implementiran\n");
    80001940:	00004517          	auipc	a0,0x4
    80001944:	77850513          	addi	a0,a0,1912 # 800060b8 <kvmincrease+0xc98>
    80001948:	00000097          	auipc	ra,0x0
    8000194c:	40c080e7          	jalr	1036(ra) # 80001d54 <_Z11printStringPKc>
#endif
            break;
        default:
            printString("Niste uneli odgovarajuci broj za test\n");
    }
}
    80001950:	01813083          	ld	ra,24(sp)
    80001954:	01013403          	ld	s0,16(sp)
    80001958:	00813483          	ld	s1,8(sp)
    8000195c:	00013903          	ld	s2,0(sp)
    80001960:	02010113          	addi	sp,sp,32
    80001964:	00008067          	ret
            printString("Nije navedeno da je zadatak 4 implementiran\n");
    80001968:	00004517          	auipc	a0,0x4
    8000196c:	78050513          	addi	a0,a0,1920 # 800060e8 <kvmincrease+0xcc8>
    80001970:	00000097          	auipc	ra,0x0
    80001974:	3e4080e7          	jalr	996(ra) # 80001d54 <_Z11printStringPKc>
            return;
    80001978:	fd9ff06f          	j	80001950 <_Z8userMainv+0xa4>
    switch (test) {
    8000197c:	00700793          	li	a5,7
    80001980:	04f49263          	bne	s1,a5,800019c4 <_Z8userMainv+0x118>
            printString("Test se nije uspesno zavrsio\n");
    80001984:	00005517          	auipc	a0,0x5
    80001988:	81450513          	addi	a0,a0,-2028 # 80006198 <kvmincrease+0xd78>
    8000198c:	00000097          	auipc	ra,0x0
    80001990:	3c8080e7          	jalr	968(ra) # 80001d54 <_Z11printStringPKc>
            printString("TEST 7 (zadatak 2., testiranje da li se korisnicki kod izvrsava u korisnickom rezimu)\n");
    80001994:	00005517          	auipc	a0,0x5
    80001998:	82450513          	addi	a0,a0,-2012 # 800061b8 <kvmincrease+0xd98>
    8000199c:	00000097          	auipc	ra,0x0
    800019a0:	3b8080e7          	jalr	952(ra) # 80001d54 <_Z11printStringPKc>
            break;
    800019a4:	fadff06f          	j	80001950 <_Z8userMainv+0xa4>
            Threads_C_API_test();
    800019a8:	00001097          	auipc	ra,0x1
    800019ac:	b58080e7          	jalr	-1192(ra) # 80002500 <_Z18Threads_C_API_testv>
            printString("TEST 1 (zadatak 2, niti C API i sinhrona promena konteksta)\n");
    800019b0:	00004517          	auipc	a0,0x4
    800019b4:	76850513          	addi	a0,a0,1896 # 80006118 <kvmincrease+0xcf8>
    800019b8:	00000097          	auipc	ra,0x0
    800019bc:	39c080e7          	jalr	924(ra) # 80001d54 <_Z11printStringPKc>
            break;
    800019c0:	f91ff06f          	j	80001950 <_Z8userMainv+0xa4>
            printString("Niste uneli odgovarajuci broj za test\n");
    800019c4:	00005517          	auipc	a0,0x5
    800019c8:	84c50513          	addi	a0,a0,-1972 # 80006210 <kvmincrease+0xdf0>
    800019cc:	00000097          	auipc	ra,0x0
    800019d0:	388080e7          	jalr	904(ra) # 80001d54 <_Z11printStringPKc>
    800019d4:	f7dff06f          	j	80001950 <_Z8userMainv+0xa4>

00000000800019d8 <_Z2faPv>:

void fa(void*){
    800019d8:	fe010113          	addi	sp,sp,-32
    800019dc:	00113c23          	sd	ra,24(sp)
    800019e0:	00813823          	sd	s0,16(sp)
    800019e4:	00913423          	sd	s1,8(sp)
    800019e8:	02010413          	addi	s0,sp,32
    //running je nitA
    //threadJoin(nitB);
    for(int i=0;i<10;i++){
    800019ec:	00000493          	li	s1,0
    800019f0:	00900793          	li	a5,9
    800019f4:	0097ce63          	blt	a5,s1,80001a10 <_Z2faPv+0x38>
        printString("A\n");
    800019f8:	00005517          	auipc	a0,0x5
    800019fc:	84050513          	addi	a0,a0,-1984 # 80006238 <kvmincrease+0xe18>
    80001a00:	00000097          	auipc	ra,0x0
    80001a04:	354080e7          	jalr	852(ra) # 80001d54 <_Z11printStringPKc>
    for(int i=0;i<10;i++){
    80001a08:	0014849b          	addiw	s1,s1,1
    80001a0c:	fe5ff06f          	j	800019f0 <_Z2faPv+0x18>

    }
    printString("\n");
    80001a10:	00005517          	auipc	a0,0x5
    80001a14:	b4050513          	addi	a0,a0,-1216 # 80006550 <_ZTV7WorkerD+0x138>
    80001a18:	00000097          	auipc	ra,0x0
    80001a1c:	33c080e7          	jalr	828(ra) # 80001d54 <_Z11printStringPKc>
    void setFinished(bool fin) { _thread::finished = fin; }
    80001a20:	00005797          	auipc	a5,0x5
    80001a24:	7307b783          	ld	a5,1840(a5) # 80007150 <_ZN7_thread7runningE>
    80001a28:	00100713          	li	a4,1
    80001a2c:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    80001a30:	00000097          	auipc	ra,0x0
    80001a34:	290080e7          	jalr	656(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    80001a38:	01813083          	ld	ra,24(sp)
    80001a3c:	01013403          	ld	s0,16(sp)
    80001a40:	00813483          	ld	s1,8(sp)
    80001a44:	02010113          	addi	sp,sp,32
    80001a48:	00008067          	ret

0000000080001a4c <_Z2fbPv>:

void fb(void*){
    80001a4c:	fe010113          	addi	sp,sp,-32
    80001a50:	00113c23          	sd	ra,24(sp)
    80001a54:	00813823          	sd	s0,16(sp)
    80001a58:	00913423          	sd	s1,8(sp)
    80001a5c:	02010413          	addi	s0,sp,32
    //threadJoin(nitC);
    for(int i=0;i<10;i++){
    80001a60:	00000493          	li	s1,0
    80001a64:	00900793          	li	a5,9
    80001a68:	0097ce63          	blt	a5,s1,80001a84 <_Z2fbPv+0x38>
        printString("B\n");
    80001a6c:	00004517          	auipc	a0,0x4
    80001a70:	7d450513          	addi	a0,a0,2004 # 80006240 <kvmincrease+0xe20>
    80001a74:	00000097          	auipc	ra,0x0
    80001a78:	2e0080e7          	jalr	736(ra) # 80001d54 <_Z11printStringPKc>
    for(int i=0;i<10;i++){
    80001a7c:	0014849b          	addiw	s1,s1,1
    80001a80:	fe5ff06f          	j	80001a64 <_Z2fbPv+0x18>

    }
    printString("\n");
    80001a84:	00005517          	auipc	a0,0x5
    80001a88:	acc50513          	addi	a0,a0,-1332 # 80006550 <_ZTV7WorkerD+0x138>
    80001a8c:	00000097          	auipc	ra,0x0
    80001a90:	2c8080e7          	jalr	712(ra) # 80001d54 <_Z11printStringPKc>
    80001a94:	00005797          	auipc	a5,0x5
    80001a98:	6bc7b783          	ld	a5,1724(a5) # 80007150 <_ZN7_thread7runningE>
    80001a9c:	00100713          	li	a4,1
    80001aa0:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    80001aa4:	00000097          	auipc	ra,0x0
    80001aa8:	21c080e7          	jalr	540(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    80001aac:	01813083          	ld	ra,24(sp)
    80001ab0:	01013403          	ld	s0,16(sp)
    80001ab4:	00813483          	ld	s1,8(sp)
    80001ab8:	02010113          	addi	sp,sp,32
    80001abc:	00008067          	ret

0000000080001ac0 <_Z2fcPv>:

void fc(void*){
    80001ac0:	fe010113          	addi	sp,sp,-32
    80001ac4:	00113c23          	sd	ra,24(sp)
    80001ac8:	00813823          	sd	s0,16(sp)
    80001acc:	00913423          	sd	s1,8(sp)
    80001ad0:	02010413          	addi	s0,sp,32
    for(int i=0;i<10;i++){
    80001ad4:	00000493          	li	s1,0
    80001ad8:	00900793          	li	a5,9
    80001adc:	0097ce63          	blt	a5,s1,80001af8 <_Z2fcPv+0x38>
        printString("C\n");
    80001ae0:	00004517          	auipc	a0,0x4
    80001ae4:	76850513          	addi	a0,a0,1896 # 80006248 <kvmincrease+0xe28>
    80001ae8:	00000097          	auipc	ra,0x0
    80001aec:	26c080e7          	jalr	620(ra) # 80001d54 <_Z11printStringPKc>
    for(int i=0;i<10;i++){
    80001af0:	0014849b          	addiw	s1,s1,1
    80001af4:	fe5ff06f          	j	80001ad8 <_Z2fcPv+0x18>

    }
    printString("\n");
    80001af8:	00005517          	auipc	a0,0x5
    80001afc:	a5850513          	addi	a0,a0,-1448 # 80006550 <_ZTV7WorkerD+0x138>
    80001b00:	00000097          	auipc	ra,0x0
    80001b04:	254080e7          	jalr	596(ra) # 80001d54 <_Z11printStringPKc>
    80001b08:	00005797          	auipc	a5,0x5
    80001b0c:	6487b783          	ld	a5,1608(a5) # 80007150 <_ZN7_thread7runningE>
    80001b10:	00100713          	li	a4,1
    80001b14:	02e78423          	sb	a4,40(a5)

    _thread::running->setFinished(true);
    thread_dispatch();
    80001b18:	00000097          	auipc	ra,0x0
    80001b1c:	1a8080e7          	jalr	424(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    80001b20:	01813083          	ld	ra,24(sp)
    80001b24:	01013403          	ld	s0,16(sp)
    80001b28:	00813483          	ld	s1,8(sp)
    80001b2c:	02010113          	addi	sp,sp,32
    80001b30:	00008067          	ret

0000000080001b34 <_Z7wrapperPv>:



void wrapper(void* arg){
    80001b34:	ff010113          	addi	sp,sp,-16
    80001b38:	00113423          	sd	ra,8(sp)
    80001b3c:	00813023          	sd	s0,0(sp)
    80001b40:	01010413          	addi	s0,sp,16
    thread_create(&nitA, fa, nullptr);
    80001b44:	00000613          	li	a2,0
    80001b48:	00000597          	auipc	a1,0x0
    80001b4c:	e9058593          	addi	a1,a1,-368 # 800019d8 <_Z2faPv>
    80001b50:	00005517          	auipc	a0,0x5
    80001b54:	61850513          	addi	a0,a0,1560 # 80007168 <nitA>
    80001b58:	00000097          	auipc	ra,0x0
    80001b5c:	134080e7          	jalr	308(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    thread_create(&nitB, fb, nullptr);
    80001b60:	00000613          	li	a2,0
    80001b64:	00000597          	auipc	a1,0x0
    80001b68:	ee858593          	addi	a1,a1,-280 # 80001a4c <_Z2fbPv>
    80001b6c:	00005517          	auipc	a0,0x5
    80001b70:	5f450513          	addi	a0,a0,1524 # 80007160 <nitB>
    80001b74:	00000097          	auipc	ra,0x0
    80001b78:	118080e7          	jalr	280(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    thread_create(&nitC, fc, nullptr);
    80001b7c:	00000613          	li	a2,0
    80001b80:	00000597          	auipc	a1,0x0
    80001b84:	f4058593          	addi	a1,a1,-192 # 80001ac0 <_Z2fcPv>
    80001b88:	00005517          	auipc	a0,0x5
    80001b8c:	5d050513          	addi	a0,a0,1488 # 80007158 <nitC>
    80001b90:	00000097          	auipc	ra,0x0
    80001b94:	0fc080e7          	jalr	252(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    80001b98:	00c0006f          	j	80001ba4 <_Z7wrapperPv+0x70>

    while(!nitA->isFinished() || !nitB->isFinished() || !nitC->isFinished()){
        thread_dispatch();
    80001b9c:	00000097          	auipc	ra,0x0
    80001ba0:	124080e7          	jalr	292(ra) # 80001cc0 <_Z15thread_dispatchv>
    while(!nitA->isFinished() || !nitB->isFinished() || !nitC->isFinished()){
    80001ba4:	00005797          	auipc	a5,0x5
    80001ba8:	5c47b783          	ld	a5,1476(a5) # 80007168 <nitA>
    bool isFinished() const { return finished; }
    80001bac:	0287c783          	lbu	a5,40(a5)
    80001bb0:	fe0786e3          	beqz	a5,80001b9c <_Z7wrapperPv+0x68>
    80001bb4:	00005797          	auipc	a5,0x5
    80001bb8:	5ac7b783          	ld	a5,1452(a5) # 80007160 <nitB>
    80001bbc:	0287c783          	lbu	a5,40(a5)
    80001bc0:	fc078ee3          	beqz	a5,80001b9c <_Z7wrapperPv+0x68>
    80001bc4:	00005797          	auipc	a5,0x5
    80001bc8:	5947b783          	ld	a5,1428(a5) # 80007158 <nitC>
    80001bcc:	0287c783          	lbu	a5,40(a5)
    80001bd0:	fc0786e3          	beqz	a5,80001b9c <_Z7wrapperPv+0x68>
    }

    printString("ZAVRSENA JE WRAPPER FJA\n");
    80001bd4:	00004517          	auipc	a0,0x4
    80001bd8:	67c50513          	addi	a0,a0,1660 # 80006250 <kvmincrease+0xe30>
    80001bdc:	00000097          	auipc	ra,0x0
    80001be0:	178080e7          	jalr	376(ra) # 80001d54 <_Z11printStringPKc>
    void setFinished(bool fin) { _thread::finished = fin; }
    80001be4:	00005797          	auipc	a5,0x5
    80001be8:	56c7b783          	ld	a5,1388(a5) # 80007150 <_ZN7_thread7runningE>
    80001bec:	00100713          	li	a4,1
    80001bf0:	02e78423          	sb	a4,40(a5)
    _thread::running->setFinished(true);
    thread_dispatch();
    80001bf4:	00000097          	auipc	ra,0x0
    80001bf8:	0cc080e7          	jalr	204(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    80001bfc:	00813083          	ld	ra,8(sp)
    80001c00:	00013403          	ld	s0,0(sp)
    80001c04:	01010113          	addi	sp,sp,16
    80001c08:	00008067          	ret

0000000080001c0c <main>:

int main()
{
    80001c0c:	fe010113          	addi	sp,sp,-32
    80001c10:	00113c23          	sd	ra,24(sp)
    80001c14:	00813823          	sd	s0,16(sp)
    80001c18:	02010413          	addi	s0,sp,32
    Riscv::w_stvec((uint64) &Riscv::interruptRoutine);    //upisuje adresu prekidne rutine
    80001c1c:	fffff797          	auipc	a5,0xfffff
    80001c20:	51478793          	addi	a5,a5,1300 # 80001130 <_ZN5Riscv16interruptRoutineEv>
    __asm__ volatile ("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    80001c24:	10579073          	csrw	stvec,a5
    //Riscv: :ms_sstatus (Riscv:: SSTATUS_SIE);
    thread_t thread1;
    //idle nit(nit koja nema fju koja treba da izvrsava)
    thread_create(&thread1, nullptr, nullptr);
    80001c28:	00000613          	li	a2,0
    80001c2c:	00000593          	li	a1,0
    80001c30:	fe840513          	addi	a0,s0,-24
    80001c34:	00000097          	auipc	ra,0x0
    80001c38:	058080e7          	jalr	88(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = thread1;
    80001c3c:	fe843783          	ld	a5,-24(s0)
    80001c40:	00005717          	auipc	a4,0x5
    80001c44:	50f73823          	sd	a5,1296(a4) # 80007150 <_ZN7_thread7runningE>

    thread_t thread2;
    thread_create(&thread2, reinterpret_cast<void (*)(void *)>(userMain), nullptr);
    80001c48:	00000613          	li	a2,0
    80001c4c:	00000597          	auipc	a1,0x0
    80001c50:	c6058593          	addi	a1,a1,-928 # 800018ac <_Z8userMainv>
    80001c54:	fe040513          	addi	a0,s0,-32
    80001c58:	00000097          	auipc	ra,0x0
    80001c5c:	034080e7          	jalr	52(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>

    while (!(thread2->isFinished())) {
    80001c60:	fe043783          	ld	a5,-32(s0)
    bool isFinished() const { return finished; }
    80001c64:	0287c783          	lbu	a5,40(a5)
    80001c68:	00079863          	bnez	a5,80001c78 <main+0x6c>
        thread_dispatch();
    80001c6c:	00000097          	auipc	ra,0x0
    80001c70:	054080e7          	jalr	84(ra) # 80001cc0 <_Z15thread_dispatchv>
    80001c74:	fedff06f          	j	80001c60 <main+0x54>
    }

    return 0;
}
    80001c78:	00000513          	li	a0,0
    80001c7c:	01813083          	ld	ra,24(sp)
    80001c80:	01013403          	ld	s0,16(sp)
    80001c84:	02010113          	addi	sp,sp,32
    80001c88:	00008067          	ret

0000000080001c8c <_Z13thread_createPP7_threadPFvPvES2_>:

#include "../lib/hw.h"
#include "../h/_thread.hpp"
#include "../lib/console.h"

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80001c8c:	ff010113          	addi	sp,sp,-16
    80001c90:	00813423          	sd	s0,8(sp)
    80001c94:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x11;
    __asm__ volatile("mv a3, %0" : : "r"(arg));
    80001c98:	00060693          	mv	a3,a2
    __asm__ volatile("mv a2, %0" : : "r"(start_routine));
    80001c9c:	00058613          	mv	a2,a1
    __asm__ volatile("mv a1, %0" : : "r"(handle));
    80001ca0:	00050593          	mv	a1,a0
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001ca4:	01100793          	li	a5,17
    80001ca8:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001cac:	00000073          	ecall
    return 0;
    //dodati promenljivu za povratnu vrednost
}
    80001cb0:	00000513          	li	a0,0
    80001cb4:	00813403          	ld	s0,8(sp)
    80001cb8:	01010113          	addi	sp,sp,16
    80001cbc:	00008067          	ret

0000000080001cc0 <_Z15thread_dispatchv>:

void thread_dispatch(){
    80001cc0:	ff010113          	addi	sp,sp,-16
    80001cc4:	00813423          	sd	s0,8(sp)
    80001cc8:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x13;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001ccc:	01300793          	li	a5,19
    80001cd0:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001cd4:	00000073          	ecall
}
    80001cd8:	00813403          	ld	s0,8(sp)
    80001cdc:	01010113          	addi	sp,sp,16
    80001ce0:	00008067          	ret

0000000080001ce4 <_Z11thread_exitv>:

void thread_exit(){
    80001ce4:	ff010113          	addi	sp,sp,-16
    80001ce8:	00813423          	sd	s0,8(sp)
    80001cec:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x12;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001cf0:	01200793          	li	a5,18
    80001cf4:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001cf8:	00000073          	ecall
    //dodati i ovde promenljivu
}
    80001cfc:	00813403          	ld	s0,8(sp)
    80001d00:	01010113          	addi	sp,sp,16
    80001d04:	00008067          	ret

0000000080001d08 <_Z4getcv>:

void getc(){
    80001d08:	ff010113          	addi	sp,sp,-16
    80001d0c:	00813423          	sd	s0,8(sp)
    80001d10:	01010413          	addi	s0,sp,16
    uint64 const fcode = 0x20;
    __asm__ volatile("mv a0, %0" : : "r"(fcode));
    80001d14:	02000793          	li	a5,32
    80001d18:	00078513          	mv	a0,a5
    __asm__ volatile("ecall");
    80001d1c:	00000073          	ecall
}
    80001d20:	00813403          	ld	s0,8(sp)
    80001d24:	01010113          	addi	sp,sp,16
    80001d28:	00008067          	ret

0000000080001d2c <_Z4putcc>:

void putc(char c){
    80001d2c:	ff010113          	addi	sp,sp,-16
    80001d30:	00113423          	sd	ra,8(sp)
    80001d34:	00813023          	sd	s0,0(sp)
    80001d38:	01010413          	addi	s0,sp,16
    __putc(c);
    80001d3c:	00003097          	auipc	ra,0x3
    80001d40:	5c4080e7          	jalr	1476(ra) # 80005300 <__putc>
    80001d44:	00813083          	ld	ra,8(sp)
    80001d48:	00013403          	ld	s0,0(sp)
    80001d4c:	01010113          	addi	sp,sp,16
    80001d50:	00008067          	ret

0000000080001d54 <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1)) thread_dispatch()
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80001d54:	fe010113          	addi	sp,sp,-32
    80001d58:	00113c23          	sd	ra,24(sp)
    80001d5c:	00813823          	sd	s0,16(sp)
    80001d60:	00913423          	sd	s1,8(sp)
    80001d64:	02010413          	addi	s0,sp,32
    80001d68:	00050493          	mv	s1,a0
    LOCK();
    80001d6c:	00100613          	li	a2,1
    80001d70:	00000593          	li	a1,0
    80001d74:	00005517          	auipc	a0,0x5
    80001d78:	3fc50513          	addi	a0,a0,1020 # 80007170 <lockPrint>
    80001d7c:	fffff097          	auipc	ra,0xfffff
    80001d80:	284080e7          	jalr	644(ra) # 80001000 <copy_and_swap>
    80001d84:	00050863          	beqz	a0,80001d94 <_Z11printStringPKc+0x40>
    80001d88:	00000097          	auipc	ra,0x0
    80001d8c:	f38080e7          	jalr	-200(ra) # 80001cc0 <_Z15thread_dispatchv>
    80001d90:	fddff06f          	j	80001d6c <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80001d94:	0004c503          	lbu	a0,0(s1)
    80001d98:	00050a63          	beqz	a0,80001dac <_Z11printStringPKc+0x58>
    {
        putc(*string);
    80001d9c:	00000097          	auipc	ra,0x0
    80001da0:	f90080e7          	jalr	-112(ra) # 80001d2c <_Z4putcc>
        string++;
    80001da4:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001da8:	fedff06f          	j	80001d94 <_Z11printStringPKc+0x40>
    }
    UNLOCK();
    80001dac:	00000613          	li	a2,0
    80001db0:	00100593          	li	a1,1
    80001db4:	00005517          	auipc	a0,0x5
    80001db8:	3bc50513          	addi	a0,a0,956 # 80007170 <lockPrint>
    80001dbc:	fffff097          	auipc	ra,0xfffff
    80001dc0:	244080e7          	jalr	580(ra) # 80001000 <copy_and_swap>
    80001dc4:	fe0514e3          	bnez	a0,80001dac <_Z11printStringPKc+0x58>
}
    80001dc8:	01813083          	ld	ra,24(sp)
    80001dcc:	01013403          	ld	s0,16(sp)
    80001dd0:	00813483          	ld	s1,8(sp)
    80001dd4:	02010113          	addi	sp,sp,32
    80001dd8:	00008067          	ret

0000000080001ddc <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80001ddc:	fd010113          	addi	sp,sp,-48
    80001de0:	02113423          	sd	ra,40(sp)
    80001de4:	02813023          	sd	s0,32(sp)
    80001de8:	00913c23          	sd	s1,24(sp)
    80001dec:	01213823          	sd	s2,16(sp)
    80001df0:	01313423          	sd	s3,8(sp)
    80001df4:	01413023          	sd	s4,0(sp)
    80001df8:	03010413          	addi	s0,sp,48
    80001dfc:	00050993          	mv	s3,a0
    80001e00:	00058a13          	mv	s4,a1
    LOCK();
    80001e04:	00100613          	li	a2,1
    80001e08:	00000593          	li	a1,0
    80001e0c:	00005517          	auipc	a0,0x5
    80001e10:	36450513          	addi	a0,a0,868 # 80007170 <lockPrint>
    80001e14:	fffff097          	auipc	ra,0xfffff
    80001e18:	1ec080e7          	jalr	492(ra) # 80001000 <copy_and_swap>
    80001e1c:	00050863          	beqz	a0,80001e2c <_Z9getStringPci+0x50>
    80001e20:	00000097          	auipc	ra,0x0
    80001e24:	ea0080e7          	jalr	-352(ra) # 80001cc0 <_Z15thread_dispatchv>
    80001e28:	fddff06f          	j	80001e04 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80001e2c:	00000913          	li	s2,0
    80001e30:	00090493          	mv	s1,s2
    80001e34:	0019091b          	addiw	s2,s2,1
    80001e38:	03495a63          	bge	s2,s4,80001e6c <_Z9getStringPci+0x90>
        cc = getc();
    80001e3c:	00000097          	auipc	ra,0x0
    80001e40:	ecc080e7          	jalr	-308(ra) # 80001d08 <_Z4getcv>
        if(cc < 1)
    80001e44:	02050463          	beqz	a0,80001e6c <_Z9getStringPci+0x90>
            break;
        c = cc;
        buf[i++] = c;
    80001e48:	009984b3          	add	s1,s3,s1
    80001e4c:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80001e50:	00a00793          	li	a5,10
    80001e54:	00f50a63          	beq	a0,a5,80001e68 <_Z9getStringPci+0x8c>
    80001e58:	00d00793          	li	a5,13
    80001e5c:	fcf51ae3          	bne	a0,a5,80001e30 <_Z9getStringPci+0x54>
        buf[i++] = c;
    80001e60:	00090493          	mv	s1,s2
    80001e64:	0080006f          	j	80001e6c <_Z9getStringPci+0x90>
    80001e68:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80001e6c:	009984b3          	add	s1,s3,s1
    80001e70:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80001e74:	00000613          	li	a2,0
    80001e78:	00100593          	li	a1,1
    80001e7c:	00005517          	auipc	a0,0x5
    80001e80:	2f450513          	addi	a0,a0,756 # 80007170 <lockPrint>
    80001e84:	fffff097          	auipc	ra,0xfffff
    80001e88:	17c080e7          	jalr	380(ra) # 80001000 <copy_and_swap>
    80001e8c:	fe0514e3          	bnez	a0,80001e74 <_Z9getStringPci+0x98>
    return buf;
}
    80001e90:	00098513          	mv	a0,s3
    80001e94:	02813083          	ld	ra,40(sp)
    80001e98:	02013403          	ld	s0,32(sp)
    80001e9c:	01813483          	ld	s1,24(sp)
    80001ea0:	01013903          	ld	s2,16(sp)
    80001ea4:	00813983          	ld	s3,8(sp)
    80001ea8:	00013a03          	ld	s4,0(sp)
    80001eac:	03010113          	addi	sp,sp,48
    80001eb0:	00008067          	ret

0000000080001eb4 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80001eb4:	ff010113          	addi	sp,sp,-16
    80001eb8:	00813423          	sd	s0,8(sp)
    80001ebc:	01010413          	addi	s0,sp,16
    80001ec0:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80001ec4:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80001ec8:	0006c603          	lbu	a2,0(a3) # 8000 <_entry-0x7fff8000>
    80001ecc:	fd06071b          	addiw	a4,a2,-48
    80001ed0:	0ff77713          	andi	a4,a4,255
    80001ed4:	00900793          	li	a5,9
    80001ed8:	02e7e063          	bltu	a5,a4,80001ef8 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80001edc:	0025179b          	slliw	a5,a0,0x2
    80001ee0:	00a787bb          	addw	a5,a5,a0
    80001ee4:	0017979b          	slliw	a5,a5,0x1
    80001ee8:	00168693          	addi	a3,a3,1
    80001eec:	00c787bb          	addw	a5,a5,a2
    80001ef0:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80001ef4:	fd5ff06f          	j	80001ec8 <_Z11stringToIntPKc+0x14>
    return n;
}
    80001ef8:	00813403          	ld	s0,8(sp)
    80001efc:	01010113          	addi	sp,sp,16
    80001f00:	00008067          	ret

0000000080001f04 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80001f04:	fc010113          	addi	sp,sp,-64
    80001f08:	02113c23          	sd	ra,56(sp)
    80001f0c:	02813823          	sd	s0,48(sp)
    80001f10:	02913423          	sd	s1,40(sp)
    80001f14:	03213023          	sd	s2,32(sp)
    80001f18:	01313c23          	sd	s3,24(sp)
    80001f1c:	04010413          	addi	s0,sp,64
    80001f20:	00050493          	mv	s1,a0
    80001f24:	00058913          	mv	s2,a1
    80001f28:	00060993          	mv	s3,a2
    LOCK();
    80001f2c:	00100613          	li	a2,1
    80001f30:	00000593          	li	a1,0
    80001f34:	00005517          	auipc	a0,0x5
    80001f38:	23c50513          	addi	a0,a0,572 # 80007170 <lockPrint>
    80001f3c:	fffff097          	auipc	ra,0xfffff
    80001f40:	0c4080e7          	jalr	196(ra) # 80001000 <copy_and_swap>
    80001f44:	00050863          	beqz	a0,80001f54 <_Z8printIntiii+0x50>
    80001f48:	00000097          	auipc	ra,0x0
    80001f4c:	d78080e7          	jalr	-648(ra) # 80001cc0 <_Z15thread_dispatchv>
    80001f50:	fddff06f          	j	80001f2c <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80001f54:	00098463          	beqz	s3,80001f5c <_Z8printIntiii+0x58>
    80001f58:	0804c463          	bltz	s1,80001fe0 <_Z8printIntiii+0xdc>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80001f5c:	0004851b          	sext.w	a0,s1
    neg = 0;
    80001f60:	00000593          	li	a1,0
    }

    i = 0;
    80001f64:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80001f68:	0009079b          	sext.w	a5,s2
    80001f6c:	0325773b          	remuw	a4,a0,s2
    80001f70:	00048613          	mv	a2,s1
    80001f74:	0014849b          	addiw	s1,s1,1
    80001f78:	02071693          	slli	a3,a4,0x20
    80001f7c:	0206d693          	srli	a3,a3,0x20
    80001f80:	00005717          	auipc	a4,0x5
    80001f84:	13070713          	addi	a4,a4,304 # 800070b0 <digits>
    80001f88:	00d70733          	add	a4,a4,a3
    80001f8c:	00074683          	lbu	a3,0(a4)
    80001f90:	fd040713          	addi	a4,s0,-48
    80001f94:	00c70733          	add	a4,a4,a2
    80001f98:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80001f9c:	0005071b          	sext.w	a4,a0
    80001fa0:	0325553b          	divuw	a0,a0,s2
    80001fa4:	fcf772e3          	bgeu	a4,a5,80001f68 <_Z8printIntiii+0x64>
    if(neg)
    80001fa8:	00058c63          	beqz	a1,80001fc0 <_Z8printIntiii+0xbc>
        buf[i++] = '-';
    80001fac:	fd040793          	addi	a5,s0,-48
    80001fb0:	009784b3          	add	s1,a5,s1
    80001fb4:	02d00793          	li	a5,45
    80001fb8:	fef48823          	sb	a5,-16(s1)
    80001fbc:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80001fc0:	fff4849b          	addiw	s1,s1,-1
    80001fc4:	0204c463          	bltz	s1,80001fec <_Z8printIntiii+0xe8>
        putc(buf[i]);
    80001fc8:	fd040793          	addi	a5,s0,-48
    80001fcc:	009787b3          	add	a5,a5,s1
    80001fd0:	ff07c503          	lbu	a0,-16(a5)
    80001fd4:	00000097          	auipc	ra,0x0
    80001fd8:	d58080e7          	jalr	-680(ra) # 80001d2c <_Z4putcc>
    80001fdc:	fe5ff06f          	j	80001fc0 <_Z8printIntiii+0xbc>
        x = -xx;
    80001fe0:	4090053b          	negw	a0,s1
        neg = 1;
    80001fe4:	00100593          	li	a1,1
        x = -xx;
    80001fe8:	f7dff06f          	j	80001f64 <_Z8printIntiii+0x60>

    UNLOCK();
    80001fec:	00000613          	li	a2,0
    80001ff0:	00100593          	li	a1,1
    80001ff4:	00005517          	auipc	a0,0x5
    80001ff8:	17c50513          	addi	a0,a0,380 # 80007170 <lockPrint>
    80001ffc:	fffff097          	auipc	ra,0xfffff
    80002000:	004080e7          	jalr	4(ra) # 80001000 <copy_and_swap>
    80002004:	fe0514e3          	bnez	a0,80001fec <_Z8printIntiii+0xe8>
    80002008:	03813083          	ld	ra,56(sp)
    8000200c:	03013403          	ld	s0,48(sp)
    80002010:	02813483          	ld	s1,40(sp)
    80002014:	02013903          	ld	s2,32(sp)
    80002018:	01813983          	ld	s3,24(sp)
    8000201c:	04010113          	addi	sp,sp,64
    80002020:	00008067          	ret

0000000080002024 <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    80002024:	fe010113          	addi	sp,sp,-32
    80002028:	00113c23          	sd	ra,24(sp)
    8000202c:	00813823          	sd	s0,16(sp)
    80002030:	00913423          	sd	s1,8(sp)
    80002034:	01213023          	sd	s2,0(sp)
    80002038:	02010413          	addi	s0,sp,32
    8000203c:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002040:	00100793          	li	a5,1
    80002044:	02a7f863          	bgeu	a5,a0,80002074 <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002048:	00a00793          	li	a5,10
    8000204c:	02f577b3          	remu	a5,a0,a5
    80002050:	02078e63          	beqz	a5,8000208c <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    80002054:	fff48513          	addi	a0,s1,-1
    80002058:	00000097          	auipc	ra,0x0
    8000205c:	fcc080e7          	jalr	-52(ra) # 80002024 <_ZL9fibonaccim>
    80002060:	00050913          	mv	s2,a0
    80002064:	ffe48513          	addi	a0,s1,-2
    80002068:	00000097          	auipc	ra,0x0
    8000206c:	fbc080e7          	jalr	-68(ra) # 80002024 <_ZL9fibonaccim>
    80002070:	00a90533          	add	a0,s2,a0
}
    80002074:	01813083          	ld	ra,24(sp)
    80002078:	01013403          	ld	s0,16(sp)
    8000207c:	00813483          	ld	s1,8(sp)
    80002080:	00013903          	ld	s2,0(sp)
    80002084:	02010113          	addi	sp,sp,32
    80002088:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    8000208c:	00000097          	auipc	ra,0x0
    80002090:	c34080e7          	jalr	-972(ra) # 80001cc0 <_Z15thread_dispatchv>
    80002094:	fc1ff06f          	j	80002054 <_ZL9fibonaccim+0x30>

0000000080002098 <_ZL11workerBodyDPv>:
    printString("A finished!\n");
    finishedC = true;
    thread_dispatch();
}

static void workerBodyD(void* arg) {
    80002098:	fe010113          	addi	sp,sp,-32
    8000209c:	00113c23          	sd	ra,24(sp)
    800020a0:	00813823          	sd	s0,16(sp)
    800020a4:	00913423          	sd	s1,8(sp)
    800020a8:	01213023          	sd	s2,0(sp)
    800020ac:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800020b0:	00a00493          	li	s1,10
    800020b4:	0400006f          	j	800020f4 <_ZL11workerBodyDPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800020b8:	00004517          	auipc	a0,0x4
    800020bc:	1b850513          	addi	a0,a0,440 # 80006270 <kvmincrease+0xe50>
    800020c0:	00000097          	auipc	ra,0x0
    800020c4:	c94080e7          	jalr	-876(ra) # 80001d54 <_Z11printStringPKc>
    800020c8:	00000613          	li	a2,0
    800020cc:	00a00593          	li	a1,10
    800020d0:	00048513          	mv	a0,s1
    800020d4:	00000097          	auipc	ra,0x0
    800020d8:	e30080e7          	jalr	-464(ra) # 80001f04 <_Z8printIntiii>
    800020dc:	00004517          	auipc	a0,0x4
    800020e0:	47450513          	addi	a0,a0,1140 # 80006550 <_ZTV7WorkerD+0x138>
    800020e4:	00000097          	auipc	ra,0x0
    800020e8:	c70080e7          	jalr	-912(ra) # 80001d54 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800020ec:	0014849b          	addiw	s1,s1,1
    800020f0:	0ff4f493          	andi	s1,s1,255
    800020f4:	00c00793          	li	a5,12
    800020f8:	fc97f0e3          	bgeu	a5,s1,800020b8 <_ZL11workerBodyDPv+0x20>
    }

    printString("D: dispatch\n");
    800020fc:	00004517          	auipc	a0,0x4
    80002100:	17c50513          	addi	a0,a0,380 # 80006278 <kvmincrease+0xe58>
    80002104:	00000097          	auipc	ra,0x0
    80002108:	c50080e7          	jalr	-944(ra) # 80001d54 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    8000210c:	00500313          	li	t1,5
    thread_dispatch();
    80002110:	00000097          	auipc	ra,0x0
    80002114:	bb0080e7          	jalr	-1104(ra) # 80001cc0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002118:	01000513          	li	a0,16
    8000211c:	00000097          	auipc	ra,0x0
    80002120:	f08080e7          	jalr	-248(ra) # 80002024 <_ZL9fibonaccim>
    80002124:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002128:	00004517          	auipc	a0,0x4
    8000212c:	16050513          	addi	a0,a0,352 # 80006288 <kvmincrease+0xe68>
    80002130:	00000097          	auipc	ra,0x0
    80002134:	c24080e7          	jalr	-988(ra) # 80001d54 <_Z11printStringPKc>
    80002138:	00000613          	li	a2,0
    8000213c:	00a00593          	li	a1,10
    80002140:	0009051b          	sext.w	a0,s2
    80002144:	00000097          	auipc	ra,0x0
    80002148:	dc0080e7          	jalr	-576(ra) # 80001f04 <_Z8printIntiii>
    8000214c:	00004517          	auipc	a0,0x4
    80002150:	40450513          	addi	a0,a0,1028 # 80006550 <_ZTV7WorkerD+0x138>
    80002154:	00000097          	auipc	ra,0x0
    80002158:	c00080e7          	jalr	-1024(ra) # 80001d54 <_Z11printStringPKc>
    8000215c:	0400006f          	j	8000219c <_ZL11workerBodyDPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002160:	00004517          	auipc	a0,0x4
    80002164:	11050513          	addi	a0,a0,272 # 80006270 <kvmincrease+0xe50>
    80002168:	00000097          	auipc	ra,0x0
    8000216c:	bec080e7          	jalr	-1044(ra) # 80001d54 <_Z11printStringPKc>
    80002170:	00000613          	li	a2,0
    80002174:	00a00593          	li	a1,10
    80002178:	00048513          	mv	a0,s1
    8000217c:	00000097          	auipc	ra,0x0
    80002180:	d88080e7          	jalr	-632(ra) # 80001f04 <_Z8printIntiii>
    80002184:	00004517          	auipc	a0,0x4
    80002188:	3cc50513          	addi	a0,a0,972 # 80006550 <_ZTV7WorkerD+0x138>
    8000218c:	00000097          	auipc	ra,0x0
    80002190:	bc8080e7          	jalr	-1080(ra) # 80001d54 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002194:	0014849b          	addiw	s1,s1,1
    80002198:	0ff4f493          	andi	s1,s1,255
    8000219c:	00f00793          	li	a5,15
    800021a0:	fc97f0e3          	bgeu	a5,s1,80002160 <_ZL11workerBodyDPv+0xc8>
    }

    printString("D finished!\n");
    800021a4:	00004517          	auipc	a0,0x4
    800021a8:	0f450513          	addi	a0,a0,244 # 80006298 <kvmincrease+0xe78>
    800021ac:	00000097          	auipc	ra,0x0
    800021b0:	ba8080e7          	jalr	-1112(ra) # 80001d54 <_Z11printStringPKc>
    finishedD = true;
    800021b4:	00100793          	li	a5,1
    800021b8:	00005717          	auipc	a4,0x5
    800021bc:	fcf70023          	sb	a5,-64(a4) # 80007178 <_ZL9finishedD>
    thread_dispatch();
    800021c0:	00000097          	auipc	ra,0x0
    800021c4:	b00080e7          	jalr	-1280(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    800021c8:	01813083          	ld	ra,24(sp)
    800021cc:	01013403          	ld	s0,16(sp)
    800021d0:	00813483          	ld	s1,8(sp)
    800021d4:	00013903          	ld	s2,0(sp)
    800021d8:	02010113          	addi	sp,sp,32
    800021dc:	00008067          	ret

00000000800021e0 <_ZL11workerBodyCPv>:
static void workerBodyC(void* arg) {
    800021e0:	fe010113          	addi	sp,sp,-32
    800021e4:	00113c23          	sd	ra,24(sp)
    800021e8:	00813823          	sd	s0,16(sp)
    800021ec:	00913423          	sd	s1,8(sp)
    800021f0:	01213023          	sd	s2,0(sp)
    800021f4:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    800021f8:	00000493          	li	s1,0
    800021fc:	0400006f          	j	8000223c <_ZL11workerBodyCPv+0x5c>
        printString("C: i="); printInt(i); printString("\n");
    80002200:	00004517          	auipc	a0,0x4
    80002204:	0a850513          	addi	a0,a0,168 # 800062a8 <kvmincrease+0xe88>
    80002208:	00000097          	auipc	ra,0x0
    8000220c:	b4c080e7          	jalr	-1204(ra) # 80001d54 <_Z11printStringPKc>
    80002210:	00000613          	li	a2,0
    80002214:	00a00593          	li	a1,10
    80002218:	00048513          	mv	a0,s1
    8000221c:	00000097          	auipc	ra,0x0
    80002220:	ce8080e7          	jalr	-792(ra) # 80001f04 <_Z8printIntiii>
    80002224:	00004517          	auipc	a0,0x4
    80002228:	32c50513          	addi	a0,a0,812 # 80006550 <_ZTV7WorkerD+0x138>
    8000222c:	00000097          	auipc	ra,0x0
    80002230:	b28080e7          	jalr	-1240(ra) # 80001d54 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002234:	0014849b          	addiw	s1,s1,1
    80002238:	0ff4f493          	andi	s1,s1,255
    8000223c:	00200793          	li	a5,2
    80002240:	fc97f0e3          	bgeu	a5,s1,80002200 <_ZL11workerBodyCPv+0x20>
    printString("C: dispatch\n");
    80002244:	00004517          	auipc	a0,0x4
    80002248:	06c50513          	addi	a0,a0,108 # 800062b0 <kvmincrease+0xe90>
    8000224c:	00000097          	auipc	ra,0x0
    80002250:	b08080e7          	jalr	-1272(ra) # 80001d54 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002254:	00700313          	li	t1,7
    thread_dispatch();
    80002258:	00000097          	auipc	ra,0x0
    8000225c:	a68080e7          	jalr	-1432(ra) # 80001cc0 <_Z15thread_dispatchv>
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002260:	00030913          	mv	s2,t1
    printString("C: t1="); printInt(t1); printString("\n");
    80002264:	00004517          	auipc	a0,0x4
    80002268:	05c50513          	addi	a0,a0,92 # 800062c0 <kvmincrease+0xea0>
    8000226c:	00000097          	auipc	ra,0x0
    80002270:	ae8080e7          	jalr	-1304(ra) # 80001d54 <_Z11printStringPKc>
    80002274:	00000613          	li	a2,0
    80002278:	00a00593          	li	a1,10
    8000227c:	0009051b          	sext.w	a0,s2
    80002280:	00000097          	auipc	ra,0x0
    80002284:	c84080e7          	jalr	-892(ra) # 80001f04 <_Z8printIntiii>
    80002288:	00004517          	auipc	a0,0x4
    8000228c:	2c850513          	addi	a0,a0,712 # 80006550 <_ZTV7WorkerD+0x138>
    80002290:	00000097          	auipc	ra,0x0
    80002294:	ac4080e7          	jalr	-1340(ra) # 80001d54 <_Z11printStringPKc>
    uint64 result = fibonacci(12);
    80002298:	00c00513          	li	a0,12
    8000229c:	00000097          	auipc	ra,0x0
    800022a0:	d88080e7          	jalr	-632(ra) # 80002024 <_ZL9fibonaccim>
    800022a4:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800022a8:	00004517          	auipc	a0,0x4
    800022ac:	02050513          	addi	a0,a0,32 # 800062c8 <kvmincrease+0xea8>
    800022b0:	00000097          	auipc	ra,0x0
    800022b4:	aa4080e7          	jalr	-1372(ra) # 80001d54 <_Z11printStringPKc>
    800022b8:	00000613          	li	a2,0
    800022bc:	00a00593          	li	a1,10
    800022c0:	0009051b          	sext.w	a0,s2
    800022c4:	00000097          	auipc	ra,0x0
    800022c8:	c40080e7          	jalr	-960(ra) # 80001f04 <_Z8printIntiii>
    800022cc:	00004517          	auipc	a0,0x4
    800022d0:	28450513          	addi	a0,a0,644 # 80006550 <_ZTV7WorkerD+0x138>
    800022d4:	00000097          	auipc	ra,0x0
    800022d8:	a80080e7          	jalr	-1408(ra) # 80001d54 <_Z11printStringPKc>
    800022dc:	0400006f          	j	8000231c <_ZL11workerBodyCPv+0x13c>
        printString("C: i="); printInt(i); printString("\n");
    800022e0:	00004517          	auipc	a0,0x4
    800022e4:	fc850513          	addi	a0,a0,-56 # 800062a8 <kvmincrease+0xe88>
    800022e8:	00000097          	auipc	ra,0x0
    800022ec:	a6c080e7          	jalr	-1428(ra) # 80001d54 <_Z11printStringPKc>
    800022f0:	00000613          	li	a2,0
    800022f4:	00a00593          	li	a1,10
    800022f8:	00048513          	mv	a0,s1
    800022fc:	00000097          	auipc	ra,0x0
    80002300:	c08080e7          	jalr	-1016(ra) # 80001f04 <_Z8printIntiii>
    80002304:	00004517          	auipc	a0,0x4
    80002308:	24c50513          	addi	a0,a0,588 # 80006550 <_ZTV7WorkerD+0x138>
    8000230c:	00000097          	auipc	ra,0x0
    80002310:	a48080e7          	jalr	-1464(ra) # 80001d54 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002314:	0014849b          	addiw	s1,s1,1
    80002318:	0ff4f493          	andi	s1,s1,255
    8000231c:	00500793          	li	a5,5
    80002320:	fc97f0e3          	bgeu	a5,s1,800022e0 <_ZL11workerBodyCPv+0x100>
    printString("A finished!\n");
    80002324:	00004517          	auipc	a0,0x4
    80002328:	fb450513          	addi	a0,a0,-76 # 800062d8 <kvmincrease+0xeb8>
    8000232c:	00000097          	auipc	ra,0x0
    80002330:	a28080e7          	jalr	-1496(ra) # 80001d54 <_Z11printStringPKc>
    finishedC = true;
    80002334:	00100793          	li	a5,1
    80002338:	00005717          	auipc	a4,0x5
    8000233c:	e4f700a3          	sb	a5,-447(a4) # 80007179 <_ZL9finishedC>
    thread_dispatch();
    80002340:	00000097          	auipc	ra,0x0
    80002344:	980080e7          	jalr	-1664(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    80002348:	01813083          	ld	ra,24(sp)
    8000234c:	01013403          	ld	s0,16(sp)
    80002350:	00813483          	ld	s1,8(sp)
    80002354:	00013903          	ld	s2,0(sp)
    80002358:	02010113          	addi	sp,sp,32
    8000235c:	00008067          	ret

0000000080002360 <_ZL11workerBodyBPv>:
static void workerBodyB(void* arg) {
    80002360:	fe010113          	addi	sp,sp,-32
    80002364:	00113c23          	sd	ra,24(sp)
    80002368:	00813823          	sd	s0,16(sp)
    8000236c:	00913423          	sd	s1,8(sp)
    80002370:	01213023          	sd	s2,0(sp)
    80002374:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002378:	00000913          	li	s2,0
    8000237c:	0380006f          	j	800023b4 <_ZL11workerBodyBPv+0x54>
            thread_dispatch();
    80002380:	00000097          	auipc	ra,0x0
    80002384:	940080e7          	jalr	-1728(ra) # 80001cc0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002388:	00148493          	addi	s1,s1,1
    8000238c:	000027b7          	lui	a5,0x2
    80002390:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002394:	0097ee63          	bltu	a5,s1,800023b0 <_ZL11workerBodyBPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002398:	00000713          	li	a4,0
    8000239c:	000077b7          	lui	a5,0x7
    800023a0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800023a4:	fce7eee3          	bltu	a5,a4,80002380 <_ZL11workerBodyBPv+0x20>
    800023a8:	00170713          	addi	a4,a4,1
    800023ac:	ff1ff06f          	j	8000239c <_ZL11workerBodyBPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    800023b0:	00190913          	addi	s2,s2,1
    800023b4:	00f00793          	li	a5,15
    800023b8:	0527e063          	bltu	a5,s2,800023f8 <_ZL11workerBodyBPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    800023bc:	00004517          	auipc	a0,0x4
    800023c0:	f2c50513          	addi	a0,a0,-212 # 800062e8 <kvmincrease+0xec8>
    800023c4:	00000097          	auipc	ra,0x0
    800023c8:	990080e7          	jalr	-1648(ra) # 80001d54 <_Z11printStringPKc>
    800023cc:	00000613          	li	a2,0
    800023d0:	00a00593          	li	a1,10
    800023d4:	0009051b          	sext.w	a0,s2
    800023d8:	00000097          	auipc	ra,0x0
    800023dc:	b2c080e7          	jalr	-1236(ra) # 80001f04 <_Z8printIntiii>
    800023e0:	00004517          	auipc	a0,0x4
    800023e4:	17050513          	addi	a0,a0,368 # 80006550 <_ZTV7WorkerD+0x138>
    800023e8:	00000097          	auipc	ra,0x0
    800023ec:	96c080e7          	jalr	-1684(ra) # 80001d54 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800023f0:	00000493          	li	s1,0
    800023f4:	f99ff06f          	j	8000238c <_ZL11workerBodyBPv+0x2c>
    printString("B finished!\n");
    800023f8:	00004517          	auipc	a0,0x4
    800023fc:	ef850513          	addi	a0,a0,-264 # 800062f0 <kvmincrease+0xed0>
    80002400:	00000097          	auipc	ra,0x0
    80002404:	954080e7          	jalr	-1708(ra) # 80001d54 <_Z11printStringPKc>
    finishedB = true;
    80002408:	00100793          	li	a5,1
    8000240c:	00005717          	auipc	a4,0x5
    80002410:	d6f70723          	sb	a5,-658(a4) # 8000717a <_ZL9finishedB>
    thread_dispatch();
    80002414:	00000097          	auipc	ra,0x0
    80002418:	8ac080e7          	jalr	-1876(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    8000241c:	01813083          	ld	ra,24(sp)
    80002420:	01013403          	ld	s0,16(sp)
    80002424:	00813483          	ld	s1,8(sp)
    80002428:	00013903          	ld	s2,0(sp)
    8000242c:	02010113          	addi	sp,sp,32
    80002430:	00008067          	ret

0000000080002434 <_ZL11workerBodyAPv>:
static void workerBodyA(void* arg) {
    80002434:	fe010113          	addi	sp,sp,-32
    80002438:	00113c23          	sd	ra,24(sp)
    8000243c:	00813823          	sd	s0,16(sp)
    80002440:	00913423          	sd	s1,8(sp)
    80002444:	01213023          	sd	s2,0(sp)
    80002448:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    8000244c:	00000913          	li	s2,0
    80002450:	0380006f          	j	80002488 <_ZL11workerBodyAPv+0x54>
            thread_dispatch();
    80002454:	00000097          	auipc	ra,0x0
    80002458:	86c080e7          	jalr	-1940(ra) # 80001cc0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    8000245c:	00148493          	addi	s1,s1,1
    80002460:	000027b7          	lui	a5,0x2
    80002464:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002468:	0097ee63          	bltu	a5,s1,80002484 <_ZL11workerBodyAPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    8000246c:	00000713          	li	a4,0
    80002470:	000077b7          	lui	a5,0x7
    80002474:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002478:	fce7eee3          	bltu	a5,a4,80002454 <_ZL11workerBodyAPv+0x20>
    8000247c:	00170713          	addi	a4,a4,1
    80002480:	ff1ff06f          	j	80002470 <_ZL11workerBodyAPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    80002484:	00190913          	addi	s2,s2,1
    80002488:	00900793          	li	a5,9
    8000248c:	0527e063          	bltu	a5,s2,800024cc <_ZL11workerBodyAPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    80002490:	00004517          	auipc	a0,0x4
    80002494:	e7050513          	addi	a0,a0,-400 # 80006300 <kvmincrease+0xee0>
    80002498:	00000097          	auipc	ra,0x0
    8000249c:	8bc080e7          	jalr	-1860(ra) # 80001d54 <_Z11printStringPKc>
    800024a0:	00000613          	li	a2,0
    800024a4:	00a00593          	li	a1,10
    800024a8:	0009051b          	sext.w	a0,s2
    800024ac:	00000097          	auipc	ra,0x0
    800024b0:	a58080e7          	jalr	-1448(ra) # 80001f04 <_Z8printIntiii>
    800024b4:	00004517          	auipc	a0,0x4
    800024b8:	09c50513          	addi	a0,a0,156 # 80006550 <_ZTV7WorkerD+0x138>
    800024bc:	00000097          	auipc	ra,0x0
    800024c0:	898080e7          	jalr	-1896(ra) # 80001d54 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800024c4:	00000493          	li	s1,0
    800024c8:	f99ff06f          	j	80002460 <_ZL11workerBodyAPv+0x2c>
    printString("A finished!\n");
    800024cc:	00004517          	auipc	a0,0x4
    800024d0:	e0c50513          	addi	a0,a0,-500 # 800062d8 <kvmincrease+0xeb8>
    800024d4:	00000097          	auipc	ra,0x0
    800024d8:	880080e7          	jalr	-1920(ra) # 80001d54 <_Z11printStringPKc>
    finishedA = true;
    800024dc:	00100793          	li	a5,1
    800024e0:	00005717          	auipc	a4,0x5
    800024e4:	c8f70da3          	sb	a5,-869(a4) # 8000717b <_ZL9finishedA>
}
    800024e8:	01813083          	ld	ra,24(sp)
    800024ec:	01013403          	ld	s0,16(sp)
    800024f0:	00813483          	ld	s1,8(sp)
    800024f4:	00013903          	ld	s2,0(sp)
    800024f8:	02010113          	addi	sp,sp,32
    800024fc:	00008067          	ret

0000000080002500 <_Z18Threads_C_API_testv>:


void Threads_C_API_test() {
    80002500:	fd010113          	addi	sp,sp,-48
    80002504:	02113423          	sd	ra,40(sp)
    80002508:	02813023          	sd	s0,32(sp)
    8000250c:	03010413          	addi	s0,sp,48
    thread_t threads[4];
    thread_create(&threads[0], workerBodyA, nullptr);
    80002510:	00000613          	li	a2,0
    80002514:	00000597          	auipc	a1,0x0
    80002518:	f2058593          	addi	a1,a1,-224 # 80002434 <_ZL11workerBodyAPv>
    8000251c:	fd040513          	addi	a0,s0,-48
    80002520:	fffff097          	auipc	ra,0xfffff
    80002524:	76c080e7          	jalr	1900(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadA created\n");
    80002528:	00004517          	auipc	a0,0x4
    8000252c:	de050513          	addi	a0,a0,-544 # 80006308 <kvmincrease+0xee8>
    80002530:	00000097          	auipc	ra,0x0
    80002534:	824080e7          	jalr	-2012(ra) # 80001d54 <_Z11printStringPKc>

    thread_create(&threads[1], workerBodyB, nullptr);
    80002538:	00000613          	li	a2,0
    8000253c:	00000597          	auipc	a1,0x0
    80002540:	e2458593          	addi	a1,a1,-476 # 80002360 <_ZL11workerBodyBPv>
    80002544:	fd840513          	addi	a0,s0,-40
    80002548:	fffff097          	auipc	ra,0xfffff
    8000254c:	744080e7          	jalr	1860(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadB created\n");
    80002550:	00004517          	auipc	a0,0x4
    80002554:	dd050513          	addi	a0,a0,-560 # 80006320 <kvmincrease+0xf00>
    80002558:	fffff097          	auipc	ra,0xfffff
    8000255c:	7fc080e7          	jalr	2044(ra) # 80001d54 <_Z11printStringPKc>

    thread_create(&threads[2], workerBodyC, nullptr);
    80002560:	00000613          	li	a2,0
    80002564:	00000597          	auipc	a1,0x0
    80002568:	c7c58593          	addi	a1,a1,-900 # 800021e0 <_ZL11workerBodyCPv>
    8000256c:	fe040513          	addi	a0,s0,-32
    80002570:	fffff097          	auipc	ra,0xfffff
    80002574:	71c080e7          	jalr	1820(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadC created\n");
    80002578:	00004517          	auipc	a0,0x4
    8000257c:	dc050513          	addi	a0,a0,-576 # 80006338 <kvmincrease+0xf18>
    80002580:	fffff097          	auipc	ra,0xfffff
    80002584:	7d4080e7          	jalr	2004(ra) # 80001d54 <_Z11printStringPKc>

    thread_create(&threads[3], workerBodyD, nullptr);
    80002588:	00000613          	li	a2,0
    8000258c:	00000597          	auipc	a1,0x0
    80002590:	b0c58593          	addi	a1,a1,-1268 # 80002098 <_ZL11workerBodyDPv>
    80002594:	fe840513          	addi	a0,s0,-24
    80002598:	fffff097          	auipc	ra,0xfffff
    8000259c:	6f4080e7          	jalr	1780(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    printString("ThreadD created\n");
    800025a0:	00004517          	auipc	a0,0x4
    800025a4:	db050513          	addi	a0,a0,-592 # 80006350 <kvmincrease+0xf30>
    800025a8:	fffff097          	auipc	ra,0xfffff
    800025ac:	7ac080e7          	jalr	1964(ra) # 80001d54 <_Z11printStringPKc>
    800025b0:	00c0006f          	j	800025bc <_Z18Threads_C_API_testv+0xbc>

    while (!(finishedA && finishedB && finishedC && finishedD)) {
        thread_dispatch();
    800025b4:	fffff097          	auipc	ra,0xfffff
    800025b8:	70c080e7          	jalr	1804(ra) # 80001cc0 <_Z15thread_dispatchv>
    while (!(finishedA && finishedB && finishedC && finishedD)) {
    800025bc:	00005797          	auipc	a5,0x5
    800025c0:	bbf7c783          	lbu	a5,-1089(a5) # 8000717b <_ZL9finishedA>
    800025c4:	fe0788e3          	beqz	a5,800025b4 <_Z18Threads_C_API_testv+0xb4>
    800025c8:	00005797          	auipc	a5,0x5
    800025cc:	bb27c783          	lbu	a5,-1102(a5) # 8000717a <_ZL9finishedB>
    800025d0:	fe0782e3          	beqz	a5,800025b4 <_Z18Threads_C_API_testv+0xb4>
    800025d4:	00005797          	auipc	a5,0x5
    800025d8:	ba57c783          	lbu	a5,-1115(a5) # 80007179 <_ZL9finishedC>
    800025dc:	fc078ce3          	beqz	a5,800025b4 <_Z18Threads_C_API_testv+0xb4>
    800025e0:	00005797          	auipc	a5,0x5
    800025e4:	b987c783          	lbu	a5,-1128(a5) # 80007178 <_ZL9finishedD>
    800025e8:	fc0786e3          	beqz	a5,800025b4 <_Z18Threads_C_API_testv+0xb4>
    }

}
    800025ec:	02813083          	ld	ra,40(sp)
    800025f0:	02013403          	ld	s0,32(sp)
    800025f4:	03010113          	addi	sp,sp,48
    800025f8:	00008067          	ret

00000000800025fc <_ZL9fibonaccim>:
static volatile bool finishedA = false;
static volatile bool finishedB = false;
static volatile bool finishedC = false;
static volatile bool finishedD = false;

static uint64 fibonacci(uint64 n) {
    800025fc:	fe010113          	addi	sp,sp,-32
    80002600:	00113c23          	sd	ra,24(sp)
    80002604:	00813823          	sd	s0,16(sp)
    80002608:	00913423          	sd	s1,8(sp)
    8000260c:	01213023          	sd	s2,0(sp)
    80002610:	02010413          	addi	s0,sp,32
    80002614:	00050493          	mv	s1,a0
    if (n == 0 || n == 1) { return n; }
    80002618:	00100793          	li	a5,1
    8000261c:	02a7f863          	bgeu	a5,a0,8000264c <_ZL9fibonaccim+0x50>
    if (n % 10 == 0) { thread_dispatch(); }
    80002620:	00a00793          	li	a5,10
    80002624:	02f577b3          	remu	a5,a0,a5
    80002628:	02078e63          	beqz	a5,80002664 <_ZL9fibonaccim+0x68>
    return fibonacci(n - 1) + fibonacci(n - 2);
    8000262c:	fff48513          	addi	a0,s1,-1
    80002630:	00000097          	auipc	ra,0x0
    80002634:	fcc080e7          	jalr	-52(ra) # 800025fc <_ZL9fibonaccim>
    80002638:	00050913          	mv	s2,a0
    8000263c:	ffe48513          	addi	a0,s1,-2
    80002640:	00000097          	auipc	ra,0x0
    80002644:	fbc080e7          	jalr	-68(ra) # 800025fc <_ZL9fibonaccim>
    80002648:	00a90533          	add	a0,s2,a0
}
    8000264c:	01813083          	ld	ra,24(sp)
    80002650:	01013403          	ld	s0,16(sp)
    80002654:	00813483          	ld	s1,8(sp)
    80002658:	00013903          	ld	s2,0(sp)
    8000265c:	02010113          	addi	sp,sp,32
    80002660:	00008067          	ret
    if (n % 10 == 0) { thread_dispatch(); }
    80002664:	fffff097          	auipc	ra,0xfffff
    80002668:	65c080e7          	jalr	1628(ra) # 80001cc0 <_Z15thread_dispatchv>
    8000266c:	fc1ff06f          	j	8000262c <_ZL9fibonaccim+0x30>

0000000080002670 <_ZN7WorkerA11workerBodyAEPv>:
    void run() override {
        workerBodyD(nullptr);
    }
};

void WorkerA::workerBodyA(void *arg) {
    80002670:	fe010113          	addi	sp,sp,-32
    80002674:	00113c23          	sd	ra,24(sp)
    80002678:	00813823          	sd	s0,16(sp)
    8000267c:	00913423          	sd	s1,8(sp)
    80002680:	01213023          	sd	s2,0(sp)
    80002684:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 10; i++) {
    80002688:	00000913          	li	s2,0
    8000268c:	0380006f          	j	800026c4 <_ZN7WorkerA11workerBodyAEPv+0x54>
        printString("A: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    80002690:	fffff097          	auipc	ra,0xfffff
    80002694:	630080e7          	jalr	1584(ra) # 80001cc0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002698:	00148493          	addi	s1,s1,1
    8000269c:	000027b7          	lui	a5,0x2
    800026a0:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    800026a4:	0097ee63          	bltu	a5,s1,800026c0 <_ZN7WorkerA11workerBodyAEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    800026a8:	00000713          	li	a4,0
    800026ac:	000077b7          	lui	a5,0x7
    800026b0:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    800026b4:	fce7eee3          	bltu	a5,a4,80002690 <_ZN7WorkerA11workerBodyAEPv+0x20>
    800026b8:	00170713          	addi	a4,a4,1
    800026bc:	ff1ff06f          	j	800026ac <_ZN7WorkerA11workerBodyAEPv+0x3c>
    for (uint64 i = 0; i < 10; i++) {
    800026c0:	00190913          	addi	s2,s2,1
    800026c4:	00900793          	li	a5,9
    800026c8:	0527e063          	bltu	a5,s2,80002708 <_ZN7WorkerA11workerBodyAEPv+0x98>
        printString("A: i="); printInt(i); printString("\n");
    800026cc:	00004517          	auipc	a0,0x4
    800026d0:	c3450513          	addi	a0,a0,-972 # 80006300 <kvmincrease+0xee0>
    800026d4:	fffff097          	auipc	ra,0xfffff
    800026d8:	680080e7          	jalr	1664(ra) # 80001d54 <_Z11printStringPKc>
    800026dc:	00000613          	li	a2,0
    800026e0:	00a00593          	li	a1,10
    800026e4:	0009051b          	sext.w	a0,s2
    800026e8:	00000097          	auipc	ra,0x0
    800026ec:	81c080e7          	jalr	-2020(ra) # 80001f04 <_Z8printIntiii>
    800026f0:	00004517          	auipc	a0,0x4
    800026f4:	e6050513          	addi	a0,a0,-416 # 80006550 <_ZTV7WorkerD+0x138>
    800026f8:	fffff097          	auipc	ra,0xfffff
    800026fc:	65c080e7          	jalr	1628(ra) # 80001d54 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    80002700:	00000493          	li	s1,0
    80002704:	f99ff06f          	j	8000269c <_ZN7WorkerA11workerBodyAEPv+0x2c>
        }
    }
    printString("A finished!\n");
    80002708:	00004517          	auipc	a0,0x4
    8000270c:	bd050513          	addi	a0,a0,-1072 # 800062d8 <kvmincrease+0xeb8>
    80002710:	fffff097          	auipc	ra,0xfffff
    80002714:	644080e7          	jalr	1604(ra) # 80001d54 <_Z11printStringPKc>
    finishedA = true;
    80002718:	00100793          	li	a5,1
    8000271c:	00005717          	auipc	a4,0x5
    80002720:	a6f701a3          	sb	a5,-1437(a4) # 8000717f <_ZL9finishedA>
}
    80002724:	01813083          	ld	ra,24(sp)
    80002728:	01013403          	ld	s0,16(sp)
    8000272c:	00813483          	ld	s1,8(sp)
    80002730:	00013903          	ld	s2,0(sp)
    80002734:	02010113          	addi	sp,sp,32
    80002738:	00008067          	ret

000000008000273c <_ZN7WorkerB11workerBodyBEPv>:

void WorkerB::workerBodyB(void *arg) {
    8000273c:	fe010113          	addi	sp,sp,-32
    80002740:	00113c23          	sd	ra,24(sp)
    80002744:	00813823          	sd	s0,16(sp)
    80002748:	00913423          	sd	s1,8(sp)
    8000274c:	01213023          	sd	s2,0(sp)
    80002750:	02010413          	addi	s0,sp,32
    for (uint64 i = 0; i < 16; i++) {
    80002754:	00000913          	li	s2,0
    80002758:	0380006f          	j	80002790 <_ZN7WorkerB11workerBodyBEPv+0x54>
        printString("B: i="); printInt(i); printString("\n");
        for (uint64 j = 0; j < 10000; j++) {
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
            thread_dispatch();
    8000275c:	fffff097          	auipc	ra,0xfffff
    80002760:	564080e7          	jalr	1380(ra) # 80001cc0 <_Z15thread_dispatchv>
        for (uint64 j = 0; j < 10000; j++) {
    80002764:	00148493          	addi	s1,s1,1
    80002768:	000027b7          	lui	a5,0x2
    8000276c:	70f78793          	addi	a5,a5,1807 # 270f <_entry-0x7fffd8f1>
    80002770:	0097ee63          	bltu	a5,s1,8000278c <_ZN7WorkerB11workerBodyBEPv+0x50>
            for (uint64 k = 0; k < 30000; k++) { /* busy wait */ }
    80002774:	00000713          	li	a4,0
    80002778:	000077b7          	lui	a5,0x7
    8000277c:	52f78793          	addi	a5,a5,1327 # 752f <_entry-0x7fff8ad1>
    80002780:	fce7eee3          	bltu	a5,a4,8000275c <_ZN7WorkerB11workerBodyBEPv+0x20>
    80002784:	00170713          	addi	a4,a4,1
    80002788:	ff1ff06f          	j	80002778 <_ZN7WorkerB11workerBodyBEPv+0x3c>
    for (uint64 i = 0; i < 16; i++) {
    8000278c:	00190913          	addi	s2,s2,1
    80002790:	00f00793          	li	a5,15
    80002794:	0527e063          	bltu	a5,s2,800027d4 <_ZN7WorkerB11workerBodyBEPv+0x98>
        printString("B: i="); printInt(i); printString("\n");
    80002798:	00004517          	auipc	a0,0x4
    8000279c:	b5050513          	addi	a0,a0,-1200 # 800062e8 <kvmincrease+0xec8>
    800027a0:	fffff097          	auipc	ra,0xfffff
    800027a4:	5b4080e7          	jalr	1460(ra) # 80001d54 <_Z11printStringPKc>
    800027a8:	00000613          	li	a2,0
    800027ac:	00a00593          	li	a1,10
    800027b0:	0009051b          	sext.w	a0,s2
    800027b4:	fffff097          	auipc	ra,0xfffff
    800027b8:	750080e7          	jalr	1872(ra) # 80001f04 <_Z8printIntiii>
    800027bc:	00004517          	auipc	a0,0x4
    800027c0:	d9450513          	addi	a0,a0,-620 # 80006550 <_ZTV7WorkerD+0x138>
    800027c4:	fffff097          	auipc	ra,0xfffff
    800027c8:	590080e7          	jalr	1424(ra) # 80001d54 <_Z11printStringPKc>
        for (uint64 j = 0; j < 10000; j++) {
    800027cc:	00000493          	li	s1,0
    800027d0:	f99ff06f          	j	80002768 <_ZN7WorkerB11workerBodyBEPv+0x2c>
        }
    }
    printString("B finished!\n");
    800027d4:	00004517          	auipc	a0,0x4
    800027d8:	b1c50513          	addi	a0,a0,-1252 # 800062f0 <kvmincrease+0xed0>
    800027dc:	fffff097          	auipc	ra,0xfffff
    800027e0:	578080e7          	jalr	1400(ra) # 80001d54 <_Z11printStringPKc>
    finishedB = true;
    800027e4:	00100793          	li	a5,1
    800027e8:	00005717          	auipc	a4,0x5
    800027ec:	98f70b23          	sb	a5,-1642(a4) # 8000717e <_ZL9finishedB>
    thread_dispatch();
    800027f0:	fffff097          	auipc	ra,0xfffff
    800027f4:	4d0080e7          	jalr	1232(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    800027f8:	01813083          	ld	ra,24(sp)
    800027fc:	01013403          	ld	s0,16(sp)
    80002800:	00813483          	ld	s1,8(sp)
    80002804:	00013903          	ld	s2,0(sp)
    80002808:	02010113          	addi	sp,sp,32
    8000280c:	00008067          	ret

0000000080002810 <_ZN7WorkerC11workerBodyCEPv>:

void WorkerC::workerBodyC(void *arg) {
    80002810:	fe010113          	addi	sp,sp,-32
    80002814:	00113c23          	sd	ra,24(sp)
    80002818:	00813823          	sd	s0,16(sp)
    8000281c:	00913423          	sd	s1,8(sp)
    80002820:	01213023          	sd	s2,0(sp)
    80002824:	02010413          	addi	s0,sp,32
    uint8 i = 0;
    80002828:	00000493          	li	s1,0
    8000282c:	0400006f          	j	8000286c <_ZN7WorkerC11workerBodyCEPv+0x5c>
    for (; i < 3; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002830:	00004517          	auipc	a0,0x4
    80002834:	a7850513          	addi	a0,a0,-1416 # 800062a8 <kvmincrease+0xe88>
    80002838:	fffff097          	auipc	ra,0xfffff
    8000283c:	51c080e7          	jalr	1308(ra) # 80001d54 <_Z11printStringPKc>
    80002840:	00000613          	li	a2,0
    80002844:	00a00593          	li	a1,10
    80002848:	00048513          	mv	a0,s1
    8000284c:	fffff097          	auipc	ra,0xfffff
    80002850:	6b8080e7          	jalr	1720(ra) # 80001f04 <_Z8printIntiii>
    80002854:	00004517          	auipc	a0,0x4
    80002858:	cfc50513          	addi	a0,a0,-772 # 80006550 <_ZTV7WorkerD+0x138>
    8000285c:	fffff097          	auipc	ra,0xfffff
    80002860:	4f8080e7          	jalr	1272(ra) # 80001d54 <_Z11printStringPKc>
    for (; i < 3; i++) {
    80002864:	0014849b          	addiw	s1,s1,1
    80002868:	0ff4f493          	andi	s1,s1,255
    8000286c:	00200793          	li	a5,2
    80002870:	fc97f0e3          	bgeu	a5,s1,80002830 <_ZN7WorkerC11workerBodyCEPv+0x20>
    }

    printString("C: dispatch\n");
    80002874:	00004517          	auipc	a0,0x4
    80002878:	a3c50513          	addi	a0,a0,-1476 # 800062b0 <kvmincrease+0xe90>
    8000287c:	fffff097          	auipc	ra,0xfffff
    80002880:	4d8080e7          	jalr	1240(ra) # 80001d54 <_Z11printStringPKc>
    __asm__ ("li t1, 7");
    80002884:	00700313          	li	t1,7
    thread_dispatch();
    80002888:	fffff097          	auipc	ra,0xfffff
    8000288c:	438080e7          	jalr	1080(ra) # 80001cc0 <_Z15thread_dispatchv>

    uint64 t1 = 0;
    __asm__ ("mv %[t1], t1" : [t1] "=r"(t1));
    80002890:	00030913          	mv	s2,t1

    printString("C: t1="); printInt(t1); printString("\n");
    80002894:	00004517          	auipc	a0,0x4
    80002898:	a2c50513          	addi	a0,a0,-1492 # 800062c0 <kvmincrease+0xea0>
    8000289c:	fffff097          	auipc	ra,0xfffff
    800028a0:	4b8080e7          	jalr	1208(ra) # 80001d54 <_Z11printStringPKc>
    800028a4:	00000613          	li	a2,0
    800028a8:	00a00593          	li	a1,10
    800028ac:	0009051b          	sext.w	a0,s2
    800028b0:	fffff097          	auipc	ra,0xfffff
    800028b4:	654080e7          	jalr	1620(ra) # 80001f04 <_Z8printIntiii>
    800028b8:	00004517          	auipc	a0,0x4
    800028bc:	c9850513          	addi	a0,a0,-872 # 80006550 <_ZTV7WorkerD+0x138>
    800028c0:	fffff097          	auipc	ra,0xfffff
    800028c4:	494080e7          	jalr	1172(ra) # 80001d54 <_Z11printStringPKc>

    uint64 result = fibonacci(12);
    800028c8:	00c00513          	li	a0,12
    800028cc:	00000097          	auipc	ra,0x0
    800028d0:	d30080e7          	jalr	-720(ra) # 800025fc <_ZL9fibonaccim>
    800028d4:	00050913          	mv	s2,a0
    printString("C: fibonaci="); printInt(result); printString("\n");
    800028d8:	00004517          	auipc	a0,0x4
    800028dc:	9f050513          	addi	a0,a0,-1552 # 800062c8 <kvmincrease+0xea8>
    800028e0:	fffff097          	auipc	ra,0xfffff
    800028e4:	474080e7          	jalr	1140(ra) # 80001d54 <_Z11printStringPKc>
    800028e8:	00000613          	li	a2,0
    800028ec:	00a00593          	li	a1,10
    800028f0:	0009051b          	sext.w	a0,s2
    800028f4:	fffff097          	auipc	ra,0xfffff
    800028f8:	610080e7          	jalr	1552(ra) # 80001f04 <_Z8printIntiii>
    800028fc:	00004517          	auipc	a0,0x4
    80002900:	c5450513          	addi	a0,a0,-940 # 80006550 <_ZTV7WorkerD+0x138>
    80002904:	fffff097          	auipc	ra,0xfffff
    80002908:	450080e7          	jalr	1104(ra) # 80001d54 <_Z11printStringPKc>
    8000290c:	0400006f          	j	8000294c <_ZN7WorkerC11workerBodyCEPv+0x13c>

    for (; i < 6; i++) {
        printString("C: i="); printInt(i); printString("\n");
    80002910:	00004517          	auipc	a0,0x4
    80002914:	99850513          	addi	a0,a0,-1640 # 800062a8 <kvmincrease+0xe88>
    80002918:	fffff097          	auipc	ra,0xfffff
    8000291c:	43c080e7          	jalr	1084(ra) # 80001d54 <_Z11printStringPKc>
    80002920:	00000613          	li	a2,0
    80002924:	00a00593          	li	a1,10
    80002928:	00048513          	mv	a0,s1
    8000292c:	fffff097          	auipc	ra,0xfffff
    80002930:	5d8080e7          	jalr	1496(ra) # 80001f04 <_Z8printIntiii>
    80002934:	00004517          	auipc	a0,0x4
    80002938:	c1c50513          	addi	a0,a0,-996 # 80006550 <_ZTV7WorkerD+0x138>
    8000293c:	fffff097          	auipc	ra,0xfffff
    80002940:	418080e7          	jalr	1048(ra) # 80001d54 <_Z11printStringPKc>
    for (; i < 6; i++) {
    80002944:	0014849b          	addiw	s1,s1,1
    80002948:	0ff4f493          	andi	s1,s1,255
    8000294c:	00500793          	li	a5,5
    80002950:	fc97f0e3          	bgeu	a5,s1,80002910 <_ZN7WorkerC11workerBodyCEPv+0x100>
    }

    printString("A finished!\n");
    80002954:	00004517          	auipc	a0,0x4
    80002958:	98450513          	addi	a0,a0,-1660 # 800062d8 <kvmincrease+0xeb8>
    8000295c:	fffff097          	auipc	ra,0xfffff
    80002960:	3f8080e7          	jalr	1016(ra) # 80001d54 <_Z11printStringPKc>
    finishedC = true;
    80002964:	00100793          	li	a5,1
    80002968:	00005717          	auipc	a4,0x5
    8000296c:	80f70aa3          	sb	a5,-2027(a4) # 8000717d <_ZL9finishedC>
    thread_dispatch();
    80002970:	fffff097          	auipc	ra,0xfffff
    80002974:	350080e7          	jalr	848(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    80002978:	01813083          	ld	ra,24(sp)
    8000297c:	01013403          	ld	s0,16(sp)
    80002980:	00813483          	ld	s1,8(sp)
    80002984:	00013903          	ld	s2,0(sp)
    80002988:	02010113          	addi	sp,sp,32
    8000298c:	00008067          	ret

0000000080002990 <_ZN7WorkerD11workerBodyDEPv>:

void WorkerD::workerBodyD(void* arg) {
    80002990:	fe010113          	addi	sp,sp,-32
    80002994:	00113c23          	sd	ra,24(sp)
    80002998:	00813823          	sd	s0,16(sp)
    8000299c:	00913423          	sd	s1,8(sp)
    800029a0:	01213023          	sd	s2,0(sp)
    800029a4:	02010413          	addi	s0,sp,32
    uint8 i = 10;
    800029a8:	00a00493          	li	s1,10
    800029ac:	0400006f          	j	800029ec <_ZN7WorkerD11workerBodyDEPv+0x5c>
    for (; i < 13; i++) {
        printString("D: i="); printInt(i); printString("\n");
    800029b0:	00004517          	auipc	a0,0x4
    800029b4:	8c050513          	addi	a0,a0,-1856 # 80006270 <kvmincrease+0xe50>
    800029b8:	fffff097          	auipc	ra,0xfffff
    800029bc:	39c080e7          	jalr	924(ra) # 80001d54 <_Z11printStringPKc>
    800029c0:	00000613          	li	a2,0
    800029c4:	00a00593          	li	a1,10
    800029c8:	00048513          	mv	a0,s1
    800029cc:	fffff097          	auipc	ra,0xfffff
    800029d0:	538080e7          	jalr	1336(ra) # 80001f04 <_Z8printIntiii>
    800029d4:	00004517          	auipc	a0,0x4
    800029d8:	b7c50513          	addi	a0,a0,-1156 # 80006550 <_ZTV7WorkerD+0x138>
    800029dc:	fffff097          	auipc	ra,0xfffff
    800029e0:	378080e7          	jalr	888(ra) # 80001d54 <_Z11printStringPKc>
    for (; i < 13; i++) {
    800029e4:	0014849b          	addiw	s1,s1,1
    800029e8:	0ff4f493          	andi	s1,s1,255
    800029ec:	00c00793          	li	a5,12
    800029f0:	fc97f0e3          	bgeu	a5,s1,800029b0 <_ZN7WorkerD11workerBodyDEPv+0x20>
    }

    printString("D: dispatch\n");
    800029f4:	00004517          	auipc	a0,0x4
    800029f8:	88450513          	addi	a0,a0,-1916 # 80006278 <kvmincrease+0xe58>
    800029fc:	fffff097          	auipc	ra,0xfffff
    80002a00:	358080e7          	jalr	856(ra) # 80001d54 <_Z11printStringPKc>
    __asm__ ("li t1, 5");
    80002a04:	00500313          	li	t1,5
    thread_dispatch();
    80002a08:	fffff097          	auipc	ra,0xfffff
    80002a0c:	2b8080e7          	jalr	696(ra) # 80001cc0 <_Z15thread_dispatchv>

    uint64 result = fibonacci(16);
    80002a10:	01000513          	li	a0,16
    80002a14:	00000097          	auipc	ra,0x0
    80002a18:	be8080e7          	jalr	-1048(ra) # 800025fc <_ZL9fibonaccim>
    80002a1c:	00050913          	mv	s2,a0
    printString("D: fibonaci="); printInt(result); printString("\n");
    80002a20:	00004517          	auipc	a0,0x4
    80002a24:	86850513          	addi	a0,a0,-1944 # 80006288 <kvmincrease+0xe68>
    80002a28:	fffff097          	auipc	ra,0xfffff
    80002a2c:	32c080e7          	jalr	812(ra) # 80001d54 <_Z11printStringPKc>
    80002a30:	00000613          	li	a2,0
    80002a34:	00a00593          	li	a1,10
    80002a38:	0009051b          	sext.w	a0,s2
    80002a3c:	fffff097          	auipc	ra,0xfffff
    80002a40:	4c8080e7          	jalr	1224(ra) # 80001f04 <_Z8printIntiii>
    80002a44:	00004517          	auipc	a0,0x4
    80002a48:	b0c50513          	addi	a0,a0,-1268 # 80006550 <_ZTV7WorkerD+0x138>
    80002a4c:	fffff097          	auipc	ra,0xfffff
    80002a50:	308080e7          	jalr	776(ra) # 80001d54 <_Z11printStringPKc>
    80002a54:	0400006f          	j	80002a94 <_ZN7WorkerD11workerBodyDEPv+0x104>

    for (; i < 16; i++) {
        printString("D: i="); printInt(i); printString("\n");
    80002a58:	00004517          	auipc	a0,0x4
    80002a5c:	81850513          	addi	a0,a0,-2024 # 80006270 <kvmincrease+0xe50>
    80002a60:	fffff097          	auipc	ra,0xfffff
    80002a64:	2f4080e7          	jalr	756(ra) # 80001d54 <_Z11printStringPKc>
    80002a68:	00000613          	li	a2,0
    80002a6c:	00a00593          	li	a1,10
    80002a70:	00048513          	mv	a0,s1
    80002a74:	fffff097          	auipc	ra,0xfffff
    80002a78:	490080e7          	jalr	1168(ra) # 80001f04 <_Z8printIntiii>
    80002a7c:	00004517          	auipc	a0,0x4
    80002a80:	ad450513          	addi	a0,a0,-1324 # 80006550 <_ZTV7WorkerD+0x138>
    80002a84:	fffff097          	auipc	ra,0xfffff
    80002a88:	2d0080e7          	jalr	720(ra) # 80001d54 <_Z11printStringPKc>
    for (; i < 16; i++) {
    80002a8c:	0014849b          	addiw	s1,s1,1
    80002a90:	0ff4f493          	andi	s1,s1,255
    80002a94:	00f00793          	li	a5,15
    80002a98:	fc97f0e3          	bgeu	a5,s1,80002a58 <_ZN7WorkerD11workerBodyDEPv+0xc8>
    }

    printString("D finished!\n");
    80002a9c:	00003517          	auipc	a0,0x3
    80002aa0:	7fc50513          	addi	a0,a0,2044 # 80006298 <kvmincrease+0xe78>
    80002aa4:	fffff097          	auipc	ra,0xfffff
    80002aa8:	2b0080e7          	jalr	688(ra) # 80001d54 <_Z11printStringPKc>
    finishedD = true;
    80002aac:	00100793          	li	a5,1
    80002ab0:	00004717          	auipc	a4,0x4
    80002ab4:	6cf70623          	sb	a5,1740(a4) # 8000717c <_ZL9finishedD>
    thread_dispatch();
    80002ab8:	fffff097          	auipc	ra,0xfffff
    80002abc:	208080e7          	jalr	520(ra) # 80001cc0 <_Z15thread_dispatchv>
}
    80002ac0:	01813083          	ld	ra,24(sp)
    80002ac4:	01013403          	ld	s0,16(sp)
    80002ac8:	00813483          	ld	s1,8(sp)
    80002acc:	00013903          	ld	s2,0(sp)
    80002ad0:	02010113          	addi	sp,sp,32
    80002ad4:	00008067          	ret

0000000080002ad8 <_Z20Threads_CPP_API_testv>:


void Threads_CPP_API_test() {
    80002ad8:	fc010113          	addi	sp,sp,-64
    80002adc:	02113c23          	sd	ra,56(sp)
    80002ae0:	02813823          	sd	s0,48(sp)
    80002ae4:	02913423          	sd	s1,40(sp)
    80002ae8:	03213023          	sd	s2,32(sp)
    80002aec:	04010413          	addi	s0,sp,64
    Thread* threads[4];

    threads[0] = new WorkerA();
    80002af0:	02000513          	li	a0,32
    80002af4:	ffffe097          	auipc	ra,0xffffe
    80002af8:	74c080e7          	jalr	1868(ra) # 80001240 <_Znwm>

    static void dispatch() {thread_dispatch();}
    static int sleep(time_t);

protected:
    Thread(){};
    80002afc:	00053823          	sd	zero,16(a0)
    WorkerA():Thread() {}
    80002b00:	00004797          	auipc	a5,0x4
    80002b04:	8b078793          	addi	a5,a5,-1872 # 800063b0 <_ZTV7WorkerA+0x10>
    80002b08:	00f53023          	sd	a5,0(a0)
    threads[0] = new WorkerA();
    80002b0c:	fca43023          	sd	a0,-64(s0)
    printString("ThreadA created\n");
    80002b10:	00003517          	auipc	a0,0x3
    80002b14:	7f850513          	addi	a0,a0,2040 # 80006308 <kvmincrease+0xee8>
    80002b18:	fffff097          	auipc	ra,0xfffff
    80002b1c:	23c080e7          	jalr	572(ra) # 80001d54 <_Z11printStringPKc>

    threads[1] = new WorkerB();
    80002b20:	02000513          	li	a0,32
    80002b24:	ffffe097          	auipc	ra,0xffffe
    80002b28:	71c080e7          	jalr	1820(ra) # 80001240 <_Znwm>
    80002b2c:	00053823          	sd	zero,16(a0)
    WorkerB():Thread() {}
    80002b30:	00004797          	auipc	a5,0x4
    80002b34:	8a878793          	addi	a5,a5,-1880 # 800063d8 <_ZTV7WorkerB+0x10>
    80002b38:	00f53023          	sd	a5,0(a0)
    threads[1] = new WorkerB();
    80002b3c:	fca43423          	sd	a0,-56(s0)
    printString("ThreadB created\n");
    80002b40:	00003517          	auipc	a0,0x3
    80002b44:	7e050513          	addi	a0,a0,2016 # 80006320 <kvmincrease+0xf00>
    80002b48:	fffff097          	auipc	ra,0xfffff
    80002b4c:	20c080e7          	jalr	524(ra) # 80001d54 <_Z11printStringPKc>

    threads[2] = new WorkerC();
    80002b50:	02000513          	li	a0,32
    80002b54:	ffffe097          	auipc	ra,0xffffe
    80002b58:	6ec080e7          	jalr	1772(ra) # 80001240 <_Znwm>
    80002b5c:	00053823          	sd	zero,16(a0)
    WorkerC():Thread() {}
    80002b60:	00004797          	auipc	a5,0x4
    80002b64:	8a078793          	addi	a5,a5,-1888 # 80006400 <_ZTV7WorkerC+0x10>
    80002b68:	00f53023          	sd	a5,0(a0)
    threads[2] = new WorkerC();
    80002b6c:	fca43823          	sd	a0,-48(s0)
    printString("ThreadC created\n");
    80002b70:	00003517          	auipc	a0,0x3
    80002b74:	7c850513          	addi	a0,a0,1992 # 80006338 <kvmincrease+0xf18>
    80002b78:	fffff097          	auipc	ra,0xfffff
    80002b7c:	1dc080e7          	jalr	476(ra) # 80001d54 <_Z11printStringPKc>

    threads[3] = new WorkerD();
    80002b80:	02000513          	li	a0,32
    80002b84:	ffffe097          	auipc	ra,0xffffe
    80002b88:	6bc080e7          	jalr	1724(ra) # 80001240 <_Znwm>
    80002b8c:	00053823          	sd	zero,16(a0)
    WorkerD():Thread() {}
    80002b90:	00004797          	auipc	a5,0x4
    80002b94:	89878793          	addi	a5,a5,-1896 # 80006428 <_ZTV7WorkerD+0x10>
    80002b98:	00f53023          	sd	a5,0(a0)
    threads[3] = new WorkerD();
    80002b9c:	fca43c23          	sd	a0,-40(s0)
    printString("ThreadD created\n");
    80002ba0:	00003517          	auipc	a0,0x3
    80002ba4:	7b050513          	addi	a0,a0,1968 # 80006350 <kvmincrease+0xf30>
    80002ba8:	fffff097          	auipc	ra,0xfffff
    80002bac:	1ac080e7          	jalr	428(ra) # 80001d54 <_Z11printStringPKc>

    for(int i=0; i<4; i++) {
    80002bb0:	00000493          	li	s1,0
    80002bb4:	0200006f          	j	80002bd4 <_Z20Threads_CPP_API_testv+0xfc>
            thread_create(&myhandle, &threadWrapper,this);
    80002bb8:	00050613          	mv	a2,a0
    80002bbc:	00000597          	auipc	a1,0x0
    80002bc0:	0f458593          	addi	a1,a1,244 # 80002cb0 <_ZN6Thread13threadWrapperEPv>
    80002bc4:	00850513          	addi	a0,a0,8
    80002bc8:	fffff097          	auipc	ra,0xfffff
    80002bcc:	0c4080e7          	jalr	196(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    80002bd0:	0014849b          	addiw	s1,s1,1
    80002bd4:	00300793          	li	a5,3
    80002bd8:	0297cc63          	blt	a5,s1,80002c10 <_Z20Threads_CPP_API_testv+0x138>
        threads[i]->start();
    80002bdc:	00349793          	slli	a5,s1,0x3
    80002be0:	fe040713          	addi	a4,s0,-32
    80002be4:	00f707b3          	add	a5,a4,a5
    80002be8:	fe07b503          	ld	a0,-32(a5)
        if (body == nullptr){
    80002bec:	01053583          	ld	a1,16(a0)
    80002bf0:	fc0584e3          	beqz	a1,80002bb8 <_Z20Threads_CPP_API_testv+0xe0>
            thread_create(&myhandle, body,arg);
    80002bf4:	01853603          	ld	a2,24(a0)
    80002bf8:	00850513          	addi	a0,a0,8
    80002bfc:	fffff097          	auipc	ra,0xfffff
    80002c00:	090080e7          	jalr	144(ra) # 80001c8c <_Z13thread_createPP7_threadPFvPvES2_>
    80002c04:	fcdff06f          	j	80002bd0 <_Z20Threads_CPP_API_testv+0xf8>
    static void dispatch() {thread_dispatch();}
    80002c08:	fffff097          	auipc	ra,0xfffff
    80002c0c:	0b8080e7          	jalr	184(ra) # 80001cc0 <_Z15thread_dispatchv>
    }

    while (!(finishedA && finishedB && finishedC && finishedD)) {
    80002c10:	00004797          	auipc	a5,0x4
    80002c14:	56f7c783          	lbu	a5,1391(a5) # 8000717f <_ZL9finishedA>
    80002c18:	fe0788e3          	beqz	a5,80002c08 <_Z20Threads_CPP_API_testv+0x130>
    80002c1c:	00004797          	auipc	a5,0x4
    80002c20:	5627c783          	lbu	a5,1378(a5) # 8000717e <_ZL9finishedB>
    80002c24:	fe0782e3          	beqz	a5,80002c08 <_Z20Threads_CPP_API_testv+0x130>
    80002c28:	00004797          	auipc	a5,0x4
    80002c2c:	5557c783          	lbu	a5,1365(a5) # 8000717d <_ZL9finishedC>
    80002c30:	fc078ce3          	beqz	a5,80002c08 <_Z20Threads_CPP_API_testv+0x130>
    80002c34:	00004797          	auipc	a5,0x4
    80002c38:	5487c783          	lbu	a5,1352(a5) # 8000717c <_ZL9finishedD>
    80002c3c:	fc0786e3          	beqz	a5,80002c08 <_Z20Threads_CPP_API_testv+0x130>
    80002c40:	fc040493          	addi	s1,s0,-64
    80002c44:	0080006f          	j	80002c4c <_Z20Threads_CPP_API_testv+0x174>
        Thread::dispatch();
    }

    for (auto thread: threads) {  printString("Obrisao\n"); delete thread; }
    80002c48:	00848493          	addi	s1,s1,8
    80002c4c:	fe040793          	addi	a5,s0,-32
    80002c50:	02f48863          	beq	s1,a5,80002c80 <_Z20Threads_CPP_API_testv+0x1a8>
    80002c54:	0004b903          	ld	s2,0(s1)
    80002c58:	00003517          	auipc	a0,0x3
    80002c5c:	71050513          	addi	a0,a0,1808 # 80006368 <kvmincrease+0xf48>
    80002c60:	fffff097          	auipc	ra,0xfffff
    80002c64:	0f4080e7          	jalr	244(ra) # 80001d54 <_Z11printStringPKc>
    80002c68:	fe0900e3          	beqz	s2,80002c48 <_Z20Threads_CPP_API_testv+0x170>
    80002c6c:	00093783          	ld	a5,0(s2)
    80002c70:	0087b783          	ld	a5,8(a5)
    80002c74:	00090513          	mv	a0,s2
    80002c78:	000780e7          	jalr	a5
    80002c7c:	fcdff06f          	j	80002c48 <_Z20Threads_CPP_API_testv+0x170>
}
    80002c80:	03813083          	ld	ra,56(sp)
    80002c84:	03013403          	ld	s0,48(sp)
    80002c88:	02813483          	ld	s1,40(sp)
    80002c8c:	02013903          	ld	s2,32(sp)
    80002c90:	04010113          	addi	sp,sp,64
    80002c94:	00008067          	ret

0000000080002c98 <_ZN6Thread3runEv>:
    virtual void run(){}
    80002c98:	ff010113          	addi	sp,sp,-16
    80002c9c:	00813423          	sd	s0,8(sp)
    80002ca0:	01010413          	addi	s0,sp,16
    80002ca4:	00813403          	ld	s0,8(sp)
    80002ca8:	01010113          	addi	sp,sp,16
    80002cac:	00008067          	ret

0000000080002cb0 <_ZN6Thread13threadWrapperEPv>:

private:
    static void threadWrapper(void* p){
        Thread* thr = (Thread*)p;
        if (thr) thr->run();
    80002cb0:	02050863          	beqz	a0,80002ce0 <_ZN6Thread13threadWrapperEPv+0x30>
    static void threadWrapper(void* p){
    80002cb4:	ff010113          	addi	sp,sp,-16
    80002cb8:	00113423          	sd	ra,8(sp)
    80002cbc:	00813023          	sd	s0,0(sp)
    80002cc0:	01010413          	addi	s0,sp,16
        if (thr) thr->run();
    80002cc4:	00053783          	ld	a5,0(a0)
    80002cc8:	0107b783          	ld	a5,16(a5)
    80002ccc:	000780e7          	jalr	a5
    }
    80002cd0:	00813083          	ld	ra,8(sp)
    80002cd4:	00013403          	ld	s0,0(sp)
    80002cd8:	01010113          	addi	sp,sp,16
    80002cdc:	00008067          	ret
    80002ce0:	00008067          	ret

0000000080002ce4 <_ZN6ThreadD1Ev>:
    virtual ~Thread() { thread_exit();}
    80002ce4:	ff010113          	addi	sp,sp,-16
    80002ce8:	00113423          	sd	ra,8(sp)
    80002cec:	00813023          	sd	s0,0(sp)
    80002cf0:	01010413          	addi	s0,sp,16
    80002cf4:	00003797          	auipc	a5,0x3
    80002cf8:	69478793          	addi	a5,a5,1684 # 80006388 <_ZTV6Thread+0x10>
    80002cfc:	00f53023          	sd	a5,0(a0)
    80002d00:	fffff097          	auipc	ra,0xfffff
    80002d04:	fe4080e7          	jalr	-28(ra) # 80001ce4 <_Z11thread_exitv>
    80002d08:	00813083          	ld	ra,8(sp)
    80002d0c:	00013403          	ld	s0,0(sp)
    80002d10:	01010113          	addi	sp,sp,16
    80002d14:	00008067          	ret

0000000080002d18 <_ZN6ThreadD0Ev>:
    80002d18:	fe010113          	addi	sp,sp,-32
    80002d1c:	00113c23          	sd	ra,24(sp)
    80002d20:	00813823          	sd	s0,16(sp)
    80002d24:	00913423          	sd	s1,8(sp)
    80002d28:	02010413          	addi	s0,sp,32
    80002d2c:	00050493          	mv	s1,a0
    80002d30:	00003797          	auipc	a5,0x3
    80002d34:	65878793          	addi	a5,a5,1624 # 80006388 <_ZTV6Thread+0x10>
    80002d38:	00f53023          	sd	a5,0(a0)
    80002d3c:	fffff097          	auipc	ra,0xfffff
    80002d40:	fa8080e7          	jalr	-88(ra) # 80001ce4 <_Z11thread_exitv>
    80002d44:	00048513          	mv	a0,s1
    80002d48:	ffffe097          	auipc	ra,0xffffe
    80002d4c:	548080e7          	jalr	1352(ra) # 80001290 <_ZdlPv>
    80002d50:	01813083          	ld	ra,24(sp)
    80002d54:	01013403          	ld	s0,16(sp)
    80002d58:	00813483          	ld	s1,8(sp)
    80002d5c:	02010113          	addi	sp,sp,32
    80002d60:	00008067          	ret

0000000080002d64 <_ZN7WorkerAD1Ev>:
class WorkerA: public Thread {
    80002d64:	ff010113          	addi	sp,sp,-16
    80002d68:	00113423          	sd	ra,8(sp)
    80002d6c:	00813023          	sd	s0,0(sp)
    80002d70:	01010413          	addi	s0,sp,16
    80002d74:	00003797          	auipc	a5,0x3
    80002d78:	61478793          	addi	a5,a5,1556 # 80006388 <_ZTV6Thread+0x10>
    80002d7c:	00f53023          	sd	a5,0(a0)
    80002d80:	fffff097          	auipc	ra,0xfffff
    80002d84:	f64080e7          	jalr	-156(ra) # 80001ce4 <_Z11thread_exitv>
    80002d88:	00813083          	ld	ra,8(sp)
    80002d8c:	00013403          	ld	s0,0(sp)
    80002d90:	01010113          	addi	sp,sp,16
    80002d94:	00008067          	ret

0000000080002d98 <_ZN7WorkerAD0Ev>:
    80002d98:	fe010113          	addi	sp,sp,-32
    80002d9c:	00113c23          	sd	ra,24(sp)
    80002da0:	00813823          	sd	s0,16(sp)
    80002da4:	00913423          	sd	s1,8(sp)
    80002da8:	02010413          	addi	s0,sp,32
    80002dac:	00050493          	mv	s1,a0
    80002db0:	00003797          	auipc	a5,0x3
    80002db4:	5d878793          	addi	a5,a5,1496 # 80006388 <_ZTV6Thread+0x10>
    80002db8:	00f53023          	sd	a5,0(a0)
    80002dbc:	fffff097          	auipc	ra,0xfffff
    80002dc0:	f28080e7          	jalr	-216(ra) # 80001ce4 <_Z11thread_exitv>
    80002dc4:	00048513          	mv	a0,s1
    80002dc8:	ffffe097          	auipc	ra,0xffffe
    80002dcc:	4c8080e7          	jalr	1224(ra) # 80001290 <_ZdlPv>
    80002dd0:	01813083          	ld	ra,24(sp)
    80002dd4:	01013403          	ld	s0,16(sp)
    80002dd8:	00813483          	ld	s1,8(sp)
    80002ddc:	02010113          	addi	sp,sp,32
    80002de0:	00008067          	ret

0000000080002de4 <_ZN7WorkerBD1Ev>:
class WorkerB: public Thread {
    80002de4:	ff010113          	addi	sp,sp,-16
    80002de8:	00113423          	sd	ra,8(sp)
    80002dec:	00813023          	sd	s0,0(sp)
    80002df0:	01010413          	addi	s0,sp,16
    80002df4:	00003797          	auipc	a5,0x3
    80002df8:	59478793          	addi	a5,a5,1428 # 80006388 <_ZTV6Thread+0x10>
    80002dfc:	00f53023          	sd	a5,0(a0)
    80002e00:	fffff097          	auipc	ra,0xfffff
    80002e04:	ee4080e7          	jalr	-284(ra) # 80001ce4 <_Z11thread_exitv>
    80002e08:	00813083          	ld	ra,8(sp)
    80002e0c:	00013403          	ld	s0,0(sp)
    80002e10:	01010113          	addi	sp,sp,16
    80002e14:	00008067          	ret

0000000080002e18 <_ZN7WorkerBD0Ev>:
    80002e18:	fe010113          	addi	sp,sp,-32
    80002e1c:	00113c23          	sd	ra,24(sp)
    80002e20:	00813823          	sd	s0,16(sp)
    80002e24:	00913423          	sd	s1,8(sp)
    80002e28:	02010413          	addi	s0,sp,32
    80002e2c:	00050493          	mv	s1,a0
    80002e30:	00003797          	auipc	a5,0x3
    80002e34:	55878793          	addi	a5,a5,1368 # 80006388 <_ZTV6Thread+0x10>
    80002e38:	00f53023          	sd	a5,0(a0)
    80002e3c:	fffff097          	auipc	ra,0xfffff
    80002e40:	ea8080e7          	jalr	-344(ra) # 80001ce4 <_Z11thread_exitv>
    80002e44:	00048513          	mv	a0,s1
    80002e48:	ffffe097          	auipc	ra,0xffffe
    80002e4c:	448080e7          	jalr	1096(ra) # 80001290 <_ZdlPv>
    80002e50:	01813083          	ld	ra,24(sp)
    80002e54:	01013403          	ld	s0,16(sp)
    80002e58:	00813483          	ld	s1,8(sp)
    80002e5c:	02010113          	addi	sp,sp,32
    80002e60:	00008067          	ret

0000000080002e64 <_ZN7WorkerCD1Ev>:
class WorkerC: public Thread {
    80002e64:	ff010113          	addi	sp,sp,-16
    80002e68:	00113423          	sd	ra,8(sp)
    80002e6c:	00813023          	sd	s0,0(sp)
    80002e70:	01010413          	addi	s0,sp,16
    80002e74:	00003797          	auipc	a5,0x3
    80002e78:	51478793          	addi	a5,a5,1300 # 80006388 <_ZTV6Thread+0x10>
    80002e7c:	00f53023          	sd	a5,0(a0)
    80002e80:	fffff097          	auipc	ra,0xfffff
    80002e84:	e64080e7          	jalr	-412(ra) # 80001ce4 <_Z11thread_exitv>
    80002e88:	00813083          	ld	ra,8(sp)
    80002e8c:	00013403          	ld	s0,0(sp)
    80002e90:	01010113          	addi	sp,sp,16
    80002e94:	00008067          	ret

0000000080002e98 <_ZN7WorkerCD0Ev>:
    80002e98:	fe010113          	addi	sp,sp,-32
    80002e9c:	00113c23          	sd	ra,24(sp)
    80002ea0:	00813823          	sd	s0,16(sp)
    80002ea4:	00913423          	sd	s1,8(sp)
    80002ea8:	02010413          	addi	s0,sp,32
    80002eac:	00050493          	mv	s1,a0
    80002eb0:	00003797          	auipc	a5,0x3
    80002eb4:	4d878793          	addi	a5,a5,1240 # 80006388 <_ZTV6Thread+0x10>
    80002eb8:	00f53023          	sd	a5,0(a0)
    80002ebc:	fffff097          	auipc	ra,0xfffff
    80002ec0:	e28080e7          	jalr	-472(ra) # 80001ce4 <_Z11thread_exitv>
    80002ec4:	00048513          	mv	a0,s1
    80002ec8:	ffffe097          	auipc	ra,0xffffe
    80002ecc:	3c8080e7          	jalr	968(ra) # 80001290 <_ZdlPv>
    80002ed0:	01813083          	ld	ra,24(sp)
    80002ed4:	01013403          	ld	s0,16(sp)
    80002ed8:	00813483          	ld	s1,8(sp)
    80002edc:	02010113          	addi	sp,sp,32
    80002ee0:	00008067          	ret

0000000080002ee4 <_ZN7WorkerDD1Ev>:
class WorkerD: public Thread {
    80002ee4:	ff010113          	addi	sp,sp,-16
    80002ee8:	00113423          	sd	ra,8(sp)
    80002eec:	00813023          	sd	s0,0(sp)
    80002ef0:	01010413          	addi	s0,sp,16
    80002ef4:	00003797          	auipc	a5,0x3
    80002ef8:	49478793          	addi	a5,a5,1172 # 80006388 <_ZTV6Thread+0x10>
    80002efc:	00f53023          	sd	a5,0(a0)
    80002f00:	fffff097          	auipc	ra,0xfffff
    80002f04:	de4080e7          	jalr	-540(ra) # 80001ce4 <_Z11thread_exitv>
    80002f08:	00813083          	ld	ra,8(sp)
    80002f0c:	00013403          	ld	s0,0(sp)
    80002f10:	01010113          	addi	sp,sp,16
    80002f14:	00008067          	ret

0000000080002f18 <_ZN7WorkerDD0Ev>:
    80002f18:	fe010113          	addi	sp,sp,-32
    80002f1c:	00113c23          	sd	ra,24(sp)
    80002f20:	00813823          	sd	s0,16(sp)
    80002f24:	00913423          	sd	s1,8(sp)
    80002f28:	02010413          	addi	s0,sp,32
    80002f2c:	00050493          	mv	s1,a0
    80002f30:	00003797          	auipc	a5,0x3
    80002f34:	45878793          	addi	a5,a5,1112 # 80006388 <_ZTV6Thread+0x10>
    80002f38:	00f53023          	sd	a5,0(a0)
    80002f3c:	fffff097          	auipc	ra,0xfffff
    80002f40:	da8080e7          	jalr	-600(ra) # 80001ce4 <_Z11thread_exitv>
    80002f44:	00048513          	mv	a0,s1
    80002f48:	ffffe097          	auipc	ra,0xffffe
    80002f4c:	348080e7          	jalr	840(ra) # 80001290 <_ZdlPv>
    80002f50:	01813083          	ld	ra,24(sp)
    80002f54:	01013403          	ld	s0,16(sp)
    80002f58:	00813483          	ld	s1,8(sp)
    80002f5c:	02010113          	addi	sp,sp,32
    80002f60:	00008067          	ret

0000000080002f64 <_ZN7WorkerA3runEv>:
    void run() override {
    80002f64:	ff010113          	addi	sp,sp,-16
    80002f68:	00113423          	sd	ra,8(sp)
    80002f6c:	00813023          	sd	s0,0(sp)
    80002f70:	01010413          	addi	s0,sp,16
        workerBodyA(nullptr);
    80002f74:	00000593          	li	a1,0
    80002f78:	fffff097          	auipc	ra,0xfffff
    80002f7c:	6f8080e7          	jalr	1784(ra) # 80002670 <_ZN7WorkerA11workerBodyAEPv>
    }
    80002f80:	00813083          	ld	ra,8(sp)
    80002f84:	00013403          	ld	s0,0(sp)
    80002f88:	01010113          	addi	sp,sp,16
    80002f8c:	00008067          	ret

0000000080002f90 <_ZN7WorkerB3runEv>:
    void run() override {
    80002f90:	ff010113          	addi	sp,sp,-16
    80002f94:	00113423          	sd	ra,8(sp)
    80002f98:	00813023          	sd	s0,0(sp)
    80002f9c:	01010413          	addi	s0,sp,16
        workerBodyB(nullptr);
    80002fa0:	00000593          	li	a1,0
    80002fa4:	fffff097          	auipc	ra,0xfffff
    80002fa8:	798080e7          	jalr	1944(ra) # 8000273c <_ZN7WorkerB11workerBodyBEPv>
    }
    80002fac:	00813083          	ld	ra,8(sp)
    80002fb0:	00013403          	ld	s0,0(sp)
    80002fb4:	01010113          	addi	sp,sp,16
    80002fb8:	00008067          	ret

0000000080002fbc <_ZN7WorkerC3runEv>:
    void run() override {
    80002fbc:	ff010113          	addi	sp,sp,-16
    80002fc0:	00113423          	sd	ra,8(sp)
    80002fc4:	00813023          	sd	s0,0(sp)
    80002fc8:	01010413          	addi	s0,sp,16
        workerBodyC(nullptr);
    80002fcc:	00000593          	li	a1,0
    80002fd0:	00000097          	auipc	ra,0x0
    80002fd4:	840080e7          	jalr	-1984(ra) # 80002810 <_ZN7WorkerC11workerBodyCEPv>
    }
    80002fd8:	00813083          	ld	ra,8(sp)
    80002fdc:	00013403          	ld	s0,0(sp)
    80002fe0:	01010113          	addi	sp,sp,16
    80002fe4:	00008067          	ret

0000000080002fe8 <_ZN7WorkerD3runEv>:
    void run() override {
    80002fe8:	ff010113          	addi	sp,sp,-16
    80002fec:	00113423          	sd	ra,8(sp)
    80002ff0:	00813023          	sd	s0,0(sp)
    80002ff4:	01010413          	addi	s0,sp,16
        workerBodyD(nullptr);
    80002ff8:	00000593          	li	a1,0
    80002ffc:	00000097          	auipc	ra,0x0
    80003000:	994080e7          	jalr	-1644(ra) # 80002990 <_ZN7WorkerD11workerBodyDEPv>
    }
    80003004:	00813083          	ld	ra,8(sp)
    80003008:	00013403          	ld	s0,0(sp)
    8000300c:	01010113          	addi	sp,sp,16
    80003010:	00008067          	ret

0000000080003014 <start>:
    80003014:	ff010113          	addi	sp,sp,-16
    80003018:	00813423          	sd	s0,8(sp)
    8000301c:	01010413          	addi	s0,sp,16
    80003020:	300027f3          	csrr	a5,mstatus
    80003024:	ffffe737          	lui	a4,0xffffe
    80003028:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff63cf>
    8000302c:	00e7f7b3          	and	a5,a5,a4
    80003030:	00001737          	lui	a4,0x1
    80003034:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80003038:	00e7e7b3          	or	a5,a5,a4
    8000303c:	30079073          	csrw	mstatus,a5
    80003040:	00000797          	auipc	a5,0x0
    80003044:	16078793          	addi	a5,a5,352 # 800031a0 <system_main>
    80003048:	34179073          	csrw	mepc,a5
    8000304c:	00000793          	li	a5,0
    80003050:	18079073          	csrw	satp,a5
    80003054:	000107b7          	lui	a5,0x10
    80003058:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000305c:	30279073          	csrw	medeleg,a5
    80003060:	30379073          	csrw	mideleg,a5
    80003064:	104027f3          	csrr	a5,sie
    80003068:	2227e793          	ori	a5,a5,546
    8000306c:	10479073          	csrw	sie,a5
    80003070:	fff00793          	li	a5,-1
    80003074:	00a7d793          	srli	a5,a5,0xa
    80003078:	3b079073          	csrw	pmpaddr0,a5
    8000307c:	00f00793          	li	a5,15
    80003080:	3a079073          	csrw	pmpcfg0,a5
    80003084:	f14027f3          	csrr	a5,mhartid
    80003088:	0200c737          	lui	a4,0x200c
    8000308c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003090:	0007869b          	sext.w	a3,a5
    80003094:	00269713          	slli	a4,a3,0x2
    80003098:	000f4637          	lui	a2,0xf4
    8000309c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800030a0:	00d70733          	add	a4,a4,a3
    800030a4:	0037979b          	slliw	a5,a5,0x3
    800030a8:	020046b7          	lui	a3,0x2004
    800030ac:	00d787b3          	add	a5,a5,a3
    800030b0:	00c585b3          	add	a1,a1,a2
    800030b4:	00371693          	slli	a3,a4,0x3
    800030b8:	00004717          	auipc	a4,0x4
    800030bc:	10870713          	addi	a4,a4,264 # 800071c0 <timer_scratch>
    800030c0:	00b7b023          	sd	a1,0(a5)
    800030c4:	00d70733          	add	a4,a4,a3
    800030c8:	00f73c23          	sd	a5,24(a4)
    800030cc:	02c73023          	sd	a2,32(a4)
    800030d0:	34071073          	csrw	mscratch,a4
    800030d4:	00000797          	auipc	a5,0x0
    800030d8:	6ec78793          	addi	a5,a5,1772 # 800037c0 <timervec>
    800030dc:	30579073          	csrw	mtvec,a5
    800030e0:	300027f3          	csrr	a5,mstatus
    800030e4:	0087e793          	ori	a5,a5,8
    800030e8:	30079073          	csrw	mstatus,a5
    800030ec:	304027f3          	csrr	a5,mie
    800030f0:	0807e793          	ori	a5,a5,128
    800030f4:	30479073          	csrw	mie,a5
    800030f8:	f14027f3          	csrr	a5,mhartid
    800030fc:	0007879b          	sext.w	a5,a5
    80003100:	00078213          	mv	tp,a5
    80003104:	30200073          	mret
    80003108:	00813403          	ld	s0,8(sp)
    8000310c:	01010113          	addi	sp,sp,16
    80003110:	00008067          	ret

0000000080003114 <timerinit>:
    80003114:	ff010113          	addi	sp,sp,-16
    80003118:	00813423          	sd	s0,8(sp)
    8000311c:	01010413          	addi	s0,sp,16
    80003120:	f14027f3          	csrr	a5,mhartid
    80003124:	0200c737          	lui	a4,0x200c
    80003128:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000312c:	0007869b          	sext.w	a3,a5
    80003130:	00269713          	slli	a4,a3,0x2
    80003134:	000f4637          	lui	a2,0xf4
    80003138:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000313c:	00d70733          	add	a4,a4,a3
    80003140:	0037979b          	slliw	a5,a5,0x3
    80003144:	020046b7          	lui	a3,0x2004
    80003148:	00d787b3          	add	a5,a5,a3
    8000314c:	00c585b3          	add	a1,a1,a2
    80003150:	00371693          	slli	a3,a4,0x3
    80003154:	00004717          	auipc	a4,0x4
    80003158:	06c70713          	addi	a4,a4,108 # 800071c0 <timer_scratch>
    8000315c:	00b7b023          	sd	a1,0(a5)
    80003160:	00d70733          	add	a4,a4,a3
    80003164:	00f73c23          	sd	a5,24(a4)
    80003168:	02c73023          	sd	a2,32(a4)
    8000316c:	34071073          	csrw	mscratch,a4
    80003170:	00000797          	auipc	a5,0x0
    80003174:	65078793          	addi	a5,a5,1616 # 800037c0 <timervec>
    80003178:	30579073          	csrw	mtvec,a5
    8000317c:	300027f3          	csrr	a5,mstatus
    80003180:	0087e793          	ori	a5,a5,8
    80003184:	30079073          	csrw	mstatus,a5
    80003188:	304027f3          	csrr	a5,mie
    8000318c:	0807e793          	ori	a5,a5,128
    80003190:	30479073          	csrw	mie,a5
    80003194:	00813403          	ld	s0,8(sp)
    80003198:	01010113          	addi	sp,sp,16
    8000319c:	00008067          	ret

00000000800031a0 <system_main>:
    800031a0:	fe010113          	addi	sp,sp,-32
    800031a4:	00813823          	sd	s0,16(sp)
    800031a8:	00913423          	sd	s1,8(sp)
    800031ac:	00113c23          	sd	ra,24(sp)
    800031b0:	02010413          	addi	s0,sp,32
    800031b4:	00000097          	auipc	ra,0x0
    800031b8:	0c4080e7          	jalr	196(ra) # 80003278 <cpuid>
    800031bc:	00004497          	auipc	s1,0x4
    800031c0:	fc448493          	addi	s1,s1,-60 # 80007180 <started>
    800031c4:	02050263          	beqz	a0,800031e8 <system_main+0x48>
    800031c8:	0004a783          	lw	a5,0(s1)
    800031cc:	0007879b          	sext.w	a5,a5
    800031d0:	fe078ce3          	beqz	a5,800031c8 <system_main+0x28>
    800031d4:	0ff0000f          	fence
    800031d8:	00003517          	auipc	a0,0x3
    800031dc:	29850513          	addi	a0,a0,664 # 80006470 <_ZTV7WorkerD+0x58>
    800031e0:	00001097          	auipc	ra,0x1
    800031e4:	a7c080e7          	jalr	-1412(ra) # 80003c5c <panic>
    800031e8:	00001097          	auipc	ra,0x1
    800031ec:	9d0080e7          	jalr	-1584(ra) # 80003bb8 <consoleinit>
    800031f0:	00001097          	auipc	ra,0x1
    800031f4:	15c080e7          	jalr	348(ra) # 8000434c <printfinit>
    800031f8:	00003517          	auipc	a0,0x3
    800031fc:	35850513          	addi	a0,a0,856 # 80006550 <_ZTV7WorkerD+0x138>
    80003200:	00001097          	auipc	ra,0x1
    80003204:	ab8080e7          	jalr	-1352(ra) # 80003cb8 <__printf>
    80003208:	00003517          	auipc	a0,0x3
    8000320c:	23850513          	addi	a0,a0,568 # 80006440 <_ZTV7WorkerD+0x28>
    80003210:	00001097          	auipc	ra,0x1
    80003214:	aa8080e7          	jalr	-1368(ra) # 80003cb8 <__printf>
    80003218:	00003517          	auipc	a0,0x3
    8000321c:	33850513          	addi	a0,a0,824 # 80006550 <_ZTV7WorkerD+0x138>
    80003220:	00001097          	auipc	ra,0x1
    80003224:	a98080e7          	jalr	-1384(ra) # 80003cb8 <__printf>
    80003228:	00001097          	auipc	ra,0x1
    8000322c:	4b0080e7          	jalr	1200(ra) # 800046d8 <kinit>
    80003230:	00000097          	auipc	ra,0x0
    80003234:	148080e7          	jalr	328(ra) # 80003378 <trapinit>
    80003238:	00000097          	auipc	ra,0x0
    8000323c:	16c080e7          	jalr	364(ra) # 800033a4 <trapinithart>
    80003240:	00000097          	auipc	ra,0x0
    80003244:	5c0080e7          	jalr	1472(ra) # 80003800 <plicinit>
    80003248:	00000097          	auipc	ra,0x0
    8000324c:	5e0080e7          	jalr	1504(ra) # 80003828 <plicinithart>
    80003250:	00000097          	auipc	ra,0x0
    80003254:	078080e7          	jalr	120(ra) # 800032c8 <userinit>
    80003258:	0ff0000f          	fence
    8000325c:	00100793          	li	a5,1
    80003260:	00003517          	auipc	a0,0x3
    80003264:	1f850513          	addi	a0,a0,504 # 80006458 <_ZTV7WorkerD+0x40>
    80003268:	00f4a023          	sw	a5,0(s1)
    8000326c:	00001097          	auipc	ra,0x1
    80003270:	a4c080e7          	jalr	-1460(ra) # 80003cb8 <__printf>
    80003274:	0000006f          	j	80003274 <system_main+0xd4>

0000000080003278 <cpuid>:
    80003278:	ff010113          	addi	sp,sp,-16
    8000327c:	00813423          	sd	s0,8(sp)
    80003280:	01010413          	addi	s0,sp,16
    80003284:	00020513          	mv	a0,tp
    80003288:	00813403          	ld	s0,8(sp)
    8000328c:	0005051b          	sext.w	a0,a0
    80003290:	01010113          	addi	sp,sp,16
    80003294:	00008067          	ret

0000000080003298 <mycpu>:
    80003298:	ff010113          	addi	sp,sp,-16
    8000329c:	00813423          	sd	s0,8(sp)
    800032a0:	01010413          	addi	s0,sp,16
    800032a4:	00020793          	mv	a5,tp
    800032a8:	00813403          	ld	s0,8(sp)
    800032ac:	0007879b          	sext.w	a5,a5
    800032b0:	00779793          	slli	a5,a5,0x7
    800032b4:	00005517          	auipc	a0,0x5
    800032b8:	f3c50513          	addi	a0,a0,-196 # 800081f0 <cpus>
    800032bc:	00f50533          	add	a0,a0,a5
    800032c0:	01010113          	addi	sp,sp,16
    800032c4:	00008067          	ret

00000000800032c8 <userinit>:
    800032c8:	ff010113          	addi	sp,sp,-16
    800032cc:	00813423          	sd	s0,8(sp)
    800032d0:	01010413          	addi	s0,sp,16
    800032d4:	00813403          	ld	s0,8(sp)
    800032d8:	01010113          	addi	sp,sp,16
    800032dc:	fffff317          	auipc	t1,0xfffff
    800032e0:	93030067          	jr	-1744(t1) # 80001c0c <main>

00000000800032e4 <either_copyout>:
    800032e4:	ff010113          	addi	sp,sp,-16
    800032e8:	00813023          	sd	s0,0(sp)
    800032ec:	00113423          	sd	ra,8(sp)
    800032f0:	01010413          	addi	s0,sp,16
    800032f4:	02051663          	bnez	a0,80003320 <either_copyout+0x3c>
    800032f8:	00058513          	mv	a0,a1
    800032fc:	00060593          	mv	a1,a2
    80003300:	0006861b          	sext.w	a2,a3
    80003304:	00002097          	auipc	ra,0x2
    80003308:	c60080e7          	jalr	-928(ra) # 80004f64 <__memmove>
    8000330c:	00813083          	ld	ra,8(sp)
    80003310:	00013403          	ld	s0,0(sp)
    80003314:	00000513          	li	a0,0
    80003318:	01010113          	addi	sp,sp,16
    8000331c:	00008067          	ret
    80003320:	00003517          	auipc	a0,0x3
    80003324:	17850513          	addi	a0,a0,376 # 80006498 <_ZTV7WorkerD+0x80>
    80003328:	00001097          	auipc	ra,0x1
    8000332c:	934080e7          	jalr	-1740(ra) # 80003c5c <panic>

0000000080003330 <either_copyin>:
    80003330:	ff010113          	addi	sp,sp,-16
    80003334:	00813023          	sd	s0,0(sp)
    80003338:	00113423          	sd	ra,8(sp)
    8000333c:	01010413          	addi	s0,sp,16
    80003340:	02059463          	bnez	a1,80003368 <either_copyin+0x38>
    80003344:	00060593          	mv	a1,a2
    80003348:	0006861b          	sext.w	a2,a3
    8000334c:	00002097          	auipc	ra,0x2
    80003350:	c18080e7          	jalr	-1000(ra) # 80004f64 <__memmove>
    80003354:	00813083          	ld	ra,8(sp)
    80003358:	00013403          	ld	s0,0(sp)
    8000335c:	00000513          	li	a0,0
    80003360:	01010113          	addi	sp,sp,16
    80003364:	00008067          	ret
    80003368:	00003517          	auipc	a0,0x3
    8000336c:	15850513          	addi	a0,a0,344 # 800064c0 <_ZTV7WorkerD+0xa8>
    80003370:	00001097          	auipc	ra,0x1
    80003374:	8ec080e7          	jalr	-1812(ra) # 80003c5c <panic>

0000000080003378 <trapinit>:
    80003378:	ff010113          	addi	sp,sp,-16
    8000337c:	00813423          	sd	s0,8(sp)
    80003380:	01010413          	addi	s0,sp,16
    80003384:	00813403          	ld	s0,8(sp)
    80003388:	00003597          	auipc	a1,0x3
    8000338c:	16058593          	addi	a1,a1,352 # 800064e8 <_ZTV7WorkerD+0xd0>
    80003390:	00005517          	auipc	a0,0x5
    80003394:	ee050513          	addi	a0,a0,-288 # 80008270 <tickslock>
    80003398:	01010113          	addi	sp,sp,16
    8000339c:	00001317          	auipc	t1,0x1
    800033a0:	5cc30067          	jr	1484(t1) # 80004968 <initlock>

00000000800033a4 <trapinithart>:
    800033a4:	ff010113          	addi	sp,sp,-16
    800033a8:	00813423          	sd	s0,8(sp)
    800033ac:	01010413          	addi	s0,sp,16
    800033b0:	00000797          	auipc	a5,0x0
    800033b4:	30078793          	addi	a5,a5,768 # 800036b0 <kernelvec>
    800033b8:	10579073          	csrw	stvec,a5
    800033bc:	00813403          	ld	s0,8(sp)
    800033c0:	01010113          	addi	sp,sp,16
    800033c4:	00008067          	ret

00000000800033c8 <usertrap>:
    800033c8:	ff010113          	addi	sp,sp,-16
    800033cc:	00813423          	sd	s0,8(sp)
    800033d0:	01010413          	addi	s0,sp,16
    800033d4:	00813403          	ld	s0,8(sp)
    800033d8:	01010113          	addi	sp,sp,16
    800033dc:	00008067          	ret

00000000800033e0 <usertrapret>:
    800033e0:	ff010113          	addi	sp,sp,-16
    800033e4:	00813423          	sd	s0,8(sp)
    800033e8:	01010413          	addi	s0,sp,16
    800033ec:	00813403          	ld	s0,8(sp)
    800033f0:	01010113          	addi	sp,sp,16
    800033f4:	00008067          	ret

00000000800033f8 <kerneltrap>:
    800033f8:	fe010113          	addi	sp,sp,-32
    800033fc:	00813823          	sd	s0,16(sp)
    80003400:	00113c23          	sd	ra,24(sp)
    80003404:	00913423          	sd	s1,8(sp)
    80003408:	02010413          	addi	s0,sp,32
    8000340c:	142025f3          	csrr	a1,scause
    80003410:	100027f3          	csrr	a5,sstatus
    80003414:	0027f793          	andi	a5,a5,2
    80003418:	10079c63          	bnez	a5,80003530 <kerneltrap+0x138>
    8000341c:	142027f3          	csrr	a5,scause
    80003420:	0207ce63          	bltz	a5,8000345c <kerneltrap+0x64>
    80003424:	00003517          	auipc	a0,0x3
    80003428:	10c50513          	addi	a0,a0,268 # 80006530 <_ZTV7WorkerD+0x118>
    8000342c:	00001097          	auipc	ra,0x1
    80003430:	88c080e7          	jalr	-1908(ra) # 80003cb8 <__printf>
    80003434:	141025f3          	csrr	a1,sepc
    80003438:	14302673          	csrr	a2,stval
    8000343c:	00003517          	auipc	a0,0x3
    80003440:	10450513          	addi	a0,a0,260 # 80006540 <_ZTV7WorkerD+0x128>
    80003444:	00001097          	auipc	ra,0x1
    80003448:	874080e7          	jalr	-1932(ra) # 80003cb8 <__printf>
    8000344c:	00003517          	auipc	a0,0x3
    80003450:	10c50513          	addi	a0,a0,268 # 80006558 <_ZTV7WorkerD+0x140>
    80003454:	00001097          	auipc	ra,0x1
    80003458:	808080e7          	jalr	-2040(ra) # 80003c5c <panic>
    8000345c:	0ff7f713          	andi	a4,a5,255
    80003460:	00900693          	li	a3,9
    80003464:	04d70063          	beq	a4,a3,800034a4 <kerneltrap+0xac>
    80003468:	fff00713          	li	a4,-1
    8000346c:	03f71713          	slli	a4,a4,0x3f
    80003470:	00170713          	addi	a4,a4,1
    80003474:	fae798e3          	bne	a5,a4,80003424 <kerneltrap+0x2c>
    80003478:	00000097          	auipc	ra,0x0
    8000347c:	e00080e7          	jalr	-512(ra) # 80003278 <cpuid>
    80003480:	06050663          	beqz	a0,800034ec <kerneltrap+0xf4>
    80003484:	144027f3          	csrr	a5,sip
    80003488:	ffd7f793          	andi	a5,a5,-3
    8000348c:	14479073          	csrw	sip,a5
    80003490:	01813083          	ld	ra,24(sp)
    80003494:	01013403          	ld	s0,16(sp)
    80003498:	00813483          	ld	s1,8(sp)
    8000349c:	02010113          	addi	sp,sp,32
    800034a0:	00008067          	ret
    800034a4:	00000097          	auipc	ra,0x0
    800034a8:	3d0080e7          	jalr	976(ra) # 80003874 <plic_claim>
    800034ac:	00a00793          	li	a5,10
    800034b0:	00050493          	mv	s1,a0
    800034b4:	06f50863          	beq	a0,a5,80003524 <kerneltrap+0x12c>
    800034b8:	fc050ce3          	beqz	a0,80003490 <kerneltrap+0x98>
    800034bc:	00050593          	mv	a1,a0
    800034c0:	00003517          	auipc	a0,0x3
    800034c4:	05050513          	addi	a0,a0,80 # 80006510 <_ZTV7WorkerD+0xf8>
    800034c8:	00000097          	auipc	ra,0x0
    800034cc:	7f0080e7          	jalr	2032(ra) # 80003cb8 <__printf>
    800034d0:	01013403          	ld	s0,16(sp)
    800034d4:	01813083          	ld	ra,24(sp)
    800034d8:	00048513          	mv	a0,s1
    800034dc:	00813483          	ld	s1,8(sp)
    800034e0:	02010113          	addi	sp,sp,32
    800034e4:	00000317          	auipc	t1,0x0
    800034e8:	3c830067          	jr	968(t1) # 800038ac <plic_complete>
    800034ec:	00005517          	auipc	a0,0x5
    800034f0:	d8450513          	addi	a0,a0,-636 # 80008270 <tickslock>
    800034f4:	00001097          	auipc	ra,0x1
    800034f8:	498080e7          	jalr	1176(ra) # 8000498c <acquire>
    800034fc:	00004717          	auipc	a4,0x4
    80003500:	c8870713          	addi	a4,a4,-888 # 80007184 <ticks>
    80003504:	00072783          	lw	a5,0(a4)
    80003508:	00005517          	auipc	a0,0x5
    8000350c:	d6850513          	addi	a0,a0,-664 # 80008270 <tickslock>
    80003510:	0017879b          	addiw	a5,a5,1
    80003514:	00f72023          	sw	a5,0(a4)
    80003518:	00001097          	auipc	ra,0x1
    8000351c:	540080e7          	jalr	1344(ra) # 80004a58 <release>
    80003520:	f65ff06f          	j	80003484 <kerneltrap+0x8c>
    80003524:	00001097          	auipc	ra,0x1
    80003528:	09c080e7          	jalr	156(ra) # 800045c0 <uartintr>
    8000352c:	fa5ff06f          	j	800034d0 <kerneltrap+0xd8>
    80003530:	00003517          	auipc	a0,0x3
    80003534:	fc050513          	addi	a0,a0,-64 # 800064f0 <_ZTV7WorkerD+0xd8>
    80003538:	00000097          	auipc	ra,0x0
    8000353c:	724080e7          	jalr	1828(ra) # 80003c5c <panic>

0000000080003540 <clockintr>:
    80003540:	fe010113          	addi	sp,sp,-32
    80003544:	00813823          	sd	s0,16(sp)
    80003548:	00913423          	sd	s1,8(sp)
    8000354c:	00113c23          	sd	ra,24(sp)
    80003550:	02010413          	addi	s0,sp,32
    80003554:	00005497          	auipc	s1,0x5
    80003558:	d1c48493          	addi	s1,s1,-740 # 80008270 <tickslock>
    8000355c:	00048513          	mv	a0,s1
    80003560:	00001097          	auipc	ra,0x1
    80003564:	42c080e7          	jalr	1068(ra) # 8000498c <acquire>
    80003568:	00004717          	auipc	a4,0x4
    8000356c:	c1c70713          	addi	a4,a4,-996 # 80007184 <ticks>
    80003570:	00072783          	lw	a5,0(a4)
    80003574:	01013403          	ld	s0,16(sp)
    80003578:	01813083          	ld	ra,24(sp)
    8000357c:	00048513          	mv	a0,s1
    80003580:	0017879b          	addiw	a5,a5,1
    80003584:	00813483          	ld	s1,8(sp)
    80003588:	00f72023          	sw	a5,0(a4)
    8000358c:	02010113          	addi	sp,sp,32
    80003590:	00001317          	auipc	t1,0x1
    80003594:	4c830067          	jr	1224(t1) # 80004a58 <release>

0000000080003598 <devintr>:
    80003598:	142027f3          	csrr	a5,scause
    8000359c:	00000513          	li	a0,0
    800035a0:	0007c463          	bltz	a5,800035a8 <devintr+0x10>
    800035a4:	00008067          	ret
    800035a8:	fe010113          	addi	sp,sp,-32
    800035ac:	00813823          	sd	s0,16(sp)
    800035b0:	00113c23          	sd	ra,24(sp)
    800035b4:	00913423          	sd	s1,8(sp)
    800035b8:	02010413          	addi	s0,sp,32
    800035bc:	0ff7f713          	andi	a4,a5,255
    800035c0:	00900693          	li	a3,9
    800035c4:	04d70c63          	beq	a4,a3,8000361c <devintr+0x84>
    800035c8:	fff00713          	li	a4,-1
    800035cc:	03f71713          	slli	a4,a4,0x3f
    800035d0:	00170713          	addi	a4,a4,1
    800035d4:	00e78c63          	beq	a5,a4,800035ec <devintr+0x54>
    800035d8:	01813083          	ld	ra,24(sp)
    800035dc:	01013403          	ld	s0,16(sp)
    800035e0:	00813483          	ld	s1,8(sp)
    800035e4:	02010113          	addi	sp,sp,32
    800035e8:	00008067          	ret
    800035ec:	00000097          	auipc	ra,0x0
    800035f0:	c8c080e7          	jalr	-884(ra) # 80003278 <cpuid>
    800035f4:	06050663          	beqz	a0,80003660 <devintr+0xc8>
    800035f8:	144027f3          	csrr	a5,sip
    800035fc:	ffd7f793          	andi	a5,a5,-3
    80003600:	14479073          	csrw	sip,a5
    80003604:	01813083          	ld	ra,24(sp)
    80003608:	01013403          	ld	s0,16(sp)
    8000360c:	00813483          	ld	s1,8(sp)
    80003610:	00200513          	li	a0,2
    80003614:	02010113          	addi	sp,sp,32
    80003618:	00008067          	ret
    8000361c:	00000097          	auipc	ra,0x0
    80003620:	258080e7          	jalr	600(ra) # 80003874 <plic_claim>
    80003624:	00a00793          	li	a5,10
    80003628:	00050493          	mv	s1,a0
    8000362c:	06f50663          	beq	a0,a5,80003698 <devintr+0x100>
    80003630:	00100513          	li	a0,1
    80003634:	fa0482e3          	beqz	s1,800035d8 <devintr+0x40>
    80003638:	00048593          	mv	a1,s1
    8000363c:	00003517          	auipc	a0,0x3
    80003640:	ed450513          	addi	a0,a0,-300 # 80006510 <_ZTV7WorkerD+0xf8>
    80003644:	00000097          	auipc	ra,0x0
    80003648:	674080e7          	jalr	1652(ra) # 80003cb8 <__printf>
    8000364c:	00048513          	mv	a0,s1
    80003650:	00000097          	auipc	ra,0x0
    80003654:	25c080e7          	jalr	604(ra) # 800038ac <plic_complete>
    80003658:	00100513          	li	a0,1
    8000365c:	f7dff06f          	j	800035d8 <devintr+0x40>
    80003660:	00005517          	auipc	a0,0x5
    80003664:	c1050513          	addi	a0,a0,-1008 # 80008270 <tickslock>
    80003668:	00001097          	auipc	ra,0x1
    8000366c:	324080e7          	jalr	804(ra) # 8000498c <acquire>
    80003670:	00004717          	auipc	a4,0x4
    80003674:	b1470713          	addi	a4,a4,-1260 # 80007184 <ticks>
    80003678:	00072783          	lw	a5,0(a4)
    8000367c:	00005517          	auipc	a0,0x5
    80003680:	bf450513          	addi	a0,a0,-1036 # 80008270 <tickslock>
    80003684:	0017879b          	addiw	a5,a5,1
    80003688:	00f72023          	sw	a5,0(a4)
    8000368c:	00001097          	auipc	ra,0x1
    80003690:	3cc080e7          	jalr	972(ra) # 80004a58 <release>
    80003694:	f65ff06f          	j	800035f8 <devintr+0x60>
    80003698:	00001097          	auipc	ra,0x1
    8000369c:	f28080e7          	jalr	-216(ra) # 800045c0 <uartintr>
    800036a0:	fadff06f          	j	8000364c <devintr+0xb4>
	...

00000000800036b0 <kernelvec>:
    800036b0:	f0010113          	addi	sp,sp,-256
    800036b4:	00113023          	sd	ra,0(sp)
    800036b8:	00213423          	sd	sp,8(sp)
    800036bc:	00313823          	sd	gp,16(sp)
    800036c0:	00413c23          	sd	tp,24(sp)
    800036c4:	02513023          	sd	t0,32(sp)
    800036c8:	02613423          	sd	t1,40(sp)
    800036cc:	02713823          	sd	t2,48(sp)
    800036d0:	02813c23          	sd	s0,56(sp)
    800036d4:	04913023          	sd	s1,64(sp)
    800036d8:	04a13423          	sd	a0,72(sp)
    800036dc:	04b13823          	sd	a1,80(sp)
    800036e0:	04c13c23          	sd	a2,88(sp)
    800036e4:	06d13023          	sd	a3,96(sp)
    800036e8:	06e13423          	sd	a4,104(sp)
    800036ec:	06f13823          	sd	a5,112(sp)
    800036f0:	07013c23          	sd	a6,120(sp)
    800036f4:	09113023          	sd	a7,128(sp)
    800036f8:	09213423          	sd	s2,136(sp)
    800036fc:	09313823          	sd	s3,144(sp)
    80003700:	09413c23          	sd	s4,152(sp)
    80003704:	0b513023          	sd	s5,160(sp)
    80003708:	0b613423          	sd	s6,168(sp)
    8000370c:	0b713823          	sd	s7,176(sp)
    80003710:	0b813c23          	sd	s8,184(sp)
    80003714:	0d913023          	sd	s9,192(sp)
    80003718:	0da13423          	sd	s10,200(sp)
    8000371c:	0db13823          	sd	s11,208(sp)
    80003720:	0dc13c23          	sd	t3,216(sp)
    80003724:	0fd13023          	sd	t4,224(sp)
    80003728:	0fe13423          	sd	t5,232(sp)
    8000372c:	0ff13823          	sd	t6,240(sp)
    80003730:	cc9ff0ef          	jal	ra,800033f8 <kerneltrap>
    80003734:	00013083          	ld	ra,0(sp)
    80003738:	00813103          	ld	sp,8(sp)
    8000373c:	01013183          	ld	gp,16(sp)
    80003740:	02013283          	ld	t0,32(sp)
    80003744:	02813303          	ld	t1,40(sp)
    80003748:	03013383          	ld	t2,48(sp)
    8000374c:	03813403          	ld	s0,56(sp)
    80003750:	04013483          	ld	s1,64(sp)
    80003754:	04813503          	ld	a0,72(sp)
    80003758:	05013583          	ld	a1,80(sp)
    8000375c:	05813603          	ld	a2,88(sp)
    80003760:	06013683          	ld	a3,96(sp)
    80003764:	06813703          	ld	a4,104(sp)
    80003768:	07013783          	ld	a5,112(sp)
    8000376c:	07813803          	ld	a6,120(sp)
    80003770:	08013883          	ld	a7,128(sp)
    80003774:	08813903          	ld	s2,136(sp)
    80003778:	09013983          	ld	s3,144(sp)
    8000377c:	09813a03          	ld	s4,152(sp)
    80003780:	0a013a83          	ld	s5,160(sp)
    80003784:	0a813b03          	ld	s6,168(sp)
    80003788:	0b013b83          	ld	s7,176(sp)
    8000378c:	0b813c03          	ld	s8,184(sp)
    80003790:	0c013c83          	ld	s9,192(sp)
    80003794:	0c813d03          	ld	s10,200(sp)
    80003798:	0d013d83          	ld	s11,208(sp)
    8000379c:	0d813e03          	ld	t3,216(sp)
    800037a0:	0e013e83          	ld	t4,224(sp)
    800037a4:	0e813f03          	ld	t5,232(sp)
    800037a8:	0f013f83          	ld	t6,240(sp)
    800037ac:	10010113          	addi	sp,sp,256
    800037b0:	10200073          	sret
    800037b4:	00000013          	nop
    800037b8:	00000013          	nop
    800037bc:	00000013          	nop

00000000800037c0 <timervec>:
    800037c0:	34051573          	csrrw	a0,mscratch,a0
    800037c4:	00b53023          	sd	a1,0(a0)
    800037c8:	00c53423          	sd	a2,8(a0)
    800037cc:	00d53823          	sd	a3,16(a0)
    800037d0:	01853583          	ld	a1,24(a0)
    800037d4:	02053603          	ld	a2,32(a0)
    800037d8:	0005b683          	ld	a3,0(a1)
    800037dc:	00c686b3          	add	a3,a3,a2
    800037e0:	00d5b023          	sd	a3,0(a1)
    800037e4:	00200593          	li	a1,2
    800037e8:	14459073          	csrw	sip,a1
    800037ec:	01053683          	ld	a3,16(a0)
    800037f0:	00853603          	ld	a2,8(a0)
    800037f4:	00053583          	ld	a1,0(a0)
    800037f8:	34051573          	csrrw	a0,mscratch,a0
    800037fc:	30200073          	mret

0000000080003800 <plicinit>:
    80003800:	ff010113          	addi	sp,sp,-16
    80003804:	00813423          	sd	s0,8(sp)
    80003808:	01010413          	addi	s0,sp,16
    8000380c:	00813403          	ld	s0,8(sp)
    80003810:	0c0007b7          	lui	a5,0xc000
    80003814:	00100713          	li	a4,1
    80003818:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000381c:	00e7a223          	sw	a4,4(a5)
    80003820:	01010113          	addi	sp,sp,16
    80003824:	00008067          	ret

0000000080003828 <plicinithart>:
    80003828:	ff010113          	addi	sp,sp,-16
    8000382c:	00813023          	sd	s0,0(sp)
    80003830:	00113423          	sd	ra,8(sp)
    80003834:	01010413          	addi	s0,sp,16
    80003838:	00000097          	auipc	ra,0x0
    8000383c:	a40080e7          	jalr	-1472(ra) # 80003278 <cpuid>
    80003840:	0085171b          	slliw	a4,a0,0x8
    80003844:	0c0027b7          	lui	a5,0xc002
    80003848:	00e787b3          	add	a5,a5,a4
    8000384c:	40200713          	li	a4,1026
    80003850:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003854:	00813083          	ld	ra,8(sp)
    80003858:	00013403          	ld	s0,0(sp)
    8000385c:	00d5151b          	slliw	a0,a0,0xd
    80003860:	0c2017b7          	lui	a5,0xc201
    80003864:	00a78533          	add	a0,a5,a0
    80003868:	00052023          	sw	zero,0(a0)
    8000386c:	01010113          	addi	sp,sp,16
    80003870:	00008067          	ret

0000000080003874 <plic_claim>:
    80003874:	ff010113          	addi	sp,sp,-16
    80003878:	00813023          	sd	s0,0(sp)
    8000387c:	00113423          	sd	ra,8(sp)
    80003880:	01010413          	addi	s0,sp,16
    80003884:	00000097          	auipc	ra,0x0
    80003888:	9f4080e7          	jalr	-1548(ra) # 80003278 <cpuid>
    8000388c:	00813083          	ld	ra,8(sp)
    80003890:	00013403          	ld	s0,0(sp)
    80003894:	00d5151b          	slliw	a0,a0,0xd
    80003898:	0c2017b7          	lui	a5,0xc201
    8000389c:	00a78533          	add	a0,a5,a0
    800038a0:	00452503          	lw	a0,4(a0)
    800038a4:	01010113          	addi	sp,sp,16
    800038a8:	00008067          	ret

00000000800038ac <plic_complete>:
    800038ac:	fe010113          	addi	sp,sp,-32
    800038b0:	00813823          	sd	s0,16(sp)
    800038b4:	00913423          	sd	s1,8(sp)
    800038b8:	00113c23          	sd	ra,24(sp)
    800038bc:	02010413          	addi	s0,sp,32
    800038c0:	00050493          	mv	s1,a0
    800038c4:	00000097          	auipc	ra,0x0
    800038c8:	9b4080e7          	jalr	-1612(ra) # 80003278 <cpuid>
    800038cc:	01813083          	ld	ra,24(sp)
    800038d0:	01013403          	ld	s0,16(sp)
    800038d4:	00d5179b          	slliw	a5,a0,0xd
    800038d8:	0c201737          	lui	a4,0xc201
    800038dc:	00f707b3          	add	a5,a4,a5
    800038e0:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    800038e4:	00813483          	ld	s1,8(sp)
    800038e8:	02010113          	addi	sp,sp,32
    800038ec:	00008067          	ret

00000000800038f0 <consolewrite>:
    800038f0:	fb010113          	addi	sp,sp,-80
    800038f4:	04813023          	sd	s0,64(sp)
    800038f8:	04113423          	sd	ra,72(sp)
    800038fc:	02913c23          	sd	s1,56(sp)
    80003900:	03213823          	sd	s2,48(sp)
    80003904:	03313423          	sd	s3,40(sp)
    80003908:	03413023          	sd	s4,32(sp)
    8000390c:	01513c23          	sd	s5,24(sp)
    80003910:	05010413          	addi	s0,sp,80
    80003914:	06c05c63          	blez	a2,8000398c <consolewrite+0x9c>
    80003918:	00060993          	mv	s3,a2
    8000391c:	00050a13          	mv	s4,a0
    80003920:	00058493          	mv	s1,a1
    80003924:	00000913          	li	s2,0
    80003928:	fff00a93          	li	s5,-1
    8000392c:	01c0006f          	j	80003948 <consolewrite+0x58>
    80003930:	fbf44503          	lbu	a0,-65(s0)
    80003934:	0019091b          	addiw	s2,s2,1
    80003938:	00148493          	addi	s1,s1,1
    8000393c:	00001097          	auipc	ra,0x1
    80003940:	a9c080e7          	jalr	-1380(ra) # 800043d8 <uartputc>
    80003944:	03298063          	beq	s3,s2,80003964 <consolewrite+0x74>
    80003948:	00048613          	mv	a2,s1
    8000394c:	00100693          	li	a3,1
    80003950:	000a0593          	mv	a1,s4
    80003954:	fbf40513          	addi	a0,s0,-65
    80003958:	00000097          	auipc	ra,0x0
    8000395c:	9d8080e7          	jalr	-1576(ra) # 80003330 <either_copyin>
    80003960:	fd5518e3          	bne	a0,s5,80003930 <consolewrite+0x40>
    80003964:	04813083          	ld	ra,72(sp)
    80003968:	04013403          	ld	s0,64(sp)
    8000396c:	03813483          	ld	s1,56(sp)
    80003970:	02813983          	ld	s3,40(sp)
    80003974:	02013a03          	ld	s4,32(sp)
    80003978:	01813a83          	ld	s5,24(sp)
    8000397c:	00090513          	mv	a0,s2
    80003980:	03013903          	ld	s2,48(sp)
    80003984:	05010113          	addi	sp,sp,80
    80003988:	00008067          	ret
    8000398c:	00000913          	li	s2,0
    80003990:	fd5ff06f          	j	80003964 <consolewrite+0x74>

0000000080003994 <consoleread>:
    80003994:	f9010113          	addi	sp,sp,-112
    80003998:	06813023          	sd	s0,96(sp)
    8000399c:	04913c23          	sd	s1,88(sp)
    800039a0:	05213823          	sd	s2,80(sp)
    800039a4:	05313423          	sd	s3,72(sp)
    800039a8:	05413023          	sd	s4,64(sp)
    800039ac:	03513c23          	sd	s5,56(sp)
    800039b0:	03613823          	sd	s6,48(sp)
    800039b4:	03713423          	sd	s7,40(sp)
    800039b8:	03813023          	sd	s8,32(sp)
    800039bc:	06113423          	sd	ra,104(sp)
    800039c0:	01913c23          	sd	s9,24(sp)
    800039c4:	07010413          	addi	s0,sp,112
    800039c8:	00060b93          	mv	s7,a2
    800039cc:	00050913          	mv	s2,a0
    800039d0:	00058c13          	mv	s8,a1
    800039d4:	00060b1b          	sext.w	s6,a2
    800039d8:	00005497          	auipc	s1,0x5
    800039dc:	8c048493          	addi	s1,s1,-1856 # 80008298 <cons>
    800039e0:	00400993          	li	s3,4
    800039e4:	fff00a13          	li	s4,-1
    800039e8:	00a00a93          	li	s5,10
    800039ec:	05705e63          	blez	s7,80003a48 <consoleread+0xb4>
    800039f0:	09c4a703          	lw	a4,156(s1)
    800039f4:	0984a783          	lw	a5,152(s1)
    800039f8:	0007071b          	sext.w	a4,a4
    800039fc:	08e78463          	beq	a5,a4,80003a84 <consoleread+0xf0>
    80003a00:	07f7f713          	andi	a4,a5,127
    80003a04:	00e48733          	add	a4,s1,a4
    80003a08:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80003a0c:	0017869b          	addiw	a3,a5,1
    80003a10:	08d4ac23          	sw	a3,152(s1)
    80003a14:	00070c9b          	sext.w	s9,a4
    80003a18:	0b370663          	beq	a4,s3,80003ac4 <consoleread+0x130>
    80003a1c:	00100693          	li	a3,1
    80003a20:	f9f40613          	addi	a2,s0,-97
    80003a24:	000c0593          	mv	a1,s8
    80003a28:	00090513          	mv	a0,s2
    80003a2c:	f8e40fa3          	sb	a4,-97(s0)
    80003a30:	00000097          	auipc	ra,0x0
    80003a34:	8b4080e7          	jalr	-1868(ra) # 800032e4 <either_copyout>
    80003a38:	01450863          	beq	a0,s4,80003a48 <consoleread+0xb4>
    80003a3c:	001c0c13          	addi	s8,s8,1
    80003a40:	fffb8b9b          	addiw	s7,s7,-1
    80003a44:	fb5c94e3          	bne	s9,s5,800039ec <consoleread+0x58>
    80003a48:	000b851b          	sext.w	a0,s7
    80003a4c:	06813083          	ld	ra,104(sp)
    80003a50:	06013403          	ld	s0,96(sp)
    80003a54:	05813483          	ld	s1,88(sp)
    80003a58:	05013903          	ld	s2,80(sp)
    80003a5c:	04813983          	ld	s3,72(sp)
    80003a60:	04013a03          	ld	s4,64(sp)
    80003a64:	03813a83          	ld	s5,56(sp)
    80003a68:	02813b83          	ld	s7,40(sp)
    80003a6c:	02013c03          	ld	s8,32(sp)
    80003a70:	01813c83          	ld	s9,24(sp)
    80003a74:	40ab053b          	subw	a0,s6,a0
    80003a78:	03013b03          	ld	s6,48(sp)
    80003a7c:	07010113          	addi	sp,sp,112
    80003a80:	00008067          	ret
    80003a84:	00001097          	auipc	ra,0x1
    80003a88:	1d8080e7          	jalr	472(ra) # 80004c5c <push_on>
    80003a8c:	0984a703          	lw	a4,152(s1)
    80003a90:	09c4a783          	lw	a5,156(s1)
    80003a94:	0007879b          	sext.w	a5,a5
    80003a98:	fef70ce3          	beq	a4,a5,80003a90 <consoleread+0xfc>
    80003a9c:	00001097          	auipc	ra,0x1
    80003aa0:	234080e7          	jalr	564(ra) # 80004cd0 <pop_on>
    80003aa4:	0984a783          	lw	a5,152(s1)
    80003aa8:	07f7f713          	andi	a4,a5,127
    80003aac:	00e48733          	add	a4,s1,a4
    80003ab0:	01874703          	lbu	a4,24(a4)
    80003ab4:	0017869b          	addiw	a3,a5,1
    80003ab8:	08d4ac23          	sw	a3,152(s1)
    80003abc:	00070c9b          	sext.w	s9,a4
    80003ac0:	f5371ee3          	bne	a4,s3,80003a1c <consoleread+0x88>
    80003ac4:	000b851b          	sext.w	a0,s7
    80003ac8:	f96bf2e3          	bgeu	s7,s6,80003a4c <consoleread+0xb8>
    80003acc:	08f4ac23          	sw	a5,152(s1)
    80003ad0:	f7dff06f          	j	80003a4c <consoleread+0xb8>

0000000080003ad4 <consputc>:
    80003ad4:	10000793          	li	a5,256
    80003ad8:	00f50663          	beq	a0,a5,80003ae4 <consputc+0x10>
    80003adc:	00001317          	auipc	t1,0x1
    80003ae0:	9f430067          	jr	-1548(t1) # 800044d0 <uartputc_sync>
    80003ae4:	ff010113          	addi	sp,sp,-16
    80003ae8:	00113423          	sd	ra,8(sp)
    80003aec:	00813023          	sd	s0,0(sp)
    80003af0:	01010413          	addi	s0,sp,16
    80003af4:	00800513          	li	a0,8
    80003af8:	00001097          	auipc	ra,0x1
    80003afc:	9d8080e7          	jalr	-1576(ra) # 800044d0 <uartputc_sync>
    80003b00:	02000513          	li	a0,32
    80003b04:	00001097          	auipc	ra,0x1
    80003b08:	9cc080e7          	jalr	-1588(ra) # 800044d0 <uartputc_sync>
    80003b0c:	00013403          	ld	s0,0(sp)
    80003b10:	00813083          	ld	ra,8(sp)
    80003b14:	00800513          	li	a0,8
    80003b18:	01010113          	addi	sp,sp,16
    80003b1c:	00001317          	auipc	t1,0x1
    80003b20:	9b430067          	jr	-1612(t1) # 800044d0 <uartputc_sync>

0000000080003b24 <consoleintr>:
    80003b24:	fe010113          	addi	sp,sp,-32
    80003b28:	00813823          	sd	s0,16(sp)
    80003b2c:	00913423          	sd	s1,8(sp)
    80003b30:	01213023          	sd	s2,0(sp)
    80003b34:	00113c23          	sd	ra,24(sp)
    80003b38:	02010413          	addi	s0,sp,32
    80003b3c:	00004917          	auipc	s2,0x4
    80003b40:	75c90913          	addi	s2,s2,1884 # 80008298 <cons>
    80003b44:	00050493          	mv	s1,a0
    80003b48:	00090513          	mv	a0,s2
    80003b4c:	00001097          	auipc	ra,0x1
    80003b50:	e40080e7          	jalr	-448(ra) # 8000498c <acquire>
    80003b54:	02048c63          	beqz	s1,80003b8c <consoleintr+0x68>
    80003b58:	0a092783          	lw	a5,160(s2)
    80003b5c:	09892703          	lw	a4,152(s2)
    80003b60:	07f00693          	li	a3,127
    80003b64:	40e7873b          	subw	a4,a5,a4
    80003b68:	02e6e263          	bltu	a3,a4,80003b8c <consoleintr+0x68>
    80003b6c:	00d00713          	li	a4,13
    80003b70:	04e48063          	beq	s1,a4,80003bb0 <consoleintr+0x8c>
    80003b74:	07f7f713          	andi	a4,a5,127
    80003b78:	00e90733          	add	a4,s2,a4
    80003b7c:	0017879b          	addiw	a5,a5,1
    80003b80:	0af92023          	sw	a5,160(s2)
    80003b84:	00970c23          	sb	s1,24(a4)
    80003b88:	08f92e23          	sw	a5,156(s2)
    80003b8c:	01013403          	ld	s0,16(sp)
    80003b90:	01813083          	ld	ra,24(sp)
    80003b94:	00813483          	ld	s1,8(sp)
    80003b98:	00013903          	ld	s2,0(sp)
    80003b9c:	00004517          	auipc	a0,0x4
    80003ba0:	6fc50513          	addi	a0,a0,1788 # 80008298 <cons>
    80003ba4:	02010113          	addi	sp,sp,32
    80003ba8:	00001317          	auipc	t1,0x1
    80003bac:	eb030067          	jr	-336(t1) # 80004a58 <release>
    80003bb0:	00a00493          	li	s1,10
    80003bb4:	fc1ff06f          	j	80003b74 <consoleintr+0x50>

0000000080003bb8 <consoleinit>:
    80003bb8:	fe010113          	addi	sp,sp,-32
    80003bbc:	00113c23          	sd	ra,24(sp)
    80003bc0:	00813823          	sd	s0,16(sp)
    80003bc4:	00913423          	sd	s1,8(sp)
    80003bc8:	02010413          	addi	s0,sp,32
    80003bcc:	00004497          	auipc	s1,0x4
    80003bd0:	6cc48493          	addi	s1,s1,1740 # 80008298 <cons>
    80003bd4:	00048513          	mv	a0,s1
    80003bd8:	00003597          	auipc	a1,0x3
    80003bdc:	99058593          	addi	a1,a1,-1648 # 80006568 <_ZTV7WorkerD+0x150>
    80003be0:	00001097          	auipc	ra,0x1
    80003be4:	d88080e7          	jalr	-632(ra) # 80004968 <initlock>
    80003be8:	00000097          	auipc	ra,0x0
    80003bec:	7ac080e7          	jalr	1964(ra) # 80004394 <uartinit>
    80003bf0:	01813083          	ld	ra,24(sp)
    80003bf4:	01013403          	ld	s0,16(sp)
    80003bf8:	00000797          	auipc	a5,0x0
    80003bfc:	d9c78793          	addi	a5,a5,-612 # 80003994 <consoleread>
    80003c00:	0af4bc23          	sd	a5,184(s1)
    80003c04:	00000797          	auipc	a5,0x0
    80003c08:	cec78793          	addi	a5,a5,-788 # 800038f0 <consolewrite>
    80003c0c:	0cf4b023          	sd	a5,192(s1)
    80003c10:	00813483          	ld	s1,8(sp)
    80003c14:	02010113          	addi	sp,sp,32
    80003c18:	00008067          	ret

0000000080003c1c <console_read>:
    80003c1c:	ff010113          	addi	sp,sp,-16
    80003c20:	00813423          	sd	s0,8(sp)
    80003c24:	01010413          	addi	s0,sp,16
    80003c28:	00813403          	ld	s0,8(sp)
    80003c2c:	00004317          	auipc	t1,0x4
    80003c30:	72433303          	ld	t1,1828(t1) # 80008350 <devsw+0x10>
    80003c34:	01010113          	addi	sp,sp,16
    80003c38:	00030067          	jr	t1

0000000080003c3c <console_write>:
    80003c3c:	ff010113          	addi	sp,sp,-16
    80003c40:	00813423          	sd	s0,8(sp)
    80003c44:	01010413          	addi	s0,sp,16
    80003c48:	00813403          	ld	s0,8(sp)
    80003c4c:	00004317          	auipc	t1,0x4
    80003c50:	70c33303          	ld	t1,1804(t1) # 80008358 <devsw+0x18>
    80003c54:	01010113          	addi	sp,sp,16
    80003c58:	00030067          	jr	t1

0000000080003c5c <panic>:
    80003c5c:	fe010113          	addi	sp,sp,-32
    80003c60:	00113c23          	sd	ra,24(sp)
    80003c64:	00813823          	sd	s0,16(sp)
    80003c68:	00913423          	sd	s1,8(sp)
    80003c6c:	02010413          	addi	s0,sp,32
    80003c70:	00050493          	mv	s1,a0
    80003c74:	00003517          	auipc	a0,0x3
    80003c78:	8fc50513          	addi	a0,a0,-1796 # 80006570 <_ZTV7WorkerD+0x158>
    80003c7c:	00004797          	auipc	a5,0x4
    80003c80:	7607ae23          	sw	zero,1916(a5) # 800083f8 <pr+0x18>
    80003c84:	00000097          	auipc	ra,0x0
    80003c88:	034080e7          	jalr	52(ra) # 80003cb8 <__printf>
    80003c8c:	00048513          	mv	a0,s1
    80003c90:	00000097          	auipc	ra,0x0
    80003c94:	028080e7          	jalr	40(ra) # 80003cb8 <__printf>
    80003c98:	00003517          	auipc	a0,0x3
    80003c9c:	8b850513          	addi	a0,a0,-1864 # 80006550 <_ZTV7WorkerD+0x138>
    80003ca0:	00000097          	auipc	ra,0x0
    80003ca4:	018080e7          	jalr	24(ra) # 80003cb8 <__printf>
    80003ca8:	00100793          	li	a5,1
    80003cac:	00003717          	auipc	a4,0x3
    80003cb0:	4cf72e23          	sw	a5,1244(a4) # 80007188 <panicked>
    80003cb4:	0000006f          	j	80003cb4 <panic+0x58>

0000000080003cb8 <__printf>:
    80003cb8:	f3010113          	addi	sp,sp,-208
    80003cbc:	08813023          	sd	s0,128(sp)
    80003cc0:	07313423          	sd	s3,104(sp)
    80003cc4:	09010413          	addi	s0,sp,144
    80003cc8:	05813023          	sd	s8,64(sp)
    80003ccc:	08113423          	sd	ra,136(sp)
    80003cd0:	06913c23          	sd	s1,120(sp)
    80003cd4:	07213823          	sd	s2,112(sp)
    80003cd8:	07413023          	sd	s4,96(sp)
    80003cdc:	05513c23          	sd	s5,88(sp)
    80003ce0:	05613823          	sd	s6,80(sp)
    80003ce4:	05713423          	sd	s7,72(sp)
    80003ce8:	03913c23          	sd	s9,56(sp)
    80003cec:	03a13823          	sd	s10,48(sp)
    80003cf0:	03b13423          	sd	s11,40(sp)
    80003cf4:	00004317          	auipc	t1,0x4
    80003cf8:	6ec30313          	addi	t1,t1,1772 # 800083e0 <pr>
    80003cfc:	01832c03          	lw	s8,24(t1)
    80003d00:	00b43423          	sd	a1,8(s0)
    80003d04:	00c43823          	sd	a2,16(s0)
    80003d08:	00d43c23          	sd	a3,24(s0)
    80003d0c:	02e43023          	sd	a4,32(s0)
    80003d10:	02f43423          	sd	a5,40(s0)
    80003d14:	03043823          	sd	a6,48(s0)
    80003d18:	03143c23          	sd	a7,56(s0)
    80003d1c:	00050993          	mv	s3,a0
    80003d20:	4a0c1663          	bnez	s8,800041cc <__printf+0x514>
    80003d24:	60098c63          	beqz	s3,8000433c <__printf+0x684>
    80003d28:	0009c503          	lbu	a0,0(s3)
    80003d2c:	00840793          	addi	a5,s0,8
    80003d30:	f6f43c23          	sd	a5,-136(s0)
    80003d34:	00000493          	li	s1,0
    80003d38:	22050063          	beqz	a0,80003f58 <__printf+0x2a0>
    80003d3c:	00002a37          	lui	s4,0x2
    80003d40:	00018ab7          	lui	s5,0x18
    80003d44:	000f4b37          	lui	s6,0xf4
    80003d48:	00989bb7          	lui	s7,0x989
    80003d4c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80003d50:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80003d54:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80003d58:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80003d5c:	00148c9b          	addiw	s9,s1,1
    80003d60:	02500793          	li	a5,37
    80003d64:	01998933          	add	s2,s3,s9
    80003d68:	38f51263          	bne	a0,a5,800040ec <__printf+0x434>
    80003d6c:	00094783          	lbu	a5,0(s2)
    80003d70:	00078c9b          	sext.w	s9,a5
    80003d74:	1e078263          	beqz	a5,80003f58 <__printf+0x2a0>
    80003d78:	0024849b          	addiw	s1,s1,2
    80003d7c:	07000713          	li	a4,112
    80003d80:	00998933          	add	s2,s3,s1
    80003d84:	38e78a63          	beq	a5,a4,80004118 <__printf+0x460>
    80003d88:	20f76863          	bltu	a4,a5,80003f98 <__printf+0x2e0>
    80003d8c:	42a78863          	beq	a5,a0,800041bc <__printf+0x504>
    80003d90:	06400713          	li	a4,100
    80003d94:	40e79663          	bne	a5,a4,800041a0 <__printf+0x4e8>
    80003d98:	f7843783          	ld	a5,-136(s0)
    80003d9c:	0007a603          	lw	a2,0(a5)
    80003da0:	00878793          	addi	a5,a5,8
    80003da4:	f6f43c23          	sd	a5,-136(s0)
    80003da8:	42064a63          	bltz	a2,800041dc <__printf+0x524>
    80003dac:	00a00713          	li	a4,10
    80003db0:	02e677bb          	remuw	a5,a2,a4
    80003db4:	00002d97          	auipc	s11,0x2
    80003db8:	7e4d8d93          	addi	s11,s11,2020 # 80006598 <digits>
    80003dbc:	00900593          	li	a1,9
    80003dc0:	0006051b          	sext.w	a0,a2
    80003dc4:	00000c93          	li	s9,0
    80003dc8:	02079793          	slli	a5,a5,0x20
    80003dcc:	0207d793          	srli	a5,a5,0x20
    80003dd0:	00fd87b3          	add	a5,s11,a5
    80003dd4:	0007c783          	lbu	a5,0(a5)
    80003dd8:	02e656bb          	divuw	a3,a2,a4
    80003ddc:	f8f40023          	sb	a5,-128(s0)
    80003de0:	14c5d863          	bge	a1,a2,80003f30 <__printf+0x278>
    80003de4:	06300593          	li	a1,99
    80003de8:	00100c93          	li	s9,1
    80003dec:	02e6f7bb          	remuw	a5,a3,a4
    80003df0:	02079793          	slli	a5,a5,0x20
    80003df4:	0207d793          	srli	a5,a5,0x20
    80003df8:	00fd87b3          	add	a5,s11,a5
    80003dfc:	0007c783          	lbu	a5,0(a5)
    80003e00:	02e6d73b          	divuw	a4,a3,a4
    80003e04:	f8f400a3          	sb	a5,-127(s0)
    80003e08:	12a5f463          	bgeu	a1,a0,80003f30 <__printf+0x278>
    80003e0c:	00a00693          	li	a3,10
    80003e10:	00900593          	li	a1,9
    80003e14:	02d777bb          	remuw	a5,a4,a3
    80003e18:	02079793          	slli	a5,a5,0x20
    80003e1c:	0207d793          	srli	a5,a5,0x20
    80003e20:	00fd87b3          	add	a5,s11,a5
    80003e24:	0007c503          	lbu	a0,0(a5)
    80003e28:	02d757bb          	divuw	a5,a4,a3
    80003e2c:	f8a40123          	sb	a0,-126(s0)
    80003e30:	48e5f263          	bgeu	a1,a4,800042b4 <__printf+0x5fc>
    80003e34:	06300513          	li	a0,99
    80003e38:	02d7f5bb          	remuw	a1,a5,a3
    80003e3c:	02059593          	slli	a1,a1,0x20
    80003e40:	0205d593          	srli	a1,a1,0x20
    80003e44:	00bd85b3          	add	a1,s11,a1
    80003e48:	0005c583          	lbu	a1,0(a1)
    80003e4c:	02d7d7bb          	divuw	a5,a5,a3
    80003e50:	f8b401a3          	sb	a1,-125(s0)
    80003e54:	48e57263          	bgeu	a0,a4,800042d8 <__printf+0x620>
    80003e58:	3e700513          	li	a0,999
    80003e5c:	02d7f5bb          	remuw	a1,a5,a3
    80003e60:	02059593          	slli	a1,a1,0x20
    80003e64:	0205d593          	srli	a1,a1,0x20
    80003e68:	00bd85b3          	add	a1,s11,a1
    80003e6c:	0005c583          	lbu	a1,0(a1)
    80003e70:	02d7d7bb          	divuw	a5,a5,a3
    80003e74:	f8b40223          	sb	a1,-124(s0)
    80003e78:	46e57663          	bgeu	a0,a4,800042e4 <__printf+0x62c>
    80003e7c:	02d7f5bb          	remuw	a1,a5,a3
    80003e80:	02059593          	slli	a1,a1,0x20
    80003e84:	0205d593          	srli	a1,a1,0x20
    80003e88:	00bd85b3          	add	a1,s11,a1
    80003e8c:	0005c583          	lbu	a1,0(a1)
    80003e90:	02d7d7bb          	divuw	a5,a5,a3
    80003e94:	f8b402a3          	sb	a1,-123(s0)
    80003e98:	46ea7863          	bgeu	s4,a4,80004308 <__printf+0x650>
    80003e9c:	02d7f5bb          	remuw	a1,a5,a3
    80003ea0:	02059593          	slli	a1,a1,0x20
    80003ea4:	0205d593          	srli	a1,a1,0x20
    80003ea8:	00bd85b3          	add	a1,s11,a1
    80003eac:	0005c583          	lbu	a1,0(a1)
    80003eb0:	02d7d7bb          	divuw	a5,a5,a3
    80003eb4:	f8b40323          	sb	a1,-122(s0)
    80003eb8:	3eeaf863          	bgeu	s5,a4,800042a8 <__printf+0x5f0>
    80003ebc:	02d7f5bb          	remuw	a1,a5,a3
    80003ec0:	02059593          	slli	a1,a1,0x20
    80003ec4:	0205d593          	srli	a1,a1,0x20
    80003ec8:	00bd85b3          	add	a1,s11,a1
    80003ecc:	0005c583          	lbu	a1,0(a1)
    80003ed0:	02d7d7bb          	divuw	a5,a5,a3
    80003ed4:	f8b403a3          	sb	a1,-121(s0)
    80003ed8:	42eb7e63          	bgeu	s6,a4,80004314 <__printf+0x65c>
    80003edc:	02d7f5bb          	remuw	a1,a5,a3
    80003ee0:	02059593          	slli	a1,a1,0x20
    80003ee4:	0205d593          	srli	a1,a1,0x20
    80003ee8:	00bd85b3          	add	a1,s11,a1
    80003eec:	0005c583          	lbu	a1,0(a1)
    80003ef0:	02d7d7bb          	divuw	a5,a5,a3
    80003ef4:	f8b40423          	sb	a1,-120(s0)
    80003ef8:	42ebfc63          	bgeu	s7,a4,80004330 <__printf+0x678>
    80003efc:	02079793          	slli	a5,a5,0x20
    80003f00:	0207d793          	srli	a5,a5,0x20
    80003f04:	00fd8db3          	add	s11,s11,a5
    80003f08:	000dc703          	lbu	a4,0(s11)
    80003f0c:	00a00793          	li	a5,10
    80003f10:	00900c93          	li	s9,9
    80003f14:	f8e404a3          	sb	a4,-119(s0)
    80003f18:	00065c63          	bgez	a2,80003f30 <__printf+0x278>
    80003f1c:	f9040713          	addi	a4,s0,-112
    80003f20:	00f70733          	add	a4,a4,a5
    80003f24:	02d00693          	li	a3,45
    80003f28:	fed70823          	sb	a3,-16(a4)
    80003f2c:	00078c93          	mv	s9,a5
    80003f30:	f8040793          	addi	a5,s0,-128
    80003f34:	01978cb3          	add	s9,a5,s9
    80003f38:	f7f40d13          	addi	s10,s0,-129
    80003f3c:	000cc503          	lbu	a0,0(s9)
    80003f40:	fffc8c93          	addi	s9,s9,-1
    80003f44:	00000097          	auipc	ra,0x0
    80003f48:	b90080e7          	jalr	-1136(ra) # 80003ad4 <consputc>
    80003f4c:	ffac98e3          	bne	s9,s10,80003f3c <__printf+0x284>
    80003f50:	00094503          	lbu	a0,0(s2)
    80003f54:	e00514e3          	bnez	a0,80003d5c <__printf+0xa4>
    80003f58:	1a0c1663          	bnez	s8,80004104 <__printf+0x44c>
    80003f5c:	08813083          	ld	ra,136(sp)
    80003f60:	08013403          	ld	s0,128(sp)
    80003f64:	07813483          	ld	s1,120(sp)
    80003f68:	07013903          	ld	s2,112(sp)
    80003f6c:	06813983          	ld	s3,104(sp)
    80003f70:	06013a03          	ld	s4,96(sp)
    80003f74:	05813a83          	ld	s5,88(sp)
    80003f78:	05013b03          	ld	s6,80(sp)
    80003f7c:	04813b83          	ld	s7,72(sp)
    80003f80:	04013c03          	ld	s8,64(sp)
    80003f84:	03813c83          	ld	s9,56(sp)
    80003f88:	03013d03          	ld	s10,48(sp)
    80003f8c:	02813d83          	ld	s11,40(sp)
    80003f90:	0d010113          	addi	sp,sp,208
    80003f94:	00008067          	ret
    80003f98:	07300713          	li	a4,115
    80003f9c:	1ce78a63          	beq	a5,a4,80004170 <__printf+0x4b8>
    80003fa0:	07800713          	li	a4,120
    80003fa4:	1ee79e63          	bne	a5,a4,800041a0 <__printf+0x4e8>
    80003fa8:	f7843783          	ld	a5,-136(s0)
    80003fac:	0007a703          	lw	a4,0(a5)
    80003fb0:	00878793          	addi	a5,a5,8
    80003fb4:	f6f43c23          	sd	a5,-136(s0)
    80003fb8:	28074263          	bltz	a4,8000423c <__printf+0x584>
    80003fbc:	00002d97          	auipc	s11,0x2
    80003fc0:	5dcd8d93          	addi	s11,s11,1500 # 80006598 <digits>
    80003fc4:	00f77793          	andi	a5,a4,15
    80003fc8:	00fd87b3          	add	a5,s11,a5
    80003fcc:	0007c683          	lbu	a3,0(a5)
    80003fd0:	00f00613          	li	a2,15
    80003fd4:	0007079b          	sext.w	a5,a4
    80003fd8:	f8d40023          	sb	a3,-128(s0)
    80003fdc:	0047559b          	srliw	a1,a4,0x4
    80003fe0:	0047569b          	srliw	a3,a4,0x4
    80003fe4:	00000c93          	li	s9,0
    80003fe8:	0ee65063          	bge	a2,a4,800040c8 <__printf+0x410>
    80003fec:	00f6f693          	andi	a3,a3,15
    80003ff0:	00dd86b3          	add	a3,s11,a3
    80003ff4:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80003ff8:	0087d79b          	srliw	a5,a5,0x8
    80003ffc:	00100c93          	li	s9,1
    80004000:	f8d400a3          	sb	a3,-127(s0)
    80004004:	0cb67263          	bgeu	a2,a1,800040c8 <__printf+0x410>
    80004008:	00f7f693          	andi	a3,a5,15
    8000400c:	00dd86b3          	add	a3,s11,a3
    80004010:	0006c583          	lbu	a1,0(a3)
    80004014:	00f00613          	li	a2,15
    80004018:	0047d69b          	srliw	a3,a5,0x4
    8000401c:	f8b40123          	sb	a1,-126(s0)
    80004020:	0047d593          	srli	a1,a5,0x4
    80004024:	28f67e63          	bgeu	a2,a5,800042c0 <__printf+0x608>
    80004028:	00f6f693          	andi	a3,a3,15
    8000402c:	00dd86b3          	add	a3,s11,a3
    80004030:	0006c503          	lbu	a0,0(a3)
    80004034:	0087d813          	srli	a6,a5,0x8
    80004038:	0087d69b          	srliw	a3,a5,0x8
    8000403c:	f8a401a3          	sb	a0,-125(s0)
    80004040:	28b67663          	bgeu	a2,a1,800042cc <__printf+0x614>
    80004044:	00f6f693          	andi	a3,a3,15
    80004048:	00dd86b3          	add	a3,s11,a3
    8000404c:	0006c583          	lbu	a1,0(a3)
    80004050:	00c7d513          	srli	a0,a5,0xc
    80004054:	00c7d69b          	srliw	a3,a5,0xc
    80004058:	f8b40223          	sb	a1,-124(s0)
    8000405c:	29067a63          	bgeu	a2,a6,800042f0 <__printf+0x638>
    80004060:	00f6f693          	andi	a3,a3,15
    80004064:	00dd86b3          	add	a3,s11,a3
    80004068:	0006c583          	lbu	a1,0(a3)
    8000406c:	0107d813          	srli	a6,a5,0x10
    80004070:	0107d69b          	srliw	a3,a5,0x10
    80004074:	f8b402a3          	sb	a1,-123(s0)
    80004078:	28a67263          	bgeu	a2,a0,800042fc <__printf+0x644>
    8000407c:	00f6f693          	andi	a3,a3,15
    80004080:	00dd86b3          	add	a3,s11,a3
    80004084:	0006c683          	lbu	a3,0(a3)
    80004088:	0147d79b          	srliw	a5,a5,0x14
    8000408c:	f8d40323          	sb	a3,-122(s0)
    80004090:	21067663          	bgeu	a2,a6,8000429c <__printf+0x5e4>
    80004094:	02079793          	slli	a5,a5,0x20
    80004098:	0207d793          	srli	a5,a5,0x20
    8000409c:	00fd8db3          	add	s11,s11,a5
    800040a0:	000dc683          	lbu	a3,0(s11)
    800040a4:	00800793          	li	a5,8
    800040a8:	00700c93          	li	s9,7
    800040ac:	f8d403a3          	sb	a3,-121(s0)
    800040b0:	00075c63          	bgez	a4,800040c8 <__printf+0x410>
    800040b4:	f9040713          	addi	a4,s0,-112
    800040b8:	00f70733          	add	a4,a4,a5
    800040bc:	02d00693          	li	a3,45
    800040c0:	fed70823          	sb	a3,-16(a4)
    800040c4:	00078c93          	mv	s9,a5
    800040c8:	f8040793          	addi	a5,s0,-128
    800040cc:	01978cb3          	add	s9,a5,s9
    800040d0:	f7f40d13          	addi	s10,s0,-129
    800040d4:	000cc503          	lbu	a0,0(s9)
    800040d8:	fffc8c93          	addi	s9,s9,-1
    800040dc:	00000097          	auipc	ra,0x0
    800040e0:	9f8080e7          	jalr	-1544(ra) # 80003ad4 <consputc>
    800040e4:	ff9d18e3          	bne	s10,s9,800040d4 <__printf+0x41c>
    800040e8:	0100006f          	j	800040f8 <__printf+0x440>
    800040ec:	00000097          	auipc	ra,0x0
    800040f0:	9e8080e7          	jalr	-1560(ra) # 80003ad4 <consputc>
    800040f4:	000c8493          	mv	s1,s9
    800040f8:	00094503          	lbu	a0,0(s2)
    800040fc:	c60510e3          	bnez	a0,80003d5c <__printf+0xa4>
    80004100:	e40c0ee3          	beqz	s8,80003f5c <__printf+0x2a4>
    80004104:	00004517          	auipc	a0,0x4
    80004108:	2dc50513          	addi	a0,a0,732 # 800083e0 <pr>
    8000410c:	00001097          	auipc	ra,0x1
    80004110:	94c080e7          	jalr	-1716(ra) # 80004a58 <release>
    80004114:	e49ff06f          	j	80003f5c <__printf+0x2a4>
    80004118:	f7843783          	ld	a5,-136(s0)
    8000411c:	03000513          	li	a0,48
    80004120:	01000d13          	li	s10,16
    80004124:	00878713          	addi	a4,a5,8
    80004128:	0007bc83          	ld	s9,0(a5)
    8000412c:	f6e43c23          	sd	a4,-136(s0)
    80004130:	00000097          	auipc	ra,0x0
    80004134:	9a4080e7          	jalr	-1628(ra) # 80003ad4 <consputc>
    80004138:	07800513          	li	a0,120
    8000413c:	00000097          	auipc	ra,0x0
    80004140:	998080e7          	jalr	-1640(ra) # 80003ad4 <consputc>
    80004144:	00002d97          	auipc	s11,0x2
    80004148:	454d8d93          	addi	s11,s11,1108 # 80006598 <digits>
    8000414c:	03ccd793          	srli	a5,s9,0x3c
    80004150:	00fd87b3          	add	a5,s11,a5
    80004154:	0007c503          	lbu	a0,0(a5)
    80004158:	fffd0d1b          	addiw	s10,s10,-1
    8000415c:	004c9c93          	slli	s9,s9,0x4
    80004160:	00000097          	auipc	ra,0x0
    80004164:	974080e7          	jalr	-1676(ra) # 80003ad4 <consputc>
    80004168:	fe0d12e3          	bnez	s10,8000414c <__printf+0x494>
    8000416c:	f8dff06f          	j	800040f8 <__printf+0x440>
    80004170:	f7843783          	ld	a5,-136(s0)
    80004174:	0007bc83          	ld	s9,0(a5)
    80004178:	00878793          	addi	a5,a5,8
    8000417c:	f6f43c23          	sd	a5,-136(s0)
    80004180:	000c9a63          	bnez	s9,80004194 <__printf+0x4dc>
    80004184:	1080006f          	j	8000428c <__printf+0x5d4>
    80004188:	001c8c93          	addi	s9,s9,1
    8000418c:	00000097          	auipc	ra,0x0
    80004190:	948080e7          	jalr	-1720(ra) # 80003ad4 <consputc>
    80004194:	000cc503          	lbu	a0,0(s9)
    80004198:	fe0518e3          	bnez	a0,80004188 <__printf+0x4d0>
    8000419c:	f5dff06f          	j	800040f8 <__printf+0x440>
    800041a0:	02500513          	li	a0,37
    800041a4:	00000097          	auipc	ra,0x0
    800041a8:	930080e7          	jalr	-1744(ra) # 80003ad4 <consputc>
    800041ac:	000c8513          	mv	a0,s9
    800041b0:	00000097          	auipc	ra,0x0
    800041b4:	924080e7          	jalr	-1756(ra) # 80003ad4 <consputc>
    800041b8:	f41ff06f          	j	800040f8 <__printf+0x440>
    800041bc:	02500513          	li	a0,37
    800041c0:	00000097          	auipc	ra,0x0
    800041c4:	914080e7          	jalr	-1772(ra) # 80003ad4 <consputc>
    800041c8:	f31ff06f          	j	800040f8 <__printf+0x440>
    800041cc:	00030513          	mv	a0,t1
    800041d0:	00000097          	auipc	ra,0x0
    800041d4:	7bc080e7          	jalr	1980(ra) # 8000498c <acquire>
    800041d8:	b4dff06f          	j	80003d24 <__printf+0x6c>
    800041dc:	40c0053b          	negw	a0,a2
    800041e0:	00a00713          	li	a4,10
    800041e4:	02e576bb          	remuw	a3,a0,a4
    800041e8:	00002d97          	auipc	s11,0x2
    800041ec:	3b0d8d93          	addi	s11,s11,944 # 80006598 <digits>
    800041f0:	ff700593          	li	a1,-9
    800041f4:	02069693          	slli	a3,a3,0x20
    800041f8:	0206d693          	srli	a3,a3,0x20
    800041fc:	00dd86b3          	add	a3,s11,a3
    80004200:	0006c683          	lbu	a3,0(a3)
    80004204:	02e557bb          	divuw	a5,a0,a4
    80004208:	f8d40023          	sb	a3,-128(s0)
    8000420c:	10b65e63          	bge	a2,a1,80004328 <__printf+0x670>
    80004210:	06300593          	li	a1,99
    80004214:	02e7f6bb          	remuw	a3,a5,a4
    80004218:	02069693          	slli	a3,a3,0x20
    8000421c:	0206d693          	srli	a3,a3,0x20
    80004220:	00dd86b3          	add	a3,s11,a3
    80004224:	0006c683          	lbu	a3,0(a3)
    80004228:	02e7d73b          	divuw	a4,a5,a4
    8000422c:	00200793          	li	a5,2
    80004230:	f8d400a3          	sb	a3,-127(s0)
    80004234:	bca5ece3          	bltu	a1,a0,80003e0c <__printf+0x154>
    80004238:	ce5ff06f          	j	80003f1c <__printf+0x264>
    8000423c:	40e007bb          	negw	a5,a4
    80004240:	00002d97          	auipc	s11,0x2
    80004244:	358d8d93          	addi	s11,s11,856 # 80006598 <digits>
    80004248:	00f7f693          	andi	a3,a5,15
    8000424c:	00dd86b3          	add	a3,s11,a3
    80004250:	0006c583          	lbu	a1,0(a3)
    80004254:	ff100613          	li	a2,-15
    80004258:	0047d69b          	srliw	a3,a5,0x4
    8000425c:	f8b40023          	sb	a1,-128(s0)
    80004260:	0047d59b          	srliw	a1,a5,0x4
    80004264:	0ac75e63          	bge	a4,a2,80004320 <__printf+0x668>
    80004268:	00f6f693          	andi	a3,a3,15
    8000426c:	00dd86b3          	add	a3,s11,a3
    80004270:	0006c603          	lbu	a2,0(a3)
    80004274:	00f00693          	li	a3,15
    80004278:	0087d79b          	srliw	a5,a5,0x8
    8000427c:	f8c400a3          	sb	a2,-127(s0)
    80004280:	d8b6e4e3          	bltu	a3,a1,80004008 <__printf+0x350>
    80004284:	00200793          	li	a5,2
    80004288:	e2dff06f          	j	800040b4 <__printf+0x3fc>
    8000428c:	00002c97          	auipc	s9,0x2
    80004290:	2ecc8c93          	addi	s9,s9,748 # 80006578 <_ZTV7WorkerD+0x160>
    80004294:	02800513          	li	a0,40
    80004298:	ef1ff06f          	j	80004188 <__printf+0x4d0>
    8000429c:	00700793          	li	a5,7
    800042a0:	00600c93          	li	s9,6
    800042a4:	e0dff06f          	j	800040b0 <__printf+0x3f8>
    800042a8:	00700793          	li	a5,7
    800042ac:	00600c93          	li	s9,6
    800042b0:	c69ff06f          	j	80003f18 <__printf+0x260>
    800042b4:	00300793          	li	a5,3
    800042b8:	00200c93          	li	s9,2
    800042bc:	c5dff06f          	j	80003f18 <__printf+0x260>
    800042c0:	00300793          	li	a5,3
    800042c4:	00200c93          	li	s9,2
    800042c8:	de9ff06f          	j	800040b0 <__printf+0x3f8>
    800042cc:	00400793          	li	a5,4
    800042d0:	00300c93          	li	s9,3
    800042d4:	dddff06f          	j	800040b0 <__printf+0x3f8>
    800042d8:	00400793          	li	a5,4
    800042dc:	00300c93          	li	s9,3
    800042e0:	c39ff06f          	j	80003f18 <__printf+0x260>
    800042e4:	00500793          	li	a5,5
    800042e8:	00400c93          	li	s9,4
    800042ec:	c2dff06f          	j	80003f18 <__printf+0x260>
    800042f0:	00500793          	li	a5,5
    800042f4:	00400c93          	li	s9,4
    800042f8:	db9ff06f          	j	800040b0 <__printf+0x3f8>
    800042fc:	00600793          	li	a5,6
    80004300:	00500c93          	li	s9,5
    80004304:	dadff06f          	j	800040b0 <__printf+0x3f8>
    80004308:	00600793          	li	a5,6
    8000430c:	00500c93          	li	s9,5
    80004310:	c09ff06f          	j	80003f18 <__printf+0x260>
    80004314:	00800793          	li	a5,8
    80004318:	00700c93          	li	s9,7
    8000431c:	bfdff06f          	j	80003f18 <__printf+0x260>
    80004320:	00100793          	li	a5,1
    80004324:	d91ff06f          	j	800040b4 <__printf+0x3fc>
    80004328:	00100793          	li	a5,1
    8000432c:	bf1ff06f          	j	80003f1c <__printf+0x264>
    80004330:	00900793          	li	a5,9
    80004334:	00800c93          	li	s9,8
    80004338:	be1ff06f          	j	80003f18 <__printf+0x260>
    8000433c:	00002517          	auipc	a0,0x2
    80004340:	24450513          	addi	a0,a0,580 # 80006580 <_ZTV7WorkerD+0x168>
    80004344:	00000097          	auipc	ra,0x0
    80004348:	918080e7          	jalr	-1768(ra) # 80003c5c <panic>

000000008000434c <printfinit>:
    8000434c:	fe010113          	addi	sp,sp,-32
    80004350:	00813823          	sd	s0,16(sp)
    80004354:	00913423          	sd	s1,8(sp)
    80004358:	00113c23          	sd	ra,24(sp)
    8000435c:	02010413          	addi	s0,sp,32
    80004360:	00004497          	auipc	s1,0x4
    80004364:	08048493          	addi	s1,s1,128 # 800083e0 <pr>
    80004368:	00048513          	mv	a0,s1
    8000436c:	00002597          	auipc	a1,0x2
    80004370:	22458593          	addi	a1,a1,548 # 80006590 <_ZTV7WorkerD+0x178>
    80004374:	00000097          	auipc	ra,0x0
    80004378:	5f4080e7          	jalr	1524(ra) # 80004968 <initlock>
    8000437c:	01813083          	ld	ra,24(sp)
    80004380:	01013403          	ld	s0,16(sp)
    80004384:	0004ac23          	sw	zero,24(s1)
    80004388:	00813483          	ld	s1,8(sp)
    8000438c:	02010113          	addi	sp,sp,32
    80004390:	00008067          	ret

0000000080004394 <uartinit>:
    80004394:	ff010113          	addi	sp,sp,-16
    80004398:	00813423          	sd	s0,8(sp)
    8000439c:	01010413          	addi	s0,sp,16
    800043a0:	100007b7          	lui	a5,0x10000
    800043a4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800043a8:	f8000713          	li	a4,-128
    800043ac:	00e781a3          	sb	a4,3(a5)
    800043b0:	00300713          	li	a4,3
    800043b4:	00e78023          	sb	a4,0(a5)
    800043b8:	000780a3          	sb	zero,1(a5)
    800043bc:	00e781a3          	sb	a4,3(a5)
    800043c0:	00700693          	li	a3,7
    800043c4:	00d78123          	sb	a3,2(a5)
    800043c8:	00e780a3          	sb	a4,1(a5)
    800043cc:	00813403          	ld	s0,8(sp)
    800043d0:	01010113          	addi	sp,sp,16
    800043d4:	00008067          	ret

00000000800043d8 <uartputc>:
    800043d8:	00003797          	auipc	a5,0x3
    800043dc:	db07a783          	lw	a5,-592(a5) # 80007188 <panicked>
    800043e0:	00078463          	beqz	a5,800043e8 <uartputc+0x10>
    800043e4:	0000006f          	j	800043e4 <uartputc+0xc>
    800043e8:	fd010113          	addi	sp,sp,-48
    800043ec:	02813023          	sd	s0,32(sp)
    800043f0:	00913c23          	sd	s1,24(sp)
    800043f4:	01213823          	sd	s2,16(sp)
    800043f8:	01313423          	sd	s3,8(sp)
    800043fc:	02113423          	sd	ra,40(sp)
    80004400:	03010413          	addi	s0,sp,48
    80004404:	00003917          	auipc	s2,0x3
    80004408:	d8c90913          	addi	s2,s2,-628 # 80007190 <uart_tx_r>
    8000440c:	00093783          	ld	a5,0(s2)
    80004410:	00003497          	auipc	s1,0x3
    80004414:	d8848493          	addi	s1,s1,-632 # 80007198 <uart_tx_w>
    80004418:	0004b703          	ld	a4,0(s1)
    8000441c:	02078693          	addi	a3,a5,32
    80004420:	00050993          	mv	s3,a0
    80004424:	02e69c63          	bne	a3,a4,8000445c <uartputc+0x84>
    80004428:	00001097          	auipc	ra,0x1
    8000442c:	834080e7          	jalr	-1996(ra) # 80004c5c <push_on>
    80004430:	00093783          	ld	a5,0(s2)
    80004434:	0004b703          	ld	a4,0(s1)
    80004438:	02078793          	addi	a5,a5,32
    8000443c:	00e79463          	bne	a5,a4,80004444 <uartputc+0x6c>
    80004440:	0000006f          	j	80004440 <uartputc+0x68>
    80004444:	00001097          	auipc	ra,0x1
    80004448:	88c080e7          	jalr	-1908(ra) # 80004cd0 <pop_on>
    8000444c:	00093783          	ld	a5,0(s2)
    80004450:	0004b703          	ld	a4,0(s1)
    80004454:	02078693          	addi	a3,a5,32
    80004458:	fce688e3          	beq	a3,a4,80004428 <uartputc+0x50>
    8000445c:	01f77693          	andi	a3,a4,31
    80004460:	00004597          	auipc	a1,0x4
    80004464:	fa058593          	addi	a1,a1,-96 # 80008400 <uart_tx_buf>
    80004468:	00d586b3          	add	a3,a1,a3
    8000446c:	00170713          	addi	a4,a4,1
    80004470:	01368023          	sb	s3,0(a3)
    80004474:	00e4b023          	sd	a4,0(s1)
    80004478:	10000637          	lui	a2,0x10000
    8000447c:	02f71063          	bne	a4,a5,8000449c <uartputc+0xc4>
    80004480:	0340006f          	j	800044b4 <uartputc+0xdc>
    80004484:	00074703          	lbu	a4,0(a4)
    80004488:	00f93023          	sd	a5,0(s2)
    8000448c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80004490:	00093783          	ld	a5,0(s2)
    80004494:	0004b703          	ld	a4,0(s1)
    80004498:	00f70e63          	beq	a4,a5,800044b4 <uartputc+0xdc>
    8000449c:	00564683          	lbu	a3,5(a2)
    800044a0:	01f7f713          	andi	a4,a5,31
    800044a4:	00e58733          	add	a4,a1,a4
    800044a8:	0206f693          	andi	a3,a3,32
    800044ac:	00178793          	addi	a5,a5,1
    800044b0:	fc069ae3          	bnez	a3,80004484 <uartputc+0xac>
    800044b4:	02813083          	ld	ra,40(sp)
    800044b8:	02013403          	ld	s0,32(sp)
    800044bc:	01813483          	ld	s1,24(sp)
    800044c0:	01013903          	ld	s2,16(sp)
    800044c4:	00813983          	ld	s3,8(sp)
    800044c8:	03010113          	addi	sp,sp,48
    800044cc:	00008067          	ret

00000000800044d0 <uartputc_sync>:
    800044d0:	ff010113          	addi	sp,sp,-16
    800044d4:	00813423          	sd	s0,8(sp)
    800044d8:	01010413          	addi	s0,sp,16
    800044dc:	00003717          	auipc	a4,0x3
    800044e0:	cac72703          	lw	a4,-852(a4) # 80007188 <panicked>
    800044e4:	02071663          	bnez	a4,80004510 <uartputc_sync+0x40>
    800044e8:	00050793          	mv	a5,a0
    800044ec:	100006b7          	lui	a3,0x10000
    800044f0:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    800044f4:	02077713          	andi	a4,a4,32
    800044f8:	fe070ce3          	beqz	a4,800044f0 <uartputc_sync+0x20>
    800044fc:	0ff7f793          	andi	a5,a5,255
    80004500:	00f68023          	sb	a5,0(a3)
    80004504:	00813403          	ld	s0,8(sp)
    80004508:	01010113          	addi	sp,sp,16
    8000450c:	00008067          	ret
    80004510:	0000006f          	j	80004510 <uartputc_sync+0x40>

0000000080004514 <uartstart>:
    80004514:	ff010113          	addi	sp,sp,-16
    80004518:	00813423          	sd	s0,8(sp)
    8000451c:	01010413          	addi	s0,sp,16
    80004520:	00003617          	auipc	a2,0x3
    80004524:	c7060613          	addi	a2,a2,-912 # 80007190 <uart_tx_r>
    80004528:	00003517          	auipc	a0,0x3
    8000452c:	c7050513          	addi	a0,a0,-912 # 80007198 <uart_tx_w>
    80004530:	00063783          	ld	a5,0(a2)
    80004534:	00053703          	ld	a4,0(a0)
    80004538:	04f70263          	beq	a4,a5,8000457c <uartstart+0x68>
    8000453c:	100005b7          	lui	a1,0x10000
    80004540:	00004817          	auipc	a6,0x4
    80004544:	ec080813          	addi	a6,a6,-320 # 80008400 <uart_tx_buf>
    80004548:	01c0006f          	j	80004564 <uartstart+0x50>
    8000454c:	0006c703          	lbu	a4,0(a3)
    80004550:	00f63023          	sd	a5,0(a2)
    80004554:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004558:	00063783          	ld	a5,0(a2)
    8000455c:	00053703          	ld	a4,0(a0)
    80004560:	00f70e63          	beq	a4,a5,8000457c <uartstart+0x68>
    80004564:	01f7f713          	andi	a4,a5,31
    80004568:	00e806b3          	add	a3,a6,a4
    8000456c:	0055c703          	lbu	a4,5(a1)
    80004570:	00178793          	addi	a5,a5,1
    80004574:	02077713          	andi	a4,a4,32
    80004578:	fc071ae3          	bnez	a4,8000454c <uartstart+0x38>
    8000457c:	00813403          	ld	s0,8(sp)
    80004580:	01010113          	addi	sp,sp,16
    80004584:	00008067          	ret

0000000080004588 <uartgetc>:
    80004588:	ff010113          	addi	sp,sp,-16
    8000458c:	00813423          	sd	s0,8(sp)
    80004590:	01010413          	addi	s0,sp,16
    80004594:	10000737          	lui	a4,0x10000
    80004598:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000459c:	0017f793          	andi	a5,a5,1
    800045a0:	00078c63          	beqz	a5,800045b8 <uartgetc+0x30>
    800045a4:	00074503          	lbu	a0,0(a4)
    800045a8:	0ff57513          	andi	a0,a0,255
    800045ac:	00813403          	ld	s0,8(sp)
    800045b0:	01010113          	addi	sp,sp,16
    800045b4:	00008067          	ret
    800045b8:	fff00513          	li	a0,-1
    800045bc:	ff1ff06f          	j	800045ac <uartgetc+0x24>

00000000800045c0 <uartintr>:
    800045c0:	100007b7          	lui	a5,0x10000
    800045c4:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800045c8:	0017f793          	andi	a5,a5,1
    800045cc:	0a078463          	beqz	a5,80004674 <uartintr+0xb4>
    800045d0:	fe010113          	addi	sp,sp,-32
    800045d4:	00813823          	sd	s0,16(sp)
    800045d8:	00913423          	sd	s1,8(sp)
    800045dc:	00113c23          	sd	ra,24(sp)
    800045e0:	02010413          	addi	s0,sp,32
    800045e4:	100004b7          	lui	s1,0x10000
    800045e8:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    800045ec:	0ff57513          	andi	a0,a0,255
    800045f0:	fffff097          	auipc	ra,0xfffff
    800045f4:	534080e7          	jalr	1332(ra) # 80003b24 <consoleintr>
    800045f8:	0054c783          	lbu	a5,5(s1)
    800045fc:	0017f793          	andi	a5,a5,1
    80004600:	fe0794e3          	bnez	a5,800045e8 <uartintr+0x28>
    80004604:	00003617          	auipc	a2,0x3
    80004608:	b8c60613          	addi	a2,a2,-1140 # 80007190 <uart_tx_r>
    8000460c:	00003517          	auipc	a0,0x3
    80004610:	b8c50513          	addi	a0,a0,-1140 # 80007198 <uart_tx_w>
    80004614:	00063783          	ld	a5,0(a2)
    80004618:	00053703          	ld	a4,0(a0)
    8000461c:	04f70263          	beq	a4,a5,80004660 <uartintr+0xa0>
    80004620:	100005b7          	lui	a1,0x10000
    80004624:	00004817          	auipc	a6,0x4
    80004628:	ddc80813          	addi	a6,a6,-548 # 80008400 <uart_tx_buf>
    8000462c:	01c0006f          	j	80004648 <uartintr+0x88>
    80004630:	0006c703          	lbu	a4,0(a3)
    80004634:	00f63023          	sd	a5,0(a2)
    80004638:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000463c:	00063783          	ld	a5,0(a2)
    80004640:	00053703          	ld	a4,0(a0)
    80004644:	00f70e63          	beq	a4,a5,80004660 <uartintr+0xa0>
    80004648:	01f7f713          	andi	a4,a5,31
    8000464c:	00e806b3          	add	a3,a6,a4
    80004650:	0055c703          	lbu	a4,5(a1)
    80004654:	00178793          	addi	a5,a5,1
    80004658:	02077713          	andi	a4,a4,32
    8000465c:	fc071ae3          	bnez	a4,80004630 <uartintr+0x70>
    80004660:	01813083          	ld	ra,24(sp)
    80004664:	01013403          	ld	s0,16(sp)
    80004668:	00813483          	ld	s1,8(sp)
    8000466c:	02010113          	addi	sp,sp,32
    80004670:	00008067          	ret
    80004674:	00003617          	auipc	a2,0x3
    80004678:	b1c60613          	addi	a2,a2,-1252 # 80007190 <uart_tx_r>
    8000467c:	00003517          	auipc	a0,0x3
    80004680:	b1c50513          	addi	a0,a0,-1252 # 80007198 <uart_tx_w>
    80004684:	00063783          	ld	a5,0(a2)
    80004688:	00053703          	ld	a4,0(a0)
    8000468c:	04f70263          	beq	a4,a5,800046d0 <uartintr+0x110>
    80004690:	100005b7          	lui	a1,0x10000
    80004694:	00004817          	auipc	a6,0x4
    80004698:	d6c80813          	addi	a6,a6,-660 # 80008400 <uart_tx_buf>
    8000469c:	01c0006f          	j	800046b8 <uartintr+0xf8>
    800046a0:	0006c703          	lbu	a4,0(a3)
    800046a4:	00f63023          	sd	a5,0(a2)
    800046a8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800046ac:	00063783          	ld	a5,0(a2)
    800046b0:	00053703          	ld	a4,0(a0)
    800046b4:	02f70063          	beq	a4,a5,800046d4 <uartintr+0x114>
    800046b8:	01f7f713          	andi	a4,a5,31
    800046bc:	00e806b3          	add	a3,a6,a4
    800046c0:	0055c703          	lbu	a4,5(a1)
    800046c4:	00178793          	addi	a5,a5,1
    800046c8:	02077713          	andi	a4,a4,32
    800046cc:	fc071ae3          	bnez	a4,800046a0 <uartintr+0xe0>
    800046d0:	00008067          	ret
    800046d4:	00008067          	ret

00000000800046d8 <kinit>:
    800046d8:	fc010113          	addi	sp,sp,-64
    800046dc:	02913423          	sd	s1,40(sp)
    800046e0:	fffff7b7          	lui	a5,0xfffff
    800046e4:	00005497          	auipc	s1,0x5
    800046e8:	d4b48493          	addi	s1,s1,-693 # 8000942f <end+0xfff>
    800046ec:	02813823          	sd	s0,48(sp)
    800046f0:	01313c23          	sd	s3,24(sp)
    800046f4:	00f4f4b3          	and	s1,s1,a5
    800046f8:	02113c23          	sd	ra,56(sp)
    800046fc:	03213023          	sd	s2,32(sp)
    80004700:	01413823          	sd	s4,16(sp)
    80004704:	01513423          	sd	s5,8(sp)
    80004708:	04010413          	addi	s0,sp,64
    8000470c:	000017b7          	lui	a5,0x1
    80004710:	01100993          	li	s3,17
    80004714:	00f487b3          	add	a5,s1,a5
    80004718:	01b99993          	slli	s3,s3,0x1b
    8000471c:	06f9e063          	bltu	s3,a5,8000477c <kinit+0xa4>
    80004720:	00004a97          	auipc	s5,0x4
    80004724:	d10a8a93          	addi	s5,s5,-752 # 80008430 <end>
    80004728:	0754ec63          	bltu	s1,s5,800047a0 <kinit+0xc8>
    8000472c:	0734fa63          	bgeu	s1,s3,800047a0 <kinit+0xc8>
    80004730:	00088a37          	lui	s4,0x88
    80004734:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004738:	00003917          	auipc	s2,0x3
    8000473c:	a6890913          	addi	s2,s2,-1432 # 800071a0 <kmem>
    80004740:	00ca1a13          	slli	s4,s4,0xc
    80004744:	0140006f          	j	80004758 <kinit+0x80>
    80004748:	000017b7          	lui	a5,0x1
    8000474c:	00f484b3          	add	s1,s1,a5
    80004750:	0554e863          	bltu	s1,s5,800047a0 <kinit+0xc8>
    80004754:	0534f663          	bgeu	s1,s3,800047a0 <kinit+0xc8>
    80004758:	00001637          	lui	a2,0x1
    8000475c:	00100593          	li	a1,1
    80004760:	00048513          	mv	a0,s1
    80004764:	00000097          	auipc	ra,0x0
    80004768:	5e4080e7          	jalr	1508(ra) # 80004d48 <__memset>
    8000476c:	00093783          	ld	a5,0(s2)
    80004770:	00f4b023          	sd	a5,0(s1)
    80004774:	00993023          	sd	s1,0(s2)
    80004778:	fd4498e3          	bne	s1,s4,80004748 <kinit+0x70>
    8000477c:	03813083          	ld	ra,56(sp)
    80004780:	03013403          	ld	s0,48(sp)
    80004784:	02813483          	ld	s1,40(sp)
    80004788:	02013903          	ld	s2,32(sp)
    8000478c:	01813983          	ld	s3,24(sp)
    80004790:	01013a03          	ld	s4,16(sp)
    80004794:	00813a83          	ld	s5,8(sp)
    80004798:	04010113          	addi	sp,sp,64
    8000479c:	00008067          	ret
    800047a0:	00002517          	auipc	a0,0x2
    800047a4:	e1050513          	addi	a0,a0,-496 # 800065b0 <digits+0x18>
    800047a8:	fffff097          	auipc	ra,0xfffff
    800047ac:	4b4080e7          	jalr	1204(ra) # 80003c5c <panic>

00000000800047b0 <freerange>:
    800047b0:	fc010113          	addi	sp,sp,-64
    800047b4:	000017b7          	lui	a5,0x1
    800047b8:	02913423          	sd	s1,40(sp)
    800047bc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800047c0:	009504b3          	add	s1,a0,s1
    800047c4:	fffff537          	lui	a0,0xfffff
    800047c8:	02813823          	sd	s0,48(sp)
    800047cc:	02113c23          	sd	ra,56(sp)
    800047d0:	03213023          	sd	s2,32(sp)
    800047d4:	01313c23          	sd	s3,24(sp)
    800047d8:	01413823          	sd	s4,16(sp)
    800047dc:	01513423          	sd	s5,8(sp)
    800047e0:	01613023          	sd	s6,0(sp)
    800047e4:	04010413          	addi	s0,sp,64
    800047e8:	00a4f4b3          	and	s1,s1,a0
    800047ec:	00f487b3          	add	a5,s1,a5
    800047f0:	06f5e463          	bltu	a1,a5,80004858 <freerange+0xa8>
    800047f4:	00004a97          	auipc	s5,0x4
    800047f8:	c3ca8a93          	addi	s5,s5,-964 # 80008430 <end>
    800047fc:	0954e263          	bltu	s1,s5,80004880 <freerange+0xd0>
    80004800:	01100993          	li	s3,17
    80004804:	01b99993          	slli	s3,s3,0x1b
    80004808:	0734fc63          	bgeu	s1,s3,80004880 <freerange+0xd0>
    8000480c:	00058a13          	mv	s4,a1
    80004810:	00003917          	auipc	s2,0x3
    80004814:	99090913          	addi	s2,s2,-1648 # 800071a0 <kmem>
    80004818:	00002b37          	lui	s6,0x2
    8000481c:	0140006f          	j	80004830 <freerange+0x80>
    80004820:	000017b7          	lui	a5,0x1
    80004824:	00f484b3          	add	s1,s1,a5
    80004828:	0554ec63          	bltu	s1,s5,80004880 <freerange+0xd0>
    8000482c:	0534fa63          	bgeu	s1,s3,80004880 <freerange+0xd0>
    80004830:	00001637          	lui	a2,0x1
    80004834:	00100593          	li	a1,1
    80004838:	00048513          	mv	a0,s1
    8000483c:	00000097          	auipc	ra,0x0
    80004840:	50c080e7          	jalr	1292(ra) # 80004d48 <__memset>
    80004844:	00093703          	ld	a4,0(s2)
    80004848:	016487b3          	add	a5,s1,s6
    8000484c:	00e4b023          	sd	a4,0(s1)
    80004850:	00993023          	sd	s1,0(s2)
    80004854:	fcfa76e3          	bgeu	s4,a5,80004820 <freerange+0x70>
    80004858:	03813083          	ld	ra,56(sp)
    8000485c:	03013403          	ld	s0,48(sp)
    80004860:	02813483          	ld	s1,40(sp)
    80004864:	02013903          	ld	s2,32(sp)
    80004868:	01813983          	ld	s3,24(sp)
    8000486c:	01013a03          	ld	s4,16(sp)
    80004870:	00813a83          	ld	s5,8(sp)
    80004874:	00013b03          	ld	s6,0(sp)
    80004878:	04010113          	addi	sp,sp,64
    8000487c:	00008067          	ret
    80004880:	00002517          	auipc	a0,0x2
    80004884:	d3050513          	addi	a0,a0,-720 # 800065b0 <digits+0x18>
    80004888:	fffff097          	auipc	ra,0xfffff
    8000488c:	3d4080e7          	jalr	980(ra) # 80003c5c <panic>

0000000080004890 <kfree>:
    80004890:	fe010113          	addi	sp,sp,-32
    80004894:	00813823          	sd	s0,16(sp)
    80004898:	00113c23          	sd	ra,24(sp)
    8000489c:	00913423          	sd	s1,8(sp)
    800048a0:	02010413          	addi	s0,sp,32
    800048a4:	03451793          	slli	a5,a0,0x34
    800048a8:	04079c63          	bnez	a5,80004900 <kfree+0x70>
    800048ac:	00004797          	auipc	a5,0x4
    800048b0:	b8478793          	addi	a5,a5,-1148 # 80008430 <end>
    800048b4:	00050493          	mv	s1,a0
    800048b8:	04f56463          	bltu	a0,a5,80004900 <kfree+0x70>
    800048bc:	01100793          	li	a5,17
    800048c0:	01b79793          	slli	a5,a5,0x1b
    800048c4:	02f57e63          	bgeu	a0,a5,80004900 <kfree+0x70>
    800048c8:	00001637          	lui	a2,0x1
    800048cc:	00100593          	li	a1,1
    800048d0:	00000097          	auipc	ra,0x0
    800048d4:	478080e7          	jalr	1144(ra) # 80004d48 <__memset>
    800048d8:	00003797          	auipc	a5,0x3
    800048dc:	8c878793          	addi	a5,a5,-1848 # 800071a0 <kmem>
    800048e0:	0007b703          	ld	a4,0(a5)
    800048e4:	01813083          	ld	ra,24(sp)
    800048e8:	01013403          	ld	s0,16(sp)
    800048ec:	00e4b023          	sd	a4,0(s1)
    800048f0:	0097b023          	sd	s1,0(a5)
    800048f4:	00813483          	ld	s1,8(sp)
    800048f8:	02010113          	addi	sp,sp,32
    800048fc:	00008067          	ret
    80004900:	00002517          	auipc	a0,0x2
    80004904:	cb050513          	addi	a0,a0,-848 # 800065b0 <digits+0x18>
    80004908:	fffff097          	auipc	ra,0xfffff
    8000490c:	354080e7          	jalr	852(ra) # 80003c5c <panic>

0000000080004910 <kalloc>:
    80004910:	fe010113          	addi	sp,sp,-32
    80004914:	00813823          	sd	s0,16(sp)
    80004918:	00913423          	sd	s1,8(sp)
    8000491c:	00113c23          	sd	ra,24(sp)
    80004920:	02010413          	addi	s0,sp,32
    80004924:	00003797          	auipc	a5,0x3
    80004928:	87c78793          	addi	a5,a5,-1924 # 800071a0 <kmem>
    8000492c:	0007b483          	ld	s1,0(a5)
    80004930:	02048063          	beqz	s1,80004950 <kalloc+0x40>
    80004934:	0004b703          	ld	a4,0(s1)
    80004938:	00001637          	lui	a2,0x1
    8000493c:	00500593          	li	a1,5
    80004940:	00048513          	mv	a0,s1
    80004944:	00e7b023          	sd	a4,0(a5)
    80004948:	00000097          	auipc	ra,0x0
    8000494c:	400080e7          	jalr	1024(ra) # 80004d48 <__memset>
    80004950:	01813083          	ld	ra,24(sp)
    80004954:	01013403          	ld	s0,16(sp)
    80004958:	00048513          	mv	a0,s1
    8000495c:	00813483          	ld	s1,8(sp)
    80004960:	02010113          	addi	sp,sp,32
    80004964:	00008067          	ret

0000000080004968 <initlock>:
    80004968:	ff010113          	addi	sp,sp,-16
    8000496c:	00813423          	sd	s0,8(sp)
    80004970:	01010413          	addi	s0,sp,16
    80004974:	00813403          	ld	s0,8(sp)
    80004978:	00b53423          	sd	a1,8(a0)
    8000497c:	00052023          	sw	zero,0(a0)
    80004980:	00053823          	sd	zero,16(a0)
    80004984:	01010113          	addi	sp,sp,16
    80004988:	00008067          	ret

000000008000498c <acquire>:
    8000498c:	fe010113          	addi	sp,sp,-32
    80004990:	00813823          	sd	s0,16(sp)
    80004994:	00913423          	sd	s1,8(sp)
    80004998:	00113c23          	sd	ra,24(sp)
    8000499c:	01213023          	sd	s2,0(sp)
    800049a0:	02010413          	addi	s0,sp,32
    800049a4:	00050493          	mv	s1,a0
    800049a8:	10002973          	csrr	s2,sstatus
    800049ac:	100027f3          	csrr	a5,sstatus
    800049b0:	ffd7f793          	andi	a5,a5,-3
    800049b4:	10079073          	csrw	sstatus,a5
    800049b8:	fffff097          	auipc	ra,0xfffff
    800049bc:	8e0080e7          	jalr	-1824(ra) # 80003298 <mycpu>
    800049c0:	07852783          	lw	a5,120(a0)
    800049c4:	06078e63          	beqz	a5,80004a40 <acquire+0xb4>
    800049c8:	fffff097          	auipc	ra,0xfffff
    800049cc:	8d0080e7          	jalr	-1840(ra) # 80003298 <mycpu>
    800049d0:	07852783          	lw	a5,120(a0)
    800049d4:	0004a703          	lw	a4,0(s1)
    800049d8:	0017879b          	addiw	a5,a5,1
    800049dc:	06f52c23          	sw	a5,120(a0)
    800049e0:	04071063          	bnez	a4,80004a20 <acquire+0x94>
    800049e4:	00100713          	li	a4,1
    800049e8:	00070793          	mv	a5,a4
    800049ec:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800049f0:	0007879b          	sext.w	a5,a5
    800049f4:	fe079ae3          	bnez	a5,800049e8 <acquire+0x5c>
    800049f8:	0ff0000f          	fence
    800049fc:	fffff097          	auipc	ra,0xfffff
    80004a00:	89c080e7          	jalr	-1892(ra) # 80003298 <mycpu>
    80004a04:	01813083          	ld	ra,24(sp)
    80004a08:	01013403          	ld	s0,16(sp)
    80004a0c:	00a4b823          	sd	a0,16(s1)
    80004a10:	00013903          	ld	s2,0(sp)
    80004a14:	00813483          	ld	s1,8(sp)
    80004a18:	02010113          	addi	sp,sp,32
    80004a1c:	00008067          	ret
    80004a20:	0104b903          	ld	s2,16(s1)
    80004a24:	fffff097          	auipc	ra,0xfffff
    80004a28:	874080e7          	jalr	-1932(ra) # 80003298 <mycpu>
    80004a2c:	faa91ce3          	bne	s2,a0,800049e4 <acquire+0x58>
    80004a30:	00002517          	auipc	a0,0x2
    80004a34:	b8850513          	addi	a0,a0,-1144 # 800065b8 <digits+0x20>
    80004a38:	fffff097          	auipc	ra,0xfffff
    80004a3c:	224080e7          	jalr	548(ra) # 80003c5c <panic>
    80004a40:	00195913          	srli	s2,s2,0x1
    80004a44:	fffff097          	auipc	ra,0xfffff
    80004a48:	854080e7          	jalr	-1964(ra) # 80003298 <mycpu>
    80004a4c:	00197913          	andi	s2,s2,1
    80004a50:	07252e23          	sw	s2,124(a0)
    80004a54:	f75ff06f          	j	800049c8 <acquire+0x3c>

0000000080004a58 <release>:
    80004a58:	fe010113          	addi	sp,sp,-32
    80004a5c:	00813823          	sd	s0,16(sp)
    80004a60:	00113c23          	sd	ra,24(sp)
    80004a64:	00913423          	sd	s1,8(sp)
    80004a68:	01213023          	sd	s2,0(sp)
    80004a6c:	02010413          	addi	s0,sp,32
    80004a70:	00052783          	lw	a5,0(a0)
    80004a74:	00079a63          	bnez	a5,80004a88 <release+0x30>
    80004a78:	00002517          	auipc	a0,0x2
    80004a7c:	b4850513          	addi	a0,a0,-1208 # 800065c0 <digits+0x28>
    80004a80:	fffff097          	auipc	ra,0xfffff
    80004a84:	1dc080e7          	jalr	476(ra) # 80003c5c <panic>
    80004a88:	01053903          	ld	s2,16(a0)
    80004a8c:	00050493          	mv	s1,a0
    80004a90:	fffff097          	auipc	ra,0xfffff
    80004a94:	808080e7          	jalr	-2040(ra) # 80003298 <mycpu>
    80004a98:	fea910e3          	bne	s2,a0,80004a78 <release+0x20>
    80004a9c:	0004b823          	sd	zero,16(s1)
    80004aa0:	0ff0000f          	fence
    80004aa4:	0f50000f          	fence	iorw,ow
    80004aa8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80004aac:	ffffe097          	auipc	ra,0xffffe
    80004ab0:	7ec080e7          	jalr	2028(ra) # 80003298 <mycpu>
    80004ab4:	100027f3          	csrr	a5,sstatus
    80004ab8:	0027f793          	andi	a5,a5,2
    80004abc:	04079a63          	bnez	a5,80004b10 <release+0xb8>
    80004ac0:	07852783          	lw	a5,120(a0)
    80004ac4:	02f05e63          	blez	a5,80004b00 <release+0xa8>
    80004ac8:	fff7871b          	addiw	a4,a5,-1
    80004acc:	06e52c23          	sw	a4,120(a0)
    80004ad0:	00071c63          	bnez	a4,80004ae8 <release+0x90>
    80004ad4:	07c52783          	lw	a5,124(a0)
    80004ad8:	00078863          	beqz	a5,80004ae8 <release+0x90>
    80004adc:	100027f3          	csrr	a5,sstatus
    80004ae0:	0027e793          	ori	a5,a5,2
    80004ae4:	10079073          	csrw	sstatus,a5
    80004ae8:	01813083          	ld	ra,24(sp)
    80004aec:	01013403          	ld	s0,16(sp)
    80004af0:	00813483          	ld	s1,8(sp)
    80004af4:	00013903          	ld	s2,0(sp)
    80004af8:	02010113          	addi	sp,sp,32
    80004afc:	00008067          	ret
    80004b00:	00002517          	auipc	a0,0x2
    80004b04:	ae050513          	addi	a0,a0,-1312 # 800065e0 <digits+0x48>
    80004b08:	fffff097          	auipc	ra,0xfffff
    80004b0c:	154080e7          	jalr	340(ra) # 80003c5c <panic>
    80004b10:	00002517          	auipc	a0,0x2
    80004b14:	ab850513          	addi	a0,a0,-1352 # 800065c8 <digits+0x30>
    80004b18:	fffff097          	auipc	ra,0xfffff
    80004b1c:	144080e7          	jalr	324(ra) # 80003c5c <panic>

0000000080004b20 <holding>:
    80004b20:	00052783          	lw	a5,0(a0)
    80004b24:	00079663          	bnez	a5,80004b30 <holding+0x10>
    80004b28:	00000513          	li	a0,0
    80004b2c:	00008067          	ret
    80004b30:	fe010113          	addi	sp,sp,-32
    80004b34:	00813823          	sd	s0,16(sp)
    80004b38:	00913423          	sd	s1,8(sp)
    80004b3c:	00113c23          	sd	ra,24(sp)
    80004b40:	02010413          	addi	s0,sp,32
    80004b44:	01053483          	ld	s1,16(a0)
    80004b48:	ffffe097          	auipc	ra,0xffffe
    80004b4c:	750080e7          	jalr	1872(ra) # 80003298 <mycpu>
    80004b50:	01813083          	ld	ra,24(sp)
    80004b54:	01013403          	ld	s0,16(sp)
    80004b58:	40a48533          	sub	a0,s1,a0
    80004b5c:	00153513          	seqz	a0,a0
    80004b60:	00813483          	ld	s1,8(sp)
    80004b64:	02010113          	addi	sp,sp,32
    80004b68:	00008067          	ret

0000000080004b6c <push_off>:
    80004b6c:	fe010113          	addi	sp,sp,-32
    80004b70:	00813823          	sd	s0,16(sp)
    80004b74:	00113c23          	sd	ra,24(sp)
    80004b78:	00913423          	sd	s1,8(sp)
    80004b7c:	02010413          	addi	s0,sp,32
    80004b80:	100024f3          	csrr	s1,sstatus
    80004b84:	100027f3          	csrr	a5,sstatus
    80004b88:	ffd7f793          	andi	a5,a5,-3
    80004b8c:	10079073          	csrw	sstatus,a5
    80004b90:	ffffe097          	auipc	ra,0xffffe
    80004b94:	708080e7          	jalr	1800(ra) # 80003298 <mycpu>
    80004b98:	07852783          	lw	a5,120(a0)
    80004b9c:	02078663          	beqz	a5,80004bc8 <push_off+0x5c>
    80004ba0:	ffffe097          	auipc	ra,0xffffe
    80004ba4:	6f8080e7          	jalr	1784(ra) # 80003298 <mycpu>
    80004ba8:	07852783          	lw	a5,120(a0)
    80004bac:	01813083          	ld	ra,24(sp)
    80004bb0:	01013403          	ld	s0,16(sp)
    80004bb4:	0017879b          	addiw	a5,a5,1
    80004bb8:	06f52c23          	sw	a5,120(a0)
    80004bbc:	00813483          	ld	s1,8(sp)
    80004bc0:	02010113          	addi	sp,sp,32
    80004bc4:	00008067          	ret
    80004bc8:	0014d493          	srli	s1,s1,0x1
    80004bcc:	ffffe097          	auipc	ra,0xffffe
    80004bd0:	6cc080e7          	jalr	1740(ra) # 80003298 <mycpu>
    80004bd4:	0014f493          	andi	s1,s1,1
    80004bd8:	06952e23          	sw	s1,124(a0)
    80004bdc:	fc5ff06f          	j	80004ba0 <push_off+0x34>

0000000080004be0 <pop_off>:
    80004be0:	ff010113          	addi	sp,sp,-16
    80004be4:	00813023          	sd	s0,0(sp)
    80004be8:	00113423          	sd	ra,8(sp)
    80004bec:	01010413          	addi	s0,sp,16
    80004bf0:	ffffe097          	auipc	ra,0xffffe
    80004bf4:	6a8080e7          	jalr	1704(ra) # 80003298 <mycpu>
    80004bf8:	100027f3          	csrr	a5,sstatus
    80004bfc:	0027f793          	andi	a5,a5,2
    80004c00:	04079663          	bnez	a5,80004c4c <pop_off+0x6c>
    80004c04:	07852783          	lw	a5,120(a0)
    80004c08:	02f05a63          	blez	a5,80004c3c <pop_off+0x5c>
    80004c0c:	fff7871b          	addiw	a4,a5,-1
    80004c10:	06e52c23          	sw	a4,120(a0)
    80004c14:	00071c63          	bnez	a4,80004c2c <pop_off+0x4c>
    80004c18:	07c52783          	lw	a5,124(a0)
    80004c1c:	00078863          	beqz	a5,80004c2c <pop_off+0x4c>
    80004c20:	100027f3          	csrr	a5,sstatus
    80004c24:	0027e793          	ori	a5,a5,2
    80004c28:	10079073          	csrw	sstatus,a5
    80004c2c:	00813083          	ld	ra,8(sp)
    80004c30:	00013403          	ld	s0,0(sp)
    80004c34:	01010113          	addi	sp,sp,16
    80004c38:	00008067          	ret
    80004c3c:	00002517          	auipc	a0,0x2
    80004c40:	9a450513          	addi	a0,a0,-1628 # 800065e0 <digits+0x48>
    80004c44:	fffff097          	auipc	ra,0xfffff
    80004c48:	018080e7          	jalr	24(ra) # 80003c5c <panic>
    80004c4c:	00002517          	auipc	a0,0x2
    80004c50:	97c50513          	addi	a0,a0,-1668 # 800065c8 <digits+0x30>
    80004c54:	fffff097          	auipc	ra,0xfffff
    80004c58:	008080e7          	jalr	8(ra) # 80003c5c <panic>

0000000080004c5c <push_on>:
    80004c5c:	fe010113          	addi	sp,sp,-32
    80004c60:	00813823          	sd	s0,16(sp)
    80004c64:	00113c23          	sd	ra,24(sp)
    80004c68:	00913423          	sd	s1,8(sp)
    80004c6c:	02010413          	addi	s0,sp,32
    80004c70:	100024f3          	csrr	s1,sstatus
    80004c74:	100027f3          	csrr	a5,sstatus
    80004c78:	0027e793          	ori	a5,a5,2
    80004c7c:	10079073          	csrw	sstatus,a5
    80004c80:	ffffe097          	auipc	ra,0xffffe
    80004c84:	618080e7          	jalr	1560(ra) # 80003298 <mycpu>
    80004c88:	07852783          	lw	a5,120(a0)
    80004c8c:	02078663          	beqz	a5,80004cb8 <push_on+0x5c>
    80004c90:	ffffe097          	auipc	ra,0xffffe
    80004c94:	608080e7          	jalr	1544(ra) # 80003298 <mycpu>
    80004c98:	07852783          	lw	a5,120(a0)
    80004c9c:	01813083          	ld	ra,24(sp)
    80004ca0:	01013403          	ld	s0,16(sp)
    80004ca4:	0017879b          	addiw	a5,a5,1
    80004ca8:	06f52c23          	sw	a5,120(a0)
    80004cac:	00813483          	ld	s1,8(sp)
    80004cb0:	02010113          	addi	sp,sp,32
    80004cb4:	00008067          	ret
    80004cb8:	0014d493          	srli	s1,s1,0x1
    80004cbc:	ffffe097          	auipc	ra,0xffffe
    80004cc0:	5dc080e7          	jalr	1500(ra) # 80003298 <mycpu>
    80004cc4:	0014f493          	andi	s1,s1,1
    80004cc8:	06952e23          	sw	s1,124(a0)
    80004ccc:	fc5ff06f          	j	80004c90 <push_on+0x34>

0000000080004cd0 <pop_on>:
    80004cd0:	ff010113          	addi	sp,sp,-16
    80004cd4:	00813023          	sd	s0,0(sp)
    80004cd8:	00113423          	sd	ra,8(sp)
    80004cdc:	01010413          	addi	s0,sp,16
    80004ce0:	ffffe097          	auipc	ra,0xffffe
    80004ce4:	5b8080e7          	jalr	1464(ra) # 80003298 <mycpu>
    80004ce8:	100027f3          	csrr	a5,sstatus
    80004cec:	0027f793          	andi	a5,a5,2
    80004cf0:	04078463          	beqz	a5,80004d38 <pop_on+0x68>
    80004cf4:	07852783          	lw	a5,120(a0)
    80004cf8:	02f05863          	blez	a5,80004d28 <pop_on+0x58>
    80004cfc:	fff7879b          	addiw	a5,a5,-1
    80004d00:	06f52c23          	sw	a5,120(a0)
    80004d04:	07853783          	ld	a5,120(a0)
    80004d08:	00079863          	bnez	a5,80004d18 <pop_on+0x48>
    80004d0c:	100027f3          	csrr	a5,sstatus
    80004d10:	ffd7f793          	andi	a5,a5,-3
    80004d14:	10079073          	csrw	sstatus,a5
    80004d18:	00813083          	ld	ra,8(sp)
    80004d1c:	00013403          	ld	s0,0(sp)
    80004d20:	01010113          	addi	sp,sp,16
    80004d24:	00008067          	ret
    80004d28:	00002517          	auipc	a0,0x2
    80004d2c:	8e050513          	addi	a0,a0,-1824 # 80006608 <digits+0x70>
    80004d30:	fffff097          	auipc	ra,0xfffff
    80004d34:	f2c080e7          	jalr	-212(ra) # 80003c5c <panic>
    80004d38:	00002517          	auipc	a0,0x2
    80004d3c:	8b050513          	addi	a0,a0,-1872 # 800065e8 <digits+0x50>
    80004d40:	fffff097          	auipc	ra,0xfffff
    80004d44:	f1c080e7          	jalr	-228(ra) # 80003c5c <panic>

0000000080004d48 <__memset>:
    80004d48:	ff010113          	addi	sp,sp,-16
    80004d4c:	00813423          	sd	s0,8(sp)
    80004d50:	01010413          	addi	s0,sp,16
    80004d54:	1a060e63          	beqz	a2,80004f10 <__memset+0x1c8>
    80004d58:	40a007b3          	neg	a5,a0
    80004d5c:	0077f793          	andi	a5,a5,7
    80004d60:	00778693          	addi	a3,a5,7
    80004d64:	00b00813          	li	a6,11
    80004d68:	0ff5f593          	andi	a1,a1,255
    80004d6c:	fff6071b          	addiw	a4,a2,-1
    80004d70:	1b06e663          	bltu	a3,a6,80004f1c <__memset+0x1d4>
    80004d74:	1cd76463          	bltu	a4,a3,80004f3c <__memset+0x1f4>
    80004d78:	1a078e63          	beqz	a5,80004f34 <__memset+0x1ec>
    80004d7c:	00b50023          	sb	a1,0(a0)
    80004d80:	00100713          	li	a4,1
    80004d84:	1ae78463          	beq	a5,a4,80004f2c <__memset+0x1e4>
    80004d88:	00b500a3          	sb	a1,1(a0)
    80004d8c:	00200713          	li	a4,2
    80004d90:	1ae78a63          	beq	a5,a4,80004f44 <__memset+0x1fc>
    80004d94:	00b50123          	sb	a1,2(a0)
    80004d98:	00300713          	li	a4,3
    80004d9c:	18e78463          	beq	a5,a4,80004f24 <__memset+0x1dc>
    80004da0:	00b501a3          	sb	a1,3(a0)
    80004da4:	00400713          	li	a4,4
    80004da8:	1ae78263          	beq	a5,a4,80004f4c <__memset+0x204>
    80004dac:	00b50223          	sb	a1,4(a0)
    80004db0:	00500713          	li	a4,5
    80004db4:	1ae78063          	beq	a5,a4,80004f54 <__memset+0x20c>
    80004db8:	00b502a3          	sb	a1,5(a0)
    80004dbc:	00700713          	li	a4,7
    80004dc0:	18e79e63          	bne	a5,a4,80004f5c <__memset+0x214>
    80004dc4:	00b50323          	sb	a1,6(a0)
    80004dc8:	00700e93          	li	t4,7
    80004dcc:	00859713          	slli	a4,a1,0x8
    80004dd0:	00e5e733          	or	a4,a1,a4
    80004dd4:	01059e13          	slli	t3,a1,0x10
    80004dd8:	01c76e33          	or	t3,a4,t3
    80004ddc:	01859313          	slli	t1,a1,0x18
    80004de0:	006e6333          	or	t1,t3,t1
    80004de4:	02059893          	slli	a7,a1,0x20
    80004de8:	40f60e3b          	subw	t3,a2,a5
    80004dec:	011368b3          	or	a7,t1,a7
    80004df0:	02859813          	slli	a6,a1,0x28
    80004df4:	0108e833          	or	a6,a7,a6
    80004df8:	03059693          	slli	a3,a1,0x30
    80004dfc:	003e589b          	srliw	a7,t3,0x3
    80004e00:	00d866b3          	or	a3,a6,a3
    80004e04:	03859713          	slli	a4,a1,0x38
    80004e08:	00389813          	slli	a6,a7,0x3
    80004e0c:	00f507b3          	add	a5,a0,a5
    80004e10:	00e6e733          	or	a4,a3,a4
    80004e14:	000e089b          	sext.w	a7,t3
    80004e18:	00f806b3          	add	a3,a6,a5
    80004e1c:	00e7b023          	sd	a4,0(a5)
    80004e20:	00878793          	addi	a5,a5,8
    80004e24:	fed79ce3          	bne	a5,a3,80004e1c <__memset+0xd4>
    80004e28:	ff8e7793          	andi	a5,t3,-8
    80004e2c:	0007871b          	sext.w	a4,a5
    80004e30:	01d787bb          	addw	a5,a5,t4
    80004e34:	0ce88e63          	beq	a7,a4,80004f10 <__memset+0x1c8>
    80004e38:	00f50733          	add	a4,a0,a5
    80004e3c:	00b70023          	sb	a1,0(a4)
    80004e40:	0017871b          	addiw	a4,a5,1
    80004e44:	0cc77663          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004e48:	00e50733          	add	a4,a0,a4
    80004e4c:	00b70023          	sb	a1,0(a4)
    80004e50:	0027871b          	addiw	a4,a5,2
    80004e54:	0ac77e63          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004e58:	00e50733          	add	a4,a0,a4
    80004e5c:	00b70023          	sb	a1,0(a4)
    80004e60:	0037871b          	addiw	a4,a5,3
    80004e64:	0ac77663          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004e68:	00e50733          	add	a4,a0,a4
    80004e6c:	00b70023          	sb	a1,0(a4)
    80004e70:	0047871b          	addiw	a4,a5,4
    80004e74:	08c77e63          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004e78:	00e50733          	add	a4,a0,a4
    80004e7c:	00b70023          	sb	a1,0(a4)
    80004e80:	0057871b          	addiw	a4,a5,5
    80004e84:	08c77663          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004e88:	00e50733          	add	a4,a0,a4
    80004e8c:	00b70023          	sb	a1,0(a4)
    80004e90:	0067871b          	addiw	a4,a5,6
    80004e94:	06c77e63          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004e98:	00e50733          	add	a4,a0,a4
    80004e9c:	00b70023          	sb	a1,0(a4)
    80004ea0:	0077871b          	addiw	a4,a5,7
    80004ea4:	06c77663          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004ea8:	00e50733          	add	a4,a0,a4
    80004eac:	00b70023          	sb	a1,0(a4)
    80004eb0:	0087871b          	addiw	a4,a5,8
    80004eb4:	04c77e63          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004eb8:	00e50733          	add	a4,a0,a4
    80004ebc:	00b70023          	sb	a1,0(a4)
    80004ec0:	0097871b          	addiw	a4,a5,9
    80004ec4:	04c77663          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004ec8:	00e50733          	add	a4,a0,a4
    80004ecc:	00b70023          	sb	a1,0(a4)
    80004ed0:	00a7871b          	addiw	a4,a5,10
    80004ed4:	02c77e63          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004ed8:	00e50733          	add	a4,a0,a4
    80004edc:	00b70023          	sb	a1,0(a4)
    80004ee0:	00b7871b          	addiw	a4,a5,11
    80004ee4:	02c77663          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004ee8:	00e50733          	add	a4,a0,a4
    80004eec:	00b70023          	sb	a1,0(a4)
    80004ef0:	00c7871b          	addiw	a4,a5,12
    80004ef4:	00c77e63          	bgeu	a4,a2,80004f10 <__memset+0x1c8>
    80004ef8:	00e50733          	add	a4,a0,a4
    80004efc:	00b70023          	sb	a1,0(a4)
    80004f00:	00d7879b          	addiw	a5,a5,13
    80004f04:	00c7f663          	bgeu	a5,a2,80004f10 <__memset+0x1c8>
    80004f08:	00f507b3          	add	a5,a0,a5
    80004f0c:	00b78023          	sb	a1,0(a5)
    80004f10:	00813403          	ld	s0,8(sp)
    80004f14:	01010113          	addi	sp,sp,16
    80004f18:	00008067          	ret
    80004f1c:	00b00693          	li	a3,11
    80004f20:	e55ff06f          	j	80004d74 <__memset+0x2c>
    80004f24:	00300e93          	li	t4,3
    80004f28:	ea5ff06f          	j	80004dcc <__memset+0x84>
    80004f2c:	00100e93          	li	t4,1
    80004f30:	e9dff06f          	j	80004dcc <__memset+0x84>
    80004f34:	00000e93          	li	t4,0
    80004f38:	e95ff06f          	j	80004dcc <__memset+0x84>
    80004f3c:	00000793          	li	a5,0
    80004f40:	ef9ff06f          	j	80004e38 <__memset+0xf0>
    80004f44:	00200e93          	li	t4,2
    80004f48:	e85ff06f          	j	80004dcc <__memset+0x84>
    80004f4c:	00400e93          	li	t4,4
    80004f50:	e7dff06f          	j	80004dcc <__memset+0x84>
    80004f54:	00500e93          	li	t4,5
    80004f58:	e75ff06f          	j	80004dcc <__memset+0x84>
    80004f5c:	00600e93          	li	t4,6
    80004f60:	e6dff06f          	j	80004dcc <__memset+0x84>

0000000080004f64 <__memmove>:
    80004f64:	ff010113          	addi	sp,sp,-16
    80004f68:	00813423          	sd	s0,8(sp)
    80004f6c:	01010413          	addi	s0,sp,16
    80004f70:	0e060863          	beqz	a2,80005060 <__memmove+0xfc>
    80004f74:	fff6069b          	addiw	a3,a2,-1
    80004f78:	0006881b          	sext.w	a6,a3
    80004f7c:	0ea5e863          	bltu	a1,a0,8000506c <__memmove+0x108>
    80004f80:	00758713          	addi	a4,a1,7
    80004f84:	00a5e7b3          	or	a5,a1,a0
    80004f88:	40a70733          	sub	a4,a4,a0
    80004f8c:	0077f793          	andi	a5,a5,7
    80004f90:	00f73713          	sltiu	a4,a4,15
    80004f94:	00174713          	xori	a4,a4,1
    80004f98:	0017b793          	seqz	a5,a5
    80004f9c:	00e7f7b3          	and	a5,a5,a4
    80004fa0:	10078863          	beqz	a5,800050b0 <__memmove+0x14c>
    80004fa4:	00900793          	li	a5,9
    80004fa8:	1107f463          	bgeu	a5,a6,800050b0 <__memmove+0x14c>
    80004fac:	0036581b          	srliw	a6,a2,0x3
    80004fb0:	fff8081b          	addiw	a6,a6,-1
    80004fb4:	02081813          	slli	a6,a6,0x20
    80004fb8:	01d85893          	srli	a7,a6,0x1d
    80004fbc:	00858813          	addi	a6,a1,8
    80004fc0:	00058793          	mv	a5,a1
    80004fc4:	00050713          	mv	a4,a0
    80004fc8:	01088833          	add	a6,a7,a6
    80004fcc:	0007b883          	ld	a7,0(a5)
    80004fd0:	00878793          	addi	a5,a5,8
    80004fd4:	00870713          	addi	a4,a4,8
    80004fd8:	ff173c23          	sd	a7,-8(a4)
    80004fdc:	ff0798e3          	bne	a5,a6,80004fcc <__memmove+0x68>
    80004fe0:	ff867713          	andi	a4,a2,-8
    80004fe4:	02071793          	slli	a5,a4,0x20
    80004fe8:	0207d793          	srli	a5,a5,0x20
    80004fec:	00f585b3          	add	a1,a1,a5
    80004ff0:	40e686bb          	subw	a3,a3,a4
    80004ff4:	00f507b3          	add	a5,a0,a5
    80004ff8:	06e60463          	beq	a2,a4,80005060 <__memmove+0xfc>
    80004ffc:	0005c703          	lbu	a4,0(a1)
    80005000:	00e78023          	sb	a4,0(a5)
    80005004:	04068e63          	beqz	a3,80005060 <__memmove+0xfc>
    80005008:	0015c603          	lbu	a2,1(a1)
    8000500c:	00100713          	li	a4,1
    80005010:	00c780a3          	sb	a2,1(a5)
    80005014:	04e68663          	beq	a3,a4,80005060 <__memmove+0xfc>
    80005018:	0025c603          	lbu	a2,2(a1)
    8000501c:	00200713          	li	a4,2
    80005020:	00c78123          	sb	a2,2(a5)
    80005024:	02e68e63          	beq	a3,a4,80005060 <__memmove+0xfc>
    80005028:	0035c603          	lbu	a2,3(a1)
    8000502c:	00300713          	li	a4,3
    80005030:	00c781a3          	sb	a2,3(a5)
    80005034:	02e68663          	beq	a3,a4,80005060 <__memmove+0xfc>
    80005038:	0045c603          	lbu	a2,4(a1)
    8000503c:	00400713          	li	a4,4
    80005040:	00c78223          	sb	a2,4(a5)
    80005044:	00e68e63          	beq	a3,a4,80005060 <__memmove+0xfc>
    80005048:	0055c603          	lbu	a2,5(a1)
    8000504c:	00500713          	li	a4,5
    80005050:	00c782a3          	sb	a2,5(a5)
    80005054:	00e68663          	beq	a3,a4,80005060 <__memmove+0xfc>
    80005058:	0065c703          	lbu	a4,6(a1)
    8000505c:	00e78323          	sb	a4,6(a5)
    80005060:	00813403          	ld	s0,8(sp)
    80005064:	01010113          	addi	sp,sp,16
    80005068:	00008067          	ret
    8000506c:	02061713          	slli	a4,a2,0x20
    80005070:	02075713          	srli	a4,a4,0x20
    80005074:	00e587b3          	add	a5,a1,a4
    80005078:	f0f574e3          	bgeu	a0,a5,80004f80 <__memmove+0x1c>
    8000507c:	02069613          	slli	a2,a3,0x20
    80005080:	02065613          	srli	a2,a2,0x20
    80005084:	fff64613          	not	a2,a2
    80005088:	00e50733          	add	a4,a0,a4
    8000508c:	00c78633          	add	a2,a5,a2
    80005090:	fff7c683          	lbu	a3,-1(a5)
    80005094:	fff78793          	addi	a5,a5,-1
    80005098:	fff70713          	addi	a4,a4,-1
    8000509c:	00d70023          	sb	a3,0(a4)
    800050a0:	fec798e3          	bne	a5,a2,80005090 <__memmove+0x12c>
    800050a4:	00813403          	ld	s0,8(sp)
    800050a8:	01010113          	addi	sp,sp,16
    800050ac:	00008067          	ret
    800050b0:	02069713          	slli	a4,a3,0x20
    800050b4:	02075713          	srli	a4,a4,0x20
    800050b8:	00170713          	addi	a4,a4,1
    800050bc:	00e50733          	add	a4,a0,a4
    800050c0:	00050793          	mv	a5,a0
    800050c4:	0005c683          	lbu	a3,0(a1)
    800050c8:	00178793          	addi	a5,a5,1
    800050cc:	00158593          	addi	a1,a1,1
    800050d0:	fed78fa3          	sb	a3,-1(a5)
    800050d4:	fee798e3          	bne	a5,a4,800050c4 <__memmove+0x160>
    800050d8:	f89ff06f          	j	80005060 <__memmove+0xfc>

00000000800050dc <__mem_free>:
    800050dc:	ff010113          	addi	sp,sp,-16
    800050e0:	00813423          	sd	s0,8(sp)
    800050e4:	01010413          	addi	s0,sp,16
    800050e8:	00002597          	auipc	a1,0x2
    800050ec:	0c058593          	addi	a1,a1,192 # 800071a8 <freep>
    800050f0:	0005b783          	ld	a5,0(a1)
    800050f4:	ff050693          	addi	a3,a0,-16
    800050f8:	0007b703          	ld	a4,0(a5)
    800050fc:	00d7fc63          	bgeu	a5,a3,80005114 <__mem_free+0x38>
    80005100:	00e6ee63          	bltu	a3,a4,8000511c <__mem_free+0x40>
    80005104:	00e7fc63          	bgeu	a5,a4,8000511c <__mem_free+0x40>
    80005108:	00070793          	mv	a5,a4
    8000510c:	0007b703          	ld	a4,0(a5)
    80005110:	fed7e8e3          	bltu	a5,a3,80005100 <__mem_free+0x24>
    80005114:	fee7eae3          	bltu	a5,a4,80005108 <__mem_free+0x2c>
    80005118:	fee6f8e3          	bgeu	a3,a4,80005108 <__mem_free+0x2c>
    8000511c:	ff852803          	lw	a6,-8(a0)
    80005120:	02081613          	slli	a2,a6,0x20
    80005124:	01c65613          	srli	a2,a2,0x1c
    80005128:	00c68633          	add	a2,a3,a2
    8000512c:	02c70a63          	beq	a4,a2,80005160 <__mem_free+0x84>
    80005130:	fee53823          	sd	a4,-16(a0)
    80005134:	0087a503          	lw	a0,8(a5)
    80005138:	02051613          	slli	a2,a0,0x20
    8000513c:	01c65613          	srli	a2,a2,0x1c
    80005140:	00c78633          	add	a2,a5,a2
    80005144:	04c68263          	beq	a3,a2,80005188 <__mem_free+0xac>
    80005148:	00813403          	ld	s0,8(sp)
    8000514c:	00d7b023          	sd	a3,0(a5)
    80005150:	00f5b023          	sd	a5,0(a1)
    80005154:	00000513          	li	a0,0
    80005158:	01010113          	addi	sp,sp,16
    8000515c:	00008067          	ret
    80005160:	00872603          	lw	a2,8(a4)
    80005164:	00073703          	ld	a4,0(a4)
    80005168:	0106083b          	addw	a6,a2,a6
    8000516c:	ff052c23          	sw	a6,-8(a0)
    80005170:	fee53823          	sd	a4,-16(a0)
    80005174:	0087a503          	lw	a0,8(a5)
    80005178:	02051613          	slli	a2,a0,0x20
    8000517c:	01c65613          	srli	a2,a2,0x1c
    80005180:	00c78633          	add	a2,a5,a2
    80005184:	fcc692e3          	bne	a3,a2,80005148 <__mem_free+0x6c>
    80005188:	00813403          	ld	s0,8(sp)
    8000518c:	0105053b          	addw	a0,a0,a6
    80005190:	00a7a423          	sw	a0,8(a5)
    80005194:	00e7b023          	sd	a4,0(a5)
    80005198:	00f5b023          	sd	a5,0(a1)
    8000519c:	00000513          	li	a0,0
    800051a0:	01010113          	addi	sp,sp,16
    800051a4:	00008067          	ret

00000000800051a8 <__mem_alloc>:
    800051a8:	fc010113          	addi	sp,sp,-64
    800051ac:	02813823          	sd	s0,48(sp)
    800051b0:	02913423          	sd	s1,40(sp)
    800051b4:	03213023          	sd	s2,32(sp)
    800051b8:	01513423          	sd	s5,8(sp)
    800051bc:	02113c23          	sd	ra,56(sp)
    800051c0:	01313c23          	sd	s3,24(sp)
    800051c4:	01413823          	sd	s4,16(sp)
    800051c8:	01613023          	sd	s6,0(sp)
    800051cc:	04010413          	addi	s0,sp,64
    800051d0:	00002a97          	auipc	s5,0x2
    800051d4:	fd8a8a93          	addi	s5,s5,-40 # 800071a8 <freep>
    800051d8:	00f50913          	addi	s2,a0,15
    800051dc:	000ab683          	ld	a3,0(s5)
    800051e0:	00495913          	srli	s2,s2,0x4
    800051e4:	0019049b          	addiw	s1,s2,1
    800051e8:	00048913          	mv	s2,s1
    800051ec:	0c068c63          	beqz	a3,800052c4 <__mem_alloc+0x11c>
    800051f0:	0006b503          	ld	a0,0(a3)
    800051f4:	00852703          	lw	a4,8(a0)
    800051f8:	10977063          	bgeu	a4,s1,800052f8 <__mem_alloc+0x150>
    800051fc:	000017b7          	lui	a5,0x1
    80005200:	0009099b          	sext.w	s3,s2
    80005204:	0af4e863          	bltu	s1,a5,800052b4 <__mem_alloc+0x10c>
    80005208:	02099a13          	slli	s4,s3,0x20
    8000520c:	01ca5a13          	srli	s4,s4,0x1c
    80005210:	fff00b13          	li	s6,-1
    80005214:	0100006f          	j	80005224 <__mem_alloc+0x7c>
    80005218:	0007b503          	ld	a0,0(a5) # 1000 <_entry-0x7ffff000>
    8000521c:	00852703          	lw	a4,8(a0)
    80005220:	04977463          	bgeu	a4,s1,80005268 <__mem_alloc+0xc0>
    80005224:	00050793          	mv	a5,a0
    80005228:	fea698e3          	bne	a3,a0,80005218 <__mem_alloc+0x70>
    8000522c:	000a0513          	mv	a0,s4
    80005230:	00000097          	auipc	ra,0x0
    80005234:	1f0080e7          	jalr	496(ra) # 80005420 <kvmincrease>
    80005238:	00050793          	mv	a5,a0
    8000523c:	01050513          	addi	a0,a0,16
    80005240:	07678e63          	beq	a5,s6,800052bc <__mem_alloc+0x114>
    80005244:	0137a423          	sw	s3,8(a5)
    80005248:	00000097          	auipc	ra,0x0
    8000524c:	e94080e7          	jalr	-364(ra) # 800050dc <__mem_free>
    80005250:	000ab783          	ld	a5,0(s5)
    80005254:	06078463          	beqz	a5,800052bc <__mem_alloc+0x114>
    80005258:	0007b503          	ld	a0,0(a5)
    8000525c:	00078693          	mv	a3,a5
    80005260:	00852703          	lw	a4,8(a0)
    80005264:	fc9760e3          	bltu	a4,s1,80005224 <__mem_alloc+0x7c>
    80005268:	08e48263          	beq	s1,a4,800052ec <__mem_alloc+0x144>
    8000526c:	4127073b          	subw	a4,a4,s2
    80005270:	02071693          	slli	a3,a4,0x20
    80005274:	01c6d693          	srli	a3,a3,0x1c
    80005278:	00e52423          	sw	a4,8(a0)
    8000527c:	00d50533          	add	a0,a0,a3
    80005280:	01252423          	sw	s2,8(a0)
    80005284:	00fab023          	sd	a5,0(s5)
    80005288:	01050513          	addi	a0,a0,16
    8000528c:	03813083          	ld	ra,56(sp)
    80005290:	03013403          	ld	s0,48(sp)
    80005294:	02813483          	ld	s1,40(sp)
    80005298:	02013903          	ld	s2,32(sp)
    8000529c:	01813983          	ld	s3,24(sp)
    800052a0:	01013a03          	ld	s4,16(sp)
    800052a4:	00813a83          	ld	s5,8(sp)
    800052a8:	00013b03          	ld	s6,0(sp)
    800052ac:	04010113          	addi	sp,sp,64
    800052b0:	00008067          	ret
    800052b4:	000019b7          	lui	s3,0x1
    800052b8:	f51ff06f          	j	80005208 <__mem_alloc+0x60>
    800052bc:	00000513          	li	a0,0
    800052c0:	fcdff06f          	j	8000528c <__mem_alloc+0xe4>
    800052c4:	00003797          	auipc	a5,0x3
    800052c8:	15c78793          	addi	a5,a5,348 # 80008420 <base>
    800052cc:	00078513          	mv	a0,a5
    800052d0:	00fab023          	sd	a5,0(s5)
    800052d4:	00f7b023          	sd	a5,0(a5)
    800052d8:	00000713          	li	a4,0
    800052dc:	00003797          	auipc	a5,0x3
    800052e0:	1407a623          	sw	zero,332(a5) # 80008428 <base+0x8>
    800052e4:	00050693          	mv	a3,a0
    800052e8:	f11ff06f          	j	800051f8 <__mem_alloc+0x50>
    800052ec:	00053703          	ld	a4,0(a0)
    800052f0:	00e7b023          	sd	a4,0(a5)
    800052f4:	f91ff06f          	j	80005284 <__mem_alloc+0xdc>
    800052f8:	00068793          	mv	a5,a3
    800052fc:	f6dff06f          	j	80005268 <__mem_alloc+0xc0>

0000000080005300 <__putc>:
    80005300:	fe010113          	addi	sp,sp,-32
    80005304:	00813823          	sd	s0,16(sp)
    80005308:	00113c23          	sd	ra,24(sp)
    8000530c:	02010413          	addi	s0,sp,32
    80005310:	00050793          	mv	a5,a0
    80005314:	fef40593          	addi	a1,s0,-17
    80005318:	00100613          	li	a2,1
    8000531c:	00000513          	li	a0,0
    80005320:	fef407a3          	sb	a5,-17(s0)
    80005324:	fffff097          	auipc	ra,0xfffff
    80005328:	918080e7          	jalr	-1768(ra) # 80003c3c <console_write>
    8000532c:	01813083          	ld	ra,24(sp)
    80005330:	01013403          	ld	s0,16(sp)
    80005334:	02010113          	addi	sp,sp,32
    80005338:	00008067          	ret

000000008000533c <__getc>:
    8000533c:	fe010113          	addi	sp,sp,-32
    80005340:	00813823          	sd	s0,16(sp)
    80005344:	00113c23          	sd	ra,24(sp)
    80005348:	02010413          	addi	s0,sp,32
    8000534c:	fe840593          	addi	a1,s0,-24
    80005350:	00100613          	li	a2,1
    80005354:	00000513          	li	a0,0
    80005358:	fffff097          	auipc	ra,0xfffff
    8000535c:	8c4080e7          	jalr	-1852(ra) # 80003c1c <console_read>
    80005360:	fe844503          	lbu	a0,-24(s0)
    80005364:	01813083          	ld	ra,24(sp)
    80005368:	01013403          	ld	s0,16(sp)
    8000536c:	02010113          	addi	sp,sp,32
    80005370:	00008067          	ret

0000000080005374 <console_handler>:
    80005374:	fe010113          	addi	sp,sp,-32
    80005378:	00813823          	sd	s0,16(sp)
    8000537c:	00113c23          	sd	ra,24(sp)
    80005380:	00913423          	sd	s1,8(sp)
    80005384:	02010413          	addi	s0,sp,32
    80005388:	14202773          	csrr	a4,scause
    8000538c:	100027f3          	csrr	a5,sstatus
    80005390:	0027f793          	andi	a5,a5,2
    80005394:	06079e63          	bnez	a5,80005410 <console_handler+0x9c>
    80005398:	00074c63          	bltz	a4,800053b0 <console_handler+0x3c>
    8000539c:	01813083          	ld	ra,24(sp)
    800053a0:	01013403          	ld	s0,16(sp)
    800053a4:	00813483          	ld	s1,8(sp)
    800053a8:	02010113          	addi	sp,sp,32
    800053ac:	00008067          	ret
    800053b0:	0ff77713          	andi	a4,a4,255
    800053b4:	00900793          	li	a5,9
    800053b8:	fef712e3          	bne	a4,a5,8000539c <console_handler+0x28>
    800053bc:	ffffe097          	auipc	ra,0xffffe
    800053c0:	4b8080e7          	jalr	1208(ra) # 80003874 <plic_claim>
    800053c4:	00a00793          	li	a5,10
    800053c8:	00050493          	mv	s1,a0
    800053cc:	02f50c63          	beq	a0,a5,80005404 <console_handler+0x90>
    800053d0:	fc0506e3          	beqz	a0,8000539c <console_handler+0x28>
    800053d4:	00050593          	mv	a1,a0
    800053d8:	00001517          	auipc	a0,0x1
    800053dc:	13850513          	addi	a0,a0,312 # 80006510 <_ZTV7WorkerD+0xf8>
    800053e0:	fffff097          	auipc	ra,0xfffff
    800053e4:	8d8080e7          	jalr	-1832(ra) # 80003cb8 <__printf>
    800053e8:	01013403          	ld	s0,16(sp)
    800053ec:	01813083          	ld	ra,24(sp)
    800053f0:	00048513          	mv	a0,s1
    800053f4:	00813483          	ld	s1,8(sp)
    800053f8:	02010113          	addi	sp,sp,32
    800053fc:	ffffe317          	auipc	t1,0xffffe
    80005400:	4b030067          	jr	1200(t1) # 800038ac <plic_complete>
    80005404:	fffff097          	auipc	ra,0xfffff
    80005408:	1bc080e7          	jalr	444(ra) # 800045c0 <uartintr>
    8000540c:	fddff06f          	j	800053e8 <console_handler+0x74>
    80005410:	00001517          	auipc	a0,0x1
    80005414:	20050513          	addi	a0,a0,512 # 80006610 <digits+0x78>
    80005418:	fffff097          	auipc	ra,0xfffff
    8000541c:	844080e7          	jalr	-1980(ra) # 80003c5c <panic>

0000000080005420 <kvmincrease>:
    80005420:	fe010113          	addi	sp,sp,-32
    80005424:	01213023          	sd	s2,0(sp)
    80005428:	00001937          	lui	s2,0x1
    8000542c:	fff90913          	addi	s2,s2,-1 # fff <_entry-0x7ffff001>
    80005430:	00813823          	sd	s0,16(sp)
    80005434:	00113c23          	sd	ra,24(sp)
    80005438:	00913423          	sd	s1,8(sp)
    8000543c:	02010413          	addi	s0,sp,32
    80005440:	01250933          	add	s2,a0,s2
    80005444:	00c95913          	srli	s2,s2,0xc
    80005448:	02090863          	beqz	s2,80005478 <kvmincrease+0x58>
    8000544c:	00000493          	li	s1,0
    80005450:	00148493          	addi	s1,s1,1
    80005454:	fffff097          	auipc	ra,0xfffff
    80005458:	4bc080e7          	jalr	1212(ra) # 80004910 <kalloc>
    8000545c:	fe991ae3          	bne	s2,s1,80005450 <kvmincrease+0x30>
    80005460:	01813083          	ld	ra,24(sp)
    80005464:	01013403          	ld	s0,16(sp)
    80005468:	00813483          	ld	s1,8(sp)
    8000546c:	00013903          	ld	s2,0(sp)
    80005470:	02010113          	addi	sp,sp,32
    80005474:	00008067          	ret
    80005478:	01813083          	ld	ra,24(sp)
    8000547c:	01013403          	ld	s0,16(sp)
    80005480:	00813483          	ld	s1,8(sp)
    80005484:	00013903          	ld	s2,0(sp)
    80005488:	00000513          	li	a0,0
    8000548c:	02010113          	addi	sp,sp,32
    80005490:	00008067          	ret
	...
