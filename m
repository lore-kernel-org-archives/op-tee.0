From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 5/5] optee: add FF-A support
Date: Fri, 08 Oct 2021 14:27:32 +0100
Message-ID: <20211008132732.hbmkd3hftdydtrsc@bogus>
In-Reply-To: <20211006070902.2531311-6-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4139853455141697802=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4139853455141697802==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 06, 2021 at 09:09:02AM +0200, Jens Wiklander wrote:
> Adds support for using FF-A [1] as transport to the OP-TEE driver.
>
> Introduces struct optee_msg_param_fmem which carries all information
> needed when OP-TEE is calling FFA_MEM_RETRIEVE_REQ to get the shared
> memory reference mapped by the hypervisor in S-EL2. Register usage is
> also updated to include the information needed.
>
> The FF-A part of this driver is enabled if CONFIG_ARM_FFA_TRANSPORT is
> enabled.
>

I am not sure if I missed this with earlier version but I see the below
warning the second time I insert the optee module. I am sure I tested it
with previous version when I was fixing issues with FF-A as a module.

Not sure if I am missing something in my steps.

Regards,
Sudeep

-->8

 sysfs: cannot create duplicate filename '/devices/optee-ta-d96a5b40-c3e5-21e=
3-8794-1002a5d5c61b'
 CPU: 7 PID: 181 Comm: modprobe Not tainted 5.15.0-rc4+ #6
 Hardware name: FVP Base RevC (DT)
 Call trace:
  dump_backtrace+0x0/0x1d4
  show_stack+0x18/0x64
  dump_stack_lvl+0x64/0x7c
  dump_stack+0x18/0x38
  sysfs_create_dir_ns+0xe4/0x140
  kobject_add_internal+0x170/0x354
  kobject_add+0x94/0x100
  device_add+0x178/0x5f0
  device_register+0x20/0x30
  optee_enumerate_devices+0x204/0x2fc [optee]
  optee_ffa_probe+0x370/0x3bc [optee]
  ffa_device_probe+0x1c/0x28 [ffa_module]
  really_probe+0xc4/0x2f4
  __driver_probe_device+0xb4/0xe0
  driver_probe_device+0x40/0x134
  __driver_attach+0xe0/0x180=20
  bus_for_each_dev+0x80/0xcc
  driver_attach+0x24/0x30
  bus_add_driver+0xfc/0x1dc
  driver_register+0x78/0x110
  ffa_driver_register+0x2c/0x40 [ffa_module]
  optee_ffa_abi_register+0x28/0x34 [optee]
  init_module+0x38/0x60 [optee]
  do_one_initcall+0xbc/0x230
  do_init_module+0x58/0x304
  load_module+0x1cb8/0x1f78

--===============4139853455141697802==--

