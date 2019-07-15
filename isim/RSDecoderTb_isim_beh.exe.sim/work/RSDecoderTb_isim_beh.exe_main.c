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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *WORK_P_0915166706;
char *IEEE_P_1242562249;
char *STD_STANDARD;
char *IEEE_P_2592010699;
char *IEEE_P_3620187407;
char *IEEE_P_3499444699;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    ieee_p_1242562249_init();
    work_p_0915166706_init();
    work_a_2769321831_1516540902_init();
    work_a_3588430723_1516540902_init();
    work_a_1130988942_1516540902_init();
    work_a_0290344353_1516540902_init();
    work_a_0025575011_1516540902_init();
    work_a_0589364102_1516540902_init();
    work_a_0813739016_1516540902_init();
    work_a_3682293638_1516540902_init();
    work_a_0078671962_1516540902_init();
    work_a_2646151529_3553469787_init();


    xsi_register_tops("work_a_2646151529_3553469787");

    WORK_P_0915166706 = xsi_get_engine_memory("work_p_0915166706");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");

    return xsi_run_simulation(argc, argv);

}
