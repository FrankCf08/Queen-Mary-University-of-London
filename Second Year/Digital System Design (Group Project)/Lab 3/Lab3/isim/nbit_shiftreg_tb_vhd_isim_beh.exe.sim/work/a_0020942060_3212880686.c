/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/js317/Desktop/DSD/Lab 3 - prep/Lab3/D_flipflop.vhd";



static void work_a_0020942060_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    int64 t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    char *t14;
    unsigned char t15;
    char *t16;

LAB0:    xsi_set_current_line(46, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:    xsi_set_current_line(53, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB13;

LAB14:    t3 = (unsigned char)0;

LAB15:    if (t3 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(62, ng0);
    t5 = (7 * 1000LL);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 3392);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t3;
    xsi_driver_first_trans_delta(t1, 0U, 1, t5);
    t10 = (t0 + 3392);
    xsi_driver_intertial_reject(t10, t5, t5);
    xsi_set_current_line(63, ng0);
    t5 = (7 * 1000LL);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 3456);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t3;
    xsi_driver_first_trans_delta(t1, 0U, 1, t5);
    t10 = (t0 + 3456);
    xsi_driver_intertial_reject(t10, t5, t5);

LAB11:
LAB3:    t1 = (t0 + 3312);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(47, ng0);
    t5 = (7 * 1000LL);
    t1 = (t0 + 3392);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_delta(t1, 0U, 1, t5);
    t10 = (t0 + 3392);
    xsi_driver_intertial_reject(t10, t5, t5);
    xsi_set_current_line(48, ng0);
    t5 = (7 * 1000LL);
    t1 = (t0 + 3456);
    t2 = (t1 + 56U);
    t6 = *((char **)t2);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_delta(t1, 0U, 1, t5);
    t9 = (t0 + 3456);
    xsi_driver_intertial_reject(t9, t5, t5);
    goto LAB3;

LAB5:    xsi_set_current_line(50, ng0);
    t5 = (7 * 1000LL);
    t1 = (t0 + 3392);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_delta(t1, 0U, 1, t5);
    t14 = (t0 + 3392);
    xsi_driver_intertial_reject(t14, t5, t5);
    xsi_set_current_line(51, ng0);
    t5 = (7 * 1000LL);
    t1 = (t0 + 3456);
    t2 = (t1 + 56U);
    t6 = *((char **)t2);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_delta(t1, 0U, 1, t5);
    t9 = (t0 + 3456);
    xsi_driver_intertial_reject(t9, t5, t5);
    goto LAB3;

LAB7:    t1 = (t0 + 1192U);
    t6 = *((char **)t1);
    t12 = *((unsigned char *)t6);
    t13 = (t12 == (unsigned char)2);
    t3 = t13;
    goto LAB9;

LAB10:    xsi_set_current_line(54, ng0);
    t6 = (t0 + 1032U);
    t7 = *((char **)t6);
    t13 = *((unsigned char *)t7);
    t15 = (t13 == (unsigned char)2);
    if (t15 != 0)
        goto LAB16;

LAB18:    xsi_set_current_line(58, ng0);
    t5 = (7 * 1000LL);
    t1 = (t0 + 3392);
    t2 = (t1 + 56U);
    t6 = *((char **)t2);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_delta(t1, 0U, 1, t5);
    t9 = (t0 + 3392);
    xsi_driver_intertial_reject(t9, t5, t5);
    xsi_set_current_line(59, ng0);
    t5 = (7 * 1000LL);
    t1 = (t0 + 3456);
    t2 = (t1 + 56U);
    t6 = *((char **)t2);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_delta(t1, 0U, 1, t5);
    t9 = (t0 + 3456);
    xsi_driver_intertial_reject(t9, t5, t5);

LAB17:    goto LAB11;

LAB13:    t1 = (t0 + 1472U);
    t12 = xsi_signal_has_event(t1);
    t3 = t12;
    goto LAB15;

LAB16:    xsi_set_current_line(55, ng0);
    t5 = (7 * 1000LL);
    t6 = (t0 + 3392);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t14 = *((char **)t10);
    *((unsigned char *)t14) = (unsigned char)2;
    xsi_driver_first_trans_delta(t6, 0U, 1, t5);
    t16 = (t0 + 3392);
    xsi_driver_intertial_reject(t16, t5, t5);
    xsi_set_current_line(56, ng0);
    t5 = (7 * 1000LL);
    t1 = (t0 + 3456);
    t2 = (t1 + 56U);
    t6 = *((char **)t2);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_delta(t1, 0U, 1, t5);
    t9 = (t0 + 3456);
    xsi_driver_intertial_reject(t9, t5, t5);
    goto LAB17;

}


extern void work_a_0020942060_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0020942060_3212880686_p_0};
	xsi_register_didat("work_a_0020942060_3212880686", "isim/nbit_shiftreg_tb_vhd_isim_beh.exe.sim/work/a_0020942060_3212880686.didat");
	xsi_register_executes(pe);
}
