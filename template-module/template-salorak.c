/*
 * hello.c - The Hello, World! Kernel Module
 * From: Linux Kernel Development - Robert Love
*/

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>


static int template_salorak_init(void) 
{
    printk(KERN_ALERT "Hello world! This is a test module");
    return 0;
}

static void template_salorak_exit(void)
{
    printk(KERN_ALERT "Bye bye! Check out https://github.com/SalOrak");
}

module_init(template_salorak_init);
module_exit(template_salorak_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Shakespeare");
MODULE_DESCRIPTION("A SalOrak template module");



