From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: load optee at 36bit address
Date: Wed, 22 Mar 2023 11:50:24 +0800
Message-ID: 
 <21294832-a043-42f2-add3-1159810c38a6.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8534355885238615619=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8534355885238615619==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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

--===============8534355885238615619==--

