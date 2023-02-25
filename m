From: 梅建强(禹夜) <meijianqiang.mjq@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: Hafnium Dynamic Shared Memory
Date: Sat, 25 Feb 2023 23:19:18 +0800
Message-ID: 
 <91d2699f-c02a-47f2-addc-6cd8e3ff8a9e.meijianqiang.mjq@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8630835405954099903=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8630835405954099903==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, experts
Here are the comments I saw in the Hafnium code.
 /*
 * Hafnium doesn't support fragmentation of memory retrieve requests
 * (because it doesn't support caller-specified mappings, so a request
 * will never be larger than a single page), so this must be part of a
 * memory send (i.e. donate, lend or share) request.
 *
 * We can tell from the handle whether the memory transaction is for the
 * TEE or not.
 */
I have a few questions about this description.
1. In the case of Hafnium as SPMC, optee should register memory fragments all=
ocated by linux.=20
What does Hafnium do with these memory fragments since doesn't support fragme=
ntation of memory retrieve requests?
2. How does Hafnium map the page tables of stage-2 in dynamic shared memory f=
or CA/TA,=20
and are these page tables stored in the heap, or where?
3. What does HF_MAILBOX for dynamic shared memory mean? How does it relate to=
 RX/TX buffer?
Where can I see the related introduction in detail?
Regards,
Yuye

--===============8630835405954099903==--

