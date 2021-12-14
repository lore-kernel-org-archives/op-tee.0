From: Patrik Lantz <Patrik.Lantz@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: drivers/tee double-free of page when optee_shm_register fails
Date: Tue, 14 Dec 2021 08:30:09 +0000
Message-ID: <d9d213441d174cb7af55c7042677282a@axis.com>
In-Reply-To: <
 <CAFA6WYNNTr0O60ggowzqpJVso5cySO=peBTBTzVm9MzZy8b4ww@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0574317234909925501=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0574317234909925501==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,


I'm attaching a reproducer (only CA, there is no TA used in this case ) and c=
rash log for reference.


Regards,

Patrik

________________________________
From: Sumit Garg <sumit.garg@linaro.org>
Sent: Tuesday, December 14, 2021 8:41:20 AM
To: Lars Persson
Cc: op-tee(a)lists.trustedfirmware.org; Patrik Lantz
Subject: Re: drivers/tee double-free of page when optee_shm_register fails

Hi Lars,

On Fri, 10 Dec 2021 at 20:23, Lars Persson <larper@axis.com> wrote:
>
> Hi
>
> Me and Patrik have been tracing a kernel memory corruption bug that is
> triggered when op-tee runs out of resources and returns an error from
> the OPTEE_MSG_CMD_REGISTER_SHM call. This is yet another fall-out from
> Patrik's fuzzing of the TEE subsystem.
>
> The symptoms would look like this when page debugging is enabled:
> BUG: Bad page state in process optee_example_h  pfn:46bb0
> page:(ptrval) refcount:-1 mapcount:0 mapping:00000000 index:0x0 pfn:0x46bb0
> flags: 0x0(zone=3D0)
>
> Our reproducer runs a loop with the TEE_IOC_SHM_ALLOC until memory runs
> out at the optee-os end (dynamic SHM enabled). The error is 100%
> reproducible with such a loop.

Can you share a simple reproducer test application (CA and TA)?

>
> We have traced this down to what seems to be a miss in the memory
> ownership contract during the call to OPTEE_MSG_CMD_REGISTER_SHM.
>
> When pool_op_alloc() detects that optee_shm_register() has failed, it
> will free the allocated page at the very end of the function.
> Unfortunately that page has already been freed because OP-TEE has sent a
> OPTEE_RPC_CMD_SHM_FREE for this shm object before returning from
> OPTEE_MSG_CMD_REGISTER_SHM. This is my conclusion based on prints added
> to the code.

I can't see any RPC free command from OP-TEE in case the
OPTEE_MSG_CMD_REGISTER_SHM fails. Have you compared kernel addresses
for SHM during OPTEE_MSG_CMD_REGISTER_SHM and OPTEE_RPC_CMD_SHM_FREE?

>
> I cannot write a patch for this because I am at a loss of who actually
> is supposed to trigger the free of the pages in this situation. Is there
> an API spec that makes this clear ?

It should only be the pool_op_alloc() API in case
OPTEE_MSG_CMD_REGISTER_SHM fails.

-Sumit

>
> BR,
>   Lars



--===============0574317234909925501==
Content-Type: text/plain
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="crashlog.txt"
MIME-Version: 1.0

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CkJVRzogS0FTQU46IGRvdWJsZS1mcmVlIG9yIGludmFsaWQtZnJlZSBpbiB0ZWVf
c2htX2FsbG9jICgvbW50L2J1aWxkL29wdGVlLXFlbXUvbGludXgvZHJpdmVycy90ZWUvdGVlX3No
bS5jOjIxMCkgCgpDUFU6IDAgUElEOiAzMTAgQ29tbTogb3B0ZWVfZXhhbXBsZV9oIE5vdCB0YWlu
dGVkIDUuMTQuMCAjMTAKSGFyZHdhcmUgbmFtZTogR2VuZXJpYyBEVCBiYXNlZCBzeXN0ZW0KKHVu
d2luZF9iYWNrdHJhY2UpIGZyb20gc2hvd19zdGFjayAoL21udC9idWlsZC9vcHRlZS1xZW11L2xp
bnV4L2FyY2gvYXJtL2tlcm5lbC90cmFwcy5jOjI1NCkgCihzaG93X3N0YWNrKSBmcm9tIGR1bXBf
c3RhY2tfbHZsICgvbW50L2J1aWxkL29wdGVlLXFlbXUvbGludXgvbGliL2R1bXBfc3RhY2suYzox
MDYgKGRpc2NyaW1pbmF0b3IgMSkpIAooZHVtcF9zdGFja19sdmwpIGZyb20gcHJpbnRfYWRkcmVz
c19kZXNjcmlwdGlvbi5jb25zdHByb3AuMCAoL21udC9idWlsZC9vcHRlZS1xZW11L2xpbnV4L21t
L2thc2FuL3JlcG9ydC5jOjIzNCkgCihwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uLmNvbnN0cHJv
cC4wKSBmcm9tIGthc2FuX3JlcG9ydF9pbnZhbGlkX2ZyZWUgKC9tbnQvYnVpbGQvb3B0ZWUtcWVt
dS9saW51eC9tbS9rYXNhbi9yZXBvcnQuYzozNTkpIAooa2FzYW5fcmVwb3J0X2ludmFsaWRfZnJl
ZSkgZnJvbSBrZnJlZSAoL21udC9idWlsZC9vcHRlZS1xZW11L2xpbnV4Ly4vaW5jbHVkZS9saW51
eC92bXN0YXQuaDo1MjMgL21udC9idWlsZC9vcHRlZS1xZW11L2xpbnV4L21tL3NsdWIuYzozMjQ4
IC9tbnQvYnVpbGQvb3B0ZWUtcWVtdS9saW51eC9tbS9zbHViLmM6NDI2NCkgCihrZnJlZSkgZnJv
bSB0ZWVfc2htX2FsbG9jICgvbW50L2J1aWxkL29wdGVlLXFlbXUvbGludXgvZHJpdmVycy90ZWUv
dGVlX3NobS5jOjIxMCkgCih0ZWVfc2htX2FsbG9jKSBmcm9tIHRlZV9pb2N0bCAoL21udC9idWls
ZC9vcHRlZS1xZW11L2xpbnV4L2RyaXZlcnMvdGVlL3RlZV9jb3JlLmM6Mjk2IC9tbnQvYnVpbGQv
b3B0ZWUtcWVtdS9saW51eC9kcml2ZXJzL3RlZS90ZWVfY29yZS5jOjg2MikgCih0ZWVfaW9jdGwp
IGZyb20gc3lzX2lvY3RsICgvbW50L2J1aWxkL29wdGVlLXFlbXUvbGludXgvZnMvaW9jdGwuYzo1
MiAvbW50L2J1aWxkL29wdGVlLXFlbXUvbGludXgvZnMvaW9jdGwuYzoxMDI5IC9tbnQvYnVpbGQv
b3B0ZWUtcWVtdS9saW51eC9mcy9pb2N0bC5jOjEwNjcgL21udC9idWlsZC9vcHRlZS1xZW11L2xp
bnV4L2ZzL2lvY3RsLmM6MTA1NSkgCihzeXNfaW9jdGwpIGZyb20gcmV0X2Zhc3Rfc3lzY2FsbCAo
L21udC9idWlsZC9vcHRlZS1xZW11L2xpbnV4L2FyY2gvYXJtL2tlcm5lbC9lbnRyeS1jb21tb24u
Uzo1MSkgCkV4Y2VwdGlvbiBzdGFjaygweDg2MjkzZmE4IHRvIDB4ODYyOTNmZjApCjNmYTA6ICAg
ICAgICAgICAgICAgICAgIDAwMDAwMDE2IDAwMDAwMWEwIDAwMDAwMDAzIGMwMTBhNDAxIDIwMDAw
MDgwIDAwMDAwMDAxCjNmYzA6IDAwMDAwMDE2IDAwMDAwMWEwIDAwNDkxNTFkIDAwMDAwMDM2IDQ3
YmExMmQwIDQ3YmEwZTEwIDQ3YmExMmQwIDZlY2FlYzg4CjNmZTA6IDQ3YmEwY2QwIDQ3YmEwY2Mw
IDAwNDkwZTY5IDY2Yzc0ZDcyCgpUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBwYWdl
OgpwYWdlOihwdHJ2YWwpIHJlZmNvdW50OjAgbWFwY291bnQ6MCBtYXBwaW5nOihwdHJ2YWwpIGlu
ZGV4OjB4MCBwZm46MHg0Njg2Ygphb3BzOjB4NDAgaW5vOjAKZmxhZ3M6IDB4MCh6b25lPTApCnJh
dzogMDAwMDAwMDAgYzA4ODhkODQgYjgwNjU0YmMgODI0MDEyMDAgMDAwMDAwMDAgODAyMDAwMjAg
ZmZmZmZmZmYgMDAwMDAwMDAKcGFnZSBkdW1wZWQgYmVjYXVzZToga2FzYW46IGJhZCBhY2Nlc3Mg
ZGV0ZWN0ZWQKCk1lbW9yeSBzdGF0ZSBhcm91bmQgdGhlIGJ1Z2d5IGFkZHJlc3M6Cjg2ODZhZjgw
OiAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMAo4Njg2YjAw
MDogZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYKPjg2ODZi
MDgwOiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZgpeCjg2
ODZiMTAwOiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZiBmZgo4
Njg2YjE4MDogZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYgZmYK
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Cg==

--===============0574317234909925501==--

