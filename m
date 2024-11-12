From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Linux user-level implementation of OP-TEE
Date: Tue, 12 Nov 2024 09:49:15 +0100
Message-ID: 
 <CAHUa44FWawxeLw1RQry_xV104_jLYM3XzBDtfycwSw-JMz1yZA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CMWHPR21MB45276DB09CEBC41CC7AEEABDF1592=40MWHPR21MB?=
 =?utf-8?q?4527=2Enamprd21=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0331256151866671166=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0331256151866671166==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jork,

On Tue, Nov 12, 2024 at 8:54=E2=80=AFAM Jork Loeser (he/him) via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hello,
>
> I am Jork Loeser from Microsoft, and we are looking into providing the OP-T=
EE internal core API from Linux user-level, as well as hosting a derivative o=
f OP-TEE OS in Linux user-level. Can you say is something like this has been =
attempted in the past, and perhaps provide pointers?

I'm not aware of any attempts at this.

>
> How interesting would it be for OP-TEE to have such an implementation - e.g=
., for early/rapid-development purposes?

That depends on the accuracy of the implementation and who will
maintain it. The implementation should preferably not lag behind the
normal OP-TEE development or that might be a source of confusion.

I'm probably not in the target group, but I think an environment based
on QEMU might still be preferable due to its accuracy and closeness to
the real deal. It's also quite quick to develop TAs using QEMU. You
can usually do incremental compiles and re-launch in only a few
seconds. It can be a bit challenging to attach a debugger to a TA, and
even worse when more TAs are executed in parallel. This is an area
with room for improvement. OP-TEE OS and TA awareness in GDB would
help with lowering the bar.

Cheers,
Jens

--===============0331256151866671166==--

