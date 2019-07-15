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

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/dan/Desktop/rs_vhdl/src/datapath/AdderModulo.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;
extern char *WORK_P_0915166706;

int ieee_p_1242562249_sub_17802405650254020620_1035706684(char *, char *, char *);


static void work_a_0025575011_1516540902_p_0(char *t0)
{
    char t13[16];
    char t15[16];
    char *t1;
    char *t2;
    unsigned int t3;
    int t4;
    unsigned int t5;
    unsigned int t6;
    char *t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t14;
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    unsigned char t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;

LAB0:    xsi_set_current_line(41, ng0);

LAB3:    t1 = xsi_get_transient_memory(1U);
    memset(t1, 0, 1U);
    t2 = t1;
    if (-1 == 1)
        goto LAB5;

LAB6:    t3 = 8U;

LAB7:    t4 = (t3 - 8);
    t5 = (t4 * 1);
    t6 = (1U * t5);
    t7 = (t2 + t6);
    t8 = (8U - 8U);
    t9 = (t8 * -1);
    t9 = (t9 + 1);
    t10 = (1U * t9);
    memset(t7, (unsigned char)2, t10);
    t11 = (t0 + 5784U);
    t12 = *((char **)t11);
    t14 = ((IEEE_P_2592010699) + 4000);
    t16 = (t15 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = 8;
    t17 = (t16 + 4U);
    *((int *)t17) = 8;
    t17 = (t16 + 8U);
    *((int *)t17) = 1;
    t18 = (8 - 8);
    t19 = (t18 * 1);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t0 + 5792U);
    t20 = *((char **)t17);
    t11 = xsi_base_array_concat(t11, t13, t14, (char)97, t1, t15, (char)97, t12, t20, (char)101);
    t19 = (1U + 8U);
    t21 = (9U != t19);
    if (t21 == 1)
        goto LAB8;

LAB9:    t22 = (t0 + 13024);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    memcpy(t26, t11, 9U);
    xsi_driver_first_trans_fast(t22);

LAB2:    t27 = (t0 + 12912);
    *((int *)t27) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    t3 = 8U;
    goto LAB7;

LAB8:    xsi_size_not_matching(9U, t19, 0);
    goto LAB9;

}

static void work_a_0025575011_1516540902_p_1(char *t0)
{
    char t13[16];
    char t15[16];
    char *t1;
    char *t2;
    unsigned int t3;
    int t4;
    unsigned int t5;
    unsigned int t6;
    char *t7;
    int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t14;
    char *t16;
    char *t17;
    int t18;
    unsigned int t19;
    char *t20;
    unsigned char t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;

LAB0:    xsi_set_current_line(42, ng0);

LAB3:    t1 = xsi_get_transient_memory(1U);
    memset(t1, 0, 1U);
    t2 = t1;
    if (-1 == 1)
        goto LAB5;

LAB6:    t3 = 8U;

LAB7:    t4 = (t3 - 8);
    t5 = (t4 * 1);
    t6 = (1U * t5);
    t7 = (t2 + t6);
    t8 = (8U - 8U);
    t9 = (t8 * -1);
    t9 = (t9 + 1);
    t10 = (1U * t9);
    memset(t7, (unsigned char)2, t10);
    t11 = (t0 + 5944U);
    t12 = *((char **)t11);
    t14 = ((IEEE_P_2592010699) + 4000);
    t16 = (t15 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = 8;
    t17 = (t16 + 4U);
    *((int *)t17) = 8;
    t17 = (t16 + 8U);
    *((int *)t17) = 1;
    t18 = (8 - 8);
    t19 = (t18 * 1);
    t19 = (t19 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t19;
    t17 = (t0 + 5952U);
    t20 = *((char **)t17);
    t11 = xsi_base_array_concat(t11, t13, t14, (char)97, t1, t15, (char)97, t12, t20, (char)101);
    t19 = (1U + 8U);
    t21 = (9U != t19);
    if (t21 == 1)
        goto LAB8;

LAB9:    t22 = (t0 + 13088);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    memcpy(t26, t11, 9U);
    xsi_driver_first_trans_fast(t22);

LAB2:    t27 = (t0 + 12928);
    *((int *)t27) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    t3 = 8U;
    goto LAB7;

LAB8:    xsi_size_not_matching(9U, t19, 0);
    goto LAB9;

}

static void work_a_0025575011_1516540902_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    char *t5;
    char *t6;
    int t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(48, ng0);
    t1 = (t0 + 6904U);
    t2 = *((char **)t1);
    t1 = (t0 + 6912U);
    t3 = *((char **)t1);
    t4 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t2, t3);
    t5 = ((WORK_P_0915166706) + 1528U);
    t6 = *((char **)t5);
    t7 = *((int *)t6);
    t8 = (t4 > t7);
    if (t8 != 0)
        goto LAB3;

LAB4:
LAB5:    t13 = (t0 + 13152);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    *((unsigned char *)t17) = (unsigned char)2;
    xsi_driver_first_trans_fast(t13);

LAB2:    t18 = (t0 + 12944);
    *((int *)t18) = 1;

LAB1:    return;
LAB3:    t5 = (t0 + 13152);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast(t5);
    goto LAB2;

LAB6:    goto LAB2;

}


void ieee_p_2592010699_sub_7991387870887201249_503743352();

extern void work_a_0025575011_1516540902_init()
{
	static char *pe[] = {(void *)work_a_0025575011_1516540902_p_0,(void *)work_a_0025575011_1516540902_p_1,(void *)work_a_0025575011_1516540902_p_2};
	xsi_register_didat("work_a_0025575011_1516540902", "isim/RSDecoderTb_isim_beh.exe.sim/work/a_0025575011_1516540902.didat");
	xsi_register_executes(pe);
	xsi_register_resolution_function(1, 2, (void *)ieee_p_2592010699_sub_7991387870887201249_503743352, 4);
}
