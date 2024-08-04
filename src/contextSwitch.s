# 1 "src/contextSwitch.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "src/contextSwitch.S"
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_
.type _ZN7_thread13contextSwitchEPNS_7ContextES1_, @function
_ZN7_thread13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0) #iz ra cuvam u a0, to a0 je old->context.ra
    sd sp, 1 * 8(a0)

    ld ra, 0 * 8(a1) #iz running->context.ra cuvam u ra
    ld sp, 1 * 8(a1)

    ret
