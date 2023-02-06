From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: =?utf-8?b?5Zue5aSN77yaT1BURUU=?= TA Crash
Date: Mon, 06 Feb 2023 14:38:49 +0800
Message-ID: 
 <4df5ccdb-fd51-4ebf-82a3-dbdd86b1722d.meijianqiang.mjq@alibaba-inc.com>
In-Reply-To: <
 <ad9b6792-0d6c-4223-97cd-8665be4de9b4.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7313550223994339417=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7313550223994339417==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,
At present, I suspect that this may be a hafnium problem,=20
secure_storage CA/TA may use over 34G address space before communication.
May I ask, does hafnium currently support the configuration of the page table=
 of 0x8 80000000-xxxxxxxxx address range?=20
If yes, how to configure it?
The error log is as follows:
Current share states: SHARE 0x0 (from VM 0x0, attributes 0x2f, flags 0x8, tag=
 0, to 1 recipients [VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragment=
s, 1 retrieved, sender's original mode: 0x7 SHARE 0x1 (from VM 0x0, attribute=
s 0x2f, flags 0x8, tag 0, to 1 recipients [VM 0x8001: 0x6 (offset 48)]): full=
y sent with 1 fragments, 1 retrieved, sender's original mode: 0x7 SHARE 0x2 (=
from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients [VM 0x8001: 0=
x6 (offset 48)]): fully sent with 1 fragments, 1 retrieved, sender's original=
 mode: 0x7 WARNING: Stage-2 page fault: pc=3D0x40032106, vmid=3D0x8001, vcpu=
=3D13, vaddr=3D0x40046ce0, ipaddr=3D0x8a9b28ce0, mode=3D0x81 0x63 NOTICE: Inj=
ecting Data Abort exception into VM 0x8001. D/TC:013 0 abort_handler:550 [abo=
rt] abort in User mode (TA will panic) E/TC:??? 0 E/TC:??? 0 User mode data-a=
bort at address 0x40046ce0 (translation fault) E/TC:??? 0 esr 0x94020007 ttbr=
0 0x20000f03061a0 ttbr1 0x00000000 cidr 0x0 E/TC:??? 0 cpu #13 cpsr 0x0000013=
0 E/TC:??? 0 x0 000000004003e348 x1 000000004003e349 E/TC:??? 0 x2 0000000040=
046ce0 x3 000000004003e348 E/TC:??? 0 x4 0000000040036088 x5 0000000000000000=
 E/TC:??? 0 x6 0000000000000000 x7 0000000040042e28 E/TC:??? 0 x8 00000000000=
00000 x9 0000000000000000 E/TC:??? 0 x10 0000000000000000 x11 000000000000000=
0 E/TC:??? 0 x12 0000000000000000 x13 0000000040042e28 E/TC:??? 0 x14 0000000=
0400213cf x15 0000000000000000 E/TC:??? 0 x16 0000000000000000 x17 0000000000=
000000 E/TC:??? 0 x18 0000000000000000 x19 0000000000000000 E/TC:??? 0 x20 00=
00000000000000 x21 0000000000000000 E/TC:??? 0 x22 0000000000000000 x23 00000=
00000000000 E/TC:??? 0 x24 0000000000000000 x25 0000000000000000 E/TC:??? 0 x=
26 0000000000000000 x27 0000000000000000 E/TC:??? 0 x28 0000000000000000 x29 =
0000000000000000 E/TC:??? 0 x30 0000000000000000 elr 0000000040032106 E/TC:??=
? 0 sp_el0 0000000040042f80 E/LD: Status of TA f4e750bb-1437-4fbf-8785-8d3580=
c34994 E/LD: arch: arm E/LD: region 0: va 0x40006000 pa 0xf0404000 size 0x002=
000 flags rw-s (ldelf) E/LD: region 1: va 0x40008000 pa 0xf0406000 size 0x011=
000 flags r-xs (ldelf) E/LD: region 2: va 0x40019000 pa 0xf0417000 size 0x001=
000 flags rw-s (ldelf) E/LD: region 3: va 0x4001a000 pa 0xf0418000 size 0x004=
000 flags rw-s (ldelf) E/LD: region 4: va 0x4001e000 pa 0xf041c000 size 0x001=
000 flags r--s E/LD: region 5: va 0x4001f000 pa 0x00001000 size 0x017000 flag=
s r-xs [0] E/LD: region 6: va 0x40036000 pa 0x00018000 size 0x00c000 flags rw=
-s [0] E/LD: region 7: va 0x40042000 pa 0xf0440000 size 0x001000 flags rw-s (=
stack) E/LD: region 8: va 0x40043000 pa 0x8b9101620 size 0x003000 flags rw-- =
(param) E/LD: region 9: va 0x40046000 pa 0x8a9b28ce0 size 0x001000 flags rw--=
 (param) E/LD: [0] f4e750bb-1437-4fbf-8785-8d3580c34994 @ 0x4001f000 E/LD: Ca=
ll stack
Regards,
Yuye
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B42=E6=9C=884=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E5=85=AD) 11:40
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Aop-tee <op-tee@lists.trustedfirmware.or=
g>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9A=E8=B5=B5=E5=93=B2(=E4=B8=BA=E5=93=B2) <w=
eizhe.zz@alibaba-inc.com>; =E9=AB=98=E6=B5=B7=E6=BA=90(=E7=A0=81=E6=BA=90) =
<haiyuan.ghy@alibaba-inc.com>; =E7=8E=8B=E4=B8=80=E8=92=99(=E5=8C=97=E8=A7=
=81) <wym389994@alibaba-inc.com>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9AOPTEE TA Crash
Hi,
Does anyone have a good solution to this problem=EF=BC=9F
https://github.com/OP-TEE/optee_os/issues/5803 <https://github.com/OP-TEE/opt=
ee_os/issues/5803 >
regards,
yuye

--===============7313550223994339417==--

