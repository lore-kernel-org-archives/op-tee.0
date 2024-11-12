From: "Jork Loeser (he/him)" <Jork.Loeser@microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [EXTERNAL] Re: Linux user-level implementation of OP-TEE
Date: Tue, 12 Nov 2024 16:25:00 +0000
Message-ID: <MWHPR21MB4527E14598948099445389AAF1592@MWHPR21MB4527.namprd21.prod.outlook.com>
In-Reply-To: <
 <CAHUa44FWawxeLw1RQry_xV104_jLYM3XzBDtfycwSw-JMz1yZA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6432153523599526036=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6432153523599526036==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thank you, Jens, for the detail. Yes, the idea is to re-use as much of the so=
urce as possible, and the bar is xtest compliance. Good insights, thank you!

Best,
Jork

> -----Original Message-----
> From: Jens Wiklander <jens.wiklander@linaro.org>
> Sent: Tuesday, November 12, 2024 00:49
> To: Jork Loeser (he/him) <Jork.Loeser@microsoft.com>
> Cc: op-tee(a)lists.trustedfirmware.org
> Subject: [EXTERNAL] Re: Linux user-level implementation of OP-TEE
>=20
> [You don't often get email from jens.wiklander(a)linaro.org. Learn why this=
 is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Hi Jork,
>=20
> On Tue, Nov 12, 2024 at 8:54=E2=80=AFAM Jork Loeser (he/him) via OP-TEE <op-
> tee(a)lists.trustedfirmware.org> wrote:
> >
> > Hello,
> >
> > I am Jork Loeser from Microsoft, and we are looking into providing the OP-
> TEE internal core API from Linux user-level, as well as hosting a derivativ=
e of
> OP-TEE OS in Linux user-level. Can you say is something like this has been
> attempted in the past, and perhaps provide pointers?
>=20
> I'm not aware of any attempts at this.
>=20
> >
> > How interesting would it be for OP-TEE to have such an implementation -
> e.g., for early/rapid-development purposes?
>=20
> That depends on the accuracy of the implementation and who will maintain
> it. The implementation should preferably not lag behind the normal OP-TEE
> development or that might be a source of confusion.
>=20
> I'm probably not in the target group, but I think an environment based on
> QEMU might still be preferable due to its accuracy and closeness to the real
> deal. It's also quite quick to develop TAs using QEMU. You can usually do
> incremental compiles and re-launch in only a few seconds. It can be a bit
> challenging to attach a debugger to a TA, and even worse when more TAs are
> executed in parallel. This is an area with room for improvement. OP-TEE OS
> and TA awareness in GDB would help with lowering the bar.
>=20
> Cheers,
> Jens

--===============6432153523599526036==--

