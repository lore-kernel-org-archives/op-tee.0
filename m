From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC PATCH 0/3] tee: optee: Allow to freeze when tee-supplicant is frozen
Date: Tue, 01 Jun 2021 09:19:53 +0200
Message-ID: 
 <CAHUa44GEBa_UDURtnshGCNMSJK2LqX_jXmFFzPV1Zw=iYzf8Pw@mail.gmail.com>
In-Reply-To: <20210526070911.31681-1-cgellner@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5104478582148553367=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5104478582148553367==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, May 26, 2021 at 9:10 AM Christoph Gellner
<cgellner@de.adit-jv.com> wrote:
>
> When the system is going to hibernate or suspend it might happen
> that the tee-supplicant task is frozen first.
> In this case a running OP-TEE task might get stuck in the loop using
> wait_for_completion_interruptible to wait for response of tee-supplicant.
>
> As a consequence other OP-TEE tasks waiting for the above or a
> succeeding stuck OP-TEE task might get stuck as well
> - waiting for call queue entry to be completed
> - waiting for OPTEE_RPC_WAIT_QUEUE_WAKEUP
>
> This will result in the tasks "refusing to freeze" and
> the hibernate or suspend will fail.
>
> OP-TEE issue: https://github.com/OP-TEE/optee_os/issues/4581
>
>
> - Read back the object
> PM: suspend entry (s2idle)
> Filesystems sync: 0.000 seconds
> Freezing user space processes ...
> Freezing of tasks failed after 20.008 seconds (3 tasks refusing to freeze, =
wq_busy=3D0):
> task:optee_example_s state:R  running task     stack:    0 pid:  124 ppid: =
    1 flags:0x00000001
> [<807d3e24>] (__schedule) from [<841c4000>] (0x841c4000)
> task:optee_example_s state:D stack:    0 pid:  126 ppid:     1 flags:0x0000=
0001
> [<807d3e24>] (__schedule) from [<807d41d0>] (schedule+0x60/0x120)
> [<807d41d0>] (schedule) from [<807d7ffc>] (schedule_timeout+0x1f4/0x340)
> [<807d7ffc>] (schedule_timeout) from [<807d56a0>] (wait_for_completion+0x94=
/0xfc)
> [<807d56a0>] (wait_for_completion) from [<80692134>] (optee_cq_wait_for_com=
pletion+0x14/0x60)
> [<80692134>] (optee_cq_wait_for_completion) from [<806924dc>] (optee_do_cal=
l_with_arg+0x14c/0x154)
> [<806924dc>] (optee_do_call_with_arg) from [<80692edc>] (optee_shm_unregist=
er+0x78/0xcc)
> [<80692edc>] (optee_shm_unregister) from [<80690a9c>] (tee_shm_release+0x88=
/0x174)
> [<80690a9c>] (tee_shm_release) from [<8057f89c>] (dma_buf_release+0x44/0xb0)
> [<8057f89c>] (dma_buf_release) from [<8028e4e8>] (__dentry_kill+0x110/0x17c)
> [<8028e4e8>] (__dentry_kill) from [<80276cfc>] (__fput+0xc0/0x234)
> [<80276cfc>] (__fput) from [<80140b1c>] (task_work_run+0x90/0xbc)
> [<80140b1c>] (task_work_run) from [<8010b1c8>] (do_work_pending+0x4a0/0x5a0)
> [<8010b1c8>] (do_work_pending) from [<801000cc>] (slow_work_pending+0xc/0x2=
0)
> Exception stack(0x843f5fb0 to 0x843f5ff8)
> 5fa0:                                     00000000 7ef63448 fffffffe 000000=
00
> 5fc0: 7ef63448 76f163b0 7ef63448 00000006 7ef63448 7ef634e0 7ef63438 000000=
00
> 5fe0: 00000006 7ef63400 76e74833 76dff856 800e0130 00000004
> task:optee_example_s state:D stack:    0 pid:  128 ppid:     1 flags:0x0000=
0001
> [<807d3e24>] (__schedule) from [<807d41d0>] (schedule+0x60/0x120)
> [<807d41d0>] (schedule) from [<807d7ffc>] (schedule_timeout+0x1f4/0x340)
> [<807d7ffc>] (schedule_timeout) from [<807d56a0>] (wait_for_completion+0x94=
/0xfc)
> [<807d56a0>] (wait_for_completion) from [<8069359c>] (optee_handle_rpc+0x55=
4/0x710)
> [<8069359c>] (optee_handle_rpc) from [<806924cc>] (optee_do_call_with_arg+0=
x13c/0x154)
> [<806924cc>] (optee_do_call_with_arg) from [<80692910>] (optee_invoke_func+=
0x110/0x190)
> [<80692910>] (optee_invoke_func) from [<8068fe3c>] (tee_ioctl+0x113c/0x1244)
> [<8068fe3c>] (tee_ioctl) from [<802892ec>] (sys_ioctl+0xe0/0xa24)
> [<802892ec>] (sys_ioctl) from [<80100060>] (ret_fast_syscall+0x0/0x54)
> Exception stack(0x8424ffa8 to 0x8424fff0)
> ffa0:                   00000000 7eb67584 00000003 8010a403 7eb67438 7eb675=
fc
> ffc0: 00000000 7eb67584 7eb67604 00000036 7eb67448 7eb674e0 7eb67438 000000=
00
> ffe0: 76ef7030 7eb6742c 76ee6469 76e83178
> OOM killer enabled.
> Restarting tasks ... done.
> PM: suspend exit
> sh: write error: Device or resource busy
>
>
> The patch set will switch to interruptible waits and add try_to_freeze to a=
llow the waiting
> OP-TEE tasks to be frozen as well.
>
> ---
>
> In my humble understanding without these patches OP-TEE tasks have only bee=
n frozen in user-space.
> With these patches it is possible that OP-TEE tasks are frozen although the=
 OP-TEE command
> invocation didn't complete.
> I'm unable to judge if there are any OP-TEE implementations relying on the =
fact that suspend won't
> happen while the OP-TEE command invocation didn't complete.
>
> The theoretical alternative would be to prevent that tee-supplicant is froz=
en first.
>
>
> I was able to reproduce the issue in OP-TEE QEMU v7 using a modified versio=
n of
> optee_example_secure_storage (loop around REE FS read, support multi-sessio=
n).
> See https://github.com/OP-TEE/optee_os/issues/4581 for details.
>
> After applying these patches (minor adjustments of the includes) I was no l=
onger able to
> reproduce the issues.
> In my tests OP-TEE QEMU v7 did suspend and resume without troubles.
>
> I'm not able to test on other devices supporting OP-TEE.
>
>
> I decided to handle each of the locations the OP-TEE task could get stuck a=
s a separate commit.
> The downside is that the above call stack doesn't really fit to any of the =
commits.
>
> Christoph Gellner (3):
>   tee: optee: Allow to freeze the task waiting for tee-supplicant
>   tee: optee: Allow to freeze while waiting for call_queue
>   tee: optee: Allow to freeze while waiting in
>     OPTEE_RPC_WAIT_QUEUE_SLEEP
>
>  drivers/tee/optee/call.c | 8 +++++++-
>  drivers/tee/optee/rpc.c  | 9 ++++++++-
>  drivers/tee/optee/supp.c | 3 +++
>  3 files changed, 18 insertions(+), 2 deletions(-)

These patches look good to me. I would really appreciate feedback from
someone who is more familiar with the usage of  try_to_freeze() and
friends.

Thanks,
Jens

--===============5104478582148553367==--

