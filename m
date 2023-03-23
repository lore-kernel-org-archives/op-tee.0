From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: =?utf-8?b?5Zue5aSN77yabG9hZA==?= optee at 36bit address
Date: Thu, 23 Mar 2023 17:58:08 +0800
Message-ID: 
 <227559d8-1fe5-4184-b6d3-c5fc82c571e9.meijianqiang.mjq@alibaba-inc.com>
In-Reply-To: <
 <21294832-a043-42f2-add3-1159810c38a6.meijianqiang.mjq@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2793542851202473383=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2793542851202473383==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, experts,
We seem to have solved the problem. This problem is not caused by the load_ad=
dress of optee, but by the security space configured in the ATF.=20
It seems that the security space we have configured is too large. And why wil=
l it causes the problem needs to be further identified.
Regards,
Yuye.
------------------------------------------------------------------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A=E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=
=A4=9C) <meijianqiang.mjq@alibaba-inc.com>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2023=E5=B9=B43=E6=9C=8822=E6=97=
=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 11:50
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9AOlivier Deprez <Olivier.Deprez@arm.com>=
; Jens Wiklander <jens.wiklander@linaro.org>
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9Ahafnium <hafnium@lists.trustedfirmware.=
org>; op-tee <op-tee@lists.trustedfirmware.org>
=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9Aload optee at 36bit address
Hi, experts,
We are currently moving optee to a 36bit address to boot with environment=20
that hafnium runs at sel2 as spmc and optee runs at sel1 as sp.
Now we have moved hafnium to 0x880000000 and run successfully.
Then we tried moving optee to a 36bit address (0x89000000) as well.
Although hafnium and optee were successfully initialized on the primary cpu, =

psci_cpu_on does not seem to be entered into when the secondary cpu is starte=
d.
The error is as follows:
https://github.com/OP-TEE/optee_os/issues/5895 <https://github.com/OP-TEE/opt=
ee_os/issues/5895 >
Is there any difference between the two cases=20
where hafnium and optee initialize the secondary cpu with different load_addr=
ess?
The log print shows that the secondary cpu has not entered hafnium.
Could Hafnium be affected by the 36bit address when dealing with psci related=
 transactions?
Regards,
Yuye.

--===============2793542851202473383==--

